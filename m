Received: from cthulhu.engr.sgi.com ([192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id WAA10399; Thu, 31 Jul 1997 22:02:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA26122 for linux-list; Thu, 31 Jul 1997 16:22:16 -0700
Received: from odin.corp.sgi.com (odin.corp.sgi.com [192.26.51.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA25574 for <linux@cthulhu.engr.sgi.com>; Thu, 31 Jul 1997 16:19:37 -0700
Received: from sgibos.boston.sgi.com by odin.corp.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/951211.SGI)
	for <linux@cthulhu.engr.sgi.com> id LAA04423; Thu, 31 Jul 1997 11:38:50 -0700
Received: from tvp.boston.sgi.com by sgibos.boston.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	 id OAA18526; Thu, 31 Jul 1997 14:38:45 -0400
Received: (from wmesard@localhost) by tvp.boston.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id OAA09712; Thu, 31 Jul 1997 14:44:32 -0400
Date: Thu, 31 Jul 1997 14:44:32 -0400
Message-Id: <199707311844.OAA09712@tvp.boston.sgi.com>
From: Wayne Mesard <wmesard@cthulhu.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: startup tune
In-Reply-To: Alex deVries's message of 24 July 1997 23:15:26
References: <199707241742.KAA26102@oz.engr.sgi.com>
	<Pine.LNX.3.95.970724230351.22084H-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
> - Is there anyway to get rid of that jazzy sound startup thing?  Sure, it
> puts all the Mac's in my office to shame, but after about the twentieth
> time it's a little bothering...

  From the prom:      setenv volume 0
  From an Irix shell: nvram volume 0

Wayne();
617-489-7864
