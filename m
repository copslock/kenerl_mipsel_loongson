Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA61353 for <linux-archive@neteng.engr.sgi.com>; Tue, 1 Sep 1998 12:18:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA93691
	for linux-list;
	Tue, 1 Sep 1998 12:18:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA27887
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 1 Sep 1998 12:18:10 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA22374
	for <linux@cthulhu.engr.sgi.com>; Tue, 1 Sep 1998 12:18:10 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA29632;
	Tue, 1 Sep 1998 15:19:32 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 1 Sep 1998 15:19:31 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Carlsson <grim@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
In-Reply-To: <19980901165505.A456@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980901151853.28077F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 1 Sep 1998 ralf@uni-koblenz.de wrote:
> The problems seems to be associated with either sync SCSI or disconnect/
> reconnect.  I did a two line modification to sgiwd93.c which disables
> sync and disconnect/reconnect.  I now have since about a hour running:

Could you upload those patches to the cvs?

- Alex
