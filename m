Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B8UbRw016608
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 01:30:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B8Ubp0016607
	for linux-mips-outgoing; Thu, 11 Jul 2002 01:30:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B8UVRw016597
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 01:30:31 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6B8YoXb011163;
	Thu, 11 Jul 2002 01:34:50 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA03975;
	Thu, 11 Jul 2002 01:34:49 -0700 (PDT)
Message-ID: <009001c228b5$e87e0600$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Linux/MIPS Development" <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0207110854250.8371-100000@vervain.sonytel.be>
Subject: Re: Malta crashes on the latest 2.4 kernel
Date: Thu, 11 Jul 2002 10:35:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.1 required=5.0 tests=PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Thu, 11 Jul 2002, Kevin D. Kissell wrote:
> > I note that Ralf has, in fact, applied the fix to the
> > OSS CVS repository.  I also note that "BARRIER"
> > is still defined to be a string of 6 nops.  I would argue
> > (again) that those really, really ought to be ssnops,
> > and that if they *were* ssnops, one could probably
> > have fewer of them.
> 
> Sorry for being ignorant, but what's the difference between nop and ssnop?
> 
> I see that SSNOP is defined to be `sll zero,zero,1' in <asm/asm.h>, but that
> doesn't give me any clue.

SSNOPs are "super-scalar NOPs", which were first
invented (but not documented at the time) for the 
R8000, which was the first superscalar MIPS
implementation.  They wanted to be able to absorb
the standard "overhead" NOPS associated with
unfilled branch delay slots, etc, in the dual-issue
mechanism, but still have some means to handle
CP0 hazards such that it could be assured to force
a 1 cycle stall per instruction.  While it wasn't officially
a part of the architecture until the late 1990's, the
convention was carried forward by the R5xxx
and R1xxxx families. There have been rumours of 
superscalar MIPS processors that do not enforce 
single-issue on SSNOPs, but I don't know of any 
offhand, and the MIPS32/MIPS64 specs formalize 
the definition.

            Regards,

            Kevin K.
