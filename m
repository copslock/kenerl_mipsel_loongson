Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA96573 for <linux-archive@neteng.engr.sgi.com>; Thu, 10 Dec 1998 08:22:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA43820
	for linux-list;
	Thu, 10 Dec 1998 08:21:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA32003;
	Thu, 10 Dec 1998 08:21:48 -0800 (PST)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id IAA84751; Thu, 10 Dec 1998 08:21:47 -0800 (PST)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199812101621.IAA84751@anchor.engr.sgi.com>
Subject: Re: Linux on an SGI Challenge L
In-Reply-To: <9812100859.ZM7179@taz.cs.utah.edu> from "Steven G. Parker" at "Dec 10, 98 08:59:11 am"
To: sparker@taz.cs.utah.edu (Steven G. Parker)
Date: Thu, 10 Dec 1998 08:21:47 -0800 (PST)
Cc: ralf@uni-koblenz.de, andrewb@uab.edu, linux-smp@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Steven G. Parker wrote: 
|  On Dec 10,  4:36pm, ralf@uni-koblenz.de wrote:
|  > > Anyone care to make any comments on porting Linux to an SGI Challenge L
|  > > machine w/ (4) R4400 processors?  Am I crazy to even attempt this?
|  >
|  > You're not crazy, after all Linux is already running on bigger iron and
|  > about to run on Sun's E10000.  However you should checkout again what
|  > hardware you actually have on your system.  A Challenge L is mostly like
|  > an Indy (which is supported), that is strictly uniprocessor.  So
|  > your system either is not a multiprocessor system or not a Challenge L.
|  
|  Actually, the Indy system is a Challenge S.  The Indigo^2 system is
|  a Challenge M.   The Challenge L is the desk-side system and can indeed
|  support multiple processors.
|  
|  I can only comment on the model line - not on whether you are crazy or not :)

The hardware is radically different.  The only shared item is the cpu,
and even it's used in a fairly different way.  indy w/o graphics as
challenge S, etc. is strictly a marketing idea.

It's clearly doable, but you need a whole new set of hardware specs.

Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
