Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA41093 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Jun 1999 15:31:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA63297
	for linux-list;
	Thu, 24 Jun 1999 15:29:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA15841
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Jun 1999 15:29:22 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00834
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Jun 1999 15:29:15 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-16.uni-koblenz.de [141.26.131.16])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA26778
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jun 1999 00:29:07 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA02912
	for linux@cthulhu.engr.sgi.com; Fri, 25 Jun 1999 00:28:54 +0200
Date: Fri, 25 Jun 1999 00:28:53 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com
Subject: Re: File corruption
Message-ID: <19990625002853.D17220@uni-koblenz.de>
References: <19990622032859.B6955@thepuffingroup.com> <19990622152145.A1059@uni-koblenz.de> <19990623014923.A8953@thepuffingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990623014923.A8953@thepuffingroup.com>; from Ulf Carlsson on Wed, Jun 23, 1999 at 01:49:23AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 23, 1999 at 01:49:23AM +0200, Ulf Carlsson wrote:

> > And under which kernel version did this start to happen?
> 
> 2.2.1 I think.

Are you shure?  The problem Alan is tracking started to hit from 2.2.7 on.
If 2.2.1 already starts making these kind of troubles then we probably
track two different problems.

> Unfortunately I don't have IRIX.  However, I have a 133 MHz R4600 CPU with 512 k
> board cache.  I have two 1 Gb SCSI driver connected.

Is this a low-mem configuration?  The problem Alan is tracking apparently
seems to hit low mem systems more often.

  Ralf
