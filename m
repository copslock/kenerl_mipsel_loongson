Received:  by oss.sgi.com id <S553772AbRBABxV>;
	Wed, 31 Jan 2001 17:53:21 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56131 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S553682AbRBABxA>; Wed, 31 Jan 2001 17:53:00 -0800
Received: from sgisgp.singapore.sgi.com (sgisgp.singapore.sgi.com [134.14.84.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id SAA01222
	for <linux-mips@oss.sgi.com>; Wed, 31 Jan 2001 18:02:01 -0800 (PST)
	mail_from (calvine@sgi.com)
Received: from sgp-apsa001e--n.singapore.sgi.com by sgisgp.singapore.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id KAA28932; Thu, 1 Feb 2001 10:02:41 +0800
Received: by sgp-apsa001e--n.singapore.sgi.com with Internet Mail Service (5.5.2650.21)
	id <1AC4R0JQ>; Thu, 1 Feb 2001 09:57:54 +0800
Message-ID: <43FECA7CDC4CD411A4A3009027999112267E46@sgp-apsa001e--n.singapore.sgi.com>
From:   Calvine Chew <calvine@sgi.com>
To:     "'Guido Guenther'" <guido.guenther@uni-konstanz.de>
Cc:     "'linux-mips'" <linux-mips@oss.sgi.com>
Subject: RE: Building XFree86 4.0.2?
Date:   Thu, 1 Feb 2001 09:57:53 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'll try that, thanks!!

Regards...

--
Calvine Chew, Technical Consultant
Technology & Industry Consulting Group (Asia South), SGI.
***************************************************************
Inter spem curamque, timores inter et iras, omnem crede diem tibi
diluxisse supremum: grata superveniet quae sperabitur hora.
http://calvine
***************************************************************





> -----Original Message-----
> From: Guido Guenther [mailto:guido.guenther@uni-konstanz.de]
> Sent: Wednesday, January 31, 2001 6:15 PM
> To: Calvine Chew
> Cc: 'linux-mips'
> Subject: Re: Building XFree86 4.0.2?
> 
> 
> On Wed, Jan 31, 2001 at 02:20:17PM +0800, Calvine Chew wrote:
> > I'm trying to build XFree86 4.0.2 on HardHat 5.1 
> (unpatched) and I'm looking
> > at the Mips.cf, which mentions a bootstrapcflag, but the 
> relnotes say
> > supported configs don't need bootstrapcflag="-DMips" passed 
> to make. If I
> > pass bootstrap I get a conflict on stdio.h early on 
> (conflicting type
> > sys_errlist), whereas if I don't pass bootstrapcflag, I get 
> an error around
> > after 5000 lines of output (undefined references to 
> __libc_accept, etc, from
> > libpthread.so when trying to make makekeys.c).
> I'm running 4.0.2 on glib2.0.6 fine here. There are updated glibc2.0
> rpms on oss.sgi.com/mips. With them you can build 4.0.2 
> without any need
> to pass additional flags.
>  -- Guido
> 
