Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MAivRw019287
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 03:44:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MAiuKZ019286
	for linux-mips-outgoing; Mon, 22 Jul 2002 03:44:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sbrodie.cam.pace.co.uk (host-33-223.pace.co.uk [136.170.33.223])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MAikRw019270
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 03:44:48 -0700
Received: from loopback ([127.0.0.1]) by sbrodie.cam.pace.co.uk with SMTP; Mon, 22 Jul 2002 10:45:21 GMT
Path: sbrodie.cam.pace.co.uk%sbrodie
Date: Mon, 22 Jul 2002 11:40:50 +0100
From: Stewart Brodie <stewart.brodie@pace.co.uk>
Message-ID: <de61fd594b.sbrodie@sbrodie.cam.pace.co.uk>
Organization: Pace Micro Technology plc
User-Agent: Messenger-Pro/2.59beta2 (Newsbase/0.61b) (RISC-OS/4.00-Ursula002f)
To: linux-mips@oss.sgi.com
Subject: JFFS2 not compressing things in 2.4.17 kernels?
X-Editor: Zap, using ZapEmail 0.22 (27 Nov 1998) patch-3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Posting-Agent: RISC OS Newsbase 0.61b
X-Spam-Status: No, hits=-0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have been having problems with mkfs.jffs2 (with the fs/jffs2 files from a
2.4.17 kernel) not compressing files as it constructs the filesystem image. 
I have no idea whether this will affect the run-time behaviour or not - I've
not got that far.  After inserting debugging into the compression routines,
it appears that streaming errors are occurring when the data is being passed
through zlib, and thus the simple rtime compression is being used instead.

It looks like mkfs.jffs2 is driving zlib's compression routines in a bizarre
way (c.f. the decompression which uses a trivial loop) passing only small
blocks of data at a time.  Is that loop correct?  Why is Z_PARTIAL_FLUSH
being used?  The errors I get are all "final deflate returned -2".

Any ideas?

-- 
Stewart Brodie, Senior Software Engineer
Pace Micro Technology PLC
645 Newmarket Road
Cambridge, CB5 8PB, United Kingdom         WWW: http://www.pacemicro.com/
