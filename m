Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 20:43:43 +0100 (BST)
Received: from ispmxmta05-srv.alltel.net ([IPv6:::ffff:166.102.165.166]:19140
	"EHLO ispmxmta05-srv.alltel.net") by linux-mips.org with ESMTP
	id <S8225331AbUDMTnm>; Tue, 13 Apr 2004 20:43:42 +0100
Received: from lahoo.priv ([162.39.1.206]) by ispmxmta05-srv.alltel.net
          with ESMTP
          id <20040413194333.TPGI29083.ispmxmta05-srv.alltel.net@lahoo.priv>;
          Tue, 13 Apr 2004 14:43:33 -0500
Received: from prefect.priv ([10.1.1.141] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 1BDTaZ-0006Ci-00; Tue, 13 Apr 2004 15:28:55 -0400
Message-ID: <02ea01c4218f$9ea240d0$8d01010a@prefect>
From: "Bradley D. LaRonde" <brad@laronde.org>
To: <linux-mips@linux-mips.org>,
	"Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>
References: <028001c4218c$6d792350$8d01010a@prefect> <20040413193158.GO27939@rembrandt.csv.ica.uni-stuttgart.de>
Subject: Re: [PATCH] catch "new" gcc 3.4.0 sections
Date: Tue, 13 Apr 2004 15:43:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <brad@laronde.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@laronde.org
Precedence: bulk
X-list: linux-mips

----- Original Message ----- 
From: "Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>
To: <linux-mips@linux-mips.org>
Sent: Tuesday, April 13, 2004 3:31 PM
Subject: Re: [PATCH] catch "new" gcc 3.4.0 sections


> Bradley D. LaRonde wrote:
> > Building with gcc 3.4.0 emits a couple new sections, .rodata.cst4 and
> > .rodata.str1.4, which the current ld.script doesn't contemplate.  Here
is a
> > patch to catch them (and maybe some other latent ones).
> >
> > Anyone know why or when these sections are emitted?
>
> I'd guess to keep differently aligned strings in separate sections,
> as a preliminary for improved string merging.
>
> > Regards,
> > Brad
> >
> >
> > diff -u -r1.1.1.1 ld.script.in
> > --- arch/mips/ld.script.in      10 Nov 2003 21:06:52 -0000      1.1.1.1
> > +++ arch/mips/ld.script.in      13 Apr 2004 19:18:25 -0000
> > @@ -11,6 +11,11 @@
> >      *(.text)
> >      *(.rodata)
> >      *(.rodata1)
> > +    *(.rodata.str1.1);
> > +    *(.rodata.str1.4);
> > +    *(.rodata.str1.32);
> > +    *(.rodata.cst4);
> > +    *(.rodata.cst8);
>
> Why not just *(.rodata*); ?

I dunno.  There is already a tradition with .rodata and .rodata1 being
listed separately.  Maybe to spy on future gcc behavior?


Regards,
Brad
