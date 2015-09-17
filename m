Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 16:51:12 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:54392 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007881AbbIQOvKzeraq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 16:51:10 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZcaWk-0006V0-1s; Thu, 17 Sep 2015 16:51:10 +0200
Date:   Thu, 17 Sep 2015 16:50:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LAK <linux-arm-kernel@lists.infradead.org>
cc:     linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: drivers/irqchip patch submission 
Message-ID: <alpine.DEB.2.11.1509171642580.3951@nanos>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Folks,

I'm really tired of patches against drivers/irqchip sent to random
mailing lists and later on a ping mail why they are not applied.

Here is the relevant section of MAINTAINERS:

IRQCHIP DRIVERS
M:      Thomas Gleixner <tglx@linutronix.de>
M:      Jason Cooper <jason@lakedaemon.net>
M:      Marc Zyngier <marc.zyngier@arm.com>
L:      linux-kernel@vger.kernel.org
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
T:      git git://git.infradead.org/users/jcooper/linux.git irqchip/core
F:      Documentation/devicetree/bindings/interrupt-controller/
F:      drivers/irqchip/

This file is there for a reason and I'm not going to collect irqchip
patches from any other mailing list or from my personal inbox.

It's not that hard really.

Thanks,

	tglx
