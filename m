Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA70865 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Oct 1998 15:36:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA64768
	for linux-list;
	Tue, 13 Oct 1998 15:36:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA92051
	for <linux@engr.sgi.com>;
	Tue, 13 Oct 1998 15:36:07 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02467
	for <linux@engr.sgi.com>; Tue, 13 Oct 1998 15:32:39 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA16143
	for <linux@engr.sgi.com>; Wed, 14 Oct 1998 00:32:33 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id WAA02702;
	Tue, 13 Oct 1998 22:00:43 +0200
Message-ID: <19981013220043.A2620@uni-koblenz.de>
Date: Tue, 13 Oct 1998 22:00:43 +0200
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: R4000SC ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

accepting the danger that I'm going to frustrate someone on this list -
I managed to get the R4000SC V3.0 going under Linux in less than two hours.
I'm now typing this email logged on from my Indy running from local disk
to another Linux machine.  The worst part was actually to get rid of all
the MIPS IV code on my machine before I could do anything useful again with
a MIPS III CPU.

The patch which I'm going to commit will actually be quite a bit larger
than the fixes for the SC actually needed to be because large parts of
the support for the SC CPU were overly complex, better-than-nothing
implementations or supporting CPU configurations that aren't possible
at all.  Benefit of all this for everybody is 10kb less kernel code.

Time to fix the "CPU too expensive" panic ;-)

  Ralf
