Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA17588 for <linux-archive@neteng.engr.sgi.com>; Fri, 2 Oct 1998 09:42:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA55225
	for linux-list;
	Fri, 2 Oct 1998 09:41:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA05525
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 2 Oct 1998 09:41:14 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from bronx.patser.net (9dyn33.breda.casema.net [195.96.116.33]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA03274
	for <linux@cthulhu.engr.sgi.com>; Fri, 2 Oct 1998 09:41:11 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from infopact.nl (root@localhost [127.0.0.1])
	by bronx.patser.net (8.9.0/8.9.0) with ESMTP id SAA01878;
	Fri, 2 Oct 1998 18:46:04 +0200
Message-ID: <3615034C.CE0F134C@infopact.nl>
Date: Fri, 02 Oct 1998 18:46:04 +0200
From: Richard Hartensveld <richardh@infopact.nl>
X-Mailer: Mozilla 4.05 [en] (X11; I; Linux 2.0.35 i686)
MIME-Version: 1.0
To: Ulf Carlsson <grim@zigzegv.ml.org>
CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: crosscompiling on debian/i386
References: <Pine.LNX.3.96.981002072614.15436B-101000@calypso.saturn>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson wrote:

> On Thu, 1 Oct 1998, Thomas Bogendoerfer wrote:
>
> > no he tries to crosscompile with gcc-2.7.2.x a new kernel from CVS.
> > This does no longer work out of the box, because we've changed the
> > #ifdef _LANGUAGE_ASSEMBLY to the egcs predefined ones. And these aren't
> > defined in the gcc-2.7 spec file.
> >
> > I don't have a patch handy, but simply changing -D__LANGUAGE_ASSMBLEY__ to
> > -D_LANGUAGE_ASSEMBLY and -D__LANGUAGE_C__ to -D_LANGUAGE_C in the spec
> > file worked for me.
>
> I've already changed those defines.
>
> I don't have a patch (I don't have the old file anylonger), but I can send
> the whole file (/usr/local/lib/gcc-lib/mips-linux/2.7.2.2/specs)
>

Works perfectly, i've just build the first kernel with it and i'm  now gonna
try to get al the output on the
serial console. (challenge S).

Richard
