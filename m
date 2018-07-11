Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 11:43:14 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:36428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993577AbeGKJnEhGTL4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 11:43:04 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7535E1682;
        Wed, 11 Jul 2018 02:42:57 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 466CD3F318;
        Wed, 11 Jul 2018 02:42:57 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4F4891AE3828; Wed, 11 Jul 2018 10:43:39 +0100 (BST)
Date:   Wed, 11 Jul 2018 10:43:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180711094338.GD13963@arm.com>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
 <20180710093637.GF2476@hirez.programming.kicks-ass.net>
 <20180710105437.GT2512@hirez.programming.kicks-ass.net>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_26F8B9E004D4512B2225FCE1@qq.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

Hi Huacai,

On Tue, Jul 10, 2018 at 07:45:22PM +0800, 陈华才 wrote:
> I don't think this is a hardware bug, in design, SFB will flushed to L1
> cache in three cases:
> 1, data in SFB is full (be a complete cache line);
> 2, there is a subsequent read access in the same cache line;
> 3, a 'sync' instruction is executed.

I'd expect successful LL/SC, cache maintenance (and potentially TLB)
operations to flush your SFB as well, not that I think that provides a
better workaround than throwing a 'sync' into cpu_relax(). I assume the
SFB is all physically addressed?

Generally, CPU architectures guarantee that store buffers drain "in finite
time" which is a pretty crappy guarantee, but one which tends to be
sufficient in practice and therefore relied upon by software.

Will
