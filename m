Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7P0YXh31765
	for linux-mips-outgoing; Fri, 24 Aug 2001 17:34:33 -0700
Received: from smtp (smtp.psdc.com [209.125.203.83])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7P0YTd31762
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 17:34:30 -0700
Received: from ex2k.pcs.psdc.com ([172.19.1.1])
 by smtp (NAVIEG 2.1 bld 63) with SMTP id M2001082417344321461
 for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 17:34:43 -0700
content-class: urn:content-classes:message
Subject: RE: glibc 2.0.6 building problem.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
Date: Fri, 24 Aug 2001 17:31:17 -0700
Message-ID: <84CE342693F11946B9F54B18C1AB837B0A2699@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: glibc 2.0.6 building problem.
Thread-Index: AcEmjXrqJyuPXOUURymriCCbx1MlSAGbsDqQ
From: "Steven Liu" <stevenliu@psdc.com>
To: "Brian Murphy" <brian.murphy@eicon.com>
Cc: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f7P0YUd31763
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, Brian:

Thank you very much for your help in my building glibc-2.0.6. Now I am
building gcc from egcs-1.1.2.tar.gz for the native compiler of my Mips
R3000 target.

Do you have a Makefile in doing this? If you do, could you please send
it to me? 

Regards,

Steven Liu


-----Original Message-----
From: Brian Murphy [mailto:brian.murphy@eicon.com]
Sent: Thursday, August 16, 2001 12:58 PM
To: Steven Liu
Subject: Re: glibc 2.0.6 building problem.


Steven Liu wrote:

> Hi, ALL:
>
> After built Linux kernel 2.2.12 for mips r3000, I got the related
files
> for glibc-2.0.6 build.  But I found a problem when I were building
glibc
> 2.0.6. Here is part of the screen printout:
>
> cd build <return>
> C=mips-linux-gcc BUILD_CC=gcc AR=mips-linux-ar
RANLIB=mips-linux-ranlib
> ../configure --prefix=/usr --host=mips-linux
> --enable-add-ons=crypt,linuxthreads,localedata --enable-profile
<return>
>
> .....
>
> ......
> checking installed Linux kernel header files... TOO OLD!
> configure: error: GNU libc requires kernel header files from
> Linux 2.0.10 or later to be installed before configuring.
> The kernel header files are found usually in /usr/include/asm and
> /usr/include/linux; make sure these directories use files from
> Linux 2.0.10 or later.  This check uses <linux/version.h>, so
> make sure that file was built correctly when installing the kernel
> header
> files.
>

Here is my Makefile.global and Makefile I use to build a glibc-2.0.6

- hope it helps.

/Brian
