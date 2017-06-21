Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 15:33:03 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43474 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbdFUNcuCdZdu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jun 2017 15:32:50 +0200
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ORW0068RGAIB230@mailout2.w1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 21 Jun 2017 14:32:42 +0100 (BST)
Received: from eusmges1.samsung.com (unknown [203.254.199.239])
 by     eucas1p1.samsung.com (KnoxPortal)
 with ESMTP id  20170621133241eucas1p19ba15a87ee98641b2124e616d7b3bec9~KJlJ-72G-3072330723eucas1p1z;
        Wed, 21 Jun 2017 13:32:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206])
 by     eusmges1.samsung.com  (EUCPMTA) with SMTP id 9C.0B.14140.C757A495; Wed,
 21     Jun 2017 14:32:44 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179])
 by     eucas1p1.samsung.com (KnoxPortal)
 with ESMTP id  20170621133241eucas1p10a6aafde2f46c8e79c4bcc35e942740f~KJlJSUH9L0240902409eucas1p1X;
        Wed, 21 Jun 2017 13:32:41 +0000 (GMT)
X-AuditID: cbfec7ef-f796a6d00000373c-c8-594a757c22c0
Received: from eusync4.samsung.com ( [203.254.199.214])
 by     eusmgms1.samsung.com (EUCPMTA) with SMTP id 8D.DE.17452.8757A495; Wed,
 21     Jun 2017 14:32:41 +0100 (BST)
