Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA715776 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 May 1998 02:59:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA28725
	for linux-list;
	Mon, 18 May 1998 02:57:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA37377
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 May 1998 02:57:38 -0700 (PDT)
	mail_from (grimsy@zigzegv.ml.org)
Received: from ballyhoo.ml.org ([194.236.80.80]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id CAA15905
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 May 1998 02:57:36 -0700 (PDT)
	mail_from (grimsy@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.148.89]) by ballyhoo.ml.org
	 with smtp (ident grimsy using rfc1413) id m0ybLeg-000xjWC
	(Debian Smail-3.2 1996-Jul-4 #2); Mon, 18 May 1998 10:52:22 +0200 (CEST)
Date: Mon, 18 May 1998 11:54:34 +0200 (CEST)
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
X-Sender: grimsy@calypso.saturn
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: VCE exception
In-Reply-To: <Pine.LNX.3.96.980517122752.16103B-100000@web.aec.at>
Message-ID: <Pine.LNX.3.96.980518114812.5194B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I know that this bug is reported, but it's quite annoying (it makes my
Indy R4000 useless).

I'm now trying to boot 2.1.99.

...
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernes memory: 32k freed
Warning: unable to open an initial console.
Got vced at 88018c54.
Kernel panic: Caught VCE exception - should not happen

*sigh*

- Ulf
