Received:  by oss.sgi.com id <S42381AbQJETkB>;
	Thu, 5 Oct 2000 12:40:01 -0700
Received: from mx.mips.com ([206.31.31.226]:28077 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S42367AbQJETje>;
	Thu, 5 Oct 2000 12:39:34 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA09188;
	Thu, 5 Oct 2000 12:37:57 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA10174;
	Thu, 5 Oct 2000 12:38:13 -0700 (PDT)
Message-ID: <00d101c02f04$3a6d7340$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, "Jun Sun" <jsun@mvista.com>
Cc:     <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>,
        "Dominic Sweetman" <dom@algor.co.uk>
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com>
Subject: Re: load_unaligned() and "uld" instruction
Date:   Thu, 5 Oct 2000 21:41:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > > Ralf, before the perfect solution is found, the following patch makes
> > > the gcc complain go away.  It just use ".set mips3" pragma.

Which, as Ralf correctly observes, will generate code that will
crash on 32-bit CPUs, and apparently do entirely the wrong
thing for other reasons on the 64-bit ones.

> > It's still perfectly broken.  Uld is a 64-bit instruction meaning you
still
> > could get into problems with register corruption or even reserved
instruction
> > exceptions on 32-bit cpus.  Not too mention that nobody did notice that
> > the constraints of the inline assembler were broken for all access sizes
> > plus a cast that would have cut off the upper 32 bit of a 64 bit access
in
> > any case.  That's fixed now.
> >
>
> With my limited wisdom, I am totally confused by this paragraph.
>
> I think you mentioned a couple of times before where 64-bit instructions
> corrupt registers in 32-bit mode.  I think I have done that before with
> R5000 R4500.  I did not notice any corruption.  What exactly is the
> corruption you are referring to?

Uld is an unaligned doubleword load macro that should generate
a LDL/LDR sequence if MIPS III, IV, V or MIPS64 is enabled in
the compiler/assembler.  That sequence should either execute
correctly or deliver a reserved instruction exception.  No
MIPS-compatible CPU should silently fail or corrupt registers.

> With the second half, are you saying the "cut-off-upper-32-bit" bug
> actually hides the register corruption problem?  If so, maybe we need
> the "cut-off-upper_32-bit" bug for the 32-bit MIPS tree.

This is a joke, right?

            Kevin K.
