Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA68885 for <linux-archive@neteng.engr.sgi.com>; Wed, 31 Mar 1999 08:20:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA81095
	for linux-list;
	Wed, 31 Mar 1999 08:19:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA10101;
	Wed, 31 Mar 1999 08:19:40 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09171; Wed, 31 Mar 1999 08:19:40 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id IAA09057;
	Wed, 31 Mar 1999 08:19:25 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.03) with ESMTP id
          F9GW0N00.PEM; Wed, 31 Mar 1999 08:19:35 -0800 
Message-ID: <37024AC1.AE5D79E9@netscape.com>
Date: Wed, 31 Mar 1999 11:18:09 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: mozilla.org diplomatic corps
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.3-5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
CC: Alan Hoyt <neuroinc@unidial.com>,
        SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: Port to R3000 Indigo
References: <199903300853.AAA52093@oz.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon wrote:
> Now, if it were entirely in my hands, I would have gladly published
> some source code.  The problem is much more complex than that.  The
> IRIX source code includes licensed code from many external commercial
> sources, AT&T SVR4, Sun, Xerox, etc. each surrounded by its own complex
> licensing terms, so the lawyers need to look into this lest SGI
> becomes liable by just making some "innocent goodwill" happen.
> 
> I know it sounds lame, and I as much as anyone, hate this, but
> this is reality, and it isn't simple as it may appear to some.
> It requires a lot of legal (inspection and clearance) + engineering
> (sanitize and clean up code) time which I'm not sure we can afford
> on a global scale.

Just to leap unnecessarily to Ariel's defense, I'll tell you that once
_all_ of Netscape, from Jim Barksdale on down, had decided to release
the source to Communicator, it tooks 3 months of about 70 engineers to
clean it up fully.  That meant removing code that had crypto elements
and code that was licensed from other companies.

Communicator is a 4-year-old product.  There are (well, were) still
people around who were a part of just about every deal that put code in
there, and could tell you where all but about 15 lines came from.

Now, we have people at Netscape (excuse me, AOL) who left SGI 8 years
ago, and still have code in the IRIX kernel[*].  The effort required to
sanitize the IRIX kernel and X server and the like would surely eclipse
our experiences.  No Small Task.

It is quite pointless, IMHO, to rail at Ariel about this; he and his
band of merry men have been fighting the good fight within SGI for
years, long before it was cool for a Unix company to do Linux.  If you
really want to help, I think the best thing to do is flank SGI: make
sure that the sales and marketing folk know that SGI's support for Linux
on their older hardware is significant to you as a once-and-future
customer.  (Where they should certainly be led to interpret
``significant'' as ``affecting future purchasing decisions''.)  If you
have friends on the board of SGI, maybe give them a call too. =)

[*] grep XXXbe /usr/include/sys/*.h; that's brendan@mozilla.org.

Mike

-- 
588472.19 72598.35
