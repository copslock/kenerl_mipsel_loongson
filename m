Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 09:32:46 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.193]:8072 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133366AbWAYJcY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 09:32:24 +0000
Received: by zproxy.gmail.com with SMTP id l8so59167nzf
        for <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 01:36:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JG4wlhJcdMKDYNH5AvqNRjRbC9OXsU7kX+Pdt1rqUIwG+ovYC7rWI3I8KG6uR6KeyWnzGWw801kXkpb1Ny9PVflHDb9iq8gljHHN27foEaBnj/9Kxee8aF17QmH5YxH7sLMRJ8oQ9cDpnhkH9u7QwlZCd3U+AwLe7+1ffdw1Ia8=
Received: by 10.36.34.8 with SMTP id h8mr380117nzh;
        Wed, 25 Jan 2006 01:36:46 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Wed, 25 Jan 2006 01:36:46 -0800 (PST)
Message-ID: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
Date:	Wed, 25 Jan 2006 10:36:46 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	Ralf Baechle <ralf@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Here is a little patch to optimize swab operations by using "wsbh"
instruction available on mips revision 2 cpus. I do not know what
condition I should use to compile this only for mips r2 cpu though.

Comments ?

Thanks
--
               Franck

--- linux.git/include/asm-mips/byteorder.h~old	2006-01-25
09:39:33.000000000 +0100
+++ linux.git/include/asm-mips/byteorder.h	2006-01-25 10:30:10.000000000 +0100
@@ -8,15 +8,39 @@
 #ifndef _ASM_BYTEORDER_H
 #define _ASM_BYTEORDER_H

+#include <linux/compiler.h>
 #include <asm/types.h>

 #ifdef __GNUC__

+/* FIXME: MIPS_R2 only */
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
 #if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
 #  define __BYTEORDER_HAS_U64__
 #  define __SWAB_64_THRU_32__
 #endif

+#define __arch__swab16(x)	___arch__swab16(x)
+#define __arch__swab32(x)	___arch__swab32(x)
+
 #endif /* __GNUC__ */

 #if defined (__MIPSEB__)
