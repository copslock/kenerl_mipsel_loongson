Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 19:43:08 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.155]:18978 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491840Ab0EXRm7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 May 2010 19:42:59 +0200
Received: by fg-out-1718.google.com with SMTP id 16so1040778fgg.6
        for <linux-mips@linux-mips.org>; Mon, 24 May 2010 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=liHqhx5VEpD9bDXKjwwjFs1Kt4/+PyXYL7PiDIzz6MQ=;
        b=vtm1n0bXlchi6/T19c9IKHlfwDuhPFU6OKaUK2pNIVYMOnB0b9Zsn3U2H94Dr0ivcg
         Ki/SkB/c/jYtYN+hIxcARQY1ZQ+jNOjQU9xYiEvEevmKsClDFj3XL78g6iOwqUmqP36r
         cP1Toau3nYCSBhgrd414GEdoqHGjShL4MY3wA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NsKZdqqP1uFRc1vCL/siFSIKrFxulMopeMjqGP0JeqB034bZDAxwU5uW2ZF+k9Y9WU
         MO4cQg9pEO89S3pD1/PCuiRQOVmrLN6Nf0Bqf5b14961AKKAP9WTHhPupyIP5+ZeiZmF
         IxMDjl4lKlu80/bTtQjhL9akDZaOQjENRcIdA=
Received: by 10.87.42.2 with SMTP id u2mr8716773fgj.79.1274722978594;
        Mon, 24 May 2010 10:42:58 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 22sm6005921fkq.17.2010.05.24.10.42.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 10:42:57 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH RESEND] MIPS: Alchemy: sleepcode without compile-time cputype dependencies
Date:   Mon, 24 May 2010 19:42:52 +0200
Message-Id: <1274722972-19123-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Split the low-level sleepcode into per-cpu functions instead of
relying on compile-time-defined cpu type.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
This patch didn't make it to 2.6.35 so I'm resending it.

 arch/mips/alchemy/common/power.c           |   12 +++-
 arch/mips/alchemy/common/sleeper.S         |   81 ++++++++++++++++++----------
 arch/mips/include/asm/mach-au1x00/au1000.h |    3 +-
 3 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 14eb8c4..5ef06a1 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -193,9 +193,15 @@ static void restore_core_regs(void)
 
 void au_sleep(void)
 {
-	save_core_regs();
-	au1xxx_save_and_sleep();
-	restore_core_regs();
+	int cpuid = alchemy_get_cputype();
+	if (cpuid != ALCHEMY_CPU_UNKNOWN) {
+		save_core_regs();
+		if (cpuid <= ALCHEMY_CPU_AU1500)
+			alchemy_sleep_au1000();
+		else if (cpuid <= ALCHEMY_CPU_AU1200)
+			alchemy_sleep_au1550();
+		restore_core_regs();
+	}
 }
 
 #endif	/* CONFIG_PM */
diff --git a/arch/mips/alchemy/common/sleeper.S b/arch/mips/alchemy/common/sleeper.S
index 4f4b167..77f3c74 100644
--- a/arch/mips/alchemy/common/sleeper.S
+++ b/arch/mips/alchemy/common/sleeper.S
@@ -22,10 +22,9 @@
 	.set noat
 	.align	5
 
-/* Save all of the processor general registers and go to sleep.
- * A wakeup condition will get us back here to restore the registers.
- */
-LEAF(au1xxx_save_and_sleep)
+
+/* preparatory stuff */
+.macro	SETUP_SLEEP
 	subu	sp, PT_SIZE
 	sw	$1, PT_R1(sp)
 	sw	$2, PT_R2(sp)
@@ -69,12 +68,32 @@ LEAF(au1xxx_save_and_sleep)
 	 */
 	lui	t3, 0xb190		/* sys_xxx */
 	sw	sp, 0x0018(t3)
