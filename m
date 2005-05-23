Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 17:20:01 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:43693
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225795AbVEWQTp>; Mon, 23 May 2005 17:19:45 +0100
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4NGJh222761;
	Mon, 23 May 2005 18:19:43 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 23 May 2005 18:19:43 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4NGJgW04720;
	Mon, 23 May 2005 18:19:42 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Mon, 23 May 2005 18:19:42 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Richard Sandiford <rsandifo@redhat.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
In-Reply-To: <87oeb26vjb.fsf@firetop.home>
Message-ID: <Pine.GSO.4.10.10505231802070.3392-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Remember that support for %hi() and %lo() on REL targets is a GNU extension.

Erm. Are you sure?

SGI's ELF64 spec says:

"Any of the relocation types may appear in either a SHT_REL or a SHT_RELA
relocation section, except that relocation types involving AHL operands
are forbidden in a 64-bit SHT_REL section and discouraged in a 32-bit
SHT_REL section."

There is no word of GNU there and in any case SGI had their own tools. But
again, it is possible that the idea bounced back and forth...

> The assembler is expected to reorder the relocations so that the HI16s
> come before the LO16s.  It sounds like this isn't happening in your case,
> so which version of binutils are you using?

The user who sent the b0rked binary (`K) uses 2.15.94 or so (I'll ask him
again) / "gcc 3.5". On 2.15 / gcc 3.4.3 there is no problem like this (at
least I can't trigger it).

> This isn't really a change from gcc 3.4 to "gcc 3.5" (now known as 4.0 ;).

Well, one of %hi()s is reordered to beginning of a loop and this is what
makes it unpaired. I don't think that any assembler could fix that.

Thanks for answering,

Stanislaw
