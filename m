Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA25271 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Apr 1999 13:55:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA91350
	for linux-list;
	Mon, 5 Apr 1999 13:43:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA04647
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 5 Apr 1999 13:43:28 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup71-7-4.swipnet.se [130.244.71.100]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03068
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Apr 1999 13:43:25 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id WAA18152
	for linux@cthulhu.engr.sgi.com; Mon, 5 Apr 1999 22:33:16 -0400
Date: Mon, 5 Apr 1999 22:33:16 -0400
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: mpg123 hack
Message-ID: <19990405223315.A9898@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I know this is silly and you don't care about it, but I've patched mpg123 so
that I can play mp3's without generating wav files in between :-). Maybe you say
that I should fix my poor HAL2 driver instead - I will...

About the noise:

I have done some testing with mpg123. The HAL2 is, to say the least, acting
weird. I found that only every other sample is played, and the other ones are
dumped.

Ok now to the really really weird part: If I play audio on the samples which are
dumped and zeros on the ones which are played I can hear this silly noise in the
speakers. If I do not play anything, zeros in both channels, it's death quiet
(although the DMA is acting and the HAL2 is playing the zeros). If I play zeros
on the dumped channel and audio on the other one I can hear this noise again.

Hum, I have been looking at this noise problem for nearly two days now without
any progress. Testing one thing the other with no effect. Quite boring, I'll
hack something else tomorrow..

- Ulf

diff -ur mpg123-0.59q-orig/Makefile mpg123-0.59q/Makefile
--- mpg123-0.59q-orig/Makefile	Tue Jan 26 14:35:18 1999
+++ mpg123-0.59q/Makefile	Tue Jan 18 03:26:46 2000
@@ -56,7 +56,7 @@
 	@echo "make linux-nas      Linux, output to Network Audio System"
 	@echo "make linux-sparc    Linux/Sparc"
 	@echo "make linux-sajber   Linux, build binary for Sajber Jukebox frontend"
-	@echo "make linux-alsa     Linux with ALSA sound driver"
+	@echo "make linux-mips-alsa Linux/MIPS with ALSA sound driver"
 	@echo ""
 	@echo "make linux-esd      Linux, output to EsounD"
 	@echo "make linux-alpha-esd Linux/Alpha, output to EsounD"
@@ -148,6 +148,17 @@
 		CFLAGS='-DI386_ASSEM -DREAL_IS_FLOAT -DPENTIUM_OPT -DLINUX \
 			-DREAD_MMAP -DALSA \
 			-Wall \
+			-fomit-frame-pointer -funroll-all-loops \
+			-finline-functions -ffast-math \
+			$(RPM_OPT_FLAGS)' \
+		mpg123-make
+
+linux-mips-alsa:
+	$(MAKE) CC=gcc LDFLAGS= \
+		AUDIO_LIB='-lasound' \
+		OBJECTS='decode.o dct64.o audio_alsa.o' \
+		CFLAGS='-DLINUX -DREAD_MMAP -DSWAP_BYTES -DREAL_IS_FLOAT \
+			-DALSA -Wall -O2 \
 			-fomit-frame-pointer -funroll-all-loops \
 			-finline-functions -ffast-math \
 			$(RPM_OPT_FLAGS)' \
diff -ur mpg123-0.59q-orig/audio_alsa.c mpg123-0.59q/audio_alsa.c
--- mpg123-0.59q-orig/audio_alsa.c	Fri Nov 27 11:16:58 1998
+++ mpg123-0.59q/audio_alsa.c	Tue Jan 18 03:24:40 2000
@@ -182,8 +182,24 @@
 int audio_play_samples(struct audio_info_struct *ai,unsigned char *buf,int len)
 {
 	ssize_t ret;
+#ifdef SWAP_BYTES
+	int samples = len >> 1; /* will only work in 16 bit mode .. */
+	unsigned short *sample = (unsigned short *) buf;
+	static unsigned short *swap_buf = NULL;
 
+	if (!swap_buf)
+		swap_buf = (unsigned short *) malloc(len);
+
+	while (samples--) {
+		swap_buf[samples] =
+			(((sample[samples] & 0x00ff) << 8) |
+			((sample[samples] & 0xff00) >> 8));
+	}
+
+	ret=snd_pcm_write(ai->handle, swap_buf, len);
+#else
 	ret=snd_pcm_write(ai->handle, buf, len);
+#endif
 
 	return ret;
 }
