Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA11955 for <linux-archive@neteng.engr.sgi.com>; Sat, 26 Sep 1998 20:18:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA22290
	for linux-list;
	Sat, 26 Sep 1998 20:17:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA68683
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 26 Sep 1998 20:17:39 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA06924
	for <linux@cthulhu.engr.sgi.com>; Sat, 26 Sep 1998 20:17:37 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-13.uni-koblenz.de [141.26.249.13])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id FAA17255
	for <linux@cthulhu.engr.sgi.com>; Sun, 27 Sep 1998 05:17:41 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id FAA00669;
	Sun, 27 Sep 1998 05:17:19 +0200
Message-ID: <19980927051719.A396@uni-koblenz.de>
Date: Sun, 27 Sep 1998 05:17:19 +0200
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grim@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: indy_sc.c
References: <Pine.LNX.3.96.980927002010.2914A-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980927002010.2914A-100000@calypso.saturn>; from Ulf Carlsson on Sun, Sep 27, 1998 at 12:24:14AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Sep 27, 1998 at 12:24:14AM +0200, Ulf Carlsson wrote:

> Why aren't we using the code in linux/arch/mips/mm/kernel/indy_sc.c?

We are, but only on IP22 with R4600SC and R5000 cache modules.  Other
second level caches are not supported by this code.

  Ralf
