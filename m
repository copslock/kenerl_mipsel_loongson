Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA61462 for <linux-archive@neteng.engr.sgi.com>; Wed, 9 Sep 1998 06:34:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA20998
	for linux-list;
	Wed, 9 Sep 1998 06:34:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA60330
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 9 Sep 1998 06:34:12 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA07786
	for <linux@cthulhu.engr.sgi.com>; Wed, 9 Sep 1998 06:34:09 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id PAA10924
	for <linux@cthulhu.engr.sgi.com>; Wed, 9 Sep 1998 15:34:05 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id OAA01546;
	Wed, 9 Sep 1998 14:42:41 +0200
Message-ID: <19980909144240.E1340@uni-koblenz.de>
Date: Wed, 9 Sep 1998 14:42:40 +0200
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
References: <19980902000840.C370@uni-koblenz.de> <Pine.LNX.3.96.980902174807.334B-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980902174807.334B-100000@calypso.saturn>; from Ulf Carlsson on Wed, Sep 02, 1998 at 05:58:15PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Sep 02, 1998 at 05:58:15PM +0200, Ulf Carlsson wrote:

> On Wed, 2 Sep 1998 ralf@uni-koblenz.de wrote:
> 
> > As I recently told you on IRC - the patch as you've posted it is not
> > correct.  It will misstreat VCEI exceptions.
> 
> My idea is based on that we write the wrong cache line back, and that's
> why we receive the invalid instruction errors. 
> 
> Maybe this is foolish, but anyway: If we have data from main memory cached
> in the secondary cache and then overwrite that data line in main memory
> with an instruction line and cache the instruction. We receive a VCEI when
> we try to access the cached line, and our handler writes the data back
> instead of the intstruction and causes the invalid instructions. Well,
> this is the only idea I have at the moment.

Note that we don't have to care about if the line contains data or
instructions.  All we know is that the l2 line corrosponding to the
instruction which threw the vcei exception is in some state other than
invalid.  We cannot accidently writeback an instruction line to memory
because the Hit_Writeback_Inv_SD cacheop we're using will only write
dirty lines back.

  Ralf
