Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA31248
	for <pstadt@stud.fh-heilbronn.de>; Mon, 2 Aug 1999 23:55:18 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA07407; Mon, 2 Aug 1999 14:52:02 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA92253
	for linux-list;
	Mon, 2 Aug 1999 14:50:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA03439
	for <linux@engr.sgi.com>;
	Mon, 2 Aug 1999 14:50:28 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03545
	for <linux@engr.sgi.com>; Mon, 2 Aug 1999 14:50:26 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA08871
	for <linux@engr.sgi.com>; Mon, 2 Aug 1999 23:50:17 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id TAA28990;
	Mon, 2 Aug 1999 19:59:32 +0200
Date: Mon, 2 Aug 1999 19:59:31 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: binutils@sourceware.cygnus.com
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: MIPS gas bug & fix
Message-ID: <19990802195931.A28984@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

the cvs version of gas has a tiny typo which prevents it from swapping
an instruction preceeding a jump or branch in most cases.  The fix is
trivial and appended below.

  Ralf

--- tc-mips.c.orig	Mon Aug  2 10:47:15 1999
+++ tc-mips.c	Mon Aug  2 10:47:04 1999
@@ -2099,7 +2099,7 @@
 	      || (mips_opts.mips16 && prev_insn_fixp)
 	      /* If the previous instruction is a sync, sync.l, or 
 		 sync.p, we can not swap. */
-	      || (prev_pinfo && INSN_SYNC))
+	      || (prev_pinfo & INSN_SYNC))
 	    {
 	      /* We could do even better for unconditional branches to
 		 portions of this object file; we could pick up the
