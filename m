Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA79522 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Oct 1998 04:23:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA82759
	for linux-list;
	Sun, 4 Oct 1998 04:22:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA14238
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 4 Oct 1998 04:22:25 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from ruvild.bun.falkenberg.se ([194.236.80.7]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA03689
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Oct 1998 04:22:24 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (really [130.244.76.67]) by bun.falkenberg.se
	via in.smtpd with smtp (ident grim using rfc1413)
	id <m0zPmJ2-002vJBC@ruvild.bun.falkenberg.se> (Debian Smail3.2.0.101)
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Oct 1998 13:26:28 +0200 (CEST) 
Date: Sun, 4 Oct 1998 13:23:12 +0200 (CEST)
From: Ulf Carlsson <grim@zigzegv.ml.org>
X-Sender: grim@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: HAL2
Message-ID: <Pine.LNX.3.96.981004125525.2569A-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

As you know IRIX uses an audio library to provide audio support for user
level applications. The implementation of my HAL2 driver will exist in
kernel space, and a user level library will provide higher level interface
to the applications (the same interface as libaudio.a in IRIX). Do we know
what the interface between libaudio.a and the Irix kernel looks like or am
I free to do what I want?

The code I've written so far is based upon this idea.

Is this the Right Thing to do it?

Is there any further information except audio.h and hal.h which I don't
have? 

- Ulf
