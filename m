Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2016 14:19:24 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:62870 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993494AbcGLMTRUDiY- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jul 2016 14:19:17 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OA7004Z7BJXGF80@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 12 Jul 2016 13:19:09 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-6e-5784e03ddef3
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 21.47.05254.D30E4875; Tue,
 12 Jul 2016 13:19:09 +0100 (BST)
Received: from [106.120.53.17] by eusync3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0OA7003URBJW3T20@eusync3.samsung.com>; Tue,
 12 Jul 2016 13:19:09 +0100 (BST)
Subject: Re: [PATCH v5 00/44] dma-mapping: Use unsigned long for dma_attrs
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-rdma@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, hch@infradead.org,
        linux-rockchip@lists.infradead.org, nouveau@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-snps-arc@lists.infradead.org,
        linux-media@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
 <20160712121625.GP23520@phenom.ffwll.local>
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5784E03B.6060000@samsung.com>
Date:   Tue, 12 Jul 2016 14:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-version: 1.0
In-reply-to: <20160712121625.GP23520@phenom.ffwll.local>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNcRjH93tv5605eXsVv2mYQ5tlSsKehRj/vNGmWXOwNh31OpVOtXOc
        KDZNJZIcqu10XZdD96JSrUnTRbcdFeXaTYipnMglSnRqxn+f7/N8v8/3n4cl+Vh6ORsQfFJU
        ByuCZIwl1THb0rthx1C0fGNLzBpILytm4La+jIaeryYG0t8ZEXTocgjIqt8Go++d4WN/E4Ly
        109ouFZvlEBTmo6A/KJSErIvGChoTZigwRRdw8DExY80PK5NZyDvTQkJ8bfuzMmobgQjL2Ip
        0CVfl0Ca4SoFw+1dBBgzWxgYabhCweeh3yTosqNI0HfeIyB9JomEmL4SAgqMJRKY/j5Lw/eE
        BBoi2/LnqDKR2LVWeFrqKVTkOwg15aOE0KqfpoTmghJCeH+/mhQGL7cQQoXhnJD4LA8JbTHf
        KKFTn42ExokeSkioLETCZPlKT6sjltv9xKCAMFHt5OZj6V+UNEyETtOnM5LymEj0gopDFizm
        NuOx7ExigZfiroEyJg5Zsjx3A+Gql8mSBTGCcNJYBjK7lnB78ev2t/NpG26cxb3nQ8zMc1qc
        +yuaMTPDueCKPMM8SzkHXDN6WWJmirPH/RnF82223CGcWj1FLHis8VTiwPxNCw6w/tW3uS6W
        JTlHPNjtYB6T3CpcUTxO6tDi1P8Sqf9cqf+5shBZiGxFrW+o5phS5eyoUag02mClo2+Iqhwt
        vMeXGpT7wLUBcSySLZIOdUTJeVoRpglXNSDMkjIb6dBAtJyX+inCI0R1yFG1NkjUNCA7lpIt
        k2bUmrx4Tqk4KZ4QxVBR/XdLsBbLI5GV3VhKXYrhKcOfXZ+rT3F7Hn9KZR+nu9sc6GG72+1c
        jinxy+yVKW+SC1nx48xD4esHxrrqifuMEximit15fqtXss57v7HPJVy+Z5up8NHPHvlhX1fl
        TUIuVF+w+zS5cx3R7JGGfQrf7qtbrWxs97EK3PL7+Liy79Im9YGD2vwIGaXxVzg7kGqN4g/v
        OupAGgMAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

On 07/12/2016 02:16 PM, Daniel Vetter wrote:
> On Thu, Jun 30, 2016 at 10:23:39AM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>>
>> This is fifth approach for replacing struct dma_attrs with unsigned
>> long.
>>
>> The main patch (1/44) doing the change is split into many subpatches
>> for easier review (2-42).  They should be squashed together when
>> applying.
> 
> For all the drm driver patches:
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Should I pull these in through drm-misc, or do you prefer to merge them
> through a special topic branch (with everything else) instead on your own?
> -Daniel

Thanks. I saw today that Andrew Morton applied the patchset so I think
he will handle it.

Best regards,
Krzysztof
