Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 01:13:40 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:46890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991940AbdKAANcehgLU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Nov 2017 01:13:32 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DD0280D;
        Tue, 31 Oct 2017 17:13:24 -0700 (PDT)
Received: from zomby-woof (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C733F3E1;
        Tue, 31 Oct 2017 17:13:23 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] irqchip: mips-gic: Cleanups, fixes, prep for multi-cluster
In-Reply-To: <20171031164151.6357-1-paul.burton@mips.com> (Paul Burton's
        message of "Tue, 31 Oct 2017 09:41:43 -0700")
Organization: ARM Ltd
References: <867evc5cc9.fsf@arm.com>
        <20171031164151.6357-1-paul.burton@mips.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Wed, 01 Nov 2017 00:13:16 +0000
Message-ID: <86efpi3lgj.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On Tue, Oct 31 2017 at  9:41:43 am GMT, Paul Burton <paul.burton@mips.com> wrote:
> This series continues cleaning & fixing up the MIPS GIC irqchip driver
> whilst laying groundwork to support multi-cluster systems.
>
> Patch 1 refactors in order to reduce some duplication and prepare us for
> the following patches.
>
> Patches 2-4 move per-CPU GIC configuration away from being performed all
> at once when the driver is probed or when interrupts are masked &
> unmasked, instead performing configuration as CPUs are brought online.
> This allows us to support reconfiguring after clusters are powered down
> & back up, generally cleans up and fixes bugs in the process.
>
> Patch 5 makes use of num_possible_cpus() to reserve IPIs, rather than
> the gic_vpes variable. This prepares us for multi-cluster in which
> gic_vpes is mostly meaningless since it only reflects the local cluster,
> and it generally makes more sense to use the more standard
> num_possible_cpus().
>
> Patch 6 removes the now unused gic_vpes variable.
>
> Patch 7 is a general clean up but also prepares us for later patches as
> described in its commit message.
>
> Patch 8 is a general clean up marking some variables static.
>
> This series by itself continues along the path towards supporting
> multi-cluster systems such as the MIPS I6500, but does not yet get us
> the whole way there. If you wish to see my current work in progress
> which builds out multi-cluster support atop these patches then that can
> be found in the multicluster branch of:
>
>   git://git.linux-mips.org/pub/scm/paul/linux.git
>
> Or browsed at:
>
>   https://git.linux-mips.org/cgit/paul/linux.git/log/?h=multicluster
>
> This series applies cleanly atop v4.14-rc7.

Are those targeting 4.14 or 4.15? It is getting quite late for the
former, and it doesn't seem to cleanly apply on tip/irq/core (or my
irqchip-4.15 branch) if that's for the latter (patch 6 shouts at me).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
