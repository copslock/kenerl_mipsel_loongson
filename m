Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 18:39:18 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:50190 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224907AbUKVSjM>; Mon, 22 Nov 2004 18:39:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EA6FEF59A8; Mon, 22 Nov 2004 19:39:00 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25932-05; Mon, 22 Nov 2004 19:39:00 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 99DCCF59A3; Mon, 22 Nov 2004 19:39:00 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAMIdDG9020926;
	Mon, 22 Nov 2004 19:39:14 +0100
Date: Mon, 22 Nov 2004 18:39:02 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <20041122155631.GD902@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.58L.0411221812070.31113@blysk.ds.pg.gda.pl>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
 <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.58L.0411221428330.31113@blysk.ds.pg.gda.pl>
 <20041122155631.GD902@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/590/Wed Nov 17 22:03:52 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 22 Nov 2004, Thiemo Seufer wrote:

> >  Great stuff!  Thanks a lot.  I gave it some testing on hardware available 
> > to me and it works just fine.  I've got a couple of warnings upon 
> > building, though:
> > 
> > arch/mips/mm/tlbex.c:500: warning: 'i_LA' defined but not used
> > arch/mips/mm/tlbex.c:568: warning: 'insn_has_bdelay' defined but not used
> > arch/mips/mm/tlbex.c:582: warning: 'il_bltz' defined but not used
> > arch/mips/mm/tlbex.c:588: warning: 'il_b' defined but not used
> > 
> > How about marking them "attribute((unused))"?  I can do that if you agree.
> 
> Please do so, but IIRC there's a compiler-independent Linux-specific

 It is the reverse -- there is a macro called "__attribute_used__" for use
to prevent object removal and it normally expands to "attribute((used))",
unless the compiler is old enough not to support it.  Only then it expands
to "attribute((unused))", merely to kill this warning.  But in this case
we don't mind such removals -- they are actually welcome and we (now) know
of that, so we just want to get rid of the warnings completely.

 I don't think we support building with GCC that doesn't support this
attribute; a brief research suggests this dates back to GCC 2.7.  Anyone
please feel free to correct me.

 Oh yeah -- there is a macro called "ACPI_UNUSED_VAR"; to deal with
incorrect compilers I suppose... ;-)

> define which is preferable. Newest gcc just removes unused static
> functions without further notice, AFAIK.

 This is with 3.4.2 -- 4.0 could be different indeed (docs suggest
otherwise, but they could lag a bit; I'm too lazy to dig change logs).

  Maciej
