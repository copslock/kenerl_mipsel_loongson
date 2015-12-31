Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2015 20:44:00 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:40639 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013998AbbLaTn6P7Tpc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Dec 2015 20:43:58 +0100
Received: from localhost (unknown [38.140.131.194])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 485EB58053A;
        Thu, 31 Dec 2015 11:43:51 -0800 (PST)
Date:   Thu, 31 Dec 2015 14:43:47 -0500 (EST)
Message-Id: <20151231.144347.54643465516219979.davem@davemloft.net>
To:     mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, andrew.cooper3@citrix.com,
        virtualization@lists.linux-foundation.org,
        stefano.stabellini@eu.citrix.com, tglx@linutronix.de,
        mingo@elte.hu, hpa@zytor.com, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, mingo@kernel.org,
        ralf@linux-mips.org, andreyknvl@google.com
Subject: Re: [PATCH v2 07/32] sparc: reuse asm-generic/barrier.h
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1451572003-2440-8-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
        <1451572003-2440-8-git-send-email-mst@redhat.com>
X-Mailer: Mew version 6.6 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 31 Dec 2015 11:43:53 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 31 Dec 2015 21:06:38 +0200

> On sparc 64 bit dma_rmb, dma_wmb, smp_store_mb, smp_mb, smp_rmb,
> smp_wmb, read_barrier_depends and smp_read_barrier_depends match the
> asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
> 
> nop uses __asm__ __volatile but is otherwise identical to
> the generic version, drop that as well.
> 
> This is in preparation to refactoring this code area.
> 
> Note: nop() was in processor.h and not in barrier.h as on other
> architectures. Nothing seems to depend on it being there though.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
