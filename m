Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA3533142 for <linux-archive@neteng.engr.sgi.com>; Fri, 1 May 1998 12:38:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA18491859
	for linux-list;
	Fri, 1 May 1998 12:37:20 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA19162747;
	Fri, 1 May 1998 12:37:18 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA06563; Fri, 1 May 1998 12:37:16 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA30398;
	Fri, 1 May 1998 15:37:09 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 1 May 1998 15:37:09 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "William J. Earl" <wje@fir.engr.sgi.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Hanging.
In-Reply-To: <199805011929.MAA23116@fir.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.980501153605.22853E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 1 May 1998, William J. Earl wrote:
>      Is this an R4000?  If so, it might be the count/compare erratum, if
> the linux kernel does not have the workaround for it yet.  (I haven't
> checked the linux sources.)

This is an R4600.  How would I check if there were that patch applied?

- Alex
