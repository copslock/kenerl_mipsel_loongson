Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA29683 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Feb 1999 09:38:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA59177
	for linux-list;
	Wed, 3 Feb 1999 09:37:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA03410
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 3 Feb 1999 09:37:24 -0800 (PST)
	mail_from (chad@otg.dallas.sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	for <@sgidal.dallas.sgi.com:linux@cthulhu.engr.sgi.com> id LAA22602; Wed, 3 Feb 1999 11:37:23 -0600
Received: from roctane.dallas.sgi.com (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id JAA18570 for <linux@cthulhu.engr.sgi.com>; Wed, 3 Feb 1999 09:37:22 -0800 (PST)
Message-ID: <36B88952.4F3E1CAE@roctane.dallas.sgi.com>
Date: Wed, 03 Feb 1999 11:37:22 -0600
From: Chad Carlin <chad@otg.dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <19990202155147.A1565@ganymede> <19990203043951.D3920@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf,

Got a chance to try again last night using a i686 as a bootserver. I got the
same aieee message. Will get you my hinv and my particular register dump.

Chad


ralf@uni-koblenz.de wrote:

> On Tue, Feb 02, 1999 at 03:51:47PM +0100, Alexander Graefe wrote:
>
> > I got as far as booting Linux via bootp on my Indy, but after the
> > remote root-fs is mounted, the kernel dies with an "Aieee" and
> > something about irq request handler.
>
> Ouch.  It was actually supposed to work on Indys, regardless of the processor
> type.  Since it's no longer working things must somewhow got broken again.
> I'll try to fix it but it's going to be hairy since I don't have an R4400SC
> processor module.
>
> > I tried booting with the 2.1.131-Kernel from ftp.linux.sgi.com, but
> > that one doesn't try to mount the root-fs via NFS.
> >
> > What kernel should I use to actually see a prompt on my Indy ?
>
> Can you send me:
>
>  - the exact screen output.  Especially the register dump following the
>    Aiee message is important.
>  - the output of the hinv command.  Hinv is an IRIX command.
>
> > Quidquid latine dictum sit, altum viditur.
>
> In nomeni patrii et filiae et spiritus pinguini ;-)
>
>   Ralf

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"
