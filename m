Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA47100 for <linux-archive@neteng.engr.sgi.com>; Mon, 21 Dec 1998 13:34:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA71127
	for linux-list;
	Mon, 21 Dec 1998 13:33:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA72625
	for <linux@engr.sgi.com>;
	Mon, 21 Dec 1998 13:33:48 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id NAA08955 for linux@engr.sgi.com; Mon, 21 Dec 1998 13:33:48 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199812212133.NAA08955@oz.engr.sgi.com>
Subject: Re: bootp on IRIX server
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Mon, 21 Dec 1998 13:33:48 -0800 (PST)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[Forwarding bounced message.
 Please subscribe with an explicit general-domain (no machine)
 to avoid anti-spam subscriber-only bounces.
 Majordomo is picky about this -- Ariel]

Date: Mon, 21 Dec 1998 13:23:19 -0800
From: Shrijeet Mukherjee <shm@engr.sgi.com>
To: Al Aumenta <aumenta@albany.sgi.com>
cc: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: bootp on IRIX server
In-Reply-To: <367EB96A.AB060206@albany.sgi.com>
Message-ID: <Pine.SGI.4.05.9812211321150.14389-100000@tantrik.engr.sgi.com>


I had the same problem .. and I really do not remember what I did to make
it go away ..

but here are 2 things to try ..

1> run snoop on your SGI box .. and see what exactly is happening ..
2> try and bootp the unix kernel (IRIX) and see if bootp is setup and
running right ..


another thing I gathered is that there is some NFS incompatibility and we
need to serve the bootp of an intel linux box .. and thus I resorted to
that ..

hope this helps ..


On Mon, 21 Dec 1998, Al Aumenta wrote:

->I am attempting to install Linux on an Indy but I am running into a
->problem



-- 
Peace, Ariel
