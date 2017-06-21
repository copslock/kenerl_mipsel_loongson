Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 21:24:58 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:40539 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993879AbdFUTYvDABXb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jun 2017 21:24:51 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v5LJObIl016994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2017 19:24:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v5LJOZZL015528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 21 Jun 2017 19:24:35 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v5LJOTd2019196;
        Wed, 21 Jun 2017 19:24:31 GMT
Received: from [10.159.250.9] (/10.159.250.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Jun 2017 12:24:29 -0700
Subject: Re: clean up and modularize arch dma_mapping interface V2
To:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20170616181059.19206-1-hch@lst.de>
From:   tndave <tushar.n.dave@oracle.com>
Message-ID: <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
Date:   Wed, 21 Jun 2017 12:24:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <tushar.n.dave@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tushar.n.dave@oracle.com
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



On 06/16/2017 11:10 AM, Christoph Hellwig wrote:
> Hi all,
> 
> for a while we have a generic implementation of the dma mapping routines
> that call into per-arch or per-device operations.  But right now there
> still are various bits in the interfaces where don't clearly operate
> on these ops.  This series tries to clean up a lot of those (but not all
> yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
> way of signaling failures of the mapping routines from the
> implementations to the generic code (and cleans up various drivers that
> were incorrectly using it), and gets rid of the ->set_dma_mask routine
> in favor of relying on the ->dma_capable method that can be used in
> the same way, but which requires less code duplication.
Chris,

Thanks for doing this.
So archs can still have their own definition for dma_set_mask() if 
HAVE_ARCH_DMA_SET_MASK is y?
(and similarly for dma_set_coherent_mask() when 
CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK is y)
Any plan to change these?

I'm in a process of making some changes to SPARC iommu so it would be 
good to know. Thanks.

-Tushar

> 
> I've got a good number of reviews last time, but a few are still missing.
> I'd love to not have to re-spam everyone with this patchbomb, so early
> ACKs (or complaints) are welcome.
> 
> I plan to create a new dma-mapping tree to collect all this work.
> Any volunteers for co-maintainers, especially from the iommu gang?
> 
> The whole series is also available in git:
> 
>      git://git.infradead.org/users/hch/misc.git dma-map
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map
> 
> Changes since V1:
>   - remove two lines of code from arm dmabounce
>   - a few commit message tweaks
>   - lots of ACKs
> 
