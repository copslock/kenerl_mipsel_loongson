Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA51875 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Feb 1999 10:15:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA58384
	for linux-list;
	Mon, 22 Feb 1999 10:14:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from otg.dallas.sgi.com (roctane.dallas.sgi.com [169.238.83.62])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA99534
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Feb 1999 10:14:30 -0800 (PST)
	mail_from (chad@dallas.sgi.com)
Received: from dallas.sgi.com (localhost [127.0.0.1]) by otg.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA17544 for <linux@cthulhu.engr.sgi.com>; Mon, 22 Feb 1999 10:14:23 -0800 (PST)
Message-ID: <36D19E7E.955F66EC@dallas.sgi.com>
Date: Mon, 22 Feb 1999 12:14:22 -0600
From: Chad Carlin <chad@dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
CC: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
References: <Pine.LNX.3.96.990217020751.6350A-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I got my 200MHz R4400 working too. Yes it actually boots. I guess you guys
weren't making all this stuff up after all.

I have one problem though. Something is broken in modules. The networking
stuff is working incorrectly because of this. When I try to telnet in from
another host, the linux-indy panics. I can hand copy more verbose
information when I get home if this is not a common problem that everyone
else knows the answer to.

Almost there.
Chad


Alex deVries wrote:

> On Tue, 16 Feb 1999, Joan Eslinger wrote:
> > Anyway, vmlinux-indy-990212 was the winner: it booted up into the
> > installer, I was able to do a complete install (ignoring swap, as web
> > page says), and it's up and running. I'm sending this out to let those
> > who've been having trouble with Indy/R4400SC know that it can be done
> > now!
>
> Okay, that's cool.  Could you give us an output from your irix's hinv?
>
> - Alex
>
> --
> Alex deVries, puffin on LinuxNet.
> I know exactly what I want in life.

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"
