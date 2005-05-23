Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 18:23:46 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:25047 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225808AbVEWRX3>;
	Mon, 23 May 2005 18:23:29 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4NHNO3C019218;
	Mon, 23 May 2005 13:23:24 -0400
Received: from firetop.home (vpn50-36.rdu.redhat.com [172.16.50.36])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4NHNNO23720;
	Mon, 23 May 2005 13:23:24 -0400
Received: from rsandifo by firetop.home with local (Exim 4.50)
	id 1DaGe5-0003IL-RR; Mon, 23 May 2005 18:23:17 +0100
From:	Richard Sandiford <rsandifo@redhat.com>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
References: <87oeb26vjb.fsf@firetop.home>
	<Pine.GSO.4.10.10505231802070.3392-100000@helios.et.put.poznan.pl>
Date:	Mon, 23 May 2005 18:23:17 +0100
In-Reply-To: <Pine.GSO.4.10.10505231802070.3392-100000@helios.et.put.poznan.pl>
	(Stanislaw Skowronek's message of "Mon, 23 May 2005 18:19:42 +0200
	(MET DST)")
Message-ID: <8764x926wq.fsf@firetop.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL> writes:
>> Remember that support for %hi() and %lo() on REL targets is a GNU extension.
>
> Erm. Are you sure?
>
> SGI's ELF64 spec says:
>
> "Any of the relocation types may appear in either a SHT_REL or a SHT_RELA
> relocation section, except that relocation types involving AHL operands
> are forbidden in a 64-bit SHT_REL section and discouraged in a 32-bit
> SHT_REL section."
>
> There is no word of GNU there and in any case SGI had their own tools. But
> again, it is possible that the idea bounced back and forth...

I'm talking about the %hi() and %lo() relocation _operators_,
not the ELF relocations themselves.  The ELF spec has nothing
to say about the syntax of assembler relocation operators.

>> This isn't really a change from gcc 3.4 to "gcc 3.5" (now known as 4.0 ;).
>
> Well, one of %hi()s is reordered to beginning of a loop and this is what
> makes it unpaired. I don't think that any assembler could fix that.

What do you mean?  I'm talking about reordering the relocations in
the .rel.foo section, not reordering the code.  I.e. if you have:

    .text
    ...
    addiu $4,$4,%lo(foo)
    ...
    lui $4,%hi(foo)

the assembler is expected to output the R_MIPS_HI16 .rel.text entry
for the lui before the R_MIPS_LO16 entry for the addiu.

Richard
