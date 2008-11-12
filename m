Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 06:25:42 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:27061 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23627443AbYKLGZh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Nov 2008 06:25:37 +0000
Received: (qmail 9575 invoked by uid 1000); 12 Nov 2008 07:22:43 +0100
Date:	Wed, 12 Nov 2008 07:22:43 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [RFC PATCH] Alchemy: IRQ code overhaul
Message-ID: <20081112062243.GA9521@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

Starting with 2.6.28-rc, ethernet on one of my au1200 boards stopped working
due to the IRQ it was hooked up to not having a flow handler installed.

So I decided to take a look at the alchemy irq code and came up with the
patch below.

It adds struct irq_chip for IC0 and IC1, a set_type() callback to change
IRQ type at runtime (should be useful for GPIO too), a set_wake() callback
to enable GPIO-based wakeup, merge the cpu-fixed irqmap into irq.c file
(IIRC next-gen Alchemy SoC use a different IRQ controller, so this map
should not change much in the future anyway.  Also, I hate all those
extern declarations and try to get rid of them when possible).

Tested on the Db1200 and custom Au1200 platform, works very well so
far.

The patch is against my code-consolidation changes.

Feedback very welcome!

Thanks,
	Manuel Lauss

---
