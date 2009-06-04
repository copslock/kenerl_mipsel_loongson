Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:09:15 +0100 (WEST)
Received: from mail-px0-f186.google.com ([209.85.216.186]:34980 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022608AbZFDNH4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:07:56 +0100
Received: by mail-px0-f186.google.com with SMTP id 16so749871pxi.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:07:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zB4a/iPV2GCP98n7ZuL0G1zVeJNBuuFXEDX/O8k37qc=;
        b=GCO7u5e1bhKjos5R/gGdkHwvc2t5Smt70MbFZ5d/Rc48zZu3tlxMes9Eg5cqeETVbJ
         KqIb+I3kKTdQM1E1Qf6K0rI+s9EHzliCyzQVaFeNqbL/I7UL4dR2B5jg1AtT2CBXulYU
         ncSU2OAcu+aT5eTcNoEw3ZhgwGGmYe98/6clg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jgql6UYS/EGtResdNQNAz5zQx9tsgdVK+PN/8UUK8ZSRSRvhfWwc4RhGYI62z2dDDF
         BQgDu82XZBLC/D9KbD8jA2Vy8+MoSss1B3BO7lQ1m0fLLMOqrPXVIIhMbQO5dUONelkj
         U39jboU6Xz0jOiGJcqg/S/uLOk0+oFjb/jN8w=
Received: by 10.115.32.1 with SMTP id k1mr3536462waj.66.1244120875728;
        Thu, 04 Jun 2009 06:07:55 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id j26sm11158719waf.63.2009.06.04.06.07.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:07:55 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [loongson-PATCH-v3 16/25] enable halt command for yeeloong-7inch laptop
Date:	Thu,  4 Jun 2009 21:07:42 +0800
Message-Id: <bb532aa63a8d6c4d78d51397f61e5fc800278596.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

the only differences between yeeloong-7inch and yeeloong-8.9inc are the
screen size and shutdown logic. here only focus on the shutdown logic,
the screen size handling will be fixed later.

currently, I add two new kernel config options LEMOTE_YEELOONG_7INCH and
LEMOTE_YEELOONG_89INCH to let user select a suitable kernel for his
yeeloong laptop.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    7 +++++
 arch/mips/include/asm/mach-loongson/machine.h  |   18 ++++++++++--
 arch/mips/loongson/Kconfig                     |   12 ++++++++
 arch/mips/loongson/yeeloong-2f/reset.c         |   34 +++++++++++++++++++++--
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index cd6668b..ea99209 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -44,6 +44,13 @@ extern void mach_irq_dispatch(unsigned int pending);
 extern void mach_prepare_reboot(void);
 extern void mach_prepare_shutdown(void);
 
+/* We need this in some places... */
+#define delay()	({			\
+	int x;					\
+	for (x = 0; x < 100000; x++)  \
+		__asm__ __volatile__(""); \
+})
+
 #define LOONGSON_REG(x) \
 	(*(u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
 #define LOONGSON_IRQ_BASE	32
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index c920d39..15d8b93 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -50,13 +50,25 @@
  * 2, fill the PORT_LOW as EC register low part.
  * 3, fill the PORT_DATA as EC register write data or get the data from it.
  */
-#define	EC_IO_PORT_HIGH	0x0381
-#define	EC_IO_PORT_LOW	0x0382
-#define	EC_IO_PORT_DATA	0x0383
+#define	EC_RESET_IO_PORT_HIGH	0x0381
+#define	EC_RESET_IO_PORT_LOW	0x0382
+#define	EC_RESET_IO_PORT_DATA	0x0383
 #define	REG_RESET_HIGH	0xF4	/* reset the machine auto-clear : rd/wr */
 #define REG_RESET_LOW	0xEC
 #define	BIT_RESET_ON	(1 << 0)
 
+/* 7inch yeeloong have the different shutdown hardware logic from 8.9inch */
+#ifdef CONFIG_LEMOTE_YEELOONG2F_7INCH
+
+#define	EC_SHUTDOWN_IO_PORT_HIGH	0xff2d
+#define	EC_SHUTDOWN_IO_PORT_LOW		0xff2e
+#define	EC_SHUTDOWN_IO_PORT_DATA	0xff2f
+#define	REG_SHUTDOWN_HIGH	0xFC
+#define REG_SHUTDOWN_LOW	0x29
+#define	BIT_SHUTDOWN_ON	(1 << 1)
+
+#endif
+
 #endif	/* !CONFIG_LEMOTE_FULOONG2E */
 
 /* fuloong2f and yeeloong2f have the same IRQ control interface */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 9cc817f..63d00c1 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -93,6 +93,18 @@ config LEMOTE_YEELOONG2F
 
 endchoice
 
+choice
+	prompt "YeeLoong Type"
+	depends on LEMOTE_YEELOONG2F
+
+config LEMOTE_YEELOONG2F_89INCH
+	bool "8.9 inch"
+
+config LEMOTE_YEELOONG2F_7INCH
+	bool "7 inch"
+
+endchoice
+
 config CS5536
 	bool
 
diff --git a/arch/mips/loongson/yeeloong-2f/reset.c b/arch/mips/loongson/yeeloong-2f/reset.c
index a3719a4..294592f 100644
--- a/arch/mips/loongson/yeeloong-2f/reset.c
+++ b/arch/mips/loongson/yeeloong-2f/reset.c
@@ -24,17 +24,45 @@ void mach_prepare_reboot(void)
 	LOONGSON_CHIPCFG0 |= 0x7;
 
 	/* sending an reset signal to EC(embedded controller) */
-	writeb(REG_RESET_HIGH, (u8 *) (mips_io_port_base + EC_IO_PORT_HIGH));
-	writeb(REG_RESET_LOW, (u8 *) (mips_io_port_base + EC_IO_PORT_LOW));
+	writeb(REG_RESET_HIGH,
+	       (u8 *) (mips_io_port_base + EC_RESET_IO_PORT_HIGH));
+	writeb(REG_RESET_LOW,
+	       (u8 *) (mips_io_port_base + EC_RESET_IO_PORT_LOW));
 	mmiowb();
-	writeb(BIT_RESET_ON, (u8 *) (mips_io_port_base + EC_IO_PORT_DATA));
+	writeb(BIT_RESET_ON,
+	       (u8 *) (mips_io_port_base + EC_RESET_IO_PORT_DATA));
 	mmiowb();
 }
 
 void mach_prepare_shutdown(void)
 {
+#ifdef CONFIG_LEMOTE_YEELOONG2F_7INCH
+	{
+		u8 val;
+		u64 i;
+
+		writeb(REG_SHUTDOWN_HIGH,
+		       (u8 *) (mips_io_port_base + EC_SHUTDOWN_IO_PORT_HIGH));
+		writeb(REG_SHUTDOWN_LOW,
+		       (u8 *) (mips_io_port_base + EC_SHUTDOWN_IO_PORT_LOW));
+		mmiowb();
+		val =
+		    readb((u8 *) (mips_io_port_base +
+				  EC_SHUTDOWN_IO_PORT_DATA));
+		writeb(val & (~BIT_SHUTDOWN_ON),
+		       (u8 *) (mips_io_port_base + EC_SHUTDOWN_IO_PORT_DATA));
+		mmiowb();
+		/* need enough wait here... how many microseconds needs? */
+		for (i = 0; i < 0x10000; i++)
+			delay();
+		writeb(val | BIT_SHUTDOWN_ON,
+		       (u8 *) (mips_io_port_base + EC_SHUTDOWN_IO_PORT_DATA));
+		mmiowb();
+	}
+#else
 	/* cpu-gpio0 output low */
 	LOONGSON_GPIODATA &= ~0x00000001;
 	/* cpu-gpio0 as output */
 	LOONGSON_GPIOIE &= ~0x00000001;
+#endif
 }
-- 
1.6.0.4
