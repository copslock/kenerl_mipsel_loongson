Received:  by oss.sgi.com id <S42207AbQF2URO>;
	Thu, 29 Jun 2000 13:17:14 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:50523 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42202AbQF2UQ4>;
	Thu, 29 Jun 2000 13:16:56 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id NAA12820
	for <linux-mips@oss.sgi.com>; Thu, 29 Jun 2000 13:12:05 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA18180; Thu, 29 Jun 2000 16:06:44 -0300
Date:   Thu, 29 Jun 2000 16:06:44 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: MIPS symbol versioning patches
In-Reply-To: <14683.40873.494836.164828@calypso.engr.sgi.com>
Message-ID: <Pine.SGI.4.10.10006291601050.18148-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Thanks, that's exactly what I needed to know.

On Thu, 29 Jun 2000, Ulf Carlsson wrote:

>  > I take this to mean that we may soon have a working glibc 2.1.xx for MIPS?
>  > 
> 
> Yes, it's just a matter of recompiling everything against it.  Keith
> Wesolowski is doing this.  We have found some minor problems with
> glibc that we haven't been able to resolve yet.  There is some bug in
> the dynamic linker, it tries to resolve symbols that aren't there in
> some packages.
> 
> There is also a problem with compiling gcc 2.96 natively, but I
> actually think that's a problem in gcc 2.96.  It shouldn't try to
> generate jump instructions like it does that in PIC code.  I think the
> bootstrapping of gcc 2.96 currently is broken, but that's not a MIPS
> issue.
> 
> Note that glibc 2.1 never will run on MIPS, glibc 2.1.90 is the
> development version for the forthcoming glibc 2.2.
> 
> Ulf
> 
