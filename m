Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA62564 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Dec 1998 08:22:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA03999
	for linux-list;
	Fri, 25 Dec 1998 08:21:20 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA44493;
	Fri, 25 Dec 1998 08:21:15 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA02148; Fri, 25 Dec 1998 08:21:09 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-28.uni-koblenz.de [141.26.249.28])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id RAA06952;
	Fri, 25 Dec 1998 17:20:51 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id TAA00696;
	Thu, 24 Dec 1998 19:05:46 +0100
Message-ID: <19981224190545.A648@uni-koblenz.de>
Date: Thu, 24 Dec 1998 19:05:45 +0100
From: ralf@uni-koblenz.de
To: Greg Chesson <greg@xtp.engr.sgi.com>,
        Alex deVries <adevries@engsoc.carleton.ca>
Cc: Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        Fredrik Rovik <fredrov@hotmail.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Status
References: <Pine.LNX.3.96.981222224859.1946C-100000@lager.engsoc.carleton.ca> <adevries@engsoc.carleton.ca> <9812230951.ZM5336@xtp.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <9812230951.ZM5336@xtp.engr.sgi.com>; from Greg Chesson on Wed, Dec 23, 1998 at 09:51:36AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Dec 23, 1998 at 09:51:36AM -0800, Greg Chesson wrote:

> Indy, I2, and Challenge-S are all related.
> Challenge-S is an Indy (small blue box) with the media stuff removed,
> with basically the same motherboard.  I don't know for sure whether
> it has the extra SCSI channel like the I2.  The I2 is a different
> motherboard in a larger (than Indy) box.  Core chipsets are the same.
> 
> What we need to do is make it easy for Linux to determine what
> chipsets are attached to the cpu.  Bill Earl might have some straightforward
> answers.  I'm in favor of simply publishing the relevant sections
> of Irix bootstrap code.  Perhaps Santa Claus can make a code drop this year.

Isn't that ``Full House'' vs. ``Guiness''?  Linux knows that difference since
it is running on the Indy.

  Ralf
