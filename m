Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 14:46:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36736 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993423AbdCaMq2Jk5SQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Mar 2017 14:46:28 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2VCkPWb031448;
        Fri, 31 Mar 2017 14:46:25 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2VCkO0T031447;
        Fri, 31 Mar 2017 14:46:24 +0200
Date:   Fri, 31 Mar 2017 14:46:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip/mips-gic: Fix Local compare interrupt
Message-ID: <20170331124624.GA26330@linux-mips.org>
References: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com>
 <1490958332-31094-3-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490958332-31094-3-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Mar 31, 2017 at 12:05:32PM +0100, Matt Redfearn wrote:

> Commit 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts") added
> mapping of several local interrupts during initialisation of the gic
> driver. This associates virq numbers with these interrupts.
> Unfortunately, as not all of the interrupts are mapped in hardware
> order, when drivers subsequently request these interrupts they conflict
> with the mappings that have already been set up. For example, this
> manifests itself in the gic clocksource driver, which fails to probe
> with the message:
> 
> clocksource: GIC: mask: 0xffffffffffffffff max_cycles: 0x7350c9738,
> max_idle_ns: 440795203769 ns
> GIC timer IRQ 25 setup failed: -22
> 
> This is because virq 25 (the correct IRQ number specified via device
> tree) was allocated to the PERFCTR interrupt (and 24 to the timer, 26 to
> the FDC). To fix this, map all of these local interrupts in the hardware
> order so as to associate their virq numbers with the correct hw
> interrupts.
> 
> Fixes: 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts")
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
