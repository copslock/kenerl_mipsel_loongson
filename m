Received:  by oss.sgi.com id <S553980AbRAZLme>;
	Fri, 26 Jan 2001 03:42:34 -0800
Received: from mx.mips.com ([206.31.31.226]:54244 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553953AbRAZLmR>;
	Fri, 26 Jan 2001 03:42:17 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA04958;
	Fri, 26 Jan 2001 03:42:13 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA08303;
	Fri, 26 Jan 2001 03:42:08 -0800 (PST)
Message-ID: <019b01c0878d$8ac9e6c0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Carsten Langgaard" <carstenl@mips.com>,
        "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Michael Shmulevich" <michaels@jungo.com>, <linux-mips@oss.sgi.com>
References: <3A70A356.F3CA71F1@jungo.com> <20010125141632.B2311@bacchus.dhis.org> <3A712A52.FAC574F1@mips.com>
Subject: Re: MIPS/linux compatible PCI network cards
Date:   Fri, 26 Jan 2001 12:45:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > > Hello all,
> > >
> > > I would like to ask if someone knows some more or less widely
available
> > > PCI network card that is compatible with MIPS/Linux.
> > >
> > > I have heard of Tulip and AMD's PCnet. I wonder if you heard of
others.
> >
> > These all have already been used with Linux/MIPS.  I don't have any
reports
> > on the current status of these drivers.  If they don't work they should
> > be reasonably easy to fix.
>
> The tulip driver worked fine at least in the past. The AMD PCnet driver
works
> just fine, we are using it on our reference boards.

Note, however, that the Tulip driver that was part of the
standard 2.2/2.3 repository at oss.sgi.com was both
downrev with regard to the author's own web site and
subobtimal if not outright buggy in it's cache management.
The AMD PCnet driver as we found it was clean and efficient
but had no MIPS cache hooks.   I had to put those in.
So unless Ralf or someone at SGI that the versions
on oss.sgi.com are the versions I cleaned up for MIPS,
I would recommend pulling them off the MIPS site.

            Regards,

            Kevin K.
