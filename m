Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA94279 for <linux-archive@neteng.engr.sgi.com>; Thu, 10 Dec 1998 07:41:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA92565
	for linux-list;
	Thu, 10 Dec 1998 07:40:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA42864
	for <linux@engr.sgi.com>;
	Thu, 10 Dec 1998 07:40:48 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA00789
	for <linux@engr.sgi.com>; Thu, 10 Dec 1998 07:38:59 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.65.127])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with SMTP id QAA05751;
	Thu, 10 Dec 1998 16:36:49 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id QAA04620; Thu, 10 Dec 1998 16:36:47 +0100
Message-ID: <19981210163646.60106@uni-koblenz.de>
Date: Thu, 10 Dec 1998 16:36:46 +0100
To: "Andrew R. Baker" <andrewb@uab.edu>
Cc: linux-smp@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: Linux on an SGI Challenge L
References: <Pine.LNX.3.96.981209154550.5530A-100000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.96.981209154550.5530A-100000@mdk187.tucc.uab.edu>; from Andrew R. Baker on Wed, Dec 09, 1998 at 03:47:19PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Dec 09, 1998 at 03:47:19PM -0600, Andrew R. Baker wrote:

> Anyone care to make any comments on porting Linux to an SGI Challenge L
> machine w/ (4) R4400 processors?  Am I crazy to even attempt this?

You're not crazy, after all Linux is already running on bigger iron and
about to run on Sun's E10000.  However you should checkout again what
hardware you actually have on your system.  A Challenge L is mostly like
an Indy (which is supported), that is strictly uniprocessor.  So
your system either is not a multiprocessor system or not a Challenge L.

  Ralf
