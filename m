Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2012 12:22:21 +0100 (CET)
Received: from 8bytes.org ([85.214.48.195]:35224 "EHLO mail.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823017Ab2KZLWVEDOUv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Nov 2012 12:22:21 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.8bytes.org (Postfix) with SMTP id 8428512B07B
        for <linux-mips@linux-mips.org>; Mon, 26 Nov 2012 12:22:20 +0100 (CET)
Received: by mail.8bytes.org (Postfix, from userid 1000)
        id 1BAE112AFBA; Mon, 26 Nov 2012 12:22:18 +0100 (CET)
Date:   Mon, 26 Nov 2012 12:22:17 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Shuah Khan <shuah.khan@hp.com>
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
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
Message-ID: <20121126112217.GG25742@8bytes.org>
References: <1353706142.5270.93.camel@lorien2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353706142.5270.93.camel@lorien2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-DSPAM-Result: Whitelisted
X-DSPAM-Processed: Mon Nov 26 12:22:20 2012
X-DSPAM-Confidence: 0.9989
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 50b350ec22971206812616
X-archive-position: 35127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joro@8bytes.org
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

Hi Shuah,

On Fri, Nov 23, 2012 at 02:29:02PM -0700, Shuah Khan wrote:
> x86 - done in the first patch that added the feature.
> 
> ARM64: dma_debug: add debug_dma_mapping_error support
> c6x: dma_debug: add debug_dma_mapping_error support
> ia64: dma_debug: add debug_dma_mapping_error support
> microblaze: dma-mapping: support debug_dma_mapping_error
> mips: dma_debug: add debug_dma_mapping_error support
> powerpc: dma_debug: add debug_dma_mapping_error support
> sh: dma_debug: add debug_dma_mapping_error support
> sparc: dma_debug: add debug_dma_mapping_error support
> tile: dma_debug: add debug_dma_mapping_error support

Have you compile-tested the invididual archs you are changing here?


	Joerg
