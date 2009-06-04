Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 15:15:27 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:63799 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021665AbZFDOPU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 15:15:20 +0100
Received: by fxm23 with SMTP id 23so815046fxm.0
        for <multiple recipients>; Thu, 04 Jun 2009 07:15:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=oKhb6ics4ju2dgd+fsQ18ae/nPxAcTXucsGxNTN1eWw=;
        b=juSggt+fgn22923w+HdGUbC3nCcZp/qh3uNQX/6J3+8ziMB6n3X/LzfAhrRdd4jl1N
         cHUvaT4k9z6vNTbMhz8CHujqwg7H54Ph7bIVoXWjIGNVm43pBN+2CkqeYkihrYIdVSPY
         QkkSgVtAM7+J17A0+5TG1u0oxdojaI4uqbXl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=CZEY3Fqj8NnX3XG+PmZqd14DqTBOkeyWNu8oITn/DC3PVNs5oRyt9XxrgOPTDIw4YL
         OMNvGxN62W/vBrVMkStSpVxbdoyw6mptQQa7Lfkr8/jW/9v46hOtcTceBpc//VRUQH2j
         XnLRQ1RSbZN7y+d2Q7dDcwlAc4rIswx94/xik=
Received: by 10.204.65.17 with SMTP id g17mr2019609bki.193.1244124914273;
        Thu, 04 Jun 2009 07:15:14 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 21sm11758580fkx.44.2009.06.04.07.15.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 07:15:13 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 4 Jun 2009 16:15:07 +0200
Subject: [PATCH 1/8] add lib/gcd.c
MIME-Version: 1.0
X-UID:	232
X-Length: 2489
To:	"Linux-MIPS" <linux-mips@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906041615.10467.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds lib/gcd.c which contains a greatest
common divider implementation taken from
sound/core/pcm_timer.c

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/include/linux/gcd.h b/include/linux/gcd.h
new file mode 100644
index 0000000..69f5e8a
--- /dev/null
+++ b/include/linux/gcd.h
@@ -0,0 +1,8 @@
+#ifndef _GCD_H
+#define _GCD_H
+
+#include <linux/compiler.h>
+
+unsigned long gcd(unsigned long a, unsigned long b) __attribute_const__;
+
+#endif /* _GCD_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 8ade0a7..70a9906 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -10,6 +10,9 @@ menu "Library routines"
 config BITREVERSE
 	tristate
 
+config GCD
+	bool
+
 config GENERIC_FIND_FIRST_BIT
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 33a40e4..389bdd2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_CRC_ITU_T)	+= crc-itu-t.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_CRC7)	+= crc7.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
+obj-$(CONFIG_GCD)	+= gcd.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff --git a/lib/gcd.c b/lib/gcd.c
new file mode 100644
index 0000000..fbf81a8
--- /dev/null
+++ b/lib/gcd.c
@@ -0,0 +1,20 @@
+#include <linux/gcd.h>
+#include <linux/module.h>
+
+/* Greatest common divisor */
+unsigned long gcd(unsigned long a, unsigned long b)
+{
+	unsigned long r;
+
+	if (a < b) {
+		r = a;
+		a = b;
+	b = r;
+	}
+	while ((r = a % b) != 0) {
+		a = b;
+		b = r;
+	}
+	return b;
+}
+EXPORT_SYMBOL(gcd);
