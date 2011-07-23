Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 14:41:31 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60684 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491155Ab1GWMlX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 14:41:23 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QkbWE-0003ua-Pn; Sat, 23 Jul 2011 14:41:22 +0200
Message-Id: <20110723123948.573545817@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sat, 23 Jul 2011 12:41:22 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 0/7] MIPS: Assorted fixlets and annotation patches
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16783

Ralf,

the following series is the fallout of the 3.0-rt work for MIPS.

The first 3 patches are bug fixes, the last 3 annotations for spin
locks and interrupts which want to be marked NO_THREAD.

There is one bug remaining, which I currently worked around by
disabling the dynamic ftrace functionality.

When the tracer starts up then ftrace_dyn_arch_init() is called with
interrupts disabled, but the MIPS code issues a SMP function call
which complains about interrupts being disabled. Observed on SWARM.

Thanks,

	tglx
