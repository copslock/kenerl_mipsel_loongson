Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA23226 for <linux-archive@neteng.engr.sgi.com>; Wed, 4 Nov 1998 16:42:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA09539
	for linux-list;
	Wed, 4 Nov 1998 16:41:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from piecomputer.engr.sgi.com (piecomputer.engr.sgi.com [150.166.75.62])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA18612
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 4 Nov 1998 16:41:47 -0800 (PST)
	mail_from (mende@piecomputer.engr.sgi.com)
Received: (from mende@localhost) by piecomputer.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id QAA02949; Wed, 4 Nov 1998 16:41:46 -0800 (PST)
Date: Wed, 4 Nov 1998 16:41:46 -0800 (PST)
Message-Id: <199811050041.QAA02949@piecomputer.engr.sgi.com>
From: Bob Mende Pie <mende@piecomputer.engr.sgi.com>
To: ralf@uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <19981028132004.A2100@uni-koblenz.de> (ralf@uni-koblenz.de)
Subject: Re: Challenge S question
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Date: Wed, 4 Nov 1998 13:20:04 +0100
> From: ralf@uni-koblenz.de
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> X-Mailer: Mutt 0.91.1
> Sender: owner-linux@cthulhu
> Precedence: bulk
> 
> Short question, the Challenge S is headless.  Does it still have the
> keyboard controller and keyboard and mouse ports in the hardware?
> 
>   Ralf
> 

It should.   The challenge/S is a indy with the following changes.

.	Pull the graphics card out of it.
.	Put an IOplus card where the graphics card goes.
	An ioplus has two WD33C95A controlers on it and a 2nd eithernet
	that is the same type as the onboard ec0 but is IDed as ec3.
.	Put diffrent sheetmetal on the back of the box so the connectors on
	the IOplus line up with holes.

                    /Bob...                    mailto:mende@sgi.com
              http://reality.sgi.com/mende            KF6EID
