Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA22699 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Oct 1998 11:29:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA03111
	for linux-list;
	Mon, 12 Oct 1998 11:28:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA20932;
	Mon, 12 Oct 1998 11:28:33 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA07525; Mon, 12 Oct 1998 11:28:27 -0700
Date: Mon, 12 Oct 1998 11:28:27 -0700
Message-Id: <199810121828.LAA07525@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "Fernando D. Mato Mira" <matomira@acm.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: I am interested in helping port to Indigo
In-Reply-To: <199810121822.UAA15293@link.csem.ch>
References: <199810121822.UAA15293@link.csem.ch>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Fernando D. Mato Mira writes:
 > Hello,
 > 
 > What would one need to do to port what is running of SGI/Linux to 
 > Indigo R4400 150MHz Elan?

     By "Indigo R4400", I assume you mean "Indigo2 R4400".  As far as
I know, we only supported the R4000 in the "Indigo R4000".  The 
kernel should be mostly compatible, aside from some details about
clocks, the addition of the EISA bus, and the absence of the video
port.  The big issue is the graphics.  Elan has downloaded microcode,
although you might make do with what is downloaded by the PROM.
Unfortunately, I cannot at present supply documentation for the
interface exported by that microcode (partly because I don't have
any ready to hand).  
