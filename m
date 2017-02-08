Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 15:17:08 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:53808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991359AbdBHORAcjEmQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Feb 2017 15:17:00 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A69DF1576;
        Wed,  8 Feb 2017 06:16:53 -0800 (PST)
Received: from on-the-bus.cambridge.arm.com (on-the-bus.cambridge.arm.com [10.1.31.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934723F242;
        Wed,  8 Feb 2017 06:16:52 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/1] irqchip/mips-gic: Fix local interrupts
In-Reply-To: <1485353305-23672-1-git-send-email-marcin.nowakowski@imgtec.com>
        (Marcin Nowakowski's message of "Wed, 25 Jan 2017 15:08:25 +0100")
Organization: ARM Ltd
References: <1485353305-23672-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Date:   Wed, 08 Feb 2017 14:16:45 +0000
Message-ID: <8737fo938y.fsf@on-the-bus.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56733
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

On Wed, Jan 25 2017 at  2:08:25 pm GMT, Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:
> Some local interrupts are not initialised properly at the moment and
> cannot be used since the domain's alloc method is never called for them.
>
> This has been observed earlier and partially fixed in commit
> e875bd66dfb ("irqchip/mips-gic: Fix local interrupts"), but that change
> still relied on the interrupt to be requested by an external driver (eg.
> drivers/clocksource/mips-gic-timer.c).
>
> This does however not solve the issue for interrupts that are not
> referenced by any driver through the device tree and results in
> request_irq() calls returning -ENOSYS. It can be observed when attempting
> to use perf tool to access hardware performance counters.
>
> Fix this by explicitly calling irq_create_fwspec_mapping() for local
> interrupts.
>
> Fixes: e875bd66dfb ("irqchip/mips-gic: Fix local interrupts")
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-mips@linux-mips.org

Queued, thanks.

	M.
-- 
Jazz is not dead, it just smell funny.
