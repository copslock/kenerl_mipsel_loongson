Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA715869 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 May 1998 04:37:12 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA51134
	for linux-list;
	Mon, 18 May 1998 04:36:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA58104
	for <linux@engr.sgi.com>;
	Mon, 18 May 1998 04:36:15 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id EAA05848
	for <linux@engr.sgi.com>; Mon, 18 May 1998 04:36:05 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id NAA02326;
	Mon, 18 May 1998 13:35:54 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id NAA27974; Mon, 18 May 1998 13:35:53 +0200
Message-ID: <19980518133553.34099@uni-koblenz.de>
Date: Mon, 18 May 1998 13:35:53 +0200
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr
Subject: VCE question
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I don't have a machine with a SC CPU, so I hopbe somebody of you can
help me -- the manuals of the R4000 / R4400 documents that the L2 cache
is tagged with bits 12-14 of the virtual address.  This is somewhat
strange because only cache-size / 4kb bits are required to avoid virtual
aliases.  That would be 1 bit for the R4000SC and 2 bits for the R4400SC.

Question: will the R4000SC/R4400SC actually verify 3 bits or only the
one rsp. two bits which need to be checked?

  Ralf
