Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48LOiwJ016458
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 14:24:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48LOiYC016457
	for linux-mips-outgoing; Wed, 8 May 2002 14:24:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mta4.srv.hcvlny.cv.net (mta4.srv.hcvlny.cv.net [167.206.5.10])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48LOfwJ016441
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 14:24:42 -0700
Received: from dev1 (dev.cvnet.com [24.185.255.18]) by mta4.srv.hcvlny.cv.net
 (iPlanet Messaging Server 5.0 Patch 2 (built Dec 14 2000))
 with SMTP id <0GVT00H11A7JN4@mta4.srv.hcvlny.cv.net> for
 linux-mips@oss.sgi.com; Wed, 08 May 2002 17:26:08 -0400 (EDT)
Date: Wed, 08 May 2002 17:26:09 -0400
From: Rick Spanbauer <rick@sirius.cvnet.com>
Subject: copy_mount_options
To: linux-mips@oss.sgi.com
Message-id: <NFBBJEOAELIHHOOPHOOHOEOACGAA.rick@sirius.cvnet.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Howdy - I am having a bit of a problem with a kernel port I've been working
on recently.  Linux is up and running to the initial sh prompt, networking/ethernet
works, and so on.  When I try a mount(), I am getting a kernel page fault.  Between
a few hours worth of debugging and some Googling around, I believe I understand
what is happening, ie when copy_mount_option is copying in from user space, it
seems to be running off the end of the data segment (code was apparently written with
the assumption that this is legal).  I can think of several different solutions, but
the question is this - is there some common, accepted practice solution to
this particular problem?  From searching the discussion groups, this class of problem
seems to be a known issue, but the arguments pro/con about what to do about
it never seem to converge :)  So before tracking off into the wilderness
on my own, I thought I might ask!  Tnx Rick Spanbauer
