Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA01698 for <linux-archive@neteng.engr.sgi.com>; Tue, 19 Jan 1999 19:35:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA13915
	for linux-list;
	Tue, 19 Jan 1999 19:34:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id TAA15446
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 19 Jan 1999 19:34:25 -0800 (PST)
	mail_from (chad@sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	 id VAA02148; Tue, 19 Jan 1999 21:32:44 -0600
Received: from localhost (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id TAA07206; Tue, 19 Jan 1999 19:32:43 -0800 (PST)
Date: Tue, 19 Jan 1999 21:32:43 -0600 (CST)
From: Chad Carlin <chad@sgi.com>
X-Sender: chad@roctane.dallas.sgi.com
To: job bogan <job@piquin.uchicago.edu>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: [Fwd: linus.linux.sgi.com] 
In-Reply-To: <199901200204.UAA14601@piquin.uchicago.edu>
Message-ID: <Pine.SGI.3.94.990119201144.7100B-101000@roctane.dallas.sgi.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1443998914-1763575553-916803163=:7100"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1443998914-1763575553-916803163=:7100
Content-Type: TEXT/PLAIN; charset=US-ASCII

->Lots of PCs use 10ns SDRAM and 6ns SDRAM all of the time.  And there is
A->plenty of memory saturation happening on those systems.  Trust me.  We
->do it all the time w/ scientific matrix code.

I appologize for the way I came accross. I meant no offense. Nor did I mean to suggest that your applications were unable to tax the memory subsystem of a variety of manufacturers PCs. To be candid, I have spent very little time with specs for PC memory. 
I also believed that I said "mainstream" not record setting.

->pardon me but...
->Cut the SGI - "We Are Better Than God, Bow Before Our I/O" crap.

I would never suggest that you bow before our IO either. Some people need it, some don't. Not really my place to make that determination for you. Though, you have to admit that we do a pretty good job for those apps that really need it. 

->Humm, a look at the glossies for the 320 and 540 make it look like all
->of SGI is working off a typo.  It lists:
->   * 100 MHz (50 ns) ECC synchronous dynamic RAM (SDRAM)
->that should read 5ns.  and beyond that, lots of people sell 100Mhz
->capable SDRAM.  (eg http://www.memoryx.com/generic.htm)  

That's the problem with the internet, no real way to verify your sources. That email could have come from a temp janitor on his last day. I really don't know any of the specifics or part numbers. That would be something to ask your sales rep.

->Anyhow, the only things that seem different from the std garage built PC
->are:
->Video expandable to 1/2gb of ram (though this looks like it's running
->      off the system ram, not dedicated ram.  not a bad thing, but it
->      kills the system bus. and it's a bit misleading)

Much cheaper that raster managers. As more information comes out about the architecture of the new systems, I'll think you might change your mind. I've seen the some of the overviews and it looks impressive. Keep an eye out for something about io being gu
aranteed in the hardware. 

->2 64-bit PCI busses
->540 uses a WTX tower case.  (320 uses ATX)
->540 has SCA scsi disk bays.  I wonder if i'll need $700 drive sleds...
->Video Capture card (S-Video, RCA.  in/out)
->USB Keyboard & Mouse (this currently limits linux support - USB is
->      alpha'ish)

Linux problem maybe. Late beta'ish maybe. My mom's iMac is working like a champ though. USB hub and all. 

->video connector for the SGI LCD Display
->2 firewire ports.  not hard to do, just pointless for the next 6months.

Imagine how mad you'd be in 6 months if we didn't include this originally but were preparing to sell it to you as an upgrade.

->I might buy some if they are competitive w/ plain old white Linux boxes.
->Esp. if they have good OpenGL performance under Linux.  

Haven't gotten to play with hardware accellerated OpenGl on many "plain old white Linux boxes". How do they do? We'd be happy to forward the data to marketing.

->They would be
->more interesting if they had a craylink type high speed connector that
->could be used ala myrinet for making Beowulf clusters.

Did you know we're are already getting criticized for distributing a CD, with NT (service pak4) custom burned to include our GFX drivers. They are saying that we are being too proprietary. Can you imagine the beating we would take for custom building non-
industry standard PC hardware (that would probably need special RAM). There are choices to be made about what to make custom and what to make generic. I prefer custom but the number of folks that need it enough to pay for it, is not growing as fast as the
 other segments of the computing markets. 

Actually, there is a "craylink type high speed connector" coming in the near future. It's called GSN, Giga-Byte System Network. It is not slated to be part of the desktop family though. Once again, I think this technology, while useful by some, would be l
argely ignored by the desktop system buying public as being exotic or proprietary.  

Once again, many appologies.
Chad

->Director of Computing					773-702-2588
->James Franck Institute				5640 South Ellis Ave
->University of Chicago				   Chicago, Il 60637

---1443998914-1763575553-916803163=:7100
Content-Type: APPLICATION/octet-stream; name="1."
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SGI.3.94.990119213243.7100C@roctane.dallas.sgi.com>
Content-Description: 


---1443998914-1763575553-916803163=:7100--
