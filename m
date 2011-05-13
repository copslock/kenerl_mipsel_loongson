Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 18:29:45 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59893 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491860Ab1EMQ31 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 18:29:27 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4DGUvA0011605;
        Fri, 13 May 2011 17:30:57 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4DGUt90011603;
        Fri, 13 May 2011 17:30:55 +0100
Date:   Fri, 13 May 2011 17:30:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org,
        florian@openwrt.org
Subject: Re: [PATCH] MIPS: AR7: Fix GCC 4.6.0 build error.
Message-ID: <20110513163055.GA11537@linux-mips.org>
References: <20110513152855.GM25017@chipmunk>
 <4DCD4EC9.1070804@mvista.com>
 <20110513155030.GO25017@chipmunk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110513155030.GO25017@chipmunk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 04:50:30PM +0100, Alexander Clouter wrote:

> > >+	struct ar7_gpio_chip *gpch = (!ar7_is_titan())
> > 
> >    Parens around (!x) are not really necessary. Perhaps Ralf could
> > remove them while applying...
> > 
> I'm happy to resubmit if that is preferred.

Florian who is experiencing email problems submitted an alternative patch
to me which I'm appending below and which I've just applied.

Thanks folks!

  Ralf

From: Florian Fainelli <florian@openwrt.org>
Date: Fri, 13 May 2011 17:41:21 +0200
Subject: [PATCH] MIPS: AR7: Fix GPIO register size for Titan variant.

The 'size' variable contains the correct register size for both AR7
and Titan, but we never used it to ioremap the correct register size.
This problem only shows up on Titan.

Reported-by: Alexander Clouter <alex@digriz.org.uk>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/ar7/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index 425dfa5..a8aa1b4 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -326,7 +326,7 @@ int __init ar7_gpio_init(void)
 	}
 
 	gpch->regs = ioremap_nocache(AR7_REGS_GPIO,
-					AR7_REGS_GPIO + 0x10);
+					AR7_REGS_GPIO + size);
 
 	if (!gpch->regs) {
 		printk(KERN_ERR "%s: failed to ioremap regs\n",
