Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Apr 2004 19:55:44 +0100 (BST)
Received: from natsmtp00.rzone.de ([IPv6:::ffff:81.169.145.165]:34226 "EHLO
	natsmtp00.webmailer.de") by linux-mips.org with ESMTP
	id <S8225817AbUDDSzn>; Sun, 4 Apr 2004 19:55:43 +0100
Received: from excalibur.cologne.de (pD9E40B40.dip.t-dialin.net [217.228.11.64])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i34ItevZ018447;
	Sun, 4 Apr 2004 20:55:40 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 1BACmd-0001Gm-00; Sun, 04 Apr 2004 20:55:51 +0200
Date: Sun, 4 Apr 2004 20:55:51 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: debian-mips@lists.debian.org, linux-mips@linux-mips.org,
	ralf@gnu.org
Subject: [PATCH] ll/sc emulation fix (was: Kernel vs. glibc problems)
Message-ID: <20040404185551.GB31039@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org,
	ralf@gnu.org
References: <20040404115212.GA22445@excalibur.cologne.de> <20040404155010.GA1975@bogon.ms20.nix> <20040404173512.GA31039@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20040404173512.GA31039@excalibur.cologne.de>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 04, 2004 at 07:35:12PM +0200, Karsten Merker wrote:
> On Sun, Apr 04, 2004 at 05:50:10PM +0200, Guido Guenther wrote:
> > On Sun, Apr 04, 2004 at 01:52:12PM +0200, Karsten Merker wrote:
> > > On a DECstation 5000/20, having an R3000, the following combinations work:
> > > - Debian 2.4.19 plus Debian/Woody glibc (2.2.5)
> > > - Debian 2.4.19 plus Debian/Sarge glibc (2.3.2)
> > > - CVS 2.4.25 from 2004/03/25 plus Debian/Woody glibc (2.2.5)
> > > But running the same CVS 2.4.25 with the Debian/Sarge glibc (2.3.2)
> > > causes (at least) ls, sleep and tar to die with "illegal instruction".
> 
> > What is the illegal instruction? Gdb should tell.
> 
> It is an "ll" instruction in libpthread (checked in the cases of
> ls, sleep and tar). ll/sc should be emulated by the kernel on R3k,
> so it looks like there is a problem with the emulation code.

The reason seems to be in arch/mips/kernel/cpu-probe.c. In function
cpu_probe_legacy the following flags are set for R2k/R3k:

                c->options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX |
                             MIPS_CPU_LLSC;

i.e. R2k and R3k are assumed to have ll/sc implemented, so the
ll/sc emulation does not get called. The following micro-patch
should fix that.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ll-sc-emu-against-2.4.25.diff"

--- linux-mips-cvs-20040326/arch/mips/kernel/cpu-probe.c	Thu Feb  5 20:54:41 2004
+++ linux-mips-cvs-20040326.patched/arch/mips/kernel/cpu-probe.c	Sun Apr  4 20:23:21 2004
@@ -170,8 +170,7 @@
 	case PRID_IMP_R2000:
 		c->cputype = CPU_R2000;
 		c->isa_level = MIPS_CPU_ISA_I;
-		c->options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX |
-		             MIPS_CPU_LLSC;
+		c->options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
 			c->options |= MIPS_CPU_FPU;
 		c->tlbsize = 64;
@@ -185,8 +184,7 @@
 		else
 			c->cputype = CPU_R3000;
 		c->isa_level = MIPS_CPU_ISA_I;
-		c->options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX |
-		             MIPS_CPU_LLSC;
+		c->options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX; 
 		if (__cpu_has_fpu())
 			c->options |= MIPS_CPU_FPU;
 		c->tlbsize = 64;

--6TrnltStXW4iwmi0--
