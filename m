Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 14:03:07 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:61335 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226089AbTAIODG>; Thu, 9 Jan 2003 14:03:06 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA01439;
	Thu, 9 Jan 2003 15:03:16 +0100 (MET)
Date: Thu, 9 Jan 2003 15:03:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Gilad Benjamini <gilad@riverhead.com>, linux-mips@linux-mips.org
Subject: Re: ksymoops and 64 bit mips
In-Reply-To: <20030109143822.A23928@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030109144947.225C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 9 Jan 2003, Ralf Baechle wrote:

> > Initially I got a lot of garbage.
> > Upgrdaing to ksymoops 2.4.5 , and using the --truncate=1 and 
> > -t elf32-little reduced 
> > the amount of garbage, but still all the output shown
> > was "No symbol available".
> > 
> > Any additional things I should do ?
> 
> Possibly your ksymoops is get confused by the System.map file.  The vmlinux
> file is a 32-bit ELF file but the System.map file contains the addresses
> sign-extended to 64-bit.  As a bandaid you can just chop off the high
> 32-bits of all addresses in System.map.

 Recent versions of ksymoops contain code to handle 64-bit MIPS flexibly
and are expected to take care of address aliases.  They don't works very
well, though, and I've done a few fixes.  They are available in a ksymoops
2.4.8 package at my site and hopefully will be applied in a future
release.

 Anyway the cross-ksymoops case referred by Gilad is tricky -- you need to
build ksymoops linking against an appropriate BFD library, i.e. one that
supports a MIPS64 target.  Additionally MIPS64-specific nm and objdump
programs have to be available to that ksymoops binary (cf. KSYMOOPS_NM and
KSYMOOPS_OBJDUMP environment variables). 

 For detailed information on using a cross-setup see the ksymoops
documentation.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
