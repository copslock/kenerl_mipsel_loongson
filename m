Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 18:06:50 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:29180 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225196AbTCDSGt>;
	Tue, 4 Mar 2003 18:06:49 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h24I6i425984;
	Tue, 4 Mar 2003 10:06:44 -0800
Date: Tue, 4 Mar 2003 10:06:44 -0800
From: Jun Sun <jsun@mvista.com>
To: TAKANO Ryousei <takano@os-omicron.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: JVM under Linux on MIPS
Message-ID: <20030304100644.B25862@mvista.com>
References: <20030302121820.A30790@linux-mips.org> <20030304011459.457.qmail@web13302.mail.yahoo.com> <20030304171340.1a9af44d.takano@os-omicron.org> <007701c2e22c$66e30e70$10eca8c0@grendel> <20030304190902.68ffd5bb.takano@os-omicron.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030304190902.68ffd5bb.takano@os-omicron.org>; from takano@os-omicron.org on Tue, Mar 04, 2003 at 07:09:02PM +0900
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 04, 2003 at 07:09:02PM +0900, TAKANO Ryousei wrote:
> Hi Kevin,
> 
> > I'm very pleased to hear that you got it running on a Vr41xx,
> > but I'm curious about the JIT behavior you saw.  I can believe
> > that it could run "hello world", but does it really pass all the
> > internal regression tests ("make check")?  Are you running
> > a "normal" MIPS/Linux distribution which assumes a
> > hardware FPU and does kernel emulation where necessary,
> > or are you using a purely soft-float environment?  I ask
> > this because most of the problems I have with the JIT are
> > in areas where mixed integer/floating arguments are being
> > passed, and those might not be an issue with soft-float.
> > 
> I have cross-compiled Kaffe, so it did not pass "make check".
> I tried it under a Linux-VR kernel(kernel-2.4.0-test9) which is
> enabled with a kernel FPU emulation.
> I have not tried under a Linux/MIPS kernel.
>

Java VM typically uses massive threading.  Emulating ll/sc instructions
for vr4181a might one of the biggest causes of delay.

Jun
