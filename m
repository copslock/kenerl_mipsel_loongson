Received:  by oss.sgi.com id <S42212AbQGLUT6>;
	Wed, 12 Jul 2000 13:19:58 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:49184 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42209AbQGLUTg>;
	Wed, 12 Jul 2000 13:19:36 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id NAA29979
	for <linux-mips@oss.sgi.com>; Wed, 12 Jul 2000 13:12:14 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA18374; Wed, 12 Jul 2000 16:12:59 -0300
Date:   Wed, 12 Jul 2000 16:12:59 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Guido Guenther <guido.guenther@gmx.net>
cc:     linux-mips@oss.sgi.com
Subject: Re: XFree 4.0.1 on mips, mipsel
In-Reply-To: <20000623181736.A13410@bert.physik.uni-konstanz.de>
Message-ID: <Pine.SGI.4.10.10007121559360.18338-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 23 Jun 2000, Guido Guenther wrote:

> I've submitted several patches to the XFree-Project to include at least
> basic support for mips/mipsel architecture. These are based on previous
> work done by Ralf Baechle, Ulf Carlson, Gleb O. Reiko & Nina A.
> Podolskaya. I hope I didn't break anything.
> The patches are known to work on the Indy but are AFAIK untested on other 
> mips machines and appear in the alpha version of xfree which can be checked 
> out of the repository at sourceforge, see: http://www.xfree86.org/cvs/
> Regards,
>  -- Guido

Question.  What did you use for your site.def/host.def?  

I added this:
#define LinuxDistribution LinuxUnknown

Got this after the Imake boot straped itself:

Building on Linux 2.2.14 mips [ELF] (2.2.14).

Linux Distribution: Unknown
libc version: 6.0.6
binutils version: 2.9

It more or less ran through to completion.  After installing the libs and
some aps, updating the ld.so.conf path, ldconfig, etc...  I cannot run any
of the /usr/X11R6/bin utilities.  They all bus error, which sounds like a
data alignment issue or library problem.  (I really don't care about the X
server build, I just want the LIBRARIES.)

ldd shows apparently successful library resolution and the magic numbers
on the files show proper endianness, CPU target type, etc...

I'm using the Simple Linux 0.1 distro as the base.

My questions are:

#1 Is there more to the configuration than this?

#2 I downloaded the 4.0.1 src tarballs (3 of them), should those include
your patches already, or do I need to get and add those before I can build
successfully?

Thanks.

-S-
