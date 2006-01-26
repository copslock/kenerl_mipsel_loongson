Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 11:04:14 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.205]:11584 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133500AbWAZLD4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 11:03:56 +0000
Received: by zproxy.gmail.com with SMTP id l8so336541nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 03:08:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZRyUGbfzMt6qerDoRt14SZYEgKL+uVj+UJkocrrJJ5ZbokPvzlCNr3I84Zi5f09JYYYColmdCPjZ30YRNptf+XGHeSFdpLjcLRsGsWJo67DqEpcM+AVW3JDXl0NJRdOSO18v9kd4GPG7OgQrOpvlXJPGki6o/dy6ZPvUUHQsFVE=
Received: by 10.36.86.11 with SMTP id j11mr1383738nzb;
        Thu, 26 Jan 2006 03:08:25 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 03:08:25 -0800 (PST)
Message-ID: <cda58cb80601260308v3eecf0d0w@mail.gmail.com>
Date:	Thu, 26 Jan 2006 12:08:25 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Optimize swab operations
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch uses 'wsbh' instruction to optimize swab operations. This
instruction is part of the MIPS Release 2 instructions set.

Signed-off-by: Franck BUI-HUU <vagabon.xyz@gmail.com>
---

 include/asm-mips/byteorder.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

4dc5b8c501404d1d133e45ea99f1cd54bbb8e37f
diff --git a/include/asm-mips/byteorder.h b/include/asm-mips/byteorder.h
index d1fe9e5..f9f5059 100644
--- a/include/asm-mips/byteorder.h
+++ b/include/asm-mips/byteorder.h
@@ -8,10 +8,37 @@
 #ifndef _ASM_BYTEORDER_H
 #define _ASM_BYTEORDER_H

+#include <linux/compiler.h>
 #include <asm/types.h>

 #ifdef __GNUC__

+#ifdef CONFIG_CPU_MIPSR2
+
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
+{
+	__asm__(
+		"wsbh	%0, %1\n"
+		: "=r" (x)
+		: "r" (x));
+	return x;
+}
+
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
+{
+	__asm__(
+		"wsbh	%0, %1\n\t"
+		"rotr	%0, %0, 16\n"
+		: "=r" (x)
+		: "r" (x));
+	return x;
+}
+
+#define __arch__swab16(x)	___arch__swab16(x)
+#define __arch__swab32(x)	___arch__swab32(x)
+
+#endif /* CONFIG_CPU_MIPSR2 */
+
 #if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
 #  define __BYTEORDER_HAS_U64__
 #  define __SWAB_64_THRU_32__
