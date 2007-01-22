Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2007 16:50:12 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:54781 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S28574920AbXAVQuI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2007 16:50:08 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l0MGp0eh025815;
	Mon, 22 Jan 2007 08:51:00 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l0MGnuHU007560;
	Mon, 22 Jan 2007 08:49:57 -0800 (PST)
Message-ID: <01c201c73e46$7ac9d930$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Jan Engelhardt" <jengelh@linux01.gwdg.de>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"sathesh babu" <sathesh_edara2003@yahoo.co.in>,
	<linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com> <20070121001457.GA9123@linux-mips.org> <Pine.LNX.4.61.0701212228340.29213@yvahk01.tjqt.qr>
Subject: Re: Running Linux on FPGA
Date:	Mon, 22 Jan 2007 17:58:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Jan 21 2007 00:14, Ralf Baechle wrote:
> >On Sat, Jan 20, 2007 at 11:42:37PM +0000, sathesh babu wrote:
> >
> >>   I am trying to run Linux-2.6.18.2 ( with preemption enable)
> >>   kernel on FPGA board which has MIPS24KE processor runs at 12
> >>   MHZ. Programmed the timer to give interrupt at every 10msec. I
> >>   am seeing some inconsistence behavior during boot up processor.
> >>   Some times it stops after "NET: Registered protocol family 17"
> >>   and "VFS: Mounted root (jffs2 filesystem).". Could some give
> >>   some pointers why the behavior is random. Is it OK to program
> >>   the timer to 10 msec? or should it be more.
> >
> >The overhead of timer interrupts at this low clockrate is
> >significant so I recommend to minimize the timer interrupt rate as
> >far as possible. This is really a tradeoff between latency and
> >overhead and matters much less on hardcores which run at hundreds of
> >MHz.
> 
> Hm I've been running 2.6.13 on a 10/20 MHz (switchable) i386 @ 100 Hz
> before without any hangs during boot or operation.

Interrupt service overhead varies a bit between architectures, but your
observation isn't too surprising.  While the 1000Hz Linux 2.6 default
is just bad craziness for embedded cores and FPGA prototypes, I've
only seen 100Hz be truly unusable for sub-megahertz hardware simulators,
and then only when running virtual SMP kernels, where multiple virtual
"CPUs" on the same core all had to perform timer interrupt service
every clock interval, which multiplies the proportion of available cycles
consumed.  But even if the system boots and runs, it's pretty scary
to look at the proportion of time that a 20MHz core spends in interrupt
service with a HZ value of 100 or more.

So on one hand I agree with Ralf that on slow systems, especially
FPGA systems, one wants to keep the clock interrupt frequency
down to no more than 100Hz as a general rule (less than 100
wouldn't compile on 2.6.9 without some minor patches, which
took the minimum down to HZ=48, below which the various macros
that depend on HZ start generating divide-by-zero problems),
while on the other hand I agree with Jan that it's by no means certain
that Satesh's problem is really one of too many clock interrupts.

            Regards,

            Kevin K.
