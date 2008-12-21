Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:28:08 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:26341 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S22774249AbYLUI0a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:30 +0000
Received: (qmail 3959 invoked from network); 21 Dec 2008 09:24:58 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:58 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 06/14] MIPS: print irq handler description
Date:	Sun, 21 Dec 2008 09:26:19 +0100
Message-Id: <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
 <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
 <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add the name set by set_irq_chip_and_handler_name() to the output of
/proc/interrupts, like so:

db1200 ~ # cat /proc/interrupts
           CPU0
  8:         52     Alchemy-IC0-hilevel   serial
 10:        171     Alchemy-IC0-hilevel   au1xxx-mmc
 11:         47     Alchemy-IC0-hilevel   Au1xxx dbdma
 18:          1     Alchemy-IC0-hilevel   au1550-spi
 29:    1250997     Alchemy-IC0-riseedge  timer
 37:        211     Alchemy-IC0-hilevel   ehci_hcd:usb1, ohci_hcd:usb2
 38:          0     Alchemy-IC0-hilevel   lcd
 72:       2623     DB1200 CPLD-level     ide0
 73:        257     DB1200 CPLD-level     eth0
 84:          1     DB1200 CPLD-level     sd_insert
 85:          0     DB1200 CPLD-level     sd_eject

ERR:          0

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/kernel/irq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 4b4007b..a0ff2b6 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -111,6 +111,7 @@ int show_interrupts(struct seq_file *p, void *v)
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].chip->name);
+		seq_printf(p, "-%-8s", irq_desc[i].name);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-- 
1.6.0.4
