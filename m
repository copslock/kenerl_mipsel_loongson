Received:  by oss.sgi.com id <S553679AbRAHWaJ>;
	Mon, 8 Jan 2001 14:30:09 -0800
Received: from mx.mips.com ([206.31.31.226]:9935 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553705AbRAHWaE>;
	Mon, 8 Jan 2001 14:30:04 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA22416;
	Mon, 8 Jan 2001 14:29:55 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA07962;
	Mon, 8 Jan 2001 14:29:52 -0800 (PST)
Message-ID: <01b401c079c3$095c4740$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        "Karsten Merker" <karsten@excalibur.cologne.de>
Cc:     <linux-mips@oss.sgi.com>
References: <XFMail.791030042838.Harald.Koerfgen@home.ivm.de>
Subject: Re: Current CVS kernel no-go on R4k Decstation
Date:   Mon, 8 Jan 2001 23:33:25 +0100
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

> > Similar effect for me (DS5000/150, Checkout @ Sat Jan 6 ~22:30 CET),
> > except that I do not get the "illigal instruction" lines. Harald has the
> > same problem on his /260. It looks like sometime in December 2000
> > something has gone broken in the R4K-support, or are we perhaps
> > triggering a compiler bug in egcs 1.1.2?
>
> I don't think so. This hang appeared in the middle of December and may or
may
> not be related to the MIPS32 patches which were commited then.
Unfortunately I
> haven't had the time to track this down.

If you're referring to the MIPS32 patches that came from the MIPS 2.2 tree,
we generally test those on an R4600 Indy and a couple R5xxx platforms as
a matter of routine.  This is not to say that there might not be some change
to the R4x00 support between 2.2 and 2.4 that interacts pathologically with
the MIPS32 code...

           Kevin K.
