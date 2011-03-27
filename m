Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 18:22:35 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40545 "EHLO linutronix.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491883Ab1C0QWI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Mar 2011 18:22:08 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q3sj3-00054j-EF; Sun, 27 Mar 2011 18:22:01 +0200
Message-Id: <20110327155637.623706071@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sun, 27 Mar 2011 16:22:01 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: [patch 0/5] MIPS: Final irq fixups
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Ralf,

I applied Daney's genirq patches with slight modifications. The
following series has a fixed up version of the cavium patch, a fixup
for alchemy and the final scripted name space conversion.

Please pull the core changes on which this series depends from:

 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git irq/for-mips

Git replication is slooow, so you can get it from here as well:

 ssh://master.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git irq/for-mips

Thanks,

	tglx
