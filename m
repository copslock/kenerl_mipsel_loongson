Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 00:05:44 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:62127 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835256Ab3FQWFiQvox0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 00:05:38 +0200
Received: by mail-wi0-f169.google.com with SMTP id c10so4567030wiw.4
        for <multiple recipients>; Mon, 17 Jun 2013 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kMGOebklZEknusMPkJ5QKnnuKfiDwrPJ3wUIZwXQy7Y=;
        b=Mr6U2/x348e5fvZvBmAyTIP8s2uNKktlSZ5CUGfmexyPA3YtsZkLOEOOXAoSGmT4Cu
         22xkt2iAqeL6vMpDTGE74+XCKVVXns0+1/pwUaBLZCv1CQ8nORDyYT1lHcERECN3qbvg
         m8GqjzkkEftv4McXfjDR1NR458TNdKlzXokrpf0p8WwJQuHiW8HKCLsOwHF6CDyoZJEX
         PmCm9CNnGdFqzSqZs/5WGaHg68psTO8a9pd7eNjJleszas5ZUQIhMF0THxFv37Q1dw96
         oqC1fkSZRWGYj5z0p0SytzV6sqRcwdte79sM2wBOc3kGHyticQvR1Do9+NL25zDkEOdR
         v2DA==
X-Received: by 10.180.93.136 with SMTP id cu8mr6032860wib.49.1371506732869;
 Mon, 17 Jun 2013 15:05:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.133.74 with HTTP; Mon, 17 Jun 2013 15:05:02 -0700 (PDT)
In-Reply-To: <1371496390-16088-2-git-send-email-paul.gortmaker@windriver.com>
References: <1371496390-16088-1-git-send-email-paul.gortmaker@windriver.com> <1371496390-16088-2-git-send-email-paul.gortmaker@windriver.com>
From:   Paul Gortmaker <paul.gortmaker@gmail.com>
Date:   Mon, 17 Jun 2013 18:05:02 -0400
Message-ID: <CAP=VYLp-6EtLCob0a_OCTeaSaSHLx3UPjY9_0GeCWLmzgrrLUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mips: delete __cpuinit usage from all remaining MIPS users
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@gmail.com
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

On Mon, Jun 17, 2013 at 3:13 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> The __cpuinit type of throwaway sections might have made sense
> some time ago when RAM was more constrained, but now the savings
> do not offset the cost and complications.  For example, the fix in
> commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> is a good example of the nasty type of bugs that can be created
> with improper use of the various __init prefixes.
>
> After a discussion on LKML[1] it was decided that cpuinit should go
> the way of devinit and be phased out.  Once all the users are gone,
> we can then finally remove the macros themselves from linux/init.h.
>
> This removes all the remaining MIPS users of the __cpuinit macros.

This is missing dealing with the __CPUINIT in asm files, which can
lead to section mismatches.  I'll squish these two patches together,
deal with __CPUINIT (all in one patch so it is an atomic change) and
resend...  sorry for the noise.

Paul.
---

>
> [1] https://lkml.org/lkml/2013/5/20/589
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/mips/ath79/setup.c               |   2 +-
>  arch/mips/cavium-octeon/octeon-irq.c  |  12 +--
>  arch/mips/cavium-octeon/smp.c         |   6 +-
>  arch/mips/kernel/cevt-bcm1480.c       |   2 +-
>  arch/mips/kernel/cevt-gic.c           |   2 +-
>  arch/mips/kernel/cevt-r4k.c           |   2 +-
>  arch/mips/kernel/cevt-sb1250.c        |   2 +-
>  arch/mips/kernel/cevt-smtc.c          |   2 +-
>  arch/mips/kernel/cpu-bugs64.c         |   2 +-
>  arch/mips/kernel/cpu-probe.c          |  14 ++--
>  arch/mips/kernel/smp-bmips.c          |   6 +-
>  arch/mips/kernel/smp-mt.c             |   6 +-
>  arch/mips/kernel/smp-up.c             |   6 +-
>  arch/mips/kernel/smp.c                |   6 +-
>  arch/mips/kernel/smtc.c               |   2 +-
>  arch/mips/kernel/spram.c              |  14 ++--
>  arch/mips/kernel/sync-r4k.c           |  12 +--
>  arch/mips/kernel/traps.c              |  12 +--
>  arch/mips/kernel/watch.c              |   2 +-
>  arch/mips/lantiq/irq.c                |   2 +-
>  arch/mips/lib/uncached.c              |   2 +-
>  arch/mips/mm/c-octeon.c               |   6 +-
>  arch/mips/mm/c-r3k.c                  |   8 +-
>  arch/mips/mm/c-r4k.c                  |  34 ++++----
>  arch/mips/mm/c-tx39.c                 |   2 +-
>  arch/mips/mm/cache.c                  |   2 +-
>  arch/mips/mm/page.c                   |  40 +++++-----
>  arch/mips/mm/sc-ip22.c                |   2 +-
>  arch/mips/mm/sc-mips.c                |   2 +-
>  arch/mips/mm/sc-r5k.c                 |   2 +-
>  arch/mips/mm/sc-rm7k.c                |  12 +--
>  arch/mips/mm/tlb-r3k.c                |   2 +-
>  arch/mips/mm/tlb-r4k.c                |   4 +-
>  arch/mips/mm/tlb-r8k.c                |   4 +-
>  arch/mips/mm/tlbex.c                  | 144 ++++++++++++++++------------------
>  arch/mips/mti-malta/malta-smtc.c      |   6 +-
>  arch/mips/mti-malta/malta-time.c      |   2 +-
>  arch/mips/mti-sead3/sead3-time.c      |   2 +-
>  arch/mips/netlogic/common/smp.c       |   4 +-
>  arch/mips/netlogic/common/time.c      |   2 +-
>  arch/mips/netlogic/xlr/wakeup.c       |   2 +-
>  arch/mips/pci/pci-ip27.c              |   2 +-
>  arch/mips/pmcs-msp71xx/msp_smtc.c     |   7 +-
>  arch/mips/pmcs-msp71xx/msp_time.c     |   2 +-
>  arch/mips/pnx833x/common/interrupts.c |   2 +-
>  arch/mips/powertv/time.c              |   2 +-
>  arch/mips/ralink/irq.c                |   2 +-
>  arch/mips/sgi-ip27/ip27-init.c        |   4 +-
>  arch/mips/sgi-ip27/ip27-smp.c         |   6 +-
>  arch/mips/sgi-ip27/ip27-timer.c       |   6 +-
>  arch/mips/sgi-ip27/ip27-xtalk.c       |   6 +-
>  arch/mips/sibyte/bcm1480/smp.c        |   8 +-
>  arch/mips/sibyte/sb1250/smp.c         |   8 +-
>  53 files changed, 221 insertions(+), 232 deletions(-)
>
