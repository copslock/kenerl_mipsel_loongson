Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 18:47:53 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:51515 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21103675AbZAMSrv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 18:47:51 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496ce18c0000>; Tue, 13 Jan 2009 13:46:41 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 10:45:40 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 10:45:40 -0800
Message-ID: <496CE153.5010802@caviumnetworks.com>
Date:	Tue, 13 Jan 2009 10:45:39 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Andrew Morton <akpm@linux-foundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@linux-foundation.org>
CC:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Mike Travis <travis@sgi.com>
Subject: [PATCH 0/2] cpumask fallout: Initialize irq_default_affinity earlier
 et al. (v3)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jan 2009 18:45:40.0076 (UTC) FILETIME=[21A1FAC0:01C975AF]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Now that mips/OCTEON support has been merged, this patch set has 
slightly more urgency.

The interrupt affinity on OCTEON is determined by irq_default_affinity,
because that is what the code in kernel/irq/manage.c uses to set 
affinity.  Since for the majority of devices (Serial, Compact Flash,
Network...) we want interrupts to be handled on a single CPU, we set
irq_default_affinity to the boot CPU in init_IRQ().  The problem we
have is that with the new cpumask infrastructure, irq_default_affinity
is being initialized in core_initcall which undoes our initialization.

As I said in 2/2:

     Move the initialization of irq_default_affinity to early_irq_init
     as core_initcall is too late.

     irq_default_affinity can be used in init_IRQ and potentially timer
     and SMP init as well.  All of these happen before core_initcall.
     Moving the initialization to early_irq_init ensures that it is
     initialized before it is used.

Mike Travis pointed out that irq_default_affinity depends on
CONFIG_GENERIC_HARDIRQS in addition to CONFIG_SMP.  So to make things
consistent, I added 1/2 so that the irq_*_affinity functions and
irq_default_affinity are defined for the same conditions that they are
declared.

I Took Linus' suggestion to move init_irq_default_affinity over to
kernel/irq/handle.c, however due to the way that cpumask_*() are
defined, it is still necessary to have the ugly ifdefs, but now they
are localized to init_irq_default_affinity.

Mike Travis also suggested that alloc_bootmem_cpumask_var() be used in
preference to alloc_cpumask_var, so I incorporated that suggestion as
well.

I tested both with and without CONFIG_SMP, on mips/cavium_octeon, Mike
tested a similar(but not identical patch) on x86_64.

Changes from v2 of this set are just a small rearrangement of the
#ifdefs suggested by Ihar Hrachyshka that make the code look a bit
cleaner.


I will reply with the two patches.

David Daney (2):
   Make irq_*_affinity depend on CONFIG_GENERIC_HARDIRQS too.
   cpumask fallout: Initialize irq_default_affinity earlier (v3).

  kernel/irq/handle.c |   16 ++++++++++++++++
  kernel/irq/manage.c |   10 +---------
  2 files changed, 17 insertions(+), 9 deletions(-)
