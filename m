Received:  by oss.sgi.com id <S42219AbQF3UHG>;
	Fri, 30 Jun 2000 13:07:06 -0700
Received: from chmls05.mediaone.net ([24.147.1.143]:8395 "EHLO
        chmls05.mediaone.net") by oss.sgi.com with ESMTP id <S42200AbQF3UGp>;
	Fri, 30 Jun 2000 13:06:45 -0700
Received: from pianoman.cluster.toy (h00001c600ed5.ne.mediaone.net [24.147.29.131])
	by chmls05.mediaone.net (8.8.7/8.8.7) with ESMTP id QAA09114
	for <linux-mips@oss.sgi.com>; Fri, 30 Jun 2000 16:06:53 -0400 (EDT)
Message-Id: <200006302006.QAA09114@chmls05.mediaone.net>
Date:   Fri, 30 Jun 2000 16:06:54 EDT
From:   John Clemens <clemej@alum.rpi.edu>
To:     linux-mips@oss.sgi.com
Subject: XZ Graphics specs (again)..
Reply-To: clemej@alum.rpi.edu
X-Mailer: Spruce 0.7.1 for X11 w/smtpio 0.7.9
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



I know this subject has come up before.. several times.  I have XZ graphics
on
my indigo2, and I would like to write linux drivers to at least get a frame
buffer up and running, and then X. (heck, given enough docs, maybe even
MESA
support.)  Now, I know that the docs are either very hard to find or
non-existant at SGI anymore, so this is a serious hinderance.  So I have a
couple of possible solutions:

1) Ulf, could you run that script of yours again that found all the NG1
graphics
docs and look for XZ (and hey, while you're at it, indigo2) docs?

2) if that turns up nothing.. is there any possibility of someone (me, I'm
volunteering) to sign an NDA and look at the IRIX source to see how it
programs
it and reverse engineer a driver from that?  What I would need in that case
is
someone to give me a rundown on copyright law so that I know what I can and
can't do.  As much as I'd like to do this, I can't afford to get sued ;-)

thoughts? from SGI? legality concerns? I'm volunteering to do the grunt
work...

john.c

-- 
- --
/* John Clemens     http://www.rpi.edu/~clemej _/ "I Hate Quotes"       */
/* ICQ: 7175925     clemej@alum.rpi.edu      _/    -- Samuel L. Clemens */ 
