Received:  by oss.sgi.com id <S42465AbQJEWIb>;
	Thu, 5 Oct 2000 15:08:31 -0700
Received: from mx.mips.com ([206.31.31.226]:21167 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S42464AbQJEWIL>;
	Thu, 5 Oct 2000 15:08:11 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id PAA10589;
	Thu, 5 Oct 2000 15:07:09 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA14367;
	Thu, 5 Oct 2000 15:07:26 -0700 (PDT)
Message-ID: <011801c02f19$1283f6a0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>
Cc:     "Ralf Baechle" <ralf@oss.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@oss.sgi.com>, "Dominic Sweetman" <dom@algor.co.uk>
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com>
Subject: Re: load_unaligned() and "uld" instruction
Date:   Fri, 6 Oct 2000 00:10:18 +0200
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

Jun Sun wrote:
> "Kevin D. Kissell" wrote:
> >
> > > > > Ralf, before the perfect solution is found, the following patch
makes
> > > > > the gcc complain go away.  It just use ".set mips3" pragma.
> >
> > Which, as Ralf correctly observes, will generate code that will
> > crash on 32-bit CPUs,
>
> Why will it crash 32-bit CPUs?  On my R5432 CPU, the lwl/lwr sequence
> executes just fine.
>
> Or do you mean it will crash SOME 32-bit CPUs?  Do those 32-bit CPUs
> support lwl or lwr?  If they don't, they should generate a reserved
> instruction exception.  If they do, I don't see any problem.

Please re-read my previous message.  I wasn't talking about the
MIPS I lwl/lwr sequence for loading an unaligned 32-bit word, I was
talking about the MIPS III ldl/ldr sequence for loading an unaligned
64-bit doubleword.

            Kevin K.
