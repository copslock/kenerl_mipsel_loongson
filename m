Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA19249 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Sep 1998 14:31:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA98130
	for linux-list;
	Wed, 23 Sep 1998 14:30:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA76689
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Sep 1998 14:30:26 -0700 (PDT)
	mail_from (richardm@bif.cd.com)
Received: from beltway.cd.com (beltway.cd.com [204.217.30.66]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00416
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Sep 1998 14:30:24 -0700 (PDT)
	mail_from (richardm@bif.cd.com)
Received: from bif.cd.com (bif [204.217.30.130])
	by beltway.cd.com (8.9.1a/8.9.1) with SMTP id QAA24355
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Sep 1998 16:29:50 -0500 (CDT)
Received: by bif.cd.com (SMI-8.6/SMI-SVR4)
	id QAA28013; Wed, 23 Sep 1998 16:30:21 -0500
From: richardm@bif.cd.com (Richard Masoner)
Message-Id: <199809232130.QAA28013@bif.cd.com>
Subject: Re: challenge s boots linux
To: linux@cthulhu.engr.sgi.com
Date: Wed, 23 Sep 1998 16:30:21 -0500 (CDT)
In-Reply-To: <19980923212241.01963@alpha.franken.de> from "Thomas Bogendoerfer" at Sep 23, 98 09:22:41 pm
Reply-To: <richardm@cd.com>
Organization: Digi International
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > 	First, I wonder how much of the kernel will actually work on the
> > Challenge S; I'm told there are SCSI controller differences.
> 
> looking linus.linux.sgi.com, which is AFAIK a Challenge S, it seems the
> Challenge has a wd33c93 and a wd33c95.

Correct.  Challenge S has the same wd33c93 SCSI chip on it that the
Indy has.  Additionally, it has the wd33c95 chip for more SCSI buses
in place of of video and audio that's on the Indy.

--
Richard F. Masoner                         Digi International
richardm@cd.com                             1602 Newton Drive
http://www.cd.com/                    Champaign, IL 61822 USA 
