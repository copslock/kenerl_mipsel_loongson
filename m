Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA89168 for <linux-archive@neteng.engr.sgi.com>; Thu, 21 Jan 1999 10:33:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA56786
	for linux-list;
	Thu, 21 Jan 1999 10:33:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA51905;
	Thu, 21 Jan 1999 10:33:15 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id KAA51826; Thu, 21 Jan 1999 10:33:14 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199901211833.KAA51826@oz.engr.sgi.com>
Subject: Re: 2.2pre9 has VW support
To: jcoffin@sv.usweb.com (Jeff Coffin)
Date: Thu, 21 Jan 1999 10:33:14 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <m367a078bd.fsf@chuck.sv.usweb.com> from "Jeff Coffin" at Jan 21, 99 11:08:22 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:So I suppose some of you have seen this, but do any SGI folks care to
:comment knowledgeably?
:
:http://www.slashdot.org/articles/99/01/21/0727205.shtml
:
:http://edge.linuxhq.com/changelist.cgi?show=2.2.0pre9
:

I guess I can comment on this.

Bent Hagemark (an SGI engineer) figured out how to boot
Linux on the VisWS, including recognizing the low level
hardware, wrote the patch, emailed it to Ingo Molnar
for review and comments, Ingo made some minor changes
to better fit in the scheme of things, sent it to Linus,
and there we have it in the official Linux tree :-)

Please note that this only enables booting the VisWS
multi user and it doesn't yet have accelerated graphics
support as Ken Klingman said before.  I'm sure Ken
can add more information and correct me where I'm wrong.

-- 
Peace, Ariel
