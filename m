Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA84045 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Mar 1999 16:37:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA34969
	for linux-list;
	Fri, 5 Mar 1999 16:35:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from relay1.corp.sgi.com (spindle.corp.sgi.com [198.29.75.13] (may be forged))
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA50774
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 5 Mar 1999 16:35:56 -0800 (PST)
	mail_from (chad@dallas.sgi.com)
Received: from dallas.sgi.com (roctane.dallas.sgi.com [169.238.83.62]) by relay1.corp.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA31718; Fri, 5 Mar 1999 16:35:42 -0800 (PST)
Message-ID: <36E0785D.1758693B@dallas.sgi.com>
Date: Fri, 05 Mar 1999 18:35:41 -0600
From: Chad Carlin <chad@dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Re: 2.2.1 MIPS kernel sources plus Indy kernel binaries uploaded
References: <19990227001617.A4022@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas,

Anyone else have trouble with these on an R4400? I tried a couple times. Both
stopped the boot process a the "freeing unused memory" part. Sorry there was no
other info.

Regards,
Chad


Thomas Bogendoerfer wrote:

> After syncing my two source trees with CVS, I've exported a tarball
> and uploaded it to
>
> ftp://ftp.linux.sgi.com/pub/linux/mips/test/linux-2.2.1-990226.tar.gz
>
> I've tested compilation for Indy and Olivetti M700 (MIPS Magnum).
>
> I also uploaded a Indy kernel (map and .config file included):
>
> ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-2.2.1-990226.tar.gz
>
> Thomas.
>
> --
>    This device has completely bogus header. Compaq scores again :-|
> It's a host bridge, but it should be called ghost bridge instead ;^)
>                                         [Martin `MJ' Mares on linux-kernel]

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"
