Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA98027 for <linux-archive@neteng.engr.sgi.com>; Sun, 21 Jun 1998 09:01:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA72547
	for linux-list;
	Sun, 21 Jun 1998 09:01:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA94540
	for <linux@engr.sgi.com>;
	Sun, 21 Jun 1998 09:01:02 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id JAA11240
	for <linux@engr.sgi.com>; Sun, 21 Jun 1998 09:01:01 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id SAA08073
	for <linux@engr.sgi.com>; Sun, 21 Jun 1998 18:00:59 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id SAA16460; Sun, 21 Jun 1998 18:00:57 +0200
Message-ID: <19980621180056.41345@uni-koblenz.de>
Date: Sun, 21 Jun 1998 18:00:56 +0200
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com
Subject: Joe
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've fixed the editor Joe.  The problem was that it was written using
assumptions about what exactly is contained in struct sigaction.
Obviously everybody, even on Intel machines, ignored the warnings caused
by this.

  Ralf
