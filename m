Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA51616 for <linux-archive@neteng.engr.sgi.com>; Tue, 20 Oct 1998 09:02:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA33359
	for linux-list;
	Tue, 20 Oct 1998 09:00:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA32935
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Oct 1998 09:00:48 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA07282
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Oct 1998 09:00:46 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-10.uni-koblenz.de [141.26.249.10])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id SAA15292
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Oct 1998 18:00:43 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id DAA01471;
	Tue, 20 Oct 1998 03:41:38 +0200
Message-ID: <19981020034138.E676@uni-koblenz.de>
Date: Tue, 20 Oct 1998 03:41:38 +0200
From: ralf@uni-koblenz.de
To: kyriazis@sgi.com, "Fernando D. Mato Mira" <matomira@acm.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: XZ
References: <199810190644.IAA17078@link.csem.ch> <199810191953.MAA90956@jibe.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199810191953.MAA90956@jibe.engr.sgi.com>; from George Kyriazis on Mon, Oct 19, 1998 at 12:53:40PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Oct 19, 1998 at 12:53:40PM -0700, George Kyriazis wrote:

> * The monitor PROM downloads a mini-microcode that could be used.  I am
>   not sure what the entry points look like to the PROM.  I think this
>   is the safest bet.

> * Documentation will be hard to find.  Documentation for programming the
>   microcoded engines, even harder.  You could, of course, use the existing
>   microcode.

For now that looks like the best strategy.  Anyway, as step one all we
want is text output.  This can be achived by using the ARC firmware.
That may be slow, but it's working and it gives us an instant driver for
any number of console devices people might have come up with in the past.
The Sparc guys, btw already have a prom console driver.

  Ralf
