Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA10386 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Feb 1999 21:21:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA10317
	for linux-list;
	Mon, 22 Feb 1999 21:20:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from otg.dallas.sgi.com (roctane.dallas.sgi.com [169.238.83.62])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA37619
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Feb 1999 21:20:38 -0800 (PST)
	mail_from (chad@dallas.sgi.com)
Received: from dallas.sgi.com (localhost [127.0.0.1]) by otg.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id VAA18454 for <linux@cthulhu.engr.sgi.com>; Mon, 22 Feb 1999 21:20:25 -0800 (PST)
Message-ID: <36D23A99.162206DD@dallas.sgi.com>
Date: Mon, 22 Feb 1999 23:20:25 -0600
From: Chad Carlin <chad@dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: linux <linux@cthulhu.engr.sgi.com>
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
References: <199902170627.WAA09135@kilimanjaro.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok. Somebody shoot me. I went through and reinstalled linux on my Indy. I
thought that I screwed up and somehow did not get modutils-x.x.x-x because
I chose to install the wrong package set. I think I was wrong there too.

Problem:
- modutils-x.x.x-x does not get installed by the base installer. (or I
don't know which one it goes with)
- Can't get this package over the network because if I try to use my
network interface, the system panics. It panics because I don't have
modutils.
- BTW howto-french-5.1.1 seems to be corrupted in the distribution. My indy
always hangs when trying to install it. Hence, I have to deselect
optional-documentation during install.

Thanks for any help. I'm feel like I'm so close here.

Chad


--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"
