Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA86695 for <linux-archive@neteng.engr.sgi.com>; Tue, 20 Oct 1998 16:37:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA09962
	for linux-list;
	Tue, 20 Oct 1998 16:36:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA10109
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Oct 1998 16:36:46 -0700 (PDT)
	mail_from (imp@village.org)
Received: from rover.village.org (rover.village.org [204.144.255.49]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id QAA07927
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Oct 1998 16:36:44 -0700 (PDT)
	mail_from (imp@village.org)
Received: from harmony [10.0.0.6] 
	by rover.village.org with esmtp (Exim 1.71 #1)
	id 0zVlKN-0000kW-00; Tue, 20 Oct 1998 17:36:35 -0600
Received: from harmony.village.org (localhost.village.org [127.0.0.1]) by harmony.village.org (8.9.1/8.8.3) with ESMTP id RAA29729; Tue, 20 Oct 1998 17:36:54 -0600 (MDT)
Message-Id: <199810202336.RAA29729@harmony.village.org>
To: ralf@uni-koblenz.de
Subject: Re: get_mmu_context() 
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
In-reply-to: Your message of "Tue, 20 Oct 1998 19:31:16 +0200."
		<19981020193116.C478@uni-koblenz.de> 
References: <19981020193116.C478@uni-koblenz.de>  <19981019121804.F387@uni-koblenz.de> <Pine.SV4.3.91.981016185136.876A-100000@mech.math.msu.su> <XFMail.981018215318.harald.koerfgen@netcologne.de> <19981019121804.F387@uni-koblenz.de> <199810200407.WAA03233@harmony.village.org> 
Date: Tue, 20 Oct 1998 17:36:53 -0600
From: Warner Losh <imp@village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In message <19981020193116.C478@uni-koblenz.de> ralf@uni-koblenz.de writes:
: running on the target machine.  On the other side as soon as we run on
: the machine we know these details.  They're constants, so why not making
: optimal use of them?

I'm confused then...

: You're right in that things should become more generic and I have ideas
: to make them more generic.  For the moment being I don't want to continue
: on that since 2.2 is coming soon and more important things are still to do.
: That's should however be an interesting 2.3 project.

Yes.  Basically something has load the kernel, and that something
could do the fixups.  Basically it would be a relocation record with a
"tag" on it that said what systems to do it on.

However, I do see your point that when you want to have the varients
based on cache size, memory controller, cache line size, etc it gets
really ugly....

It would be a cool project, however...

Warner
