Received:  by oss.sgi.com id <S553774AbQLOIVU>;
	Fri, 15 Dec 2000 00:21:20 -0800
Received: from mx.mips.com ([206.31.31.226]:20695 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553770AbQLOIVH>;
	Fri, 15 Dec 2000 00:21:07 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA15428;
	Fri, 15 Dec 2000 00:21:04 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA05776;
	Fri, 15 Dec 2000 00:20:59 -0800 (PST)
Message-ID: <007001c06670$7345d2e0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Carsten Langgaard" <carstenl@mips.com>,
        "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     <linux-mips@oss.sgi.com>
References: <3A379CBC.ED1D9F@mips.com> <20001214215933.C28871@bacchus.dhis.org> <3A39CC1F.8FE7B2FE@mips.com>
Subject: Re: 64 bit build fails
Date:   Fri, 15 Dec 2000 09:24:22 +0100
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

> > Looks like an attempt to build a 64-bit Indy kernel.  Various people
working
> > on the Origin support have completly broken the support for anything
else in
> > their battle tank-style approach ...
>
> Ok, that explains why a lot of things are broken.
> So who will be responsible for fixing all the broken pieces ?

In the absence of the SGI people being directed to do a
clean job, I suppose the problem falls to those who have
an interest in a clean and portable 64-bit MIPS kernel.
That would include MIPS, of course.  But what about the
rest of you - could we see a show of virtual hands?  I
know that TI has both 4K and 5K licenses, and may
want to be able to exploit the 64-bit capability of the 5K
under Linux.  And the guys doing the Vr41xx ports may
also be interested.  Anyone else?  Those of you with
R4K-based DECstations, perhaps?  Software shops
looking to support high-end embedded MIPS in set-tops?

Another aspect of this is that, in the newer MIPS
designs that conform to the MIPS64 architecture spec,
it is finally possible to cleanly seperate the use of
64-bit data types from the use of 64-bit virtual addresses.
The processors in the SGI platforms do not have this
capability, and it would be a lot to ask of the people
doing 64-bit Linux for Origin etc. to treat the addressing
and data aspects orthogonally.  I haven't checked the
code, but I would imagine that we will have to go in
and redo things from that perspective as well.

            Regards,

            Kevin K.
