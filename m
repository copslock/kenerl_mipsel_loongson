Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA63701 for <linux-archive@neteng.engr.sgi.com>; Wed, 26 Aug 1998 14:52:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA79415
	for linux-list;
	Wed, 26 Aug 1998 14:51:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA37307
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 26 Aug 1998 14:51:44 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA11734
	for <linux@cthulhu.engr.sgi.com>; Wed, 26 Aug 1998 14:51:14 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id XAA11236;
	Wed, 26 Aug 1998 23:51:13 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id XAA00611; Wed, 26 Aug 1998 23:51:09 +0200
Message-ID: <19980826235109.54755@uni-koblenz.de>
Date: Wed, 26 Aug 1998 23:51:09 +0200
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Hangs
References: <m0zBN6M-0009AHC@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <m0zBN6M-0009AHC@calypso.saturn>; from Ulf Carlsson on Tue, Aug 25, 1998 at 07:41:49PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Aug 25, 1998 at 07:41:49PM +0200, Ulf Carlsson wrote:

> What a pleasure to write the first report of 2.1.116 :)
> Here are the two last lines of the boot sequence:
> 
> IP Protocols: ICMP, UDP, TCP

Seen that hang, no idea what's the problem.  It was not repeatable for me.
117 has another hanger while booting and that one is repeatable.

  Ralf
