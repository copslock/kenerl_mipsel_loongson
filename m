Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f85AHgB18644
	for linux-mips-outgoing; Wed, 5 Sep 2001 03:17:42 -0700
Received: from animal.pace.co.uk (gateway.pace.co.uk [195.44.197.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f85AHcd18638
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 03:17:38 -0700
Received: from exchange1.cam.pace.co.uk (exchange1.cam.pace.co.uk [136.170.131.80])
	by animal.pace.co.uk (8.10.2/8.10.2) with ESMTP id f85AHW709440
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 11:17:32 +0100
Received: by exchange1.cam.pace.co.uk with Internet Mail Service (5.5.2650.21)
	id <S2BF7T4N>; Wed, 5 Sep 2001 11:17:05 +0100
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC578@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: How to install the cross-compiler toolchain?
Date: Wed, 5 Sep 2001 11:17:04 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="big5"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Have you tried giving all the packages on the same command line?

	rpm -U glibc-*

...works for me.

Phil

> -----Original Message-----
> From: kjlin [mailto:kj.lin@viditec-netmedia.com.tw]
> Sent: 05 September 2001 10:51
> To: Jean-Christophe ARNU
> Cc: linux-mips@oss.sgi.com
> Subject: Re: How to install the cross-compiler toolchain?
> 
> 
> 
> ----- Original Message -----
> Subject: Re: How to install the cross-compiler toolchain?
> 
> 
> > On 05 Sep 2001 12:52:13 +0800, kjlin wrote:
> > > #rpm -ivh glibc-2.2.3-13.3.i386.rpm
> > > error: failed dependencies:
> > >                 glibc-common = 2.2.3-13.3 is needed by 
> glibc-2.2.3-13.3
> > >                 glibc-devel < 2.2.3 conflicts with 
> glibc-2.2.3-13.3
> > > I also tried to install glibc-common-2.2.3-13.3.i386.rpm but still
> failed.
> > > #rpm -ivh glibc-common-2.2.3-13.3.i386.rpm
> > > error: failed dependencies:
> > >                 glibc < 2.2.3 conflicts with 
> glibc-common-2.2.3-13.3
> > >
> > > I am confused by the result.
> >
> > You should update and not install glibc.
> > # rpm -uvh glibc-common-2.2.3-13.3.i386.rpm
> 
> It is the same.
> Just more error messages.
> # rpm -Uvh glibc-common-2.2.3-13.3.i386.rpm
> error: failed dependencies:
>         glibc < 2.2.3 conflicts with glibc-common-2.2.3-13.3
>         glibc-common = 2.2.2-10 is needed by glibc-2.2.2-10
> 
> # rpm -Uvh glibc-2.2.3-13.3.i386.rpm
> error: failed dependencies:
>         glibc-common = 2.2.3-13.3 is needed by glibc-2.2.3-13.3
>         glibc-devel < 2.2.3 conflicts with glibc-2.2.3-13.3
>         glibc > 2.2.2 conflicts with glibc-common-2.2.2-10
>         glibc = 2.2.2 is needed by glibc-devel-2.2.2-10
> 
> # rpm -Uvh glibc-devel-2.2.3-13.3.i386.rpm
> error: failed dependencies:
>         glibc = 2.2.3 is needed by glibc-devel-2.2.3-13.3
> 
> 
> 
