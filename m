Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA88326 for <linux-archive@neteng.engr.sgi.com>; Wed, 2 Sep 1998 08:58:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA87023
	for linux-list;
	Wed, 2 Sep 1998 08:58:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA74098
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Sep 1998 08:58:02 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from ballyhoo.ml.org ([194.236.80.80]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA10648
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Sep 1998 08:58:02 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.166.70]) by ballyhoo.ml.org
	 with smtp (ident grim using rfc1413) id m0zEFHY-000xgmC
	(Debian Smail-3.2.0.101 1997-Dec-17 #2); Wed, 2 Sep 1998 17:57:16 +0200 (CEST)
Date: Wed, 2 Sep 1998 17:58:15 +0200 (CEST)
From: Ulf Carlsson <grim@zigzegv.ml.org>
X-Sender: grim@calypso.saturn
Reply-To: Ulf Carlsson <grim@zigzegv.ml.org>
To: ralf@uni-koblenz.de
cc: linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
In-Reply-To: <19980902000840.C370@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980902174807.334B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 2 Sep 1998 ralf@uni-koblenz.de wrote:

> As I recently told you on IRC - the patch as you've posted it is not
> correct.  It will misstreat VCEI exceptions.

My idea is based on that we write the wrong cache line back, and that's
why we receive the invalid instruction errors. 

Maybe this is foolish, but anyway: If we have data from main memory cached
in the secondary cache and then overwrite that data line in main memory
with an instruction line and cache the instruction. We receive a VCEI when
we try to access the cached line, and our handler writes the data back
instead of the intstruction and causes the invalid instructions. Well,
this is the only idea I have at the moment.

- Ulf
