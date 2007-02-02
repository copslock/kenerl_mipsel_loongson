Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 09:59:20 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:23571 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20039092AbXBBJ7P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 09:59:15 +0000
Received: (qmail 24012 invoked by uid 1000); 2 Feb 2007 10:58:14 +0100
Date:	Fri, 2 Feb 2007 10:58:14 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.20-rc: au1x irqs broken
Message-ID: <20070202095814.GA23967@roarinelk.homelinux.net>
References: <20070202061356.GA23661@roarinelk.homelinux.net> <20070202.161857.55145886.nemoto@toshiba-tops.co.jp> <20070202075328.GB23737@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070202075328.GB23737@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri, Feb 02, 2007 at 08:53:28AM +0100, Manuel Lauss wrote:
> On Fri, Feb 02, 2007 at 04:18:57PM +0900, Atsushi Nemoto wrote:
> > On Fri, 2 Feb 2007 07:13:56 +0100, Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> > > mips-git commit 1603b5aca14f15b34848fb5594d0c7b6333b99144 broke
> > > au1x irqs. The kernel boots; however it is not able to
> > > mount nfsroot. Reverting the arch/mips/au1000/common/irq.c
> > > bits of the above commit fixes it.
> > 
> > Thank you for report.  But I can not see how that change break au1x.
> 
> I'm sorry, it was my fault. For some reason I commented out all the
> .ack/.end fields in the irq_chip descriptions to make an earlier

Here's what tripped me up. I switched au1x over to use the kernel
flow handlers, and forgot to undo all of it.

rediffed against 2.6.20-rc7

diff -Naurp linux-2.6.20-rc7/arch/mips/au1000/common/irq.c linux-2.6.20-rc7-work/arch/mips/au1000/common/irq.c
--- linux-2.6.20-rc7/arch/mips/au1000/common/irq.c	2007-02-01 15:04:35.601983000 +0100
+++ linux-2.6.20-rc7-work/arch/mips/au1000/common/irq.c	2007-02-02 11:23:35.251983000 +0100
@@ -70,7 +70,6 @@ extern irq_cpustat_t irq_stat [NR_CPUS];
 extern void mips_timer_interrupt(void);
 
 static void setup_local_irq(unsigned int irq, int type, int int_req);
-static void end_irq(unsigned int irq_nr);
 static inline void mask_and_ack_level_irq(unsigned int irq_nr);
 static inline void mask_and_ack_rise_edge_irq(unsigned int irq_nr);
 static inline void mask_and_ack_fall_edge_irq(unsigned int irq_nr);
@@ -111,7 +109,7 @@ inline void local_disable_irq(unsigned i
 }
 
 
