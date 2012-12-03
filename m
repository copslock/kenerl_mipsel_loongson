Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2012 09:52:14 +0100 (CET)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:50239 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823123Ab2LCIwF4SZq8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Dec 2012 09:52:05 +0100
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MEG009JZ61DGE30@mailout4.w1.samsung.com>; Mon,
 03 Dec 2012 08:54:43 +0000 (GMT)
X-AuditID: cbfec7f4-b7f6d6d000001620-16-50bc682c1d78
Received: from eusync2.samsung.com ( [203.254.199.212])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id DE.E8.05664.C286CB05; Mon,
 03 Dec 2012 08:51:56 +0000 (GMT)
Received: from [127.0.0.1] ([106.116.147.30])
 by eusync2.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0MEG00IUH5YHQ700@eusync2.samsung.com>; Mon,
 03 Dec 2012 08:51:56 +0000 (GMT)
Message-id: <50BC6829.4060205@samsung.com>
Date:   Mon, 03 Dec 2012 09:51:53 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-version: 1.0
To:     Joerg Roedel <joro@8bytes.org>
Cc:     shuah.khan@hp.com, a-jacquiot@ti.com, fenghua.yu@intel.com,
        catalin.marinas@arm.com, lethal@linux-sh.org,
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
References: <1353706142.5270.93.camel@lorien2> <50B34B0F.3080204@samsung.com>
 <20121202140644.GP30633@8bytes.org>
In-reply-to: <20121202140644.GP30633@8bytes.org>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4FV2djD0BBrtv8FhMmDqJ3eLSHhUH
        Jo+jK9cyBTBGcdmkpOZklqUW6dslcGUsXZ5W8IWt4vDcm2wNjPtYuxg5OCQETCSu3XbrYuQE
        MsUkLtxbz9bFyMUhJLCUUWLTllvsEE4zk8SWFc/ZQKp4BbQkfh36zw5iswioSqzomMkKYrMJ
        GEp0ve0CqxEV8JWY9usaE0S9oMSPyfdYQGwRASWJ659bweqZBU6xSDSccgexhQVKJTp+P2MG
        sYUEiiXavl5nAjmOU8BA4sGbWohyM4lHLeuYIWx5ic1r3jJPYBSYhWTDLCRls5CULWBkXsUo
        mlqaXFCclJ5rqFecmFtcmpeul5yfu4kREoZfdjAuPmZ1iFGAg1GJh/fBl90BQqyJZcWVuYcY
        JTiYlUR4o6z3BAjxpiRWVqUW5ccXleakFh9iZOLglGpgbFvhtyftHUP+pL+HRJ8odtlEZi++
        Kfmiv+yDoWjZs2dX7hg5ObJxht0W7zpQvqVy8aSNc77s5TpuLWDEEewnrSH85pnHjGh1jpQd
        PxpVLP4aScyemxW1cpK0cT63WLB47Z0Nv3OLRW4Kle7blHgh+p7/jqDX0qbb7sVsXfY7XGXd
        Jf3VmxS6lViKMxINtZiLihMBAT1oLCECAAA=
X-archive-position: 35170
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


On 12/2/2012 3:06 PM, Joerg Roedel wrote:
> Hi Marek,
>   
> On Mon, Nov 26, 2012 at 11:57:19AM +0100, Marek Szyprowski wrote:
>
> > I've took all the patches to the next-dma-debug branch in my tree, I sorry
> > that You have to wait so long for it. My branch is based on Joerg's
> > dma-debug branch and I've included it for testing in linux-next branch.
>
> The patches are now two times in next. One version from my tree and one
> from yours. Please remove the version from your tree, the patches should
> go upstream via my dma-debug branch.

Ok, I've removed them from my dma-mapping-next tree. Please add/cherry-pick
the missing patch for ARM architecture, which I've accidentally already
pushed to mainline some time ago and then reverted. See commit
871ae57adc5ed092 (and 697575896670ba).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
