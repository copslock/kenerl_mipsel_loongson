Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA64407 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Jun 1998 15:04:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA53821
	for linux-list;
	Wed, 10 Jun 1998 15:03:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA59189
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Jun 1998 15:03:40 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id PAA00603
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Jun 1998 15:03:38 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id XAA28695 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Jun 1998 23:03:36 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yjtki-000aOnC; Wed, 10 Jun 98 23:53 BST
Message-Id: <m0yjtki-000aOnC@the-village.bc.nu>
Date: Wed, 10 Jun 98 23:53 BST
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
To: linux@cthulhu.engr.sgi.com
Subject: X and stuff
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Actually I've been doing somethingwith the info from SGI indirectly. 
Unfortunately a lot of what we need to do X11 well is in XFree 3.9.* and
because XFree have currently got a rather weird policy partly due to
Xconsortium we are basically screwed on doing a proper SGI Linux server
until they release 4.0 when we get all the current and rather nice XAA
code.

Right now 3.3 really really wants to believe that all the world has direct
access to the frame buffer.

Alan
