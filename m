Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA53203 for <linux-archive@neteng.engr.sgi.com>; Wed, 2 Sep 1998 07:30:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA37935
	for linux-list;
	Wed, 2 Sep 1998 07:30:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA16995
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Sep 1998 07:30:56 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-13.uni-koblenz.de [141.26.249.13]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA05619
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Sep 1998 07:30:03 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA00929;
	Tue, 1 Sep 1998 23:56:54 +0200
Message-ID: <19980901235654.B370@uni-koblenz.de>
Date: Tue, 1 Sep 1998 23:56:54 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Carlsson <grim@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
References: <19980901165505.A456@uni-koblenz.de> <Pine.LNX.3.96.980901151853.28077F-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980901151853.28077F-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Sep 01, 1998 at 03:19:31PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 01, 1998 at 03:19:31PM -0400, Alex deVries wrote:

> On Tue, 1 Sep 1998 ralf@uni-koblenz.de wrote:
> > The problems seems to be associated with either sync SCSI or disconnect/
> > reconnect.  I did a two line modification to sgiwd93.c which disables
> > sync and disconnect/reconnect.  I now have since about a hour running:
> 
> Could you upload those patches to the cvs?

Toxic waste like that hack doesn't belong into a CVS archive.

  Ralf
