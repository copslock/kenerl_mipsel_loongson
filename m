Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA41382 for <linux-archive@neteng.engr.sgi.com>; Tue, 15 Sep 1998 15:28:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA92915
	for linux-list;
	Tue, 15 Sep 1998 15:27:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA01261
	for <linux@engr.sgi.com>;
	Tue, 15 Sep 1998 15:27:56 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07105
	for <linux@engr.sgi.com>; Tue, 15 Sep 1998 15:27:42 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-06.uni-koblenz.de [141.26.249.6])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA20019
	for <linux@engr.sgi.com>; Wed, 16 Sep 1998 00:27:32 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA00454;
	Wed, 16 Sep 1998 00:16:25 +0200
Message-ID: <19980916001625.F32589@uni-koblenz.de>
Date: Wed, 16 Sep 1998 00:16:25 +0200
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: MIPS HOWTO / FAQ
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

since nobody else does (hint, hint ...) I started to rework the MIPS FAQ.
Attached the first very incomplete version.  As of this version the
FAQ is now written using the Linux SGML tools.  I append a text version
generated with sgml2txt.  Comments, additional text etc. apreciated.
I'm especially thinking of the DECstation people but not only.

Special feature: the topic ``How to brew a cross compiler'' now has it's
own uptodate and about 5 printed pages long section describing how to
roll a crosscompiler based on the newest stuff.  The topic has actually
also been interesting for other people as many postings in the past
have shown.  Maybe the crosscompiler part is actually worth it's own,
separate HOWTO document?

  Ralf
