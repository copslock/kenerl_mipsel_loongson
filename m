Return-Path: <SRS0=PWkM=Q3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D9C10F0B
	for <linux-mips@archiver.kernel.org>; Wed, 20 Feb 2019 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9B52183F
	for <linux-mips@archiver.kernel.org>; Wed, 20 Feb 2019 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfBTOsF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:48:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59222 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfBTOsF (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 20 Feb 2019 09:48:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2FA15AB;
        Wed, 20 Feb 2019 06:48:04 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312643F5C1;
        Wed, 20 Feb 2019 06:47:59 -0800 (PST)
Date:   Wed, 20 Feb 2019 14:47:56 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v4 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
Message-ID: <20190220144756.GK7523@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <1550095217-12047-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550095217-12047-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Feb 13, 2019 at 05:00:16PM -0500, Waiman Long wrote:
> Currently, we have two different implementation of rwsem:
>  1) CONFIG_RWSEM_GENERIC_SPINLOCK (rwsem-spinlock.c)
>  2) CONFIG_RWSEM_XCHGADD_ALGORITHM (rwsem-xadd.c)
> 
> As we are going to use a single generic implementation for rwsem-xadd.c
> and no architecture-specific code will be needed, there is no point
> in keeping two different implementations of rwsem. In most cases, the
> performance of rwsem-spinlock.c will be worse. It also doesn't get all
> the performance tuning and optimizations that had been implemented in
> rwsem-xadd.c over the years.
> 
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.
> 
> All references to RWSEM_GENERIC_SPINLOCK and RWSEM_XCHGADD_ALGORITHM
> in the code are removed.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/alpha/Kconfig              |   7 -
>  arch/arc/Kconfig                |   3 -
>  arch/arm/Kconfig                |   4 -
>  arch/arm64/Kconfig              |   3 -
>  arch/c6x/Kconfig                |   3 -
>  arch/csky/Kconfig               |   3 -
>  arch/h8300/Kconfig              |   3 -
>  arch/hexagon/Kconfig            |   6 -
>  arch/ia64/Kconfig               |   4 -
>  arch/m68k/Kconfig               |   7 -
>  arch/microblaze/Kconfig         |   6 -
>  arch/mips/Kconfig               |   7 -
>  arch/nds32/Kconfig              |   3 -
>  arch/nios2/Kconfig              |   3 -
>  arch/openrisc/Kconfig           |   6 -
>  arch/parisc/Kconfig             |   6 -
>  arch/powerpc/Kconfig            |   7 -
>  arch/riscv/Kconfig              |   3 -
>  arch/s390/Kconfig               |   6 -
>  arch/sh/Kconfig                 |   6 -
>  arch/sparc/Kconfig              |   8 -
>  arch/unicore32/Kconfig          |   6 -
>  arch/x86/Kconfig                |   3 -
>  arch/x86/um/Kconfig             |   6 -
>  arch/xtensa/Kconfig             |   3 -
>  include/linux/rwsem-spinlock.h  |  47 ------
>  include/linux/rwsem.h           |   5 -
>  kernel/Kconfig.locks            |   2 +-
>  kernel/locking/Makefile         |   4 +-
>  kernel/locking/rwsem-spinlock.c | 339 ----------------------------------------
>  kernel/locking/rwsem.h          |   3 -
>  31 files changed, 2 insertions(+), 520 deletions(-)
>  delete mode 100644 include/linux/rwsem-spinlock.h
>  delete mode 100644 kernel/locking/rwsem-spinlock.c

Another nice cleanup, and it looks like the optimistic spinning in the xadd
implementation is predicated on ARCH_SUPPORTS_ATOMIC_RMW, so we're all good
there too.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
