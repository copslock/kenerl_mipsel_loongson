Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4SHaRnC026892
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 28 May 2002 10:36:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4SHaRgS026891
	for linux-mips-outgoing; Tue, 28 May 2002 10:36:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4SHaJnC026888
	for <linux-mips@oss.sgi.com>; Tue, 28 May 2002 10:36:19 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id KAA07893;
	Tue, 28 May 2002 10:37:33 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA16685;
	Tue, 28 May 2002 10:37:33 -0700 (PDT)
Message-ID: <01da01c2066f$3ed63f40$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
   "Linux/MIPS Development" <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0205271534430.15706-100000@vervain.sonytel.be> <3CF3B72B.4020600@mvista.com>
Subject: Re: PCI Graphics/Video Card for Malta Board?
Date: Tue, 28 May 2002 19:43:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Jun Sun" <jsun@mvista.com>
> Geert Uytterhoeven wrote:
> 
> > On Mon, 27 May 2002, Steven J. Hill wrote:
> > 
> >>Kevin D. Kissell wrote:
> >>
> >>>I'd like to get a video-capable graphics card up
> >>>and running on a MIPS Malta board (therefore
> >>>PCI), ideally something mainstream like ATI.
> >>>Does anyone on the list have any positive or
> >>>negative recommendations in terms of cards
> >>>and particularly in terms of the degree to which
> >>>the drivers (and PCI set-up) have been ported
> >>>to MIPS/Linux?  I'll do what I must, but I hate
> >>>re-inventing the wheel.
> >>>
> >>>
> >>I can think of two things. First, a lot of graphics cards
> >>rely on BIOS calls to be set up before the operating system
> >>even boots. Second, I would stick to graphics cards that
> >>have framebuffer support in the kernel as you stand at least
> >>half a chance that those cards don't rely so heavily on a
> >>peecee bios. Just my $.02.
> >>
> > 
> > Even then, most frame buffer device drivers rely on the firmware (PC BIOS or
> > SPARC/PPC Open Firmware) having set up the video card.
> > 
> > One of the exceptions is matroxfb, 
> 
> 
> Steve Longerbeam has a fb driver with BIOS init for ATI Xpert98 card, which 
> you can still buy.

Yeah, but it's a pretty wimpy card (8MB) and has no TV output.
  
> Dan Malek also wrote a driver for MQ200.  

Which is essentially a handheld/webphone graphics chip,
for which the documentation is only available under NDA.
Not terribly useful for me, thanks.

> If you ask  around, I am sure you can the patch somewhere.

I *am* asking around - that's why I started this thread.

> 
> For a while, I also had 3dfx voodoo3 working.  Not sure about its status now. 
>   You can find the patch at http://www.medex.hu/~danthe/tdfx/.

3dfx, in case you hadn't heard, folded some time ago.

So it sounds like the Matrox G450 PCI is really the only
game in town...

            Kevin K.
