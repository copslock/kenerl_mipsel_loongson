Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 12:18:11 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:45506 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225544AbVEWLRz>;
	Mon, 23 May 2005 12:17:55 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4NBHpcO021288;
	Mon, 23 May 2005 07:17:51 -0400
Received: from firetop.home (vpn50-11.rdu.redhat.com [172.16.50.11])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4NBHoO09935;
	Mon, 23 May 2005 07:17:50 -0400
Received: from rsandifo by firetop.home with local (Exim 4.50)
	id 1DaAwK-0002Ok-Fp; Mon, 23 May 2005 12:17:44 +0100
From:	Richard Sandiford <rsandifo@redhat.com>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
References: <Pine.GSO.4.10.10505230905300.4132-100000@helios.et.put.poznan.pl>
Date:	Mon, 23 May 2005 12:17:44 +0100
In-Reply-To: <Pine.GSO.4.10.10505230905300.4132-100000@helios.et.put.poznan.pl>
	(Stanislaw Skowronek's message of "Mon, 23 May 2005 09:10:25 +0200
	(MET DST)")
Message-ID: <87oeb26vjb.fsf@firetop.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL> writes:
> It seems that gcc (with -O; -O0 fixes the issue) will generate R_MIPS_HI16
> without succeeding R_MIPS_LO16 (or the other way - but it's not a real
> problem that way) in '.rel.text' (not '.rela.text'). According to SGI ELF
> spec this combination is invalid (well, addend AHL is created from low 16
> bits from HI16 and low 16 bits from LO16, and the actual result of
> relocation might depend on the LO16 part - at least this is what I
> understood from the specific[a]tion); it also upsets Indy PROM when
> converted into ECOFF.
>
> Gcc 3.4.3 does not exhibit this (wanton) behavior. What the heck?

Remember that support for %hi() and %lo() on REL targets is a GNU extension.
The assembler is expected to reorder the relocations so that the HI16s
come before the LO16s.  It sounds like this isn't happening in your case,
so which version of binutils are you using?

This isn't really a change from gcc 3.4 to "gcc 3.5" (now known as 4.0 ;).
It has long been possible for gcc's assembly code to contain "out of order"
%hi()s and %lo()s.  On the other hand, the more aggressive the optimisers
are, the more likely you are to see it, so the behaviour will certainly
be different in specific testcases.

Richard
