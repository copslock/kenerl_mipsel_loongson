Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA30544 for <linux-archive@neteng.engr.sgi.com>; Mon, 10 May 1999 14:03:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA80357
	for linux-list;
	Mon, 10 May 1999 14:00:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA90842
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 10 May 1999 14:00:11 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup117-1-42.swipnet.se [130.244.117.42]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA02392
	for <linux@cthulhu.engr.sgi.com>; Mon, 10 May 1999 13:59:37 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10gyPb-003LodC; Tue, 11 May 1999 00:20:35 +0200 (CEST)
Date: Tue, 11 May 1999 00:20:35 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: HAL2 driver update
Message-ID: <19990511002035.A16077@thepuffingroup.com>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I've got the HAL2 driver into the main ALSA CVS tree now. To celebrate that,
I've uploaded a new version of the driver. Including a binary kernel with sound
support this time.

If you want to play some music go through the following steps:

1. Get a binary linux-indy-sound kernel from
   ftp://ftp.linux.sgi.com/pub/linux/mips/test.

2. Install the ALSA and mpg123 precompiled RPM packages you get from
   ftp://ftp.linux.sgi.com/pub/linux/mips/ALSA (note that I have moved it out
   from the test directory).

4. You will now have to create the ALSA sound devices. Run the script
   snddevices in /usr/doc/alsa-driver-0.3.0-pre5.

5. Insert the modules, in the order: snd.o snd-pcm.o snd-timer.o
   snd-pcm1.o snd-mixer.o snd-pcm1-oss.o snd-hal2.o snd-card-hal2.o. Write this
   in the boot scripts if you don't want to insert the modules manually each
   time.

6. Play audio!

7. Tell me (ulfc@thepuffingroup.com) if it works!

/ Ulf
