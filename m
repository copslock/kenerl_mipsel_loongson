Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA56091 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 21:32:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA49783
	for linux-list;
	Tue, 26 Jan 1999 21:31:33 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA41844
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Jan 1999 21:31:31 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA09195
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Jan 1999 21:31:30 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA09071
	for <linux@cthulhu.engr.sgi.com>; Wed, 27 Jan 1999 00:33:06 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 27 Jan 1999 00:33:06 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: HAL code in the kernel...
In-Reply-To: <Pine.LNX.3.96.990127000802.20119E-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.96.990127003140.20119F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Wed, 27 Jan 1999, Alex deVries wrote:
> So far, the total output of the driver is:
> hal2: rev: 4010
> hal2: there was no device?
> sgiaudio: unable to find hal2 subsystem

Actually, that might be right; here's the hinv output of any Indy I've
ever recorded the hinv output of:
Iris Audio Processor: version A2 revision 4.1.0


I have these two for Indigo2's:
Iris Audio Processor: version A2 revision 0.1.0
Iris Audio Processor: version A2 revision 1.1.0

So Ulf might be closer than he realizes.

- Alex
