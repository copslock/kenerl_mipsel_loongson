Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA77402 for <linux-archive@neteng.engr.sgi.com>; Tue, 27 Oct 1998 07:36:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA11428
	for linux-list;
	Tue, 27 Oct 1998 07:36:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA09032
	for <linux@engr.sgi.com>;
	Tue, 27 Oct 1998 07:36:15 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA09621
	for <linux@engr.sgi.com>; Tue, 27 Oct 1998 07:36:08 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-15.uni-koblenz.de [141.26.249.15])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id QAA17838
	for <linux@engr.sgi.com>; Tue, 27 Oct 1998 16:36:05 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id FAA07450;
	Tue, 27 Oct 1998 05:57:31 +0100
Message-ID: <19981027055731.I5892@uni-koblenz.de>
Date: Tue, 27 Oct 1998 05:57:31 +0100
From: ralf@uni-koblenz.de
To: Mitchell Blank Jr <mitch@execpc.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: R5000 Unused memory (was: R4000SC...)
References: <19981017104618.A3076@zigzegv.ml.org> <19981018111145.J4768@uni-koblenz.de> <19981019111501.A16024@zigzegv.ml.org> <1998102010305 <19981020103052.G676@uni-koblenz.de> <19981021134544.A30452@zigzegv.ml.org> <19981021233814.A3030@alpha.franken.de> <19981022090933.A879@bun.falkenberg.se> <362F69B5.AB94E713@xmission.com> <19981022194442.27891@execpc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19981022194442.27891@execpc.com>; from Mitchell Blank Jr on Thu, Oct 22, 1998 at 07:44:42PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Oct 22, 1998 at 07:44:42PM -0500, Mitchell Blank Jr wrote:

> Eric Jorgensen wrote:
> > 	Yes and no. Personally I find the concept of running a modern system
> > without available swap somewhat perilous.
> 
> What about if you don't have any disk nor any rw filesystems?  Not unusual
> in imbedded applications.  The only way to get around it now apparently is
> to set up a ram disk and swap to that -- hardly effecient or useful
> (except in the case where some RAM is slower).
> 
> A typical UNIX workstation or server should always have swap -- there are
> always some gettys or something that might as well be swapped out to make
> room for more disk cache.  There are applications, however, where swap
> is just not an option.

Linux cannot swap to NFS, so that behaviour in absence is pretty much a
showstopper for diskless apps.

  Ralf
