Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 23:12:08 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:35567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816877AbaCDWMGtqRxr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 23:12:06 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1WKxZA-0005qj-Da; Tue, 04 Mar 2014 23:12:00 +0100
Date:   Tue, 4 Mar 2014 23:12:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] sched: Remove unused mc_capable() and
 smt_capable()
In-Reply-To: <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.02.1403042311480.18573@ionos.tec.linutronix.de>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39413
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



On Tue, 4 Mar 2014, Bjorn Helgaas wrote:

> Remove mc_capable() and smt_capable().  Neither is used.
> 
> Both were added by 5c45bf279d37 ("sched: mc/smt power savings sched
> policy").  Uses of both were removed by 8e7fbcbc22c1 ("sched: Remove stale
> power aware scheduling remnants and dysfunctional knobs").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm/include/asm/topology.h      |    3 ---
>  arch/ia64/include/asm/topology.h     |    1 -
>  arch/mips/include/asm/topology.h     |    4 ----
>  arch/powerpc/include/asm/topology.h  |    1 -
>  arch/sparc/include/asm/topology_64.h |    2 --
>  arch/x86/include/asm/topology.h      |    6 ------
>  6 files changed, 17 deletions(-)

Acked-by: Thomas Gleixner <tglx@linutronix.de>
