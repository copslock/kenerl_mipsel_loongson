Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2007 08:54:35 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.186]:149 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026210AbXKKIy0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Nov 2007 08:54:26 +0000
Received: by fk-out-0910.google.com with SMTP id f40so1056194fka
        for <linux-mips@linux-mips.org>; Sun, 11 Nov 2007 00:54:16 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=OM6j83eczy43xjGe1mIEsy2WUa93V0lR2Y0zaHmo2k8=;
        b=OvkAkaDfjXVvKjZpz35zvANG45APwCxWmLk4/7YUo3KWvS/05ZPrwGfol1gpdymy2hcfj0J0/Fv3aVE3gBYtROE1j7r7C5IrFhUroRzNiwn4OMvtBw4NoUf+j6IaeODLr+aR+A1UUCiEwvlXLD4dLhJ28xTq4TJj1u1e/KJOVEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=jhl+i/06pqwUqyB/W2fNufhkP9jJ3yFw4YzWzU2KNTvH2CmpkykYBtOpzcGlQRX/Un9pmXbXwhlQgbQn+v2M3DUsvmpAwvOG2fF6uyTJsj7ZVKaPFUKcBm+t2GD+OYeloNvx1I++D73DWfK3nsfw/fWckZLKjZz+xntpg/N08u8=
Received: by 10.86.4.2 with SMTP id 2mr3292256fgd.1194771256806;
        Sun, 11 Nov 2007 00:54:16 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id p38sm4750230fke.2007.11.11.00.54.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Nov 2007 00:54:16 -0800 (PST)
Message-ID: <4736C2C8.9000709@gmail.com>
Date:	Sun, 11 Nov 2007 09:52:24 +0100
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Use __fill_user() to clear bss.
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

bss is relatively big, more than 70Kb on cobalt config, so it's a pity
to clear it one word per loop. Instead this patch uses __fill_user(),
which should be faster.

Since we do a function jump to __fill_user(), argument registers needs
to be modified. However at this point, they contains the firmware
arguments which are saved the bss section. To avoid issue, this patch
makes them part of the data section.

Also this patch makes sure that sp is setup before doing a jal.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Ralf,

 I haven't done any benchmarks but it seems the right thing to do.

 Please consider,

		Franck

 arch/mips/kernel/head.S  |   14 ++++++--------
 arch/mips/kernel/setup.c |   13 ++++++++++---
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 2367687..97273ae 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -171,14 +171,6 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	mtc0	t0, CP0_STATUS
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	PTR_LA		t0, __bss_start		# clear .bss
-	LONG_S		zero, (t0)
-	PTR_LA		t1, __bss_stop - LONGSIZE
-1:
-	PTR_ADDIU	t0, LONGSIZE
-	LONG_S		zero, (t0)
-	bne		t0, t1, 1b
-
 	LONG_S		a0, fw_arg0		# firmware arguments
 	LONG_S		a1, fw_arg1
 	LONG_S		a2, fw_arg2
@@ -191,6 +183,12 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	set_saved_sp	sp, t0, t1
 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
 
+	PTR_LA		a0, __bss_start		# clear .bss
+	move		a1, zero
+	PTR_LA		a2, __bss_stop
+	LONG_SUBU	a2, a0
+	jal		__fill_user		# no need to save ra
+
 	j		start_kernel
 	END(kernel_entry)
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index a06a27d..0eee73f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -30,6 +30,7 @@
 #include <asm/setup.h>
 #include <asm/system.h>
 
+unsigned long kernelsp[NR_CPUS];
 struct cpuinfo_mips cpu_data[NR_CPUS] __read_mostly;
 
 EXPORT_SYMBOL(cpu_data);
@@ -39,6 +40,15 @@ struct screen_info screen_info;
 #endif
 
 /*
+ * Note: they're part of the data section because they're used
+ * *before* bss is cleared.
+ */
+unsigned long fw_arg0 = ULONG_MAX;
+unsigned long fw_arg1 = ULONG_MAX;
+unsigned long fw_arg2 = ULONG_MAX;
+unsigned long fw_arg3 = ULONG_MAX;
+
+/*
  * Despite it's name this variable is even if we don't have PCI
  */
 unsigned int PCI_DMA_BUS_IS_PHYS;
@@ -571,9 +581,6 @@ static int __init dsp_disable(char *s)
 
 __setup("nodsp", dsp_disable);
 
-unsigned long kernelsp[NR_CPUS];
-unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
-
 #ifdef CONFIG_DEBUG_FS
 struct dentry *mips_debugfs_dir;
 static int __init debugfs_mips(void)
-- 
1.5.3.4
