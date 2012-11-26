Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2012 11:57:31 +0100 (CET)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:26119 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821443Ab2KZK53VPYIj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2012 11:57:29 +0100
Received: from eusync1.samsung.com (mailout3.w1.samsung.com [210.118.77.13])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0ME300F78D4ATY80@mailout3.w1.samsung.com>; Mon,
 26 Nov 2012 10:57:46 +0000 (GMT)
Received: from [127.0.0.1] ([106.116.147.30])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0ME300GISD3JE210@eusync1.samsung.com>; Mon,
 26 Nov 2012 10:57:22 +0000 (GMT)
Message-id: <50B34B0F.3080204@samsung.com>
Date:   Mon, 26 Nov 2012 11:57:19 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-version: 1.0
To:     shuah.khan@hp.com
Cc:     Joerg Roedel <joro@8bytes.org>, a-jacquiot@ti.com,
        fenghua.yu@intel.com, catalin.marinas@arm.com, lethal@linux-sh.org,
        benh@kernel.crashing.org, ralf@linux-mips.org, tony.luck@intel.com,
        davem@davemloft.net, msalter@redhat.com, monstr@monstr.eu,
        Ming Lei <ming.lei@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        shuahkhan@gmail.com
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
References: <1353706142.5270.93.camel@lorien2>
In-reply-to: <1353706142.5270.93.camel@lorien2>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
X-TM-AS-MML: No
X-archive-position: 35125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
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

Hello,

On 11/23/2012 10:29 PM, Shuah Khan wrote:
> An earlier patch added dma mapping error debug feature to dma_debug
> infrastructure. References:
>
> https://lkml.org/lkml/2012/10/8/296
> https://lkml.org/lkml/2012/11/3/219
>
> The following series of patches adds the call to debug_dma_mapping_error() to
> architecture specific dma_mapping_error() interfaces on the following
> architectures that support CONFIG_DMA_API_DEBUG.

I've took all the patches to the next-dma-debug branch in my tree, I sorry
that You have to wait so long for it. My branch is based on Joerg's
dma-debug branch and I've included it for testing in linux-next branch.

Joerg: would You mind if I handle pushing the whole branch to v3.8
via my kernel tree? Those changes should be kept close together to
avoid build breaks for bisecting.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
