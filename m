Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f42KHwT18512
	for linux-mips-outgoing; Wed, 2 May 2001 13:17:58 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f42KHuF18504
	for <linux-mips@oss.sgi.com>; Wed, 2 May 2001 13:17:56 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA21919;
	Wed, 2 May 2001 13:18:01 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA10366;
	Wed, 2 May 2001 13:17:59 -0700 (PDT)
Message-ID: <018301c0d345$8f56abc0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Matthew Dharm" <mdharm@momenco.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
References: <NEBBLJGMNKKEEMNLHGAIGEEFCBAA.mdharm@momenco.com>
Subject: Re: Endianness...
Date: Wed, 2 May 2001 22:21:58 +0200
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

I have one machine set up each way, an Algorithmics
P5064/R5260 running LE on a 2.2.12 kernel and a
MIPS Malta/4KC running BE under 2.4.1.  There are pros
and cons.  On one hand, most of the "bleeding edge"
work is only tested on BE SGI platforms before being
checked-in, and the BE userland binary distributions
are more complete.  On the other hand, it's generally
easier to port drivers for x86-oriented peripherals to
a LE kernel.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Sent: Wednesday, May 02, 2001 10:01 PM
Subject: Endianness...


> What's the preferred endianness for Linux-MIPS?  I can't really go
> into why I'm asking (sensitive NDA information), but I'm basically
> faced with a group that wants to work in LE.  However, my
> understanding was that Linux-MIPS generally ran BE.
> 
> Or can it be built either way?  I know OpenBSD runs LE.... not like
> that means anything to this group, tho.
> 
> Matt Dharm
> 
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
> 
