Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jul 2005 18:37:07 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:4802 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225334AbVGXRgs>; Sun, 24 Jul 2005 18:36:48 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DwkRM-0003I0-00
	for <linux-mips@linux-mips.org>; Sun, 24 Jul 2005 19:39:04 +0200
Date:	Sun, 24 Jul 2005 19:39:04 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: Invalid ticks per second on PM support
Message-ID: <20050724173904.GC26487@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello.

When I sent my patch to fix PM support
«http://www.linux-mips.org/archives/linux-mips/2005-07/msg00255.html»
I modified function counter0_irq() as follow:

	  #ifdef CONFIG_PM
	 -void counter0_irq(int irq, void *dev_id, struct pt_regs *regs)
	 +irqreturn_t counter0_irq(int irq, void *dev_id, struct pt_regs *regs)
	  {
		 unsigned long pc0;
		 int time_elapsed;
		 static int jiffie_drift = 0;
	  
	 -	 kstat.irqs[0][irq]++;
		 if (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20) {

I removed line «kstat.irqs[0][irq]++;» since I supposed that counter
is managed by __do_IRQ(), but now I notice that without such line
reading from /proc/interrups I get:

   hostname:~# while sleep 1 ; do grep 17: /proc/interrupts ; done
    17:      31710  Au1000 Rise Edge  Au1xxx TOY                                   
    17:      32236  Au1000 Rise Edge  Au1xxx TOY                                   
    17:      32762  Au1000 Rise Edge  Au1xxx TOY                                   
    17:      33288  Au1000 Rise Edge  Au1xxx TOY                                   
    17:      33814  Au1000 Rise Edge  Au1xxx TOY                                   
    17:      34340  Au1000 Rise Edge  Au1xxx TOY                                   
    17:      34866  Au1000 Rise Edge  Au1xxx TOY                                   
    17:      35392  Au1000 Rise Edge  Au1xxx TOY                                   

Where you can see that I have 500 ticks per second...

Applying this patch:

Index: arch/mips/au1000/common/time.c
===================================================================
RCS file: /home/develop/cvs_private/linux-mips-exadron/arch/mips/au1000/common/time.c,v
retrieving revision 1.2
diff -u -r1.2 time.c
--- a/arch/mips/au1000/common/time.c	18 Jul 2005 17:16:57 -0000	1.2
+++ b/arch/mips/au1000/common/time.c	24 Jul 2005 14:31:32 -0000
@@ -125,6 +125,8 @@
 	int time_elapsed;
 	static int jiffie_drift = 0;
 
+	kstat_this_cpu.irqs[irq]++;
+
 	if (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20) {
 		/* should never happen! */
 		printk(KERN_WARNING "counter 0 w status error\n");

Everything works well... but I'm a little puzzled about it.

Can someone of you (guru) explain it? :-p

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127
