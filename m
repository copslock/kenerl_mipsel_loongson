Received:  by oss.sgi.com id <S553679AbRAHL40>;
	Mon, 8 Jan 2001 03:56:26 -0800
Received: from router.isratech.ro ([193.226.114.69]:47109 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553672AbRAHL4M>;
	Mon, 8 Jan 2001 03:56:12 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id f08Bsnl07495;
	Mon, 8 Jan 2001 13:54:50 +0200
Message-ID: <3A5A18B4.D7339CF1@isratech.ro>
Date:   Mon, 08 Jan 2001 14:44:52 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Florian Lohoff <flo@rfc822.org>
CC:     linux-mips@oss.sgi.com
Subject: Re: Loading srec imagine problem.
References: <3A58E9B1.459A33C1@isratech.ro> <20010108100930.A6841@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello ,

Florian Lohoff wrote:

> On Sun, Jan 07, 2001 at 05:12:02PM -0500, Nicu Popovici wrote:
> > Hello ,
> >
> > I have now the following cross toolchain
> > binutils 2.10.1 - egcs.1.0.3a - glibc-2.0.6.
> >
> > I manage to cross compile the kernel for mips and when I try to load the
> > srec imagine on the mips I get the following error.
> >
> > For this srec imagine I used mips-linux-objcopy -O srec vmlinux
> > srecimagine.
>
> Wouldnt this use the original load address of the vmlinux as the srec
> address ? Wouldnt this mean you are probably overwriting your monitor
> while loading the srec ? Ususally you would load the image via srec to
> a different location with a small copy and run type code in front.

I do not know if this is the problem. I made objdump on this srec imagine and
it looks like the sections begin somewhere below 0x80100000 address and for
the srec imagine ( the one that I can load on ) the sections begin after
0x8010000 address. So the problem is here , something with setting the write
address for this srec imagine. Maybe from objcopy ( but I do not think so )
or from linker.

Nicu
