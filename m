Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA45261 for <linux-archive@neteng.engr.sgi.com>; Wed, 4 Nov 1998 18:15:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA62881
	for linux-list;
	Wed, 4 Nov 1998 18:14:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA72979;
	Wed, 4 Nov 1998 18:14:47 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA05979; Wed, 4 Nov 1998 18:14:45 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA26118;
	Thu, 5 Nov 1998 03:14:30 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id DAA02726;
	Thu, 5 Nov 1998 03:13:25 +0100
Message-ID: <19981105031325.P359@uni-koblenz.de>
Date: Thu, 5 Nov 1998 03:13:25 +0100
From: ralf@uni-koblenz.de
To: Ariel Faigon <ariel@oz.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Linus is down ? (fwd)
References: <199810310228.SAA34114@oz.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199810310228.SAA34114@oz.engr.sgi.com>; from Ariel Faigon on Fri, Oct 30, 1998 at 06:28:50PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Oct 30, 1998 at 06:28:50PM -0800, Ariel Faigon wrote:

> linus had many memory parity errors (most fixed by the CPU, but
> one eventually failed) this afternoon which caused it to hang.
> David rebooted it and will be replacing the bad SIMM early next week.

Which reminds me that we don't handle cache errors and other desaster
events at all.

  Ralf
