Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA121318 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Sep 1997 14:38:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA17897 for linux-list; Wed, 24 Sep 1997 14:38:22 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA17889 for <linux@cthulhu.engr.sgi.com>; Wed, 24 Sep 1997 14:38:20 -0700
Received: from mocha.foo.org (pr119.pheasantrun.net [208.140.225.119]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA06737
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Sep 1997 14:38:19 -0700
	env-from (clepple@foo.org)
Received: from mug.foo.org by mocha.foo.org on Wed, 24 Sep 1997 17:37:42 -0400 (EDT)
Received: from mug.foo.org (localhost [127.0.0.1]) by mug.foo.org (8.7.6/8.7.3) with ESMTP id RAA00921 for <linux@cthulhu.engr.sgi.com>; Wed, 24 Sep 1997 17:37:26 -0400
Message-Id: <199709242137.RAA00921@mug.foo.org>
X-Mailer: exmh version 1.6.7 05/05/96
To: linux@cthulhu.engr.sgi.com
Subject: Indy netboot problems
Reply-to: clepple@foo.org
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 24 Sep 1997 17:37:26 -0400
From: Charles Lepple <clepple@foo.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello all,
Sorry to bother you if this is a routine question, but I read the FAQ, and 
therein lies my problem.

I'm trying to make an Indy netboot, but I'm not too familiar with the new 
monitor (let's just say that I knew sifex much better...Anyone remember the 
IRIS 3130s?). I need a way to correct the HW address, since it appears to be 
set to '0:0:FF:FF:0:0', and it is complaining about it.

Is there any other way to change nvram settings except through the 
setenv/printenv commands?

I hope to be contributing to this project soon, but I'm off to a fairly rocky 
start ;-)

Thanks in advance,

--Charles Lepple, <clepple@foo.org>
<clepple@ugrad.ee.vt.edu>
http://www.ee.vt.edu/solarcar/
http://www.mitre.org/research/nanotech/
