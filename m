Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA45498 for <linux-archive@neteng.engr.sgi.com>; Sat, 6 Mar 1999 15:12:00 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA10328
	for linux-list;
	Sat, 6 Mar 1999 15:11:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA96340
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 6 Mar 1999 15:11:15 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01210
	for <linux@cthulhu.engr.sgi.com>; Sat, 6 Mar 1999 15:11:02 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-28.uni-koblenz.de [141.26.131.28])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA07899
	for <linux@cthulhu.engr.sgi.com>; Sun, 7 Mar 1999 00:10:43 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA13586;
	Sun, 7 Mar 1999 00:06:42 +0100
Message-ID: <19990307000640.B10228@uni-koblenz.de>
Date: Sun, 7 Mar 1999 00:06:40 +0100
From: ralf@uni-koblenz.de
To: Chad Carlin <chad@dallas.sgi.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Re: 2.2.1 MIPS kernel sources plus Indy kernel binaries uploaded
References: <19990227001617.A4022@alpha.franken.de> <36E0785D.1758693B@dallas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36E0785D.1758693B@dallas.sgi.com>; from Chad Carlin on Fri, Mar 05, 1999 at 06:35:41PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Mar 05, 1999 at 06:35:41PM -0600, Chad Carlin wrote:

> Anyone else have trouble with these on an R4400? I tried a couple times. Both
> stopped the boot process a the "freeing unused memory" part. Sorry there was no

It seems one of the ``high priests'' will need get access to one of these
machine in order to debug the problem.

Did you try the usual hot keys to get a register dump?  If that still works,
what is the epc value, is the machine looping?

  Ralf