-static inline void mask_and_ack_rise_edge_irq(unsigned int irq_nr)
+static void mask_and_ack_rise_edge_irq(unsigned int irq_nr)
 {
 	if (irq_nr > AU1000_LAST_INTC0_INT) {
 		au_writel(1<<(irq_nr-32), IC1_RISINGCLR);
@@ -125,7 +123,7 @@ static inline void mask_and_ack_rise_edg
 }
 
 
-static inline void mask_and_ack_fall_edge_irq(unsigned int irq_nr)
+static void mask_and_ack_fall_edge_irq(unsigned int irq_nr)
 {
 	if (irq_nr > AU1000_LAST_INTC0_INT) {
 		au_writel(1<<(irq_nr-32), IC1_FALLINGCLR);
@@ -139,7 +137,7 @@ static inline void mask_and_ack_fall_edg
 }
 
 
-static inline void mask_and_ack_either_edge_irq(unsigned int irq_nr)
+static void mask_and_ack_either_edge_irq(unsigned int irq_nr)
 {
 	/* This may assume that we don't get interrupts from
 	 * both edges at once, or if we do, that we don't care.
@@ -158,7 +156,7 @@ static inline void mask_and_ack_either_e
 }
 
 
-static inline void mask_and_ack_level_irq(unsigned int irq_nr)
+static void mask_and_ack_level_irq(unsigned int irq_nr)
 {
 
 	local_disable_irq(irq_nr);
@@ -172,20 +170,6 @@ static inline void mask_and_ack_level_ir
 	return;
 }
 
-
-static void end_irq(unsigned int irq_nr)
-{
-	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
-		local_enable_irq(irq_nr);
-	}
-#if defined(CONFIG_MIPS_PB1000)
-	if (irq_nr == AU1000_GPIO_15) {
-		au_writel(0x4000, PB1000_MDR); /* enable int */
-		au_sync();
-	}
-#endif
-}
-
 unsigned long save_local_and_disable(int controller)
 {
 	int i;
@@ -233,39 +217,31 @@ void restore_local_and_enable(int contro
 
 
 static struct irq_chip rise_edge_irq_type = {
-	.typename = "Au1000 Rise Edge",
-	.ack = mask_and_ack_rise_edge_irq,
+	.name = "Au1000",
 	.mask = local_disable_irq,
 	.mask_ack = mask_and_ack_rise_edge_irq,
 	.unmask = local_enable_irq,
-	.end = end_irq,
 };
 
 static struct irq_chip fall_edge_irq_type = {
-	.typename = "Au1000 Fall Edge",
-	.ack = mask_and_ack_fall_edge_irq,
+	.name = "Au1000",
 	.mask = local_disable_irq,
 	.mask_ack = mask_and_ack_fall_edge_irq,
 	.unmask = local_enable_irq,
-	.end = end_irq,
 };
 
 static struct irq_chip either_edge_irq_type = {
-	.typename = "Au1000 Rise or Fall Edge",
-	.ack = mask_and_ack_either_edge_irq,
+	.name = "Au1000",
 	.mask = local_disable_irq,
 	.mask_ack = mask_and_ack_either_edge_irq,
 	.unmask = local_enable_irq,
-	.end = end_irq,
 };
 
 static struct irq_chip level_irq_type = {
-	.typename = "Au1000 Level",
-	.ack = mask_and_ack_level_irq,
+	.name = "Au1000",
 	.mask = local_disable_irq,
 	.mask_ack = mask_and_ack_level_irq,
 	.unmask = local_enable_irq,
-	.end = end_irq,
 };
 
 #ifdef CONFIG_PM
@@ -309,31 +285,31 @@ static void setup_local_irq(unsigned int
 				au_writel(1<<(irq_nr-32), IC1_CFG2CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG1CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG0SET);
-				set_irq_chip(irq_nr, &rise_edge_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &rise_edge_irq_type, handle_edge_irq, "riseedge");
 				break;
 			case INTC_INT_FALL_EDGE: /* 0:1:0 */
 				au_writel(1<<(irq_nr-32), IC1_CFG2CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG1SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG0CLR);
-				set_irq_chip(irq_nr, &fall_edge_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &fall_edge_irq_type, handle_edge_irq, "falledge");
 				break;
 			case INTC_INT_RISE_AND_FALL_EDGE: /* 0:1:1 */
 				au_writel(1<<(irq_nr-32), IC1_CFG2CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG1SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG0SET);
-				set_irq_chip(irq_nr, &either_edge_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &either_edge_irq_type, handle_edge_irq, "bothedge");
 				break;
 			case INTC_INT_HIGH_LEVEL: /* 1:0:1 */
 				au_writel(1<<(irq_nr-32), IC1_CFG2SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG1CLR);
 				au_writel(1<<(irq_nr-32), IC1_CFG0SET);
-				set_irq_chip(irq_nr, &level_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &level_irq_type, handle_level_irq, "highlevel");
 				break;
 			case INTC_INT_LOW_LEVEL: /* 1:1:0 */
 				au_writel(1<<(irq_nr-32), IC1_CFG2SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG1SET);
 				au_writel(1<<(irq_nr-32), IC1_CFG0CLR);
-				set_irq_chip(irq_nr, &level_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &level_irq_type, handle_level_irq, "lowlevel");
 				break;
 			case INTC_INT_DISABLED: /* 0:0:0 */
 				au_writel(1<<(irq_nr-32), IC1_CFG0CLR);
@@ -361,31 +337,31 @@ static void setup_local_irq(unsigned int
 				au_writel(1<<irq_nr, IC0_CFG2CLR);
 				au_writel(1<<irq_nr, IC0_CFG1CLR);
 				au_writel(1<<irq_nr, IC0_CFG0SET);
-				set_irq_chip(irq_nr, &rise_edge_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &rise_edge_irq_type, handle_edge_irq, "riseedge");
 				break;
 			case INTC_INT_FALL_EDGE: /* 0:1:0 */
 				au_writel(1<<irq_nr, IC0_CFG2CLR);
 				au_writel(1<<irq_nr, IC0_CFG1SET);
 				au_writel(1<<irq_nr, IC0_CFG0CLR);
-				set_irq_chip(irq_nr, &fall_edge_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &fall_edge_irq_type, handle_edge_irq, "falledge");
 				break;
 			case INTC_INT_RISE_AND_FALL_EDGE: /* 0:1:1 */
 				au_writel(1<<irq_nr, IC0_CFG2CLR);
 				au_writel(1<<irq_nr, IC0_CFG1SET);
 				au_writel(1<<irq_nr, IC0_CFG0SET);
-				set_irq_chip(irq_nr, &either_edge_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &either_edge_irq_type, handle_edge_irq, "bothedge");
 				break;
 			case INTC_INT_HIGH_LEVEL: /* 1:0:1 */
 				au_writel(1<<irq_nr, IC0_CFG2SET);
 				au_writel(1<<irq_nr, IC0_CFG1CLR);
 				au_writel(1<<irq_nr, IC0_CFG0SET);
-				set_irq_chip(irq_nr, &level_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &level_irq_type, handle_level_irq, "highlevel");
 				break;
 			case INTC_INT_LOW_LEVEL: /* 1:1:0 */
 				au_writel(1<<irq_nr, IC0_CFG2SET);
 				au_writel(1<<irq_nr, IC0_CFG1SET);
 				au_writel(1<<irq_nr, IC0_CFG0CLR);
-				set_irq_chip(irq_nr, &level_irq_type);
+				set_irq_chip_and_handler_name(irq_nr, &level_irq_type, handle_level_irq, "lowlevel");
 				break;
 			case INTC_INT_DISABLED: /* 0:0:0 */
 				au_writel(1<<irq_nr, IC0_CFG0CLR);
diff -Naurp linux-2.6.20-rc7/arch/mips/kernel/irq.c linux-2.6.20-rc7-work/arch/mips/kernel/irq.c
--- linux-2.6.20-rc7/arch/mips/kernel/irq.c	2007-02-01 15:04:35.831983000 +0100
+++ linux-2.6.20-rc7-work/arch/mips/kernel/irq.c	2007-02-02 11:15:34.201983000 +0100
@@ -118,6 +118,7 @@ int show_interrupts(struct seq_file *p, 
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].chip->name);
+		seq_printf(p, "-%-8s", irq_desc[i].name);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
