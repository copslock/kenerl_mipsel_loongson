Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA47410 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Feb 1999 21:02:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA14279
	for linux-list;
	Thu, 4 Feb 1999 21:01:45 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA72690
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 4 Feb 1999 21:01:43 -0800 (PST)
	mail_from (nachtfalke@usa.net)
Received: from mail.urz.uni-wuppertal.de (mail.urz.uni-wuppertal.de [132.195.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA07453
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Feb 1999 21:01:42 -0800 (PST)
	mail_from (nachtfalke@usa.net)
Received: from ganymede.priv (root@isdn70.dialin.uni-wuppertal.de [132.195.23.70])
	by mail.urz.uni-wuppertal.de (8.9.1a/8.9.1) with ESMTP id GAA26445235;
	Fri, 5 Feb 1999 06:01:20 +0100 (MET)
Received: (from nachtfalke@localhost)
	by ganymede.priv (8.8.8/8.8.8) id FAA00456;
	Fri, 5 Feb 1999 05:51:40 +0100
From: Alexander Graefe <nachtfalke@usa.net>
Date: Fri, 5 Feb 1999 05:51:40 +0100
To: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
Message-ID: <19990205055140.A383@ganymede>
References: <19990202155147.A1565@ganymede> <19990203043951.D3920@uni-koblenz.de> <19990204154637.B5941@ganymede> <19990205034821.A620@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95i
In-Reply-To: <19990205034821.A620@uni-koblenz.de>; from ralf@uni-koblenz.de on Fri, Feb 05, 1999 at 03:48:21AM +0100
X-Goddess: Willow
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Feb 05, 1999 at 03:48:21AM +0100, ralf@uni-koblenz.de wrote:

> 2.1.100 is known to fail on R4400.  This is supposed to be fixed in .131
> which is why I'm worried about the other bug report.  Your case is obvious -
> use a newer kernel.

I tried that, but .131 doesn't support nfs-root. It keeps failing to
mount the root device.
Can I bake my own kernel for the Indy on my PC with the right compiler
?

Bye,
	LeX

-- 
Quidquid latine dictum sit, altum viditur.
