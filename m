Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA46735 for <linux-archive@neteng.engr.sgi.com>; Tue, 4 May 1999 10:48:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA48729
	for linux-list;
	Tue, 4 May 1999 10:46:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA23685
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 May 1999 10:46:53 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (pr250.pheasantrun.net [208.140.225.250]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA09854
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 May 1999 13:46:52 -0400 (EDT)
	mail_from (clepple@foo.tho.org)
Received: from tool.foo.tho.org (clepple@tool.foo.tho.org [206.223.45.1])
	by foo.tho.org (8.8.7/8.8.7) with ESMTP id NAA30483;
	Tue, 4 May 1999 13:46:17 -0400
Date: Tue, 4 May 1999 13:46:17 -0400 (EDT)
From: Charles Lepple <clepple@foo.tho.org>
To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: CP0_STATUS interrupt mask patch
In-Reply-To: <XFMail.990430105522.Harald.Koerfgen@home.ivm.de>
Message-ID: <Pine.LNX.4.04.9905041342400.30478-100000@foo.tho.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 30 Apr 1999, Harald Koerfgen wrote:

> on DECstations but may trigger undiscovered bugs on other machines.

I just pulled down the CVS kernel with the patch, and it seems that it
causes a 'keyboard timeout[2]' to be printed on the console after the SCSI
bus is probed. I undid the patch manually (ie, the rest of the kernel is
still from the cvs update) and it boots fine. Anyone else seen this?

--Charles Lepple
System Administrator, Virginia Tech EE Workstation Labs
clepple@foo.tho.org || http://foo.tho.org/charles/
