Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 17:07:00 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40395 "EHLO linutronix.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491823Ab1C1PG5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Mar 2011 17:06:57 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q4E1r-0001LR-HX; Mon, 28 Mar 2011 17:06:51 +0200
Message-Id: <20110328150330.110780523@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Mon, 28 Mar 2011 15:06:51 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [patch 0/3] mips: octeon: final tweaks
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

David,

I decided to move the state bits DISABLED, MASKED and INPROGRESS into
irq_data status. I need that for some other cleanups as well.

I added the masked check to the disabled check in the affinity
setters, so that should solve your problem hopefully.

Thanks,

	tglx
.
