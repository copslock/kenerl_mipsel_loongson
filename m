Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA63128 for <linux-archive@neteng.engr.sgi.com>; Fri, 7 May 1999 08:37:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA40244
	for linux-list;
	Fri, 7 May 1999 08:36:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA65091
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 7 May 1999 08:36:32 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from vera.dpo.uab.edu (Vera.dpo.uab.edu [138.26.1.12]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA08642
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 May 1999 08:36:01 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu by vera.dpo.uab.edu (LSMTP for Windows NT v1.1a) with SMTP id <0.0DA77860@vera.dpo.uab.edu>; Fri, 7 May 1999 10:26:22 -0500
Date: Fri, 7 May 1999 10:27:04 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Remote Debugging
Message-ID: <Pine.LNX.3.96.990507101156.28911B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Could someone who has succesfully set up remote kernel debugging help me
to get it working over here?  This is what I get from gdb when trying to
set up the connection:

(gdb) target remote /dev/ttyS1
Remote debugging using /dev/ttyS1
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Couldn't establish connection to remote target
Malformed response to offset query, timeout


Any suggestions?

-Andrew
