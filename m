Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA41617 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Jun 1999 15:34:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA04313
	for linux-list;
	Thu, 24 Jun 1999 15:33:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA96812
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Jun 1999 15:33:36 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08432
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Jun 1999 15:33:33 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-16.uni-koblenz.de [141.26.131.16])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA26984
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jun 1999 00:33:30 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA02961;
	Fri, 25 Jun 1999 00:33:10 +0200
Date: Fri, 25 Jun 1999 00:33:10 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andrew Linfoot <andy@derfel99.freeserve.co.uk>
Cc: linux <linux@cthulhu.engr.sgi.com>
Subject: Re: xcompiler setup for IRIX 6.5.x
Message-ID: <19990625003310.F17220@uni-koblenz.de>
References: <000701bebb31$f2e8d790$0a02030a@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <000701bebb31$f2e8d790$0a02030a@snafu>; from Andrew Linfoot on Sun, Jun 20, 1999 at 04:31:18PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jun 20, 1999 at 04:31:18PM +0100, Andrew Linfoot wrote:

> I have an Indy running IRIX 6.5.3 can anyone tell me what i need to set this
> up for xcompiling using gcc or ecgs?

See the FAQ on http://www.linux.sgi.com/.

> What IRIX libraries etc do i need, I don't have access to a licence for the
> sgi compiler so i must use gcc/egcs.

Doesn't matter which compiler you use to build the crosscompiler.

  Ralf
