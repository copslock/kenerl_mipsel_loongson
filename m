Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 16:42:18 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:29764 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133495AbWGGPmJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 16:42:09 +0100
Received: by mo.po.2iij.net (mo30) id k67Fg64p018143; Sat, 8 Jul 2006 00:42:06 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k67Fg234030353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 8 Jul 2006 00:42:03 +0900 (JST)
Date:	Sat, 8 Jul 2006 00:42:01 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] vr41xx: changed the workaround to recommended method
Message-Id: <20060708004201.3a677b9c.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has changed the workaround to recommended method.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/mm/c-r4k.c mips/arch/mips/mm/c-r4k.c
--- mips-orig/arch/mips/mm/c-r4k.c	2006-07-06 17:54:34.149940250 +0900
+++ mips/arch/mips/mm/c-r4k.c	2006-07-06 18:00:15.249128000 +0900
@@ -867,12 +867,13 @@ static void __init probe_pcache(void)
 		/* Workaround for cache instruction bug of VR4131 */
 		if (c->processor_id == 0x0c80U || c->processor_id == 0x0c81U ||
 		    c->processor_id == 0x0c82U) {
-			config &= ~0x00000030U;
 			config |= 0x00400000U;
 			if (c->processor_id == 0x0c80U)
 				config |= VR41_CONF_BP;
 			write_c0_config(config);
-		}
+		} else
+			c->options |= MIPS_CPU_CACHE_CDEX_P;
+
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
@@ -882,8 +883,6 @@ static void __init probe_pcache(void)
 		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
 		c->dcache.waybit = __ffs(dcache_size/2);
-
-		c->options |= MIPS_CPU_CACHE_CDEX_P;
 		break;
 
 	case CPU_VR41XX:
