Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6SBp8o20143
	for linux-mips-outgoing; Sat, 28 Jul 2001 04:51:08 -0700
Received: from mailout05.sul.t-online.de (mailout05.sul.t-online.com [194.25.134.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6SBp6V20137
	for <linux-mips@oss.sgi.com>; Sat, 28 Jul 2001 04:51:07 -0700
Received: from fwd01.sul.t-online.de 
	by mailout05.sul.t-online.de with smtp 
	id 15QScZ-0004c5-03; Sat, 28 Jul 2001 13:51:03 +0200
Received: from erich (520031278902-0001@[62.155.142.221]) by fmrl01.sul.t-online.com
	with esmtp id 15QScM-1eMrpYC; Sat, 28 Jul 2001 13:50:50 +0200
Received: by erich (Postfix, from userid 1000)
	id 3565C4822B; Wed, 25 Jul 2001 23:59:24 +0200 (CEST)
Date: Wed, 25 Jul 2001 23:59:24 +0200
From: Erich Schubert <erich.schubert@mucl.de>
To: Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Sound on SGI Indy?
Message-ID: <20010725235924.A2124@erich.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-GPG: 4B3A135C 6073 C874 8488 BCDA A6A9  B761 9ED0 78EF 4B3A 135C
X-Sender: 520031278902-0001@t-dialin.net
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

did anyone get sound to run on a Indy?
As far as i've read, alsa does contain drivers which should play sound
correctly.

So i checked out current cvs kernel, compiled it, compiled alsa and
tried to load the modules - and got a kernel oops.

Can someone point me to some recent information about sound on sgi indy?

Greetings,
Erich

P.S.
I've currently not subscribed the SGI Mips list, only the debian mips
list - so please do not reply to the list only. Thanks.
Please do not crosspost replys to both lists. Thanks.
