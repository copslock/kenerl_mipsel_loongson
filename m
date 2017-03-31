Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 11:02:44 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:33330 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993423AbdCaJCfIzFyq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 11:02:35 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ctsRK-0004SI-OI; Fri, 31 Mar 2017 11:01:50 +0200
Date:   Fri, 31 Mar 2017 11:02:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/5] MIPS/irqchip: Use IPI IRQ domains for CPU interrupt
 controller IPIs
In-Reply-To: <20170330190614.14844-1-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.20.1703311101340.1780@nanos>
References: <20170330190614.14844-1-paul.burton@imgtec.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57501
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

On Thu, 30 Mar 2017, Paul Burton wrote:

> This series introduces support for IPI IRQ domains to the CPU interrupt
> controller driver, allowing IPIs to function in the same way as those
> provided by the MIPS GIC as far as platform/board code is concerned.
> 
> Doing this allows us to avoid duplicating code across platforms, avoid
> having to handle cases where IPI domains are or aren't in use depending
> upon the interrupt controller, and strengthen a sanity check for cases
> where IPI IRQ domains are supported.

For the irqchip parts:

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Ralf, feel free to route the whole lot through your MIPS tree.

Thanks,

	tglx
