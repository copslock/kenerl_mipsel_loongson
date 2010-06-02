Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 09:55:27 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:55748 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492550Ab0FBHzY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 09:55:24 +0200
Received: by pvb32 with SMTP id 32so816302pvb.36
        for <multiple recipients>; Wed, 02 Jun 2010 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Gsf0IrhSxNGEAeEjBxxVyeLcyheItQNjxqFA34GJPV4=;
        b=jvL76SmMT+lT7CS+FtqcOtiPdWge6gPS2Pf4tgEhK6Ew0ZCOTFlcNKAvygeUIJw7Xq
         Lj/AjDp9iVeYyLVI5In0+JCmciTqgQt/U8InwuAVsZTgJVk6uX/PsFDbfLqxon54LPKD
         EQgPwWajRUEB58Ehu35/JpHNhM1Eqc/58B2xA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=JSz6hm+B5d08sCmu8wjXkGI3+rOUZQHnzdriHBSOwvmhHFKuOZr6HopckyLPsc1rVS
         3dbubUXqdMxK+TcKDSKGgrJ/c5KkYjbbaFpxhAq8wiu7pDE0nEO4a2N6ol5LL71xtJRU
         e4AtChoLwT0x0GjvlASKL4CfKgmf06S/4Wg2E=
Received: by 10.115.134.14 with SMTP id l14mr6508849wan.184.1275465315104;
        Wed, 02 Jun 2010 00:55:15 -0700 (PDT)
Received: from stratos (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id n32sm66784800wae.22.2010.06.02.00.55.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 00:55:13 -0700 (PDT)
Date:   Wed, 2 Jun 2010 16:51:16 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue 1/2] MIPS: Move Cobalt Makefile parts to their own
 Platform file
Message-Id: <20100602165116.3d8aae62.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.16.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 26986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1085

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/Kbuild.platforms |    1 +
 arch/mips/Makefile         |    7 -------
 arch/mips/cobalt/Makefile  |    2 --
 arch/mips/cobalt/Platform  |    6 ++++++
 4 files changed, 7 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/cobalt/Platform

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 77e48b9..6c163c2 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -2,6 +2,7 @@
 
 platforms += alchemy
 platforms += ar7
+platforms += cobalt
 platforms += loongson
 platforms += mipssim
 platforms += sgi-ip27
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 090c969..6b6dc42 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -199,13 +199,6 @@ cflags-$(CONFIG_MACH_JAZZ)	+= -I$(srctree)/arch/mips/include/asm/mach-jazz
 load-$(CONFIG_MACH_JAZZ)	+= 0xffffffff80080000
 
 #
-# Cobalt Server
-#
-core-$(CONFIG_MIPS_COBALT)	+= arch/mips/cobalt/
-cflags-$(CONFIG_MIPS_COBALT)	+= -I$(srctree)/arch/mips/include/asm/mach-cobalt
-load-$(CONFIG_MIPS_COBALT)	+= 0xffffffff80080000
-
-#
 # DECstation family
 #
 core-$(CONFIG_MACH_DECSTATION)	+= arch/mips/dec/
diff --git a/arch/mips/cobalt/Makefile b/arch/mips/cobalt/Makefile
index 2379262..61a334a 100644
--- a/arch/mips/cobalt/Makefile
+++ b/arch/mips/cobalt/Makefile
@@ -7,5 +7,3 @@ obj-y := buttons.o irq.o lcd.o led.o reset.o rtc.o serial.o setup.o time.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
 obj-$(CONFIG_MTD_PHYSMAP)	+= mtd.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/cobalt/Platform b/arch/mips/cobalt/Platform
new file mode 100644
index 0000000..34123ef
--- /dev/null
+++ b/arch/mips/cobalt/Platform
@@ -0,0 +1,6 @@
+#
+# Cobalt Server
+#
+platform-$(CONFIG_MIPS_COBALT)	+= cobalt/
+cflags-$(CONFIG_MIPS_COBALT)	+= -I$(srctree)/arch/mips/include/asm/mach-cobalt
+load-$(CONFIG_MIPS_COBALT)	+= 0xffffffff80080000
-- 
1.7.1
