Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA93463 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Sep 1998 14:36:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA24126
	for linux-list;
	Tue, 22 Sep 1998 14:36:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA07164
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 22 Sep 1998 14:36:06 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from bronx.bizarre.nl (9dyn84.breda.casema.net [195.96.116.84]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00377
	for <linux@cthulhu.engr.sgi.com>; Tue, 22 Sep 1998 14:36:02 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from infopact.nl (root@localhost [127.0.0.1])
	by bronx.bizarre.nl (8.9.0/8.9.0) with ESMTP id XAA00467;
	Tue, 22 Sep 1998 23:41:22 +0200
Message-ID: <36081982.8D3B6975@infopact.nl>
Date: Tue, 22 Sep 1998 23:41:22 +0200
From: Richard Hartensveld <richardh@infopact.nl>
X-Mailer: Mozilla 4.05 [en] (X11; I; Linux 2.0.35 i686)
MIME-Version: 1.0
To: Rob Lembree <lembree@sgi.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
References: <36081277.17A50BC9@infopact.nl> <3608103B.6F2844E2@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Rob Lembree wrote:

> hmm, I had the same problem on my Indy.  I found that
> IRIX had stripped the major and minor numbers from the
> device files in the tar distribution -- the answer was to
> untar using Linux, not IRIX (gtar doesn't help), or to
> manually recreate the dev files.

I've untarred the hardhat distr. on my linux machine and that's the
machine that plays nfs server for the
challenge.

Should the default kernel support serial terminal consoles?? My goal is
to install linux onto the challenge
(which is headless) using a serial terminal connected to it, is this
possible by default or should i cross-compile my own kernel on another
platform?.

Regards,

Richard Hartensveld
The Netherlands
