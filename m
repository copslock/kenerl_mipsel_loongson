Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA35626 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Jun 1998 06:58:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA60068
	for linux-list;
	Thu, 18 Jun 1998 06:58:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA81569
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 Jun 1998 06:58:04 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id GAA24609
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 Jun 1998 06:58:01 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id GAA06347
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 Jun 1998 06:58:00 -0700 (PDT)
Received: from netscape.com ([205.217.243.67]) by dredd.mcom.com
          (Netscape Messaging Server 3.52)  with ESMTP id AAA1D23;
          Thu, 18 Jun 1998 06:57:59 -0700
Message-ID: <35891CC9.6027F477@netscape.com>
Date: Thu, 18 Jun 1998 09:57:29 -0400
From: Mike Shaver <shaver@netscape.com>
Organization: Mozilla Dot Weenies
X-Mailer: Mozilla 4.06 [en] (X11; I; Linux 2.0.34 i686)
MIME-Version: 1.0
To: ralf@uni-koblenz.de
CC: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Stuff that needs to be done.
References: <Pine.LNX.3.95.980617141204.8736C-100000@lager.engsoc.carleton.ca> <19980618041807.C517@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de wrote:
> > kaffe
> >      Architecture unsupported.
> 
> This is nontrivial, as Miguel explained to me this'd require writing
> a JIT.

Hrm.
http://www.kaffe.org lists MIPS as a supported processor type (OS
choices are IRIX 5, IRIX 6 and NetBSD), although it doesn't run with a
JIT (interpreter only).

Also, at the Expo DaveM said something about working on a JVM for the
Qube; perhaps that work would help us?

Mike

-- 
488733.52 411902.28