-	la	k0, 3f			/* resume path */
+	la	k0, alchemy_sleep_wakeup	/* resume path */
 	sw	k0, 0x001c(t3)
+.endm
 
-	/* Put SDRAM into self refresh:  Preload instructions into cache,
-	 * issue a precharge, auto/self refresh, then sleep commands to it.
-	 */
+.macro	DO_SLEEP
+	/* put power supply and processor to sleep */
+	sw	zero, 0x0078(t3)	/* sys_slppwr */
+	sync
+	sw	zero, 0x007c(t3)	/* sys_sleep */
+	sync
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+.endm
+
+/* sleep code for Au1000/Au1100/Au1500 memory controller type */
+LEAF(alchemy_sleep_au1000)
+
+	SETUP_SLEEP
+
+	/* cache following instructions, as memory gets put to sleep */
 	la	t0, 1f
 	.set	mips3
 	cache	0x14, 0(t0)
@@ -84,17 +103,32 @@ LEAF(au1xxx_save_and_sleep)
 	.set	mips0
 
 1:	lui 	a0, 0xb400		/* mem_xxx */
-#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100) ||	\
-    defined(CONFIG_SOC_AU1500)
 	sw	zero, 0x001c(a0) 	/* Precharge */
 	sync
 	sw	zero, 0x0020(a0)	/* Auto Refresh */
 	sync
 	sw	zero, 0x0030(a0)  	/* Sleep */
 	sync
-#endif
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+	DO_SLEEP
+
+END(alchemy_sleep_au1000)
+
+/* sleep code for Au1550/Au1200 memory controller type */
+LEAF(alchemy_sleep_au1550)
+
+	SETUP_SLEEP
+
+	/* cache following instructions, as memory gets put to sleep */
+	la	t0, 1f
+	.set	mips3
+	cache	0x14, 0(t0)
+	cache	0x14, 32(t0)
+	cache	0x14, 64(t0)
+	cache	0x14, 96(t0)
+	.set	mips0
+
+1:	lui 	a0, 0xb400		/* mem_xxx */
 	sw	zero, 0x08c0(a0) 	/* Precharge */
 	sync
 	sw	zero, 0x08d0(a0)	/* Self Refresh */
@@ -114,26 +148,17 @@ LEAF(au1xxx_save_and_sleep)
 	and 	t1, t0, t1		/* clear CE[1:0] */
 	sw 	t1, 0x0840(a0)		/* mem_sdconfiga */
 	sync
-#endif
 
-	/* put power supply and processor to sleep */
-	sw	zero, 0x0078(t3)	/* sys_slppwr */
-	sync
-	sw	zero, 0x007c(t3)	/* sys_sleep */
-	sync
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
+	DO_SLEEP
+
+END(alchemy_sleep_au1550)
+
 
 	/* This is where we return upon wakeup.
 	 * Reload all of the registers and return.
 	 */
-3:	lw	k0, 0x20(sp)
+LEAF(alchemy_sleep_wakeup)
+	lw	k0, 0x20(sp)
 	mtc0	k0, CP0_STATUS
 	lw	k0, 0x1c(sp)
 	mtc0	k0, CP0_CONTEXT
@@ -169,4 +194,4 @@ LEAF(au1xxx_save_and_sleep)
 	lw	$31, PT_R31(sp)
 	jr	ra
 	 addiu	sp, PT_SIZE
-END(au1xxx_save_and_sleep)
+END(alchemy_sleep_wakeup)
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index e76941d..a697661 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -188,7 +188,8 @@ extern unsigned long get_au1x00_uart_baud_base(void);
 extern unsigned long au1xxx_calc_clock(void);
 
 /* PM: arch/mips/alchemy/common/sleeper.S, power.c, irq.c */
-void au1xxx_save_and_sleep(void);
+void alchemy_sleep_au1000(void);
+void alchemy_sleep_au1550(void);
 void au_sleep(void);
 
 
-- 
1.7.1