Received: from [106.116.147.30] by eusync4.samsung.com
 (Oracle        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with   ESMTPA id <0ORW001OFGAG5Q90@eusync4.samsung.com>; Wed,
 21 Jun 2017 14:32:40   +0100 (BST)
Subject: Re: new dma-mapping tree,
 was Re: clean up and modularize arch dma_mapping interface V2
To:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
Date:   Wed, 21 Jun 2017 15:32:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.2.0
MIME-version: 1.0
In-reply-to: <20170620131623.GB30769@lst.de>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9tZ6NTp2X5YGW18otdhYKX7E4fTkkUFunKqJUHldRqZ4uy
        IC9ZTiNHJo45SCPKNFHmJZmt8pJWphUucVFGV8trmdlVae6s8NvveZ/n/3/f/8PLkupSJoCN
        SzSI+kRdvIZRUdVNP9sWnzRu1i7Lz1XiktxRGru+DTL4esk9AhfcCcWtqX0KbH/bQePGfDOB
        B0/XMPhzxgCN2x02BptzLyiwuTCNxJbHtwls+3ORxKZhq0ffWqrAv7+P0bipYAa2m9oZXOV8
        psDJD4po/OZ8vwL/KH9L4++VOcQ6EFI6OxnBXmxihBp7LyHct/ymhHvXSwnhY91NUniV1UwI
        FVdOCWXl1UjI6byGhMeWQiQ0fHZRQq07mRHOVxYj4as9cNuUXapV0WJ83FFRv3TNPlWsxXyX
        Omxjj7V+aSKTURuTiZQs8Mvh9YCbkHkGPOkq85yrWDV/FYH5bDuSi68IWu47/iv6uguo/1PO
        l6mEXHQjqH3R5fWaxu+H27aL1Dj78WHgML2kx4dI3kmDK6WRHm8wfAhk9md6bTl+DTwaHfWK
        KT4Isgs7yHGezkdBtqOIkGemwo+cLq+pkl8EDVfyvFqSXwkfxtJpmedAxY1+UmZ/SEt3e58K
        /DAL77LyPQLWU8wG+11Sxo3Q4g6Qk02DnuZKhcyzwJRR59tLNoLU9IUyWxC09XMyh0JD81Pf
        tZPhQnWez5KDjDNqeUSAkfQRn816eFUy5NvVkMemw6Ywo7nWCcmsE9JYJ6SxTkhTgKhi5Cca
        pYQYUQpZIukSJGNizJIDhxLsyPOJW8aaB2vQ+7Qd9YhnkWYSFzl/k1ZN645KxxPqEbCkxo9r
        M2zWqrlo3fEkUX9or94YL0r1aCZLafw57mFHpJqP0RnEg6J4WNT/6xKsMiAZid1r3Slzfl7L
        e0Zsehc1krT4dfAOV8/2phcO9a9vCy6Fp1UNRcXuCexzdg5EStGleUe29t5yr6ZSyj/lzN6p
        4iMCubra7fotyhWGwJURJZcNvV+MkY17XP64JyxuwxPTvqTdYUXz2L7wE9rWIOOt4XNdGbMe
        rZr80LI2NCtiZtHzIA0lxepCgkm9pPsL3P2WucADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsVy+t/xa7qVpV6RBjfPMFqsnvqX1eLK1/ds
        FitXH2WyWLDf2uJs0xt2i02Pr7FaHJk9gcnifcsONosPHe9YLS7vmsNmMWHqJHaLCQubmS1m
        nN/HZDHnzxRmi84vs4D6z65lt/j9/R+rxbEFYhabOi+zWWzde5XdouHkClaLR31v2S1+bHjM
        avF9y2QmBwmPxhs32Dw2repk89ix6TWTx4kZv1k8jq5cy+Tx4uB2Zo/73ceZPDYvqfdYv2Eb
        o8fkG8sZPc7PWMjocfjDFRaP3Tcb2Dz6tqxi9Pi8SS6AP8rNJiM1MSW1SCE1Lzk/JTMv3VYp
        NMRN10JJIS8xN9VWKULXNyRISaEsMacUyDMyQAMOzgHuwUr6dgluGTMmHGApmMNRcfbjMeYG
        xnNsXYycHBICJhJvni9ggbDFJC7cWw8U5+IQEljCKHFo1Tl2COc5o0TroQNgVcICSRJLj3wE
        6xYR8JbY1XmXFaSIWWAvq8T5Dw+ZITo+MUp8f/IdrIpNwFCi620XmM0rYCdx5u9fJhCbRUBV
        on/hNaAGDg5RgRiJ909dIEoEJX5Mvge2jFNAR+LwkulgrcwCZhJfXh5mhbDlJTavecsMYYtL
        NLfeZJnAKDgLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmBa2nbs
        5+YdjJc2Bh9iFOBgVOLhZVD0jBRiTSwrrsw9xCjBwawkwnuuxCtSiDclsbIqtSg/vqg0J7X4
        EKMp0G8TmaVEk/OBKTOvJN7QxNDc0tDI2MLC3MhISZy35MOVcCGB9MSS1OzU1ILUIpg+Jg5O
        qQZGFV3T0Bkap74olWQY5rhfMnmndHbNrmOxf00ydI019I721Cz8UtghHVDAUuXf8lJ+3fqz
        3PeELwX3XL6ik5CtmPlw0rTrJpZ7JDym3s+9+OvxkssztwkJGL/IkFbRZJszXaLqPpOmaeZ8
        bq9DvInOgb9mT/2g/dNFWiXtLa+XT9rSYnuvDTxKLMUZiYZazEXFiQDqh1OiYQMAAA==
X-MTR:  20000000000000000@CPGS
X-CMS-MailID: 20170621133241eucas1p10a6aafde2f46c8e79c4bcc35e942740f
X-Msg-Generator: CA
X-Sender-IP: 182.198.249.179
X-Local-Sender: =?UTF-8?B?TWFyZWsgU3p5cHJvd3NraRtTUlBPTC1LZXJuZWwgKFRQKRs=?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG1NlbmlvciBTb2Z0d2FyZSBFbmdpbmVlcg==?=
X-Global-Sender: =?UTF-8?B?TWFyZWsgU3p5cHJvd3NraRtTUlBPTC1LZXJuZWwgKFRQKRtT?=
        =?UTF-8?B?YW1zdW5nIEVsZWN0cm9uaWNzG1NlbmlvciBTb2Z0d2FyZSBFbmdpbmVlcg==?=
X-Sender-Code: =?UTF-8?B?QzEwG0VIURtDMTBDRDAyQ0QwMjczOTI=?=
CMS-TYPE: 201P
X-HopCount: 7
X-CMS-RootMailID: 20170620131628epcas1p4f21d821bd414cba7e2d49abcbe414365
X-RootMTR: 20170620131628epcas1p4f21d821bd414cba7e2d49abcbe414365
References: <20170616181059.19206-1-hch@lst.de> <20170620124140.GA27163@lst.de>
 <20170620230400.1a5ae889@canb.auug.org.au>
 <CGME20170620131628epcas1p4f21d821bd414cba7e2d49abcbe414365@epcas1p4.samsung.com>
 <20170620131623.GB30769@lst.de>
Return-Path: <m.szyprowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58735
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

Hi Christoph,

On 2017-06-20 15:16, Christoph Hellwig wrote:
> On Tue, Jun 20, 2017 at 11:04:00PM +1000, Stephen Rothwell wrote:
>> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next
>>
>> Contacts: Marek Szyprowski and Kyungmin Park (cc'd)
>>
>> I have called your tree dma-mapping-hch for now.  The other tree has
>> not been updated since 4.9-rc1 and I am not sure how general it is.
>> Marek, Kyungmin, any comments?
> I'd be happy to join efforts - co-maintainers and reviers are always
> welcome.

I did some dma-mapping unification works in the past and my tree in 
linux-next
was a side effect of that. I think that for now it can be dropped in 
favor of
Christoph's tree. I can also do some review and help in maintainers work if
needed, although I was recently busy with other stuff.

Christoph: Could you add me to your MAINTAINERS patch, so further 
dma-mapping
related patches hopefully will be also CC: to me?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
