Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA93443 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Feb 1999 22:21:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA48879
	for linux-list;
	Mon, 22 Feb 1999 22:21:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA28796
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Feb 1999 22:20:58 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA02343
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Feb 1999 22:20:57 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA01724;
	Tue, 23 Feb 1999 01:21:02 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 23 Feb 1999 01:21:02 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: chad@sgi.com
cc: linux <linux@cthulhu.engr.sgi.com>
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
In-Reply-To: <36D23A99.162206DD@dallas.sgi.com>
Message-ID: <Pine.LNX.3.96.990223011941.1617A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 22 Feb 1999, Chad Carlin wrote:
> Ok. Somebody shoot me. I went through and reinstalled linux on my Indy. I
> thought that I screwed up and somehow did not get modutils-x.x.x-x because
> I chose to install the wrong package set. I think I was wrong there too.
> 
> Problem:
> - modutils-x.x.x-x does not get installed by the base installer. (or I
> don't know which one it goes with)

Yup. modutils was broken at the time when Rough Cuts was put together.
Theres a newer package that does work on the ftp site.

> - Can't get this package over the network because if I try to use my
> network interface, the system panics. It panics because I don't have
> modutils.

Why do you need modules to get your network going?

> - BTW howto-french-5.1.1 seems to be corrupted in the distribution. My indy
> always hangs when trying to install it. Hence, I have to deselect
> optional-documentation during install.

We know that. :)

- Alex
