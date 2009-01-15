Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 19:50:41 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:58064 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21365967AbZAOTuh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 19:50:37 +0000
Received: (qmail 8812 invoked by uid 1000); 15 Jan 2009 20:49:21 +0100
Date:	Thu, 15 Jan 2009 20:49:21 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 06/14] MIPS: print irq handler description
Message-ID: <20090115194921.GB8656@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net> <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net> <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net> <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net> <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net> <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net> <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net> <496F90AA.7070407@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496F90AA.7070407@caviumnetworks.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi David,

On Thu, Jan 15, 2009 at 11:38:18AM -0800, David Daney wrote:
>> Add the name set by set_irq_chip_and_handler_name() to the output of
>
> Alchemy is the only mips cpu that uses set_irq_chip_and_handler_name()...
> ... so for most mips CPUs we now get something ugly like this:
>
> octeon:~# cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  23:       7371       7120       5747       5373            Core-<NULL>    
> timer

Ouch, I see.  Well, I certainly have no objections if you want to revert
the patch, but I like that I can see how triggers are set up (nice esp.
for gpio's and my homebrew userspace gpio interface).

Or how about this?

--- 

From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] MIPS: only print handler name if its actually set.

David Daney reports that Alchemy is the only in-tree user of
set_irq_handler_and_name().  On other systems this leaves ugly
"-<NULL>" strings in cpuinfo.

So, only print the handler string if it was actually set.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/kernel/irq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index a0ff2b6..9061ae9 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -111,7 +111,8 @@ int show_interrupts(struct seq_file *p, void *v)
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].chip->name);
-		seq_printf(p, "-%-8s", irq_desc[i].name);
+		if (irq_desc[i].name)
+			seq_printf(p, "-%-8s", irq_desc[i].name);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-- 
1.6.0.6
