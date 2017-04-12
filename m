Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2017 23:14:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59954 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993930AbdDLVOfU99NF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Apr 2017 23:14:35 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3CLEWH4005826;
        Wed, 12 Apr 2017 23:14:33 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3CLEV4U005825;
        Wed, 12 Apr 2017 23:14:32 +0200
Date:   Wed, 12 Apr 2017 23:14:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/5] MIPS/irqchip: Use IPI IRQ domains for CPU interrupt
 controller IPIs
Message-ID: <20170412211431.GB31446@linux-mips.org>
References: <20170330190614.14844-1-paul.burton@imgtec.com>
 <alpine.DEB.2.20.1703311101340.1780@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703311101340.1780@nanos>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57682
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

On Fri, Mar 31, 2017 at 11:02:33AM +0200, Thomas Gleixner wrote:

> On Thu, 30 Mar 2017, Paul Burton wrote:
> 
> > This series introduces support for IPI IRQ domains to the CPU interrupt
> > controller driver, allowing IPIs to function in the same way as those
> > provided by the MIPS GIC as far as platform/board code is concerned.
> > 
> > Doing this allows us to avoid duplicating code across platforms, avoid
> > having to handle cases where IPI domains are or aren't in use depending
> > upon the interrupt controller, and strengthen a sanity check for cases
> > where IPI IRQ domains are supported.
> 
> For the irqchip parts:
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Ralf, feel free to route the whole lot through your MIPS tree.

Done.

Nice cleanup, Paul.

  Ralf
