Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA18039 for <linux-archive@neteng.engr.sgi.com>; Tue, 19 Jan 1999 02:14:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA14868
	for linux-list;
	Tue, 19 Jan 1999 02:13:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA50108
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 19 Jan 1999 02:13:47 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ip39.cb.resolution.de [195.30.142.39]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA02106
	for <linux@cthulhu.engr.sgi.com>; Tue, 19 Jan 1999 02:13:45 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id LAA08318;
	Tue, 19 Jan 1999 11:14:00 +0100
Message-ID: <19990119111357.D454@uni-koblenz.de>
Date: Tue, 19 Jan 1999 11:13:57 +0100
From: ralf@uni-koblenz.de
To: Mike Shaver <shaver@netscape.com>,
        "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: indigo2 extreme
References: <36A4120E.2FF847E0@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36A4120E.2FF847E0@netscape.com>; from Mike Shaver on Tue, Jan 19, 1999 at 12:03:10AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 19, 1999 at 12:03:10AM -0500, Mike Shaver wrote:

> So I've got a decent deal on an indigo2[*] with the extreme kit lined
> up, and I'm wondering how much I'll regret it if I go ahead and purchase
> it.  Will I live to see it run Linux?  Will I be able to use the x86
> EISA code to get started?

Bill Earles already answered the rest of the question.  As far as EISA
goes I cannot imagine that there will be serious problems, EISA support
for other machines was pretty much straight forward.

The unfun part of dealing with (E)ISA cards in such an environment will be
to fix byteorder problems and the cache coherence in all DMA drivers.  The
really unfun part will be to deal with boards which need to be initialized
by the BIOS or needs BIOS access otherwise.

  Ralf
