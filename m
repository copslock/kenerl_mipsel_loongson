Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 13:36:58 +0100 (BST)
Received: from elvis.franken.de ([IPv6:::ffff:193.175.24.41]:48601 "EHLO
	elvis.franken.de") by linux-mips.org with ESMTP id <S8225241AbUJCMgx>;
	Sun, 3 Oct 2004 13:36:53 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1CE4xz-0003wF-0C; Sun, 03 Oct 2004 13:55:51 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4D72A27C65; Sun,  3 Oct 2004 13:40:47 +0200 (CEST)
Date: Sun, 3 Oct 2004 13:40:47 +0200
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20041003114047.GA10766@solo.franken.de>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org> <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de> <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.3.28i
From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sat, Oct 02, 2004 at 10:40:14PM +0200, Thiemo Seufer wrote:
> Thiemo Seufer wrote:
> [snip]
> > > With this fix the machines goes userspace (reverse engineered by sound
> > > of hard disk) but seems to die somewhere. Probably the same bug as seen
> > > on other archs - die on first fork.
> > 
> > The last problem happens only on r4000 and r4400, and occasionally
> > also shows up as "illegal instruction" or "unaligned access". It
> > turned out to be a broken TLB handler. I temporarily switched (for
> > 32bit kernels) from except_vec0_r4000 to except_vec0_r45k_bvahwbug.
> > This may cause an avoidable performance loss, but at least it allows
> > my R4400SC-200 (V6.0) Indy to run current 2.6 CVS.
> 
> One more nop is enough to make it work. This should probably go in
> a hazard definition.

excellent, this gets up my Indigo 2 with a 200 MHz CPU

and

my M700:

root@(none):/# cat /proc/cpuinfo
system type             : Jazz MIPS_Magnum_4000
processor               : 0
cpu model               : R4000PC V3.0  FPU V0.0
BogoMIPS                : 49.76
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 48
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 0
VCEI exceptions         : 0                                                     

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
