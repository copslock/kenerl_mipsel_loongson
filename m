Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 13:03:19 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:65516 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025144AbZFAMDM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 13:03:12 +0100
Received: by ewy19 with SMTP id 19so8029459ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 05:03:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dIYrGSN2JMBbwOtvvhOEw5tyDj3vTKCl2dZyo+AzRNA=;
        b=RWZhiVVhNBLq5J09NQUWTSl6BSmQO96OiTU/a5FDXORQIj3CI6etzo9ytlWhLjPE5+
         W4q+vnHXeJnlXAogQId1ZUrwbmcJ1hvbBacEszZ+sQ4Dz3elA6izJm4qFLn8h8ePbnt7
         aXtD1HDuUhY3M69K/f6KmTfUilWhMQQDIbgiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=X809HlBvICkbzA3pJouVnAvSA87aNptpi38f0IDJmIR8X7TJJ64A1gQFD8V44K9WNr
         8xAT8BQMiRKEHo7XYhpn354OYdB0CvYNY4ZglsdG7ASHQBJ7n+Jj64bBr6UmFBuA6QSO
         UGypWbzoCroQm73xn5VXYZn6fpxro1FSQjDug=
Received: by 10.210.30.1 with SMTP id d1mr6312503ebd.50.1243857786366;
        Mon, 01 Jun 2009 05:03:06 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 23sm85274eya.29.2009.06.01.05.03.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 05:03:06 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 1 Jun 2009 14:03:04 +0200
Subject: [PATCH 9/9] wire in AR7 support.
MIME-Version: 1.0
X-UID:	181
X-Length: 2084
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	openwrt-devel@lists.openwrt.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906011403.04327.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch wires in the AR7 support in the MIPS
architecture.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c4a84a6..0a75275 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -22,6 +22,22 @@ choice
 config MACH_ALCHEMY
 	bool "Alchemy processor based machines"
 
+config AR7
+	bool "Texas Instruments AR7"
+	select BOOT_ELF32
+	select DMA_NONCOHERENT
+	select CEVT_R4K
+	select CSRC_R4K
+	select IRQ_CPU
+	select NO_EXCEPT_FILL
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_KGDB
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GENERIC_GPIO
+
 config BASLER_EXCITE
 	bool "Basler eXcite smart camera"
 	select CEVT_R4K
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c4cae9e..5e7b3b4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -174,6 +174,13 @@ libs-$(CONFIG_SIBYTE_CFE)	+= arch/mips/sibyte/cfe/
 #
 
 #
+# Texas Instruments AR7
+#
+core-$(CONFIG_AR7)		+= arch/mips/ar7/
+cflags-$(CONFIG_AR7)		+= -I$(srctree)/arch/mips/include/asm/mach-ar7
+load-$(CONFIG_AR7)		+= 0xffffffff94100000
+
+#
 # Acer PICA 61, Mips Magnum 4000 and Olivetti M700.
 #
 core-$(CONFIG_MACH_JAZZ)	+= arch/mips/jazz/
