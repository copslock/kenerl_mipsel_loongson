Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA95016 for <linux-archive@neteng.engr.sgi.com>; Thu, 10 Dec 1998 08:00:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA02457
	for linux-list;
	Thu, 10 Dec 1998 07:59:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA45003
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 10 Dec 1998 07:59:13 -0800 (PST)
	mail_from (sparker@taz.cs.utah.edu)
Received: from wrath.cs.utah.edu (wrath.cs.utah.edu [155.99.198.100]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA09932
	for <linux@cthulhu.engr.sgi.com>; Thu, 10 Dec 1998 07:59:12 -0800 (PST)
	mail_from (sparker@taz.cs.utah.edu)
Received: from taz.cs.utah.edu (taz.cs.utah.edu [155.99.203.51])
	by wrath.cs.utah.edu (8.8.8/8.8.8) with SMTP id IAA03995;
	Thu, 10 Dec 1998 08:59:12 -0700 (MST)
Received: by taz.cs.utah.edu (950413.SGI.8.6.12/utah-2.15sun-leaf)
	id IAA07178; Thu, 10 Dec 1998 08:59:11 -0700
Date: Thu, 10 Dec 1998 08:59:11 -0700
From: sparker@taz.cs.utah.edu (Steven G. Parker)
Message-Id: <9812100859.ZM7179@taz.cs.utah.edu>
In-Reply-To: ralf@uni-koblenz.de
        "Re: Linux on an SGI Challenge L" (Dec 10,  4:36pm)
References: <Pine.LNX.3.96.981209154550.5530A-100000@mdk187.tucc.uab.edu> 
	<19981210163646.60106@uni-koblenz.de>
X-Mailer: Z-Mail-SGI (3.2S.3 08feb96 MediaMail)
To: ralf@uni-koblenz.de, "Andrew R. Baker" <andrewb@uab.edu>
Subject: Re: Linux on an SGI Challenge L
Cc: linux-smp@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Dec 10,  4:36pm, ralf@uni-koblenz.de wrote:
> Subject: Re: Linux on an SGI Challenge L
> On Wed, Dec 09, 1998 at 03:47:19PM -0600, Andrew R. Baker wrote:
>
> > Anyone care to make any comments on porting Linux to an SGI Challenge L
> > machine w/ (4) R4400 processors?  Am I crazy to even attempt this?
>
> You're not crazy, after all Linux is already running on bigger iron and
> about to run on Sun's E10000.  However you should checkout again what
> hardware you actually have on your system.  A Challenge L is mostly like
> an Indy (which is supported), that is strictly uniprocessor.  So
> your system either is not a multiprocessor system or not a Challenge L.

Actually, the Indy system is a Challenge S.  The Indigo^2 system is
a Challenge M.   The Challenge L is the desk-side system and can indeed
support multiple processors.

I can only comment on the model line - not on whether you are crazy or not :)

Steve Parker
