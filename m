Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 10:06:42 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:43790 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226030AbVF1JGV>; Tue, 28 Jun 2005 10:06:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E86BEE1C9D; Tue, 28 Jun 2005 11:05:49 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24355-05; Tue, 28 Jun 2005 11:05:49 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9E3C6E1C8A; Tue, 28 Jun 2005 11:05:49 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5S95QRE018292;
	Tue, 28 Jun 2005 11:05:26 +0200
Date:	Tue, 28 Jun 2005 10:05:30 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Markus Dahms <mad@automagically.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
In-Reply-To: <20050628062107.GA8665@gaspode.automagically.de>
Message-ID: <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl>
References: <20050627100757.GA27679@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl>
 <20050627141842.GA28236@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl>
 <20050628062107.GA8665@gaspode.automagically.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/959/Tue Jun 28 01:00:06 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Jun 2005, Markus Dahms wrote:

> | CPU revision is: 00000430
> | FPU revision is: 00000500
> | ...
> | Checking for the multiply/shift bug... yes, workaround... no.
> | kernel panic - not syncing: Reliable operation impossible!
> | Configure for R4000 to enable the workaround.
> 
> I configured the kernel for R4X00. There are a few references to
> CONFIG_CPU_R4000 in the source which doesn't seem to be a config
> option anymore, but I couldn't find a workaround somewhere...

 Well, yesterday evening I realized you mentioned the R4000 which has 
currently no way to run in the 64-bit mode with upstream Linux as there 
are grave errata in the CPU (in a couple of 64-bit instructions) that 
prevent reliable operation.  And I mean it -- with no workarounds enabled 
all I observed with my R4000 in my DECstation were random lock-ups, 
sometimes even before reaching userland (depending on stuff like cache 
alignment of some code with a given compilation).

 I implemented all the necessary workarounds and this includes Linux, GCC 
and binutils (further bits are needed for handcoded assembly programs if 
you want to run n32 or (n)64 userland; so far I've identified and fixed 
glibc and gmp).  If you'd like to use this system in the 64-bit mode you 
are most welcomed.  For this you can get toolchain bits from my site and I 
can supply you with a patch for Linux 2.4; I'll work on porting it to 2.6 
and actually applying upstream soon.

 As you may not be interested in binary RPM packages, you may just pull 
the necessary patches, which are all called "*-mips-nodaddi-*" and you 
have to make sure to rebuild all 64-bit binaries to be run on the R4000 
with either "-march=r4000" or "-mfix-r4000".  Unfortunately at the current 
state of affairs the GCC patch is not going to be accepted for inclusion 
upstream which means all the others have to live outside their respective 
official sources as well.

 I have successfully run 64-bit Linux on my R4000SC and early R4400SC 
which are both affected by these errata (but not exactly the same for both 
;-) ) for quite some time now.

 I have actually forgotten to mention you might indeed want to try a 
32-bit kernel as some low level bits differ and this is especially true 
given the above -- sorry about that.

> >> I'll also try the said patch (you're referring to "blast_scache nop ...",
> >> do you?).
> > Precisely.
> 
> doesn't change anything, neither for R4000PC nor for R4600PC.

 Well, the R4600 case was easy -- proofreading revealed the bug.  There is 
a cp0 hazard between updating a TLB entry and using it for an instruction 
fetch and for the R4600 it requires two instructions to clear.  
Unfortunately our handlers currently only execute a lone "eret" after TLB 
update instructions, which for TLB faults on instruction fetches triggers 
this hazard.  For data transfers there is no hazard in the R4600 and this 
is why your system has been able to progress through `init'; otherwise you 
would not see any output from it.

 Here's a patch.  I'm inclined to apply it as obviously correct but I'll 
resist for a while to let you provide some feedback.  The same hazard 
conditions are present for the R4700 and the R5000.  I've included the 
R5000A as well which, given the name, I've assumed was just a minor update 
to the R5000; anyone please correct me if I am wrong (but we don't ever 
use this CPU ID in Linux, so that would be for documentation only).

  Maciej

patch-mips-2.6.12-rc4-20050526-tlbex-r4600-0
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/arch/mips/mm/tlbex.c linux-mips-2.6.12-rc4-20050526/arch/mips/mm/tlbex.c
--- linux-mips-2.6.12-rc4-20050526.macro/arch/mips/mm/tlbex.c	2005-04-29 04:56:05.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/arch/mips/mm/tlbex.c	2005-06-28 01:14:39.000000000 +0000
@@ -828,11 +828,16 @@ static __init void build_tlb_write_entry
 		i_nop(p);
 		break;
 
-	case CPU_R4300:
 	case CPU_R4600:
 	case CPU_R4700:
 	case CPU_R5000:
 	case CPU_R5000A:
+		i_nop(p);
+		tlbw(p);
+		i_nop(p);
+		break;
+
+	case CPU_R4300:
 	case CPU_5KC:
 	case CPU_TX49XX:
 	case CPU_AU1000:
