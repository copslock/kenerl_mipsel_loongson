Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 17:53:23 +0000 (GMT)
Received: from p508B78D6.dip.t-dialin.net ([IPv6:::ffff:80.139.120.214]:61716
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225457AbUBERxW>; Thu, 5 Feb 2004 17:53:22 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i15Hptex023489;
	Thu, 5 Feb 2004 18:51:55 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i15HpkXf023488;
	Thu, 5 Feb 2004 18:51:46 +0100
Date: Thu, 5 Feb 2004 18:51:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Markus Dahms <dahms@fh-brandenburg.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Indy R4000PC problems
Message-ID: <20040205175146.GA18162@linux-mips.org>
References: <20040202160729.GA5966@fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202160729.GA5966@fh-brandenburg.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 05:07:29PM +0100, Markus Dahms wrote:

> I had problems getting the 2.4 kernel to work on an Indy with
> a R4000PC (100MHz) processor (very old PROM, too).
> The solution I found yesterday is to change an entry in
> arch/mips/kernel/cpu-probe.c from CPU_R4000SC to CPU_R4000PC.
> Is there a reason why only the SC version is thought to be
> there, or is it believed to be compatible?

The PC and SC versions are basically identical except the second level
cache which is missing in the PC version.

> Without this change the machine locks up after loading the
> kernel, linux hasn't switched to the black background, yet.
> 
> I also changed the compiler flags from -m{arch,tune}=r4600 to
> *r4000, but this I also tried before without success.

Do you know which version of the processor this is exactly?  IRIX's hinv
command or the "CPU revision is: ..." line of bootup messages contain
that information.

The PC version have become pretty rare, didn't recall anymore it was in
use in Indys at all.  Anyway, please try the patch below and let me know.

  Ralf

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.65
diff -u -r1.3.2.65 c-r4k.c
--- arch/mips/mm/c-r4k.c	2 Feb 2004 22:24:37 -0000	1.3.2.65
+++ arch/mips/mm/c-r4k.c	5 Feb 2004 17:50:37 -0000
@@ -965,10 +965,8 @@
 	 * Linux memory managment.
 	 */
 	switch (c->cputype) {
-	case CPU_R4000PC:
 	case CPU_R4000SC:
 	case CPU_R4000MC:
-	case CPU_R4400PC:
 	case CPU_R4400SC:
 	case CPU_R4400MC:
 		probe_scache_kseg1 = (probe_func_t) (KSEG1ADDR(&probe_scache));
Index: arch/mips/kernel/cpu-probe.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/cpu-probe.c,v
retrieving revision 1.1.2.31
diff -u -r1.1.2.31 cpu-probe.c
--- arch/mips/kernel/cpu-probe.c	19 Jan 2004 18:32:05 -0000	1.1.2.31
+++ arch/mips/kernel/cpu-probe.c	5 Feb 2004 17:50:39 -0000
@@ -192,10 +192,18 @@
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_R4000:
-		if ((c->processor_id & 0xff) >= PRID_REV_R4400)
-			c->cputype = CPU_R4400SC;
-		else
-			c->cputype = CPU_R4000SC;
+		if (read_c0_config() & CONF_SC) {
+			if ((c->processor_id & 0xff) >= PRID_REV_R4400)
+				c->cputype = CPU_R4400SC;
+			else
+				c->cputype = CPU_R4000SC;
+		} else {
+			if ((c->processor_id & 0xff) >= PRID_REV_R4400)
+				c->cputype = CPU_R4400SC;
+			else
+				c->cputype = CPU_R4000SC;
+		}
+
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 		             MIPS_CPU_WATCH | MIPS_CPU_VCE |
