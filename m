Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA17084 for <linux-archive@neteng.engr.sgi.com>; Fri, 11 Jun 1999 10:59:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA02631
	for linux-list;
	Fri, 11 Jun 1999 10:57:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA95999
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 11 Jun 1999 10:56:58 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup120-1-10.swipnet.se [130.244.120.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA01494
	for <linux@cthulhu.engr.sgi.com>; Fri, 11 Jun 1999 10:56:56 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10sW2P-003Ln2C; Fri, 11 Jun 1999 20:28:21 +0200 (CEST)
Date: Fri, 11 Jun 1999 20:28:21 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Mike Hill <mikehill@hgeng.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Belated Feedback:  HAL2
Message-ID: <19990611202821.C22699@thepuffingroup.com>
Mail-Followup-To: Mike Hill <mikehill@hgeng.com>,
	linux@cthulhu.engr.sgi.com
References: <E138DB347D10D3119C630008C79F5DEC07E9EB@BART>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <E138DB347D10D3119C630008C79F5DEC07E9EB@BART>; from Mike Hill on Fri, Jun 11, 1999 at 12:35:09PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike,

> This is only a month late, but the sound driver installation went without a
> hitch, precisely according to your instructions. I fired up the Indy last
> night using the latest sound kernel and played an .mp3 file using mpg123.

Better late than never. Great news!

> One thing I noticed was the absence of the occasional skips I've experienced
> in recent years playing CDs under IRIX 6.2.  I don't know if this can be
> attributed to a larger OS or my '94-vintage single-speed SGI-enabled CD
> drive, but it's not something I recall happening under IRIX 5.2.  (I guess
> 5.2 was less taxing on 32 M RAM.)

We beat IRIX, that sound great to me ;-)

I'm interested in how this CD playback works. Does it read raw data from the CD
drive and just play it on the HAL2 or are there some other and smarter ways of
doing it? I have a half-broken SCSI CD player here (which I'm currently only
using to raise my monitor some inches from the desk). Is it possible to read raw
data from an audio CD?

- Ulf
