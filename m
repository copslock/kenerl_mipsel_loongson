Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 09:07:19 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:53282 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037495AbWJSIHQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2006 09:07:16 +0100
Received: by mo.po.2iij.net (mo31) id k9J87ANu087612; Thu, 19 Oct 2006 17:07:10 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k9J879mg003010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Oct 2006 17:07:09 +0900 (JST)
Date:	Thu, 19 Oct 2006 17:07:09 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] merge a few printk in check_wait()
Message-Id: <20061019170709.54a8b9a6.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061018161551.GA15530@linux-mips.org>
References: <20061019002718.1ca0ec56.yoichi_yuasa@tripeaks.co.jp>
	<45364F82.8030308@innova-card.com>
	<20061018161551.GA15530@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Wed, 18 Oct 2006 17:15:52 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Oct 18, 2006 at 06:00:02PM +0200, Franck Bui-Huu wrote:
> 
> > 
> > 	printk(" %savailable.\n", cpu_wait ? "" : "un");
> 
> Or more radical, just getting rid of the printk entirely?  It doesn't
> provide very useful information.
> 
>   Ralf
> 

I agree with you.
I updated my patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/cpu-probe.c mips/arch/mips/kernel/cpu-probe.c
--- mips-orig/arch/mips/kernel/cpu-probe.c	2006-10-19 10:27:36.246613000 +0900
+++ mips/arch/mips/kernel/cpu-probe.c	2006-10-19 10:28:08.504629000 +0900
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
@@ -146,33 +144,23 @@ static inline void check_wait(void)
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
 }
