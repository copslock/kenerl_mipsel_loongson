Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA17809 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Feb 1999 19:22:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA91191
	for linux-list;
	Thu, 4 Feb 1999 18:48:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA48037
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 4 Feb 1999 18:48:26 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ip39.cb.resolution.de [195.30.142.39]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02728
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Feb 1999 18:48:23 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id DAA01442;
	Fri, 5 Feb 1999 03:48:22 +0100
Message-ID: <19990205034821.A620@uni-koblenz.de>
Date: Fri, 5 Feb 1999 03:48:21 +0100
From: ralf@uni-koblenz.de
To: Alexander Graefe <nachtfalke@usa.net>, linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <19990202155147.A1565@ganymede> <19990203043951.D3920@uni-koblenz.de> <19990204154637.B5941@ganymede>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990204154637.B5941@ganymede>; from Alexander Graefe on Thu, Feb 04, 1999 at 03:46:37PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Feb 04, 1999 at 03:46:37PM +0100, Alexander Graefe wrote:

> On Wed, Feb 03, 1999 at 04:39:51AM +0100, ralf@uni-koblenz.de wrote:
> 
> >  - the exact screen output.  Especially the register dump following the
> >    Aiee message is important.
> 
> kernel 2.1.100 (the one from the HardHat.tgz)

2.1.100 is known to fail on R4400.  This is supposed to be fixed in .131
which is why I'm worried about the other bug report.  Your case is obvious -
use a newer kernel.

  Ralf
