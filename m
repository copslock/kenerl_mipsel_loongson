Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id QAA31316
	for <pstadt@stud.fh-heilbronn.de>; Mon, 27 Sep 1999 16:28:34 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA2850371; Mon, 27 Sep 1999 07:25:02 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA86079
	for linux-list;
	Mon, 27 Sep 1999 07:17:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA91851
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 27 Sep 1999 07:17:26 -0700 (PDT)
	mail_from (hanwen@cs.uu.nl)
Received: from mail.cs.uu.nl (sunset.cs.uu.nl [131.211.80.32]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA2754271
	for <linux@cthulhu.engr.sgi.com>; Mon, 27 Sep 1999 07:17:25 -0700 (PDT)
	mail_from (hanwen@cs.uu.nl)
Received: from dokkum.cs.uu.nl.cs.uu.nl (dokkum.cs.uu.nl [131.211.80.169])
	by mail.cs.uu.nl (Postfix) with ESMTP
	id 770144516; Mon, 27 Sep 1999 16:17:20 +0200 (MET DST)
From: Han-Wen Nienhuys <hanwen@cs.uu.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14319.32174.494753.691937@dokkum.cs.uu.nl>
Date: Mon, 27 Sep 1999 16:22:38 +0200 (CEST)
To: Gavin Kistner <gavin@refinery.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Linux->Indy->O2
In-Reply-To: <v04220602b415257a1e03@[216.63.49.245]>
References: <v04220602b415257a1e03@[216.63.49.245]>
X-Mailer: VM 6.71 under Emacs 20.4.1
Reply-To: hanwen@cs.uu.nl
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

gavin@refinery.com writes:
> I noticed the previous poster mentioning that the Indy2 doesn't have X support yet under Linux. I'm wondering: does linux support for one machine get fully implemented and then tweaked to go to others, or is it a ground-up approach for each new machine in the port list?
> 
> Basically, I'm wondering how hard its going to be to take linux over to the O2 once the Indy stuff gets really done.
> 
> In that vein, I want linux for my O2 so badly (even just in a command-line configuration) that I'm thinking about trying to help. What are the major obstacles which need overcoming to get the current state of linux-mips to work on an O2?

[Disclaimer, I don't use Linux/SGI, and don't know much about the
details].

Concerning X: 

Last thing I heard was that a simple SGI/Indy framebuffer was going to
be in XFree86 v4.

The architecture of the O2 and Indy are entirely different (the indy
has a pipeline of graphics chips that do successive transformations),
while the O2 has one big pool of memory that is used as framebuffer,
main memory, texture memory, etc. simultaneously. The architecture is
different, so you can't simply port the Indy X server.

I'm not sure about the O2 port, but it has been asked before.  Maybe
you can browse the list archive.

-- 

Han-Wen Nienhuys, hanwen@cs.uu.nl ** GNU LilyPond - The Music Typesetter 
      http://www.cs.uu.nl/people/hanwen/lilypond/index.html 
