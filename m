Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA61072 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Apr 1999 17:29:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA75273
	for linux-list;
	Sun, 4 Apr 1999 17:24:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA32570
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 4 Apr 1999 17:24:08 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup84-1-11.swipnet.se [130.244.84.11]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA01022
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Apr 1999 17:24:06 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id CAA04481;
	Mon, 5 Apr 1999 02:13:54 -0400
Date: Mon, 5 Apr 1999 02:13:53 -0400
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>, alsa-devel@alsa.jcu.cz
Subject: HAL2 ALSA driver prerelease
Message-ID: <19990405021353.A4455@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>,
	alsa-devel@alsa.jcu.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I have released a preview of the forthcoming HAL2 ALSA driver, don't expect too
much out of it. You can not play mp3 directly without a patched mp3 player. They
all assume that you use big endian. I hope I don't violate any GPL license
agreements by don't uploading the SPRMS of ALSA. Everything but
alsa-hal2-driver-0.3.0-0.1.tgz and alsa-dirver-0.3.0-pre5-1.mipseb.rpm is taken
directly from the ALSA CVS tree which you can find more information about at
http://alsa.jcu.cz/.

Things it can do:
o 44100 kHz
o 16 bit
o Little endian
o Stereo 

Things it can't do (yet):
o Everything else than 44100 kHz
o Big endian
o Mono (Oups)
o Perfect audio quality
o Mixing

If you still want to try to play some music go through the following steps:

1. Compile an Indy kernel with soundcore.o compiled as a module.

2. Install the alsa precompiled rpm packages you get from
   ftp://linus.linux.sgi.com/pub/linux/mips.

3. Insert the modules, in the order: soundcore.o snd.o snd-pcm.o snd-pcm1.o
   snd-mixer.o snd-timer.o snd-pcm1-oss.o snd-hal2.o snd-card-hal2.o

4. Generate a .wav file with mpg123, either directly on the Indy or on your PC.

5. Play the .wav file with aplay -m -w.

6. Tell me if it works!

- Ulf
