Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 16:27:37 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:7744 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038531AbWJRP1b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2006 16:27:31 +0100
Received: by mo.po.2iij.net (mo32) id k9IFRRPI043469; Thu, 19 Oct 2006 00:27:27 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k9IFRNJS052170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Oct 2006 00:27:24 +0900 (JST)
Date:	Thu, 19 Oct 2006 00:27:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] merge a few printk in check_wait()
Message-Id: <20061019002718.1ca0ec56.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has merged a few printk in check_wait().

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/cpu-probe.c mips/arch/mips/kernel/cpu-probe.c
--- mips-orig/arch/mips/kernel/cpu-probe.c	2006-10-18 10:20:24.397574000 +0900
+++ mips/arch/mips/kernel/cpu-probe.c	2006-10-18 10:28:53.113366750 +0900
@@ -120,11 +120,9 @@ static inline void check_wait(void)
 	case CPU_R3081:
 	case CPU_R3081E:
 		cpu_wait = r3081_wait;
-		printk(" available.\n");
 		break;
 	case CPU_TX3927:
 		cpu_wait = r39xx_wait;
-		printk(" available.\n");
 		break;
 	case CPU_R4200:
 /*	case CPU_R4300: */
@@ -146,35 +144,30 @@ static inline void check_wait(void)
 	case CPU_74K:
  	case CPU_PR4450:
 		cpu_wait = r4k_wait;
-		printk(" available.\n");
 		break;
 	case CPU_TX49XX:
 		cpu_wait = r4k_wait_irqoff;
-		printk(" available.\n");
 		break;
 	case CPU_AU1000:
 	case CPU_AU1100:
 	case CPU_AU1500:
 	case CPU_AU1550:
 	case CPU_AU1200:
-		if (allow_au1k_wait) {
+		if (allow_au1k_wait)
 			cpu_wait = au1k_wait;
-			printk(" available.\n");
-		} else
-			printk(" unavailable.\n");
 		break;
 	case CPU_RM9000:
-		if ((c->processor_id & 0x00ff) >= 0x40) {
+		if ((c->processor_id & 0x00ff) >= 0x40)
 			cpu_wait = r4k_wait;
-			printk(" available.\n");
-		} else {
-			printk(" unavailable.\n");
-		}
 		break;
 	default:
-		printk(" unavailable.\n");
 		break;
 	}
+
+	if (cpu_wait)
+		printk(" available.\n");
+	else
+		printk(" unavailable.\n");
 }
 
 void __init check_bugs32(void)
