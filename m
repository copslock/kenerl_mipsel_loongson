Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA11533 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 May 1999 13:00:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA30377
	for linux-list;
	Thu, 27 May 1999 12:59:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA89429
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 May 1999 12:59:14 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02256
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 May 1999 12:59:12 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-24.uni-koblenz.de [141.26.131.24])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id VAA02016
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 May 1999 21:59:08 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id VAA04090;
	Thu, 27 May 1999 21:37:11 +0200
Date: Thu, 27 May 1999 21:37:11 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Pete Young <pete@alien.bt.co.uk>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: X server update, observations on a successful installation
Message-ID: <19990527213711.D4058@uni-koblenz.de>
References: <m10mxoK-001kwNC@mail.alien.bt.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <m10mxoK-001kwNC@mail.alien.bt.co.uk>; from Pete Young on Thu, May 27, 1999 at 11:55:32AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, May 27, 1999 at 11:55:32AM +0100, Pete Young wrote:

> Something I note is that two routes were set up to the local subnet:
> (at least according to the output of netstat -r)
> Apparently you no longer need to do this by hand with kernels version 2.2.*
> - this appears to happen in /etc/sysconfig/network-scripts/ifup .

This happens because we use an old version of net-tools in HardHat but
use a current kernel.  It's harmless however.  The solution is to
upgrade net-tools.

> Also, the default installation for portmap and ypbind starts them up in 
> the wrong order: I gather this is a standard RedHat error?

Yes, should be.

> Anyway, these are minor gripes not related to the HardHat distribution,
> and the box rocks. However, not having an X-server is a bit painful.
> I'm a bit confused about what is actually available: there seem to be
> lots of x applications, XFree86 and so on in the RPMS directory, so
> what's missing? A frame buffer?

The Indy hardware doesn't have a frame buffer which makes writing an
X server more difficult.  The X clients are working fine however.

  Ralf
