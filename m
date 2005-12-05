Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 05:16:38 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:56792 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133428AbVLEFQM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2005 05:16:12 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sun, 04 Dec 2005 21:15:44 -0800
  id 00098008.4393CD00.00006FED
Message-ID: <4393CCEE.2080107@jg555.com>
Date:	Sun, 04 Dec 2005 21:15:26 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-28653-1133759744-0001-2"
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Patch for RaQ2 - cpu features.h
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-28653-1133759744-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This replaces the cpu-probe.c hack we had before, which disabled ll_sc.. 
I followed the format of theother cpu-feature-overrides.h.


-- 
----
Jim Gifford
maillist@jg555.com


--=_server-28653-1133759744-0001-2
Content-Type: text/x-diff; name="cobalt_override.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cobalt_override.patch"

diff -Naur linux-2.6.14.orig/include/asm-mips/cobalt/cpu-feature-overrides.h linux-2.6.14/include/asm-mips/cobalt/cpu-feature-overrides.h
--- linux-2.6.14.orig/include/asm-mips/cobalt/cpu-feature-overrides.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14/include/asm-mips/cobalt/cpu-feature-overrides.h	2005-11-29 23:02:33.000000000 +0000
@@ -0,0 +1,24 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004 Chris Dearman
+ * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
+ */
+#ifndef __ASM_COBALT_MIPS_CPU_FEATURE_OVERRIDES_H
+#define __ASM_COBALT_MIPS_CPU_FEATURE_OVERRIDES_H
+
+#include <linux/config.h>
+
+/*
+ * CPU feature overrides for Cobalt Servers
+ */
+
+#ifdef CONFIG_64BIT
+#define cpu_has_llsc            0
+#else
+#define cpu_has_llsc            1
+#endif
+
+#endif /* __ASM_COBALT_MIPS_CPU_FEATURE_OVERRIDES_H */

--=_server-28653-1133759744-0001-2--
