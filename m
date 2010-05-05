Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 17:17:10 +0200 (CEST)
Received: from mail2.picochip.com ([82.111.145.34]:58961 "EHLO
        thurne.picochip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491927Ab0EEPRH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 17:17:07 +0200
Received: from localhost (wear.picochip.com [172.17.1.47])
        by thurne.picochip.com (8.13.8/8.13.8) with ESMTP id o45FGeiZ004274;
        Wed, 5 May 2010 16:16:40 +0100
Date:   Wed, 5 May 2010 16:18:25 +0100
From:   Jamie Iles <jamie.iles@picochip.com>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Subject: Re: [PATCH v3 4/4] MIPS: add support for hardware performance
        events
Message-ID: <20100505151825.GF5971@wear.picochip.com>
References: <1273067734-4758-1-git-send-email-dengcheng.zhu@gmail.com> <1273067734-4758-5-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1273067734-4758-5-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (thurne.picochip.com [172.17.0.105]); Wed, 05 May 2010 16:16:47 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.95.3 at thurne.picochip.com
X-Virus-Status: Clean
Return-Path: <jamie.iles@picochip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie.iles@picochip.com
Precedence: bulk
X-list: linux-mips

On Wed, May 05, 2010 at 09:55:34PM +0800, Deng-Cheng Zhu wrote:
> This patch is the HW perf event support. To enable this feature, we can
> not choose the SMTC kernel; Oprofile should be disabled; kernel
> performance events be selected. Then we can enable it in Kernel type menu.
> 
> Oprofile for MIPS platforms initializes irq at arch init time. Currently
> we do not change this logic to allow PMU reservation.
> 
> If a platform has EIC, we can use the irq base and perf counter irq
> offset defines for the interrupt controller in mipspmu_get_irq().
> 
> Besides generic hardware events and cache events, raw events are also
> supported by this patch. Please refer to processor core software user's
> manual and the comments for mipsxx_pmu_map_raw_event() for more details.

This looks good to me. I'm not familiar with MIPS so I can't offer many
comments in that respect but as a general question, is there a reason that
OProfile can't be enabled as well? In ARM we have a method to reserve the PMU
so that we can build both but only one can run at the same time. Recently,
Will Deacon has posted a patch series that makes OProfile use perf events
as the counter backend so you could even use both at the same time.

Jamie
