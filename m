Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 21:07:57 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:43658 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVTHycwF4P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 21:07:54 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZeSus-0002YC-PQ; Tue, 22 Sep 2015 21:07:50 +0200
Date:   Tue, 22 Sep 2015 21:07:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/3] MIPS GIC fixes
In-Reply-To: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.11.1509222106100.5606@nanos>
References: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49330
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

On Tue, 22 Sep 2015, Paul Burton wrote:

> This series fixes a couple of problems with the MIPS GIC support,
> impacting systems with the 64 bit CM3 and those with multithreading and
> non-contiguous numbering for VP(E)s across cores.
> 
> Paul Burton (3):
>   MIPS: CM: provide a function to map from CPU to VP ID
>   irqchip: mips-gic: convert CPU numbers to VP IDs
>   irqchip: mips-gic: fix pending & mask reads for MIPS64 with 32b GIC

I assume that's a bugfix scheduled for 4.3.

Ralf, if so, please ship it through the MIPS tree with my Acked-by for
the irqchip parts.

Thanks,

	tglx
