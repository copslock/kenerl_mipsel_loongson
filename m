Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA35474 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Sep 1998 22:45:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA34992
	for linux-list;
	Wed, 23 Sep 1998 22:44:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA52876
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Sep 1998 22:44:37 -0700 (PDT)
	mail_from (rjh@pixel.maths.monash.edu.au)
Received: from pixel.maths.monash.edu.au (pixel.maths.monash.edu.au [130.194.160.20]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA01299
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Sep 1998 22:44:34 -0700 (PDT)
	mail_from (rjh@pixel.maths.monash.edu.au)
Received: (from rjh@localhost)
	by pixel.maths.monash.edu.au (8.8.8/8.8.8-ajr) id PAA26674;
	Thu, 24 Sep 1998 15:44:22 +1000 (EST)
From: Robin Humble <rjh@pixel.maths.monash.edu.au>
Message-Id: <199809240544.PAA26674@pixel.maths.monash.edu.au>
Subject: Re: challenge s boots linux
To: richardh@infopact.nl (Richard Hartensveld)
Date: Thu, 24 Sep 1998 15:44:21 +1000 (EST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <36081277.17A50BC9@infopact.nl> from "Richard Hartensveld" at Sep 22, 98 11:11:19 pm
X-Mailer: ELM [version 2.4 PL23]
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>Warning: unable to open an initial console.

I got this message for (it seemed) a variety of reasons. One was that it
couldn't find the nfs server, but in the end it was that I was
booting off an O2 and the permissions on the dev/ directory were all
screwed from SGIs tar. Re-building dev to match a x86/Linux machine
fixed it.
So it's a long shot, but check that your dev directory in the nfs
mounted distribution looks like:

crw-------   1 root     root       4,   0 Sep 13 20:05 console
crw-rw-rw-   1 root     root       1,   3 Jan  1  1980 null
brw-r-----   1 root     disk       1,   1 Jan  1  1980 ram
crw-------   1 root     root       4,   0 Sep  3  1995 systty
crw-------   1 root     root       4,   1 Sep 13 20:05 tty1
crw-------   1 root     root       4,   2 Sep 13 20:05 tty2
crw-------   1 root     root       4,   3 Sep 13 20:05 tty3
crw-------   1 root     root       4,   4 Sep 13 20:05 tty4
crw-------   1 root     root       4,   5 Sep 13 20:05 tty5

+
There's not a line that goes here that  +         Robin Humble
rhymes with anything, anything,      /     rjh@pixel.maths.monash.edu.au
anything. - Camper van Beethoven  + http://www.maths.monash.edu.au/~rjh/
