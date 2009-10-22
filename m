Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 23:41:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8653 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493832AbZJVVlO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 23:41:14 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae0d1640000>; Thu, 22 Oct 2009 14:40:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 14:40:27 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 14:40:27 -0700
Message-ID: <4AE0D14B.1070307@caviumnetworks.com>
Date:	Thu, 22 Oct 2009 14:40:27 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Irq architecture for multi-core network driver. 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2009 21:40:27.0342 (UTC) FILETIME=[450546E0:01CA5360]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

My network controller is part of a multicore SOC family[1] with up to 32 
cpu cores.

The the packets-ready signal from the network controller can trigger
an interrupt on any or all cpus and is configurable on a per cpu basis.

If more than one cpu has the interrupt enabled, they would all get the
interrupt, so if a single packet were to be ready, all cpus could be
interrupted and try to process it.  The kernel interrupt management
functions don't seem to give me a good way to manage the interrupts.
More on this later.

My current approach is to add a NAPI instance for each cpu.  I start
with the interrupt enabled on a single cpu, when the interrupt
triggers, I mask the interrupt on that cpu and schedule the
napi_poll.  When the napi_poll function is entered, I look at the
packet backlog and if it is above a threshold , I enable the interrupt
on an additional cpu.  The process then iterates until the number of cpu
running the napi_poll function can maintain the backlog under the
threshold.  This all seems to work fairly well.

The main problem I have encountered is how to fit the interrupt
management into the kernel framework.  Currently the interrupt source
is connected to a single irq number.  I request_irq, and then manage
the masking and unmasking on a per cpu basis by directly manipulating
the interrupt controller's affinity/routing registers.  This goes
behind the back of all the kernel's standard interrupt management
routines.  I am looking for a better approach.

One thing that comes to mind is that I could assign a different
interrupt number per cpu to the interrupt signal.  So instead of
having one irq I would have 32 of them.  The driver would then do
request_irq for all 32 irqs, and could call enable_irq and disable_irq
to enable and disable them.  The problem with this is that there isn't
really a single packets-ready signal, but instead 16 of them.  So If I
go this route I would have 16(lines) x 32(cpus) = 512 interrupt
numbers just for the networking hardware, which seems a bit excessive.

A second possibility is to add something like:

int irq_add_affinity(unsigned int irq, cpumask_t cpumask);

int irq_remove_affinity(unsigned int irq, cpumask_t cpumask);

These would atomically add and remove cpus from an irq's affinity.
This is essentially what my current driver does, but it would be with
a new officially blessed kernel interface.

Any opinions about the best way forward are most welcome.

Thanks,
David Daney

[1]: See: arch/mips/cavium-octeon and drivers/staging/octeon.  Yes the 
staging driver is ugly, I am working to improve it.
