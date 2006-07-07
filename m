Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 16:43:01 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:33869 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133502AbWGGPmV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 16:42:21 +0100
Received: by mo.po.2iij.net (mo31) id k67FgIp1083828; Sat, 8 Jul 2006 00:42:18 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k67FgD5t030391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 8 Jul 2006 00:42:14 +0900 (JST)
Date:	Sat, 8 Jul 2006 00:42:12 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] vr41xx: define P4K bit for VR41xx
Message-Id: <20060708004212.52cbf512.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has defined P4K bit for VR41xx.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/mm/c-r4k.c mips/arch/mips/mm/c-r4k.c
--- mips-orig/arch/mips/mm/c-r4k.c	2006-07-06 18:03:06.162320750 +0900
+++ mips/arch/mips/mm/c-r4k.c	2006-07-06 18:03:13.127272250 +0900
@@ -862,7 +862,7 @@ static void __init probe_pcache(void)
 		break;
 
 	case CPU_VR4133:
-		write_c0_config(config & ~CONF_EB);
+		write_c0_config(config & ~VR41_CONF_P4K);
 	case CPU_VR4131:
 		/* Workaround for cache instruction bug of VR4131 */
 		if (c->processor_id == 0x0c80U || c->processor_id == 0x0c81U ||
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mipsregs.h mips/include/asm-mips/mipsregs.h
--- mips-orig/include/asm-mips/mipsregs.h	2006-07-06 17:49:45.931927750 +0900
+++ mips/include/asm-mips/mipsregs.h	2006-07-06 18:09:30.443242500 +0900
@@ -470,6 +470,7 @@
 
 /* Bits specific to the VR41xx.  */
 #define VR41_CONF_CS		(_ULCAST_(1) << 12)
+#define VR41_CONF_P4K		(_ULCAST_(1) << 13)
 #define VR41_CONF_BP		(_ULCAST_(1) << 16)
 #define VR41_CONF_M16		(_ULCAST_(1) << 20)
 #define VR41_CONF_AD		(_ULCAST_(1) << 23)
