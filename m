Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA255541 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 May 1998 12:38:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA16498146
	for linux-list;
	Thu, 7 May 1998 12:38:05 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA21159678
	for <linux@engr.sgi.com>;
	Thu, 7 May 1998 12:38:03 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA18663
	for <linux@engr.sgi.com>; Thu, 7 May 1998 12:37:59 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA07171
	for <linux@engr.sgi.com>; Thu, 7 May 1998 21:37:50 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id OAA05642;
	Thu, 7 May 1998 14:08:21 +0200
Message-ID: <19980507140821.18614@uni-koblenz.de>
Date: Thu, 7 May 1998 14:08:21 +0200
To: linux@cthulhu.engr.sgi.com
Subject: rpm builders, README
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I fixed a long standing bug in the ELF loader which was crashing certain
types of executables.  Ldd is one of them.  This causes binary rpm
packages to be built without library dependencies.  If you've published
binary rpms, please rebuild them running 2.1.99.

  Ralf
