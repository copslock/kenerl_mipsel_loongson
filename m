Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA19764 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Oct 1998 11:48:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA55989
	for linux-list;
	Mon, 12 Oct 1998 11:47:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA57032;
	Mon, 12 Oct 1998 11:47:27 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA07567; Mon, 12 Oct 1998 11:47:16 -0700
Date: Mon, 12 Oct 1998 11:47:16 -0700
Message-Id: <199810121847.LAA07567@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: "Fernando D. Mato Mira" <matomira@acm.org>, linux@cthulhu.engr.sgi.com
Subject: Re: I am interested in helping port to Indigo
In-Reply-To: <36224728.2D7735F2@engsoc.carleton.ca>
References: <199810121822.UAA15293@link.csem.ch>
	<36224728.2D7735F2@engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > Fernando D. Mato Mira wrote:
 > 
 > > Hello,
 > >
 > > What would one need to do to port what is running of SGI/Linux to
 > > Indigo R4400 150MHz Elan?
 > 
 > One would need to write device drivers for:
 > - SCSI
 > - ethernet
 > - display or serial
 > 
 > I thought the indigo used either gio64 or gio32.  I might be wrong.

     The original Indigo (R3000-based) used a different chip set from
the Indigo R4000, Indy, and Indigo2, which shared a common memory controller.
The latter machines use vary a bit in the details of their peripheral
chips, the parts are mostly either the same or different mainly in being
later revisions in some of the systems.  The Indigo2 added EISA bus support
(along with GIO). 
