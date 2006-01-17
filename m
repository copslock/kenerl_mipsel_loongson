Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 14:47:34 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:7824 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133371AbWAQOrJ
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 14:47:09 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0HEoVfY024953;
	Tue, 17 Jan 2006 06:50:31 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id k0HEoTYr011706;
	Tue, 17 Jan 2006 06:50:30 -0800 (PST)
Message-ID: <00e501c61b75$a5f0c0a0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Bharathi Subramanian" <sbharathi@midascomm.com>,
	"Linux MIPS" <linux-mips@linux-mips.org>
References: <Pine.LNX.4.44.0601171939020.2361-100000@bharathi.midascomm.com>
Subject: Re: Timer Interrupt
Date:	Tue, 17 Jan 2006 15:52:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Tue, 17 Jan 2006, Bharathi Subramanian wrote:
> 
> > On Mon, 16 Jan 2006, Bharathi Subramanian wrote:
> > 
> > > We are trying to implement the CPU Clock down feature for saving the 
> > > power. In this process, Whenever the CPU is put in 1/2 Clock then the 
> > > Timer interrupt is also getting delayed.
> > > 
> > > Later I found that CPU Counter is used to generate the timer intr. How 
> > > to make the Timer interrupt to happen at every 10ms, even if the CPU 
> > > is in 1/2, 1/4 or 1/8 of the original clock??
> > > 
> > > Processor: MIPS 4Kc 32B
> >   Kernel   : 2.4.20 with RTLinux Patch
> > 
> > In mips_timer_ack() function, the new Compare reg value loaded. Here I 
> > tried to put new counter value based on the present cpu clock divder 
> > setting. But board is getting rebooted.
> > 
> > Is it the right way to handle this issue?? Anybody faced same
> > condition, kindly share your exprience with me.
> 
> I read the Linux Porting guide by Junsun. In that,(s)he mention, "Some
> CPUs may have a variable CPU frequency which makes CPU counter not
> usable as a timer source". Does it mean that, we can't do the CPU
> Clock down in MIPS Processor??

Some systems have variable CPU frequencies that are invisible to software,
in which case a CPU counter would not be very usefule as a timer source.
If your CPU clock mode is programmable, as it is on most MIPS systems
of which I'm aware, it just means that you have to keep your Count register
programming synchronized with the clock mode.

You were on the right track when you tried hacking mips_timer_ack(),
but note that both cycles_per_jiffy and mips_hpt_frequency end up being
used in Count-based time calculations.  If the board is rebooting when you
tested your mod, it's probably because there's an error or a typo in your code.

Note that just changing the Count register increment will result in some
small error each time the clock mode changes, because the new increment
won't take effect until the next interrupt goes off. which will be some random
interval after the CPU clock divisor has changed.  If that's a real issue, 
you can reduce the error to a few cycles if you really want to go to the
trouble of sampling the Count register and re-computing the Compare value
when you change the CPU clock mode.

        Regards,

        Kevin K.
