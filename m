Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4U8inf23754
	for linux-mips-outgoing; Wed, 30 May 2001 01:44:49 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4U8ijh23744
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 01:44:45 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA03555;
	Tue, 29 May 2001 23:42:07 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA23826;
	Tue, 29 May 2001 23:42:03 -0700 (PDT)
Message-ID: <000901c0e8d4$4525f480$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010528172454.15200I-100000@delta.ds2.pg.gda.pl> <3B142367.791F28AF@mvista.com>
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
Date: Wed, 30 May 2001 08:46:25 +0200
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

> > > So apparently MIPS_ATOMIC_SET was invented for Linux only, probably
just to
> > > implement _test_and_set().  (It would be interesting to see how IRIX
implement
> > > _test_and_set() on MIPS I machines.  However, the machine I have
access uses
> > > ll/sc instructions).
> >
> >  Does IRIX actually run on anything below ISA II?
> >
>
> I assume nobody answering the above questions means nobody
> really care.  So we can safely move ahead without worrying about
> them. :-)

I was waiting for someone to give a more authoritative
answer, but IIRC from my days at SGI, IRIX did of course
run on the R3000-based products, but support for them
was dropped in IRIX 6.x.  I couldn't give you the version
number of the last IRIX version that did support the R3K,
though.

And as others have observed, it was in any case
not IRIX, but MIPS' own RiscOS that drove the ABI.

            Keivn K.
