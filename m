Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA86024 for <linux-archive@neteng.engr.sgi.com>; Thu, 25 Jun 1998 13:42:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA54503
	for linux-list;
	Thu, 25 Jun 1998 13:41:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA18917
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 Jun 1998 13:41:48 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id NAA05148
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Jun 1998 13:41:47 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id VAA30113; Thu, 25 Jun 1998 21:41:28 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0ypIvl-000aOnC; Thu, 25 Jun 98 21:47 BST
Message-Id: <m0ypIvl-000aOnC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: New 2.0.107 console scheme
To: jesseba@rock.csd.sgi.com (Jesse Barnes)
Date: Thu, 25 Jun 1998 21:47:41 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <3592B271.14F268F4@csd.sgi.com> from "Jesse Barnes" at Jun 25, 98 01:26:25 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Does the main kernel source tree have support for Indys natively, and
> if so, is the new fbcon method supported for the console?  

Almost and no. Its not fb_con thats relevant for the indy. fbcon is a directly
accessible bitmapped display. The indy will need to use abscon directly  to
issue newport commands
