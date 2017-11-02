Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 11:45:09 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:33792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993359AbdKBKo6ePz-I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 11:44:58 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B8961435;
        Thu,  2 Nov 2017 03:44:50 -0700 (PDT)
Received: from on-the-bus (on-the-bus.cambridge.arm.com [10.1.207.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AAB73F483;
        Thu,  2 Nov 2017 03:44:49 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] irqchip: mips-gic: Cleanups, fixes, prep for multi-cluster
In-Reply-To: <alpine.DEB.2.20.1711011758170.1942@nanos> (Thomas Gleixner's
        message of "Wed, 1 Nov 2017 17:59:23 +0100")
Organization: ARM Ltd
References: <867evc5cc9.fsf@arm.com>
        <20171031164151.6357-1-paul.burton@mips.com> <86efpi3lgj.fsf@arm.com>
        <20171101164047.4ascutd7tkoaxtjp@pburton-laptop>
        <alpine.DEB.2.20.1711011758170.1942@nanos>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Thu, 02 Nov 2017 10:44:47 +0000
Message-ID: <87h8udufhc.fsf@on-the-bus.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60660
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

On Wed, Nov 01 2017 at  5:59:23 pm GMT, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 1 Nov 2017, Paul Burton wrote:
>
>> Hi Marc,
>> 
>> On Wed, Nov 01, 2017 at 12:13:16AM +0000, Marc Zyngier wrote:
>> > On Tue, Oct 31 2017 at 9:41:43 am GMT, Paul Burton
>> > <paul.burton@mips.com> wrote:
>> > > This series continues cleaning & fixing up the MIPS GIC irqchip driver
>> > > whilst laying groundwork to support multi-cluster systems.
>> 
>> <SNIP>
>> 
>> > Are those targeting 4.14 or 4.15? It is getting quite late for the
>> > former, and it doesn't seem to cleanly apply on tip/irq/core (or my
>> > irqchip-4.15 branch) if that's for the latter (patch 6 shouts at me).
>> 
>> Whichever you're happiest with. If you'd like me to rebase them & resubmit
>> that's fine.
>> 
>> I see the conflict with patch 6 atop tip/irq/core - it's because tip/irq/core
>> is based upon v4.14-rc2 which doesn't have commit a08588ea486a
>> ("irqchip/mips-gic: Fix shifts to extract register fields") that went into
>> v4.14-rc3. The correct resolution is to keep the patches version of
>> things (ie.
>> delete the block of code).
>
> Marc, simply merge current linus into your branch with the reason:
>
>       Pick up upstream fixes so dependent patches apply

Fair enough. I've now merged -rc3 in my branch, and applied those
without a hitch.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
