Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UF5YRw012773
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 08:05:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UF5Y84012772
	for linux-mips-outgoing; Tue, 30 Jul 2002 08:05:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UF5QRw012743
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 08:05:27 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA20427;
	Tue, 30 Jul 2002 17:07:16 +0200 (MET DST)
Date: Tue, 30 Jul 2002 17:07:16 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dan Temple <dant@mips.com>
cc: Carsten Langgaard <carstenl@mips.com>, cgd@broadcom.com, hjl@lucon.org,
   linux-mips@oss.sgi.com, binutils@sources.redhat.com
Subject: Re: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux:  RFC:elf_check_arch() rework)
In-Reply-To: <Pine.LNX.4.44.0207301606350.31951-100000@coplin18.mips.com>
Message-ID: <Pine.GSO.3.96.1020730165808.16647L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.3 required=5.0 tests=IN_REP_TO,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 30 Jul 2002, Dan Temple wrote:

> I've now heard a bit of the history from Nigel at Algorithmics, and to
> summarize, they chose the 6 and 7 values for MIPS32/64 after Cygnus, who
> were also producing a MIPS32/64 toolchain, had chosen these. (Algor had
> originally used the value of 5 for MIPS32, but had to changed when both
> SGI (who assigned it to something else) and Cygnus chose otherwise).
> Hence ARCH_ALGOR_32. 
> 
> A little research also reveals that the value of 5 for ARCH_32 was first
> checked into CVS in Dec 2000 by Nick Clifton at Redhat. 

 Hmm, the relevant ChangeLog entry is:

2000-10-16  Chris Demetriou  <cgd@sibyte.com>

	* mips.h (E_MIPS_ARCH_32): New constant.
	(E_MIPS_MACH_MIPS32, E_MIPS_MACH_MIPS32_4K): Replace the
	former with the latter.

	* mips.h (E_MIPS_ARCH_5, E_MIPS_ARCH_64): New definitions.

	* mips.h (E_MIPS_MACH_SB1): New constant.

Patches went in with two commits on Dec 1st and 2nd, 2000: 

http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/include/elf/mips.h.diff?r1=1.8&r2=1.9&cvsroot=src

http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/include/elf/mips.h.diff?r1=1.9&r2=1.10&cvsroot=src

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
