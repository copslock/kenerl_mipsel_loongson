Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA20186 for <linux-archive@neteng.engr.sgi.com>; Fri, 11 Jun 1999 11:33:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA39858
	for linux-list;
	Fri, 11 Jun 1999 11:31:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA68176;
	Fri, 11 Jun 1999 11:31:26 -0700 (PDT)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id LAA05198; Fri, 11 Jun 1999 11:31:26 -0700 (PDT)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199906111831.LAA05198@anchor.engr.sgi.com>
Subject: Re: Belated Feedback:  HAL2
In-Reply-To: <19990611202821.C22699@thepuffingroup.com> from Ulf Carlsson at "Jun 11, 99 08:28:21 pm"
To: ulfc@thepuffingroup.com (Ulf Carlsson)
Date: Fri, 11 Jun 1999 11:31:26 -0700 (PDT)
Cc: mikehill@hgeng.com, linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson wrote: 
|  We beat IRIX, that sound great to me ;-)

The singlespeed cdrom drive was very touchy; it was the first generation
drive to support audio data over scsi.  It's unlikely to be a RAM limitation,
but who knows, at this point...

|  I'm interested in how this CD playback works. Does it read raw data from the CD
|  drive and just play it on the HAL2 or are there some other and smarter ways of

It reads the audio data over scsi, converts it if needed, and sends it
through the audio system.


Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
