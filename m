Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NFxdRw005077
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 08:59:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NFxdCB005076
	for linux-mips-outgoing; Tue, 23 Jul 2002 08:59:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NFxURw005067
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 08:59:31 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA01637;
	Tue, 23 Jul 2002 18:00:53 +0200 (MET DST)
Date: Tue, 23 Jul 2002 18:00:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
In-Reply-To: <003b01c23256$b262f080$1604c0d8@Ulysses>
Message-ID: <Pine.GSO.3.96.1020723164235.29699A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 23 Jul 2002, Kevin D. Kissell wrote:

> >  The following patch removes the code for 2.4.  For the trunk
> > cpu_has_fpu() would be removed as well.  Any objections?
> 
> I'm on the road and don't have ready access to the sources,
> but if I understand you correctly, I object.  The MIPS 5Kc and 
> the NEC Vr41xx are two examples of 64-bit CPUs which don't 
> have FPUs, and I believe there is at least one other from
> Toshiba. (Tx49-something-or-other).

 The function is exclusively for R2000/R3000 (mostly based on your past
suggestion there are broken processors that lock up on CP1 instructions
when none is present) which may have an external FPU.  Vr41xx CPUs have
FPU absence hardcoded (as do others which can't have an FPU) and MIPS32/64
ones obtain the information from the CP0 Config1 register, obviously.  The
function is never reached on a mips64 kernel -- there is no need to bloat
binaries with it.

 The coincidence with the i386's cpu_has_fpu definition is misleading.  At
this point we check MIPS_CPU_FPU in mips_cpu.options directly and there is
no need to wrap it in a macro, at least not yet. 

> My personal bleief is that the mips and mips64 trees 
> should ultimately be merged, and that creating additional 
> and gratuitous differences should be avoided.

 I don't think it's possible to be fully achieved.  Some differences will
have to exist, at least in the headers, but likely within the arch tree as
well.  The reason is binary code size or perfomance -- having R3000
support code in mips64 binaries is simply ridiculous as is using 32-bit
operations with 64-bit data on a 64-bit CPU.  However, it is worth trying
to minimize visible differences where possible, e.g. by convincing the
compiler to optimize irrelevant bits away. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
