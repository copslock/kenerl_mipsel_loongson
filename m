Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2002 09:00:55 +0200 (CEST)
Received: from ns.dce.bg ([212.50.14.242]:27140 "EHLO mastika.dce.bg")
	by linux-mips.org with ESMTP id <S1123927AbSJHHAz>;
	Tue, 8 Oct 2002 09:00:55 +0200
Received: from localhost ([127.0.0.1])
	by mastika.dce.bg with esmtp (Exim 3.36 #1 (Debian))
	id 17yoMP-0000EB-00
	for <linux-mips@linux-mips.org>; Tue, 08 Oct 2002 10:00:53 +0300
Date: Tue, 8 Oct 2002 10:00:52 +0300 (EEST)
From: Petko Manolov <petkan@dce.bg>
To: linux-mips@linux-mips.org
Subject: cvs problem
Message-ID: <Pine.LNX.4.44.0210080957010.877-100000@mastika.dce.bg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <petkan@dce.bg>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petkan@dce.bg
Precedence: bulk
X-list: linux-mips

	Hi there,

is it just me or the cvs repository is out of order?  When i try to
checkout the linux kernel with:
	cvs -d:pserver:cvs@oss.sgi.com:/cvs co linux
I get:
	cvs server: cannot find module `linux' - ignored
	cvs [checkout aborted]: cannot expand modules

Other modules (such as gdb) are working.  Any ideas?..


		Petko
