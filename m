Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA15549 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Feb 1999 13:42:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA85830
	for linux-list;
	Fri, 5 Feb 1999 13:42:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from otg.dallas.sgi.com (roctane.dallas.sgi.com [169.238.83.62])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA60165
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 5 Feb 1999 13:42:19 -0800 (PST)
	mail_from (chad@dallas.sgi.com)
Received: from dallas.sgi.com (localhost [127.0.0.1]) by otg.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA23026; Fri, 5 Feb 1999 13:42:17 -0800 (PST)
Message-ID: <36BB65B9.A036E9C5@dallas.sgi.com>
Date: Fri, 05 Feb 1999 15:42:17 -0600
From: Chad Carlin <chad@dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: ralf@uni-koblenz.de
CC: Alexander Graefe <nachtfalke@usa.net>, linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <19990202155147.A1565@ganymede> <19990203043951.D3920@uni-koblenz.de> <19990204154637.B5941@ganymede> <19990205034821.A620@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Does this mean that I should be able to use .131 kernel in conjunction with a
local e2fs filesystem with the contents of root-be-0.04.cpio installed on it?
And it should work?

Chad


ralf@uni-koblenz.de wrote:

> On Thu, Feb 04, 1999 at 03:46:37PM +0100, Alexander Graefe wrote:
>
> > On Wed, Feb 03, 1999 at 04:39:51AM +0100, ralf@uni-koblenz.de wrote:
> >
> > >  - the exact screen output.  Especially the register dump following the
> > >    Aiee message is important.
> >
> > kernel 2.1.100 (the one from the HardHat.tgz)
>
> 2.1.100 is known to fail on R4400.  This is supposed to be fixed in .131
> which is why I'm worried about the other bug report.  Your case is obvious -
> use a newer kernel.
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
