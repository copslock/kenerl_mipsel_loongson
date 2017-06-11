Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jun 2017 04:37:21 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:29583 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991965AbdFKChME5x2T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jun 2017 04:37:12 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v5B2av7j026449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jun 2017 02:36:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v5B2aqFs032149
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jun 2017 02:36:53 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v5B2aktV019996;
        Sun, 11 Jun 2017 02:36:48 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 10 Jun 2017 19:36:46 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 5F63B6A0104; Sat, 10 Jun 2017 22:36:44 -0400 (EDT)
Date:   Sat, 10 Jun 2017 22:36:44 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/44] xen-swiotlb: consolidate xen_swiotlb_dma_ops
Message-ID: <20170611023644.GE30966@char.us.oracle.com>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608132609.32662-8-hch@lst.de>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <konrad.wilk@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Thu, Jun 08, 2017 at 03:25:32PM +0200, Christoph Hellwig wrote:
> ARM and x86 had duplicated versions of the dma_ops structure, the
> only difference is that x86 hasn't wired up the set_dma_mask,
> mmap, and get_sgtable ops yet.  On x86 all of them are identical
> to the generic version, so they aren't needed but harmless.
> 
> All the symbols used only for xen_swiotlb_dma_ops can now be marked
> static as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/xen/mm.c              | 17 --------
>  arch/x86/xen/pci-swiotlb-xen.c | 14 -------
>  drivers/xen/swiotlb-xen.c      | 93 ++++++++++++++++++++++--------------------
>  include/xen/swiotlb-xen.h      | 62 +---------------------------
>  4 files changed, 49 insertions(+), 137 deletions(-)

Yeeey!

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
