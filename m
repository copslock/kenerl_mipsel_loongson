Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 23:15:16 +0100 (BST)
Received: from mail3.efi.com ([IPv6:::ffff:192.68.228.90]:60427 "HELO
	fcexgw03.efi.internal") by linux-mips.org with SMTP
	id <S8225281AbTFLWPO> convert rfc822-to-8bit; Thu, 12 Jun 2003 23:15:14 +0100
Received: from 10.3.12.12 by fcexgw03.efi.internal (InterScan E-Mail VirusWall NT); Thu, 12 Jun 2003 15:15:05 -0700
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: do_IRQ query
Date: Thu, 12 Jun 2003 15:15:04 -0700
Message-ID: <D9F6B9DABA4CAE4B92850252C52383AB07968331@ex-eng-corp.efi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: do_IRQ query
Thread-Index: AcMxJ1yASl7Sbv40TMiDOcJxiE590QACCOnA
From: "Ranjan Parthasarathy" <ranjanp@efi.com>
To: "Jun Sun" <jsun@mvista.com>,
	"Ranjan Parthasarathy" <ranjanp@efi.com>
Cc: <linux-mips@linux-mips.org>
Return-Path: <ranjanp@efi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranjanp@efi.com
Precedence: bulk
X-list: linux-mips

Thank you for the information. I do not have a crash log at this minute. I will send something when I see the crashes again.

Ranjan

-----Original Message-----
From: Jun Sun [mailto:jsun@mvista.com]
Sent: Thursday, June 12, 2003 2:13 PM
To: Ranjan Parthasarathy
Cc: linux-mips@linux-mips.org; jsun@mvista.com
Subject: Re: do_IRQ query


On Thu, Jun 12, 2003 at 01:16:51PM -0700, Ranjan Parthasarathy wrote:
> Is it safe to call do_IRQ directly inside interrupt handlers without doing a irq_enter. I have seen ksoftirqd_CPUX crashes when I call the do_IRQ routines directly instead of the following sequence.
> 
> irq_enter()
> do_IRQ
> irq_exit()
>

This is not right.  irq_enter()/irq_exit() is already called in 
handle_IRQ_event(), which in turn is called by do_IRQ().  YOu 
don't need this yourself.  

The rest of do_IRQ() code is protected by closing interrupts.

Something must be wrong in your system.  If you show the crash message,
we might be able to tell more.

> Some code use it while some do not. The timer code in arch/mips/kernel/time.c uses it in ll_timer_interrupt. Some ports call this function directly in their interrupt handlers.

Those ll_timer_xxx functions are alternative routes (fast ones) to
do_IRQ(), and therefore it needs to protect itself by calling
irq_enter()/irq_exit().

Jun
