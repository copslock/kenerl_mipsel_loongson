Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 05:40:34 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:8217 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022654AbYHFEk0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 05:40:26 +0100
Received: by mo.po.2iij.net (mo30) id m764eHH1021767; Wed, 6 Aug 2008 13:40:17 +0900 (JST)
Received: from rally.tokyo.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id m764eF9I021783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Aug 2008 13:40:16 +0900
Message-Id: <200808060440.m764eF9I021783@po-mbox303.hop.2iij.net>
Date:	Wed, 6 Aug 2008 13:42:13 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ricardo Mendoza <ricmm@gentoo.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
In-Reply-To: <20080806020818.GA10184@woodpecker.gentoo.org>
References: <20080805104314.GB4628@woodpecker.gentoo.org>
	<200808060147.m761l4Is022564@po-mbox303.hop.2iij.net>
	<20080806020818.GA10184@woodpecker.gentoo.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello Ricardo,

On Wed, 6 Aug 2008 02:08:18 +0000
Ricardo Mendoza <ricmm@gentoo.org> wrote:

> On Wed, Aug 06, 2008 at 10:49:01AM +0900, Yoichi Yuasa wrote:
>  
> > In VR4100 series User's Manual, it's being written
> > "IE bit of the Status register in the CP0 is also set to 1".
> > 
> > Do you have any problem on your board?
> 
> Hello Yoichi,
> 
> Just now I got my hands on the manual, I can see that the standby
> instruction sets IE bit to 1 but only on Vr4131 and Vr4181A cores, all
> others (such as my Vr4121) need to have interrupts enabled before going
> into standby.
> 
> The patch will make it work on all Vr4100 derivates, or we could also
> add code to build the function depending on CPU type. What do you think?

local_irq_disable() is included in the sample code on the User's Manul. 
I think the following patch is good way of this.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/common/pmu.c linux/arch/mips/vr41xx/common/pmu.c
--- linux-orig/arch/mips/vr41xx/common/pmu.c	2008-08-06 13:23:55.437185676 +0900
+++ linux/arch/mips/vr41xx/common/pmu.c	2008-08-06 13:32:56.744032999 +0900
@@ -46,11 +46,17 @@ static void __iomem *pmu_base;
 #define pmu_read(offset)		readw(pmu_base + (offset))
 #define pmu_write(offset, value)	writew((value), pmu_base + (offset))
 
+static void old_vr41xx_cpu_wait(void)
+{
+	__asm__("standby;\n");
+}
+
 static void vr41xx_cpu_wait(void)
 {
 	local_irq_disable();
 	if (!need_resched())
 		/*
+		 * VR4181A, VR4131 and later,
 		 * "standby" sets IE bit of the CP0_STATUS to 1.
 		 */
 		__asm__("standby;\n");
@@ -124,7 +130,17 @@ static int __init vr41xx_pmu_init(void)
 		return -EBUSY;
 	}
 
-	cpu_wait = vr41xx_cpu_wait;
+	switch (current_cpu_type()) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+	case CPU_VR4122:
+		cpu_wait = old_vr41xx_cpu_wait;
+		break;
+	default:
+		cpu_wait = vr41xx_cpu_wait;
+		break;
+	}
+
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
 	pm_power_off = vr41xx_halt;
