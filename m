Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6MAwcT12663
	for linux-mips-outgoing; Sun, 22 Jul 2001 03:58:38 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6MAwbV12660
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 03:58:37 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA27423;
	Sun, 22 Jul 2001 03:57:56 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA05118;
	Sun, 22 Jul 2001 03:57:52 -0700 (PDT)
Message-ID: <007301c1129d$cdf908e0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@oss.sgi.com>,
   "Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>
References: <20010722123526.K16278@rembrandt.csv.ica.uni-stuttgart.de>
Subject: Re: mips64 linker bug?
Date: Sun, 22 Jul 2001 13:02:21 +0200
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

> > > > Thanks...What should I do now? Change my code to mips32 or are there
some
> > > > patches to binutils that I can use, to get it working?
> > >
> > > Depends on what you want to do?
> >
> > I'm working on a very small, single address space, microkernel and I
have
> > the MIPS Malta with a 5Kc CPU to develop it on. The 5Kc is compatible
> > with mips32 but I must admit, I really like to have my kernel
> > running 64bit :).
>
> An Kernel with 64bit addresses is less compact and likely to run slower.
> OTOH, a 64bit Kernel has certainly some hack value. :-)

Note that the 5Kc is one of the new generation of MIPS64 parts
that can enable 64-bit integer and floating point instructions without
requiring that 64-bit addressing also be enabled in the kernel.
Making Linux kernel support for this capability available is
one of the things that we're working on.  But it's not there yet.

            Kevin K.
