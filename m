Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2012 17:10:12 +0100 (CET)
Received: from g1t0026.austin.hp.com ([15.216.28.33]:24460 "EHLO
        g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822668Ab2KZQKHYoAGy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2012 17:10:07 +0100
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
        by g1t0026.austin.hp.com (Postfix) with ESMTP id F1795DF3A;
        Mon, 26 Nov 2012 16:09:58 +0000 (UTC)
Received: from [10.152.0.190] (swa01cs003-da01.atlanta.hp.com [16.114.29.153])
        by g1t0038.austin.hp.com (Postfix) with ESMTP id 167F23037C;
        Mon, 26 Nov 2012 16:09:51 +0000 (UTC)
Message-ID: <1353946190.2917.5.camel@lorien2>
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
From:   Shuah Khan <shuah.khan@hp.com>
Reply-To: shuah.khan@hp.com
To:     Joerg Roedel <joro@8bytes.org>
Cc:     a-jacquiot@ti.com, fenghua.yu@intel.com, catalin.marinas@arm.com,
        lethal@linux-sh.org, benh@kernel.crashing.org, ralf@linux-mips.org,
        tony.luck@intel.com, davem@davemloft.net, m.szyprowski@samsung.com,
        msalter@redhat.com, monstr@monstr.eu,
        Ming Lei <ming.lei@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        shuahkhan@gmail.com
Date:   Mon, 26 Nov 2012 09:09:50 -0700
In-Reply-To: <20121126112217.GG25742@8bytes.org>
References: <1353706142.5270.93.camel@lorien2>
         <20121126112217.GG25742@8bytes.org>
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 35128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shuah.khan@hp.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 2012-11-26 at 12:22 +0100, Joerg Roedel wrote:
> Hi Shuah,
> 
> On Fri, Nov 23, 2012 at 02:29:02PM -0700, Shuah Khan wrote:
> > x86 - done in the first patch that added the feature.
> > 
> > ARM64: dma_debug: add debug_dma_mapping_error support
> > c6x: dma_debug: add debug_dma_mapping_error support
> > ia64: dma_debug: add debug_dma_mapping_error support
> > microblaze: dma-mapping: support debug_dma_mapping_error
> > mips: dma_debug: add debug_dma_mapping_error support
> > powerpc: dma_debug: add debug_dma_mapping_error support
> > sh: dma_debug: add debug_dma_mapping_error support
> > sparc: dma_debug: add debug_dma_mapping_error support
> > tile: dma_debug: add debug_dma_mapping_error support
> 
> Have you compile-tested the invididual archs you are changing here?
> 

Joerg,

Yes I compile tested all of them (except microblaze) on Nov 20th
linux_next git. The patch for microblaze is already in linux_next when I
tried to apply the patch to Nov 20th linux-next and figured that is
already covered and skipped that one.

-- Shuah
