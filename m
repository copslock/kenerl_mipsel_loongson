Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA14657 for <linux-archive@neteng.engr.sgi.com>; Mon, 19 Oct 1998 21:08:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA27722
	for linux-list;
	Mon, 19 Oct 1998 21:07:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA93178
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 19 Oct 1998 21:07:27 -0700 (PDT)
	mail_from (imp@village.org)
Received: from rover.village.org (rover.village.org [204.144.255.49]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id VAA06267
	for <linux@cthulhu.engr.sgi.com>; Mon, 19 Oct 1998 21:07:25 -0700 (PDT)
	mail_from (imp@village.org)
Received: from harmony [10.0.0.6] 
	by rover.village.org with esmtp (Exim 1.71 #1)
	id 0zVT4o-0000EI-00; Mon, 19 Oct 1998 22:07:18 -0600
Received: from harmony.village.org (localhost.village.org [127.0.0.1]) by harmony.village.org (8.9.1/8.8.3) with ESMTP id WAA03233; Mon, 19 Oct 1998 22:07:26 -0600 (MDT)
Message-Id: <199810200407.WAA03233@harmony.village.org>
To: ralf@uni-koblenz.de
Subject: Re: get_mmu_context() 
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
In-reply-to: Your message of "Mon, 19 Oct 1998 12:18:04 +0200."
		<19981019121804.F387@uni-koblenz.de> 
References: <19981019121804.F387@uni-koblenz.de>  <Pine.SV4.3.91.981016185136.876A-100000@mech.math.msu.su> <XFMail.981018215318.harald.koerfgen@netcologne.de> 
Date: Mon, 19 Oct 1998 22:07:26 -0600
From: Warner Losh <imp@village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Wouldn't it be easier to have ld to have variant fixup records?  That
way you could patch all instances at run time, much like we do when we
load stuff now...

You are basically duplicating the functionality of the linker here for
no good reason.  Actually, besides the non-standard aspect of it,
there is a good reason: it is easier to hack like this than to do
battle with the bfd and/or boot blocks to get this to happen. :-)

It is a way cool hack, don't get me wrong, but it just seems that it
would be more useful to be generic like that.

Warner
