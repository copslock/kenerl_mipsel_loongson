Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FEKRi18534
	for linux-mips-outgoing; Fri, 15 Feb 2002 06:20:27 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FEKL918531
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 06:20:21 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA03199;
	Fri, 15 Feb 2002 14:17:30 +0100 (MET)
Date: Fri, 15 Feb 2002 14:17:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, mdharm@momenco.com,
   ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <008601c1b61e$ff4d88b0$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1020215140421.29773G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Kevin D. Kissell wrote:

> >  The code is not correct if "bc0f" is needed to be sure a write-back
> > happened.  If that is the case, the processors need their own wbflush() 
> > implementation like R2k/R3k configurations in older DECstations. 
> 
> Note that I did not say that "the code is correct", only that it
> is correct *in considering the TX39 to be effectively SYNC-less*.

 Then you are probably misinterpreting CONFIG_CPU_HAS_SYNC (shame on me
for not documenting it at all).  It means a CPU has the "sync" 
instruction but it does not imply a "sync" is sufficient for mb() on the
CPU.  See the code in include/asm-mips/system.h in my patch.  If
CONFIG_CPU_HAS_WB is set wbflush() is executed for mb() regardless the
setting of CONFIG_CPU_HAS_SYNC.  Fast_mb() is set to a "sync" in case a
wbflush() implementation needs it for something -- the DECstation's
wbflush() actually uses it in a patch I have queued waiting for my
pending submissions to be applied by Ralf.

> I'm sure that the code is anyway broken six ways from Wednesday,
> as usual.  ;-)

 I hope with my fixes the number of ways decreases, though. ;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
