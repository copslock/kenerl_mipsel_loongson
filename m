Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 18:32:22 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:61373
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225825AbVEWRcE>; Mon, 23 May 2005 18:32:04 +0100
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4NHW2223549;
	Mon, 23 May 2005 19:32:02 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 23 May 2005 19:32:01 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4NHW0909155;
	Mon, 23 May 2005 19:32:00 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Mon, 23 May 2005 19:32:00 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Richard Sandiford <rsandifo@redhat.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
In-Reply-To: <8764x926wq.fsf@firetop.home>
Message-ID: <Pine.GSO.4.10.10505231928030.8910-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> I'm talking about the %hi() and %lo() relocation _operators_,
> not the ELF relocations themselves.  The ELF spec has nothing
> to say about the syntax of assembler relocation operators.

OK, right :)

> What do you mean?  I'm talking about reordering the relocations in
> the .rel.foo section, not reordering the code.  I.e. if you have:
> 
>     .text
>     ...
>     addiu $4,$4,%lo(foo)
>     ...
>     lui $4,%hi(foo)
> 
> the assembler is expected to output the R_MIPS_HI16 .rel.text entry
> for the lui before the R_MIPS_LO16 entry for the addiu.

If you have something like that:

	.text
	...
loop_label:
	lui $4, %hi(foo)
	addiu $4, $4, %lo(foo)
	...
	jmp loop_label
	...

the compiler might be smart and change it into:

	.text
	...
	lui $4, %hi(foo)
loop_label:
	addiu $4, $4, %lo(foo)
	...
	lui $4, %hi(foo)
	jmp loop_label
	...

for instance, to put the lui into branch delay slot (quite a smart
decision, this one). However now %hi and %lo are unpaired. What should the
tool do?

Cheers,

Stanislaw
