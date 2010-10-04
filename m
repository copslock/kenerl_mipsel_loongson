Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2010 21:33:32 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:51504 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491058Ab0JDTda (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Oct 2010 21:33:30 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1000)
        id 5AD8D4432D; Mon,  4 Oct 2010 20:33:29 +0100 (BST)
Date:   Mon, 4 Oct 2010 20:33:29 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Subject: Re: [PATCH v7 0/6] MIPS performance event support v7
Message-ID: <20101004193329.GF1670@console-pimps.org>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <matt@console-pimps.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 30, 2010 at 05:09:14PM +0800, Deng-Cheng Zhu wrote:
> o Remove function code from pmu.h, keep them duplicated in Oprofile and
> Perf-events. The duplication would be resolved by the idea of using
> Perf-events as the Oprofile backend. I'll submit a separate patchset to
> do this after this one gets merged.

I dunno if you're aware of this but I've been working on a perf
backend for OProfile. Currently only ARM and SH are making use of it,

http://marc.info/?l=linux-arm-kernel&m=128435815708349&w=2

It would be trivial to add MIPS support but I suspect that would
require you to rework this patch series. However, what we should try
to avoid is duplicating any effort of getting perf and OProfile
working together.

Would you mind waiting for my patch series to be merged before
starting work on your perf-OProfile patchset for MIPS? Alternatively,
you can base your work on,

git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/sh-2.6.git perf-oprofile
