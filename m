Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2017 21:12:12 +0200 (CEST)
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54763 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991940AbdJXTL6rDPC5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2017 21:11:58 +0200
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 215A120F2E;
        Tue, 24 Oct 2017 15:11:57 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 24 Oct 2017 15:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=cc:content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        mesmtp; bh=x+AZouwDfKXYYUvitIIfyQ/CyrITptOPYUt4jjJK23Y=; b=aSHQi
        lyN3ZzJOvTlvwGo5iT23dwBbl3NCDsldtxJ4BSCoZP769y9cK+y74jVkNcj1XH5k
        171x7F9YNgZ3WavsqesqHz9DVEDjBQGwIR6Y1lX3DxgNUn5BDjYbLp0MZQ3on+rd
        vXG33uAsseOCsDjj/c/g5Dn0ehISTQDtQE2F70=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=x+AZouwDfKXYYUvitIIfyQ/CyrITp
        tOPYUt4jjJK23Y=; b=bCxBFuwfxZ+bU2QcC/iDM/wUQ7ExJuXCcyCj2i4SIMx73
        c+6D8OVOhql0Y8nfLuzr2YM+Vw24NOJUX+lxwpMZhkt5lUS0USwHTfRB1OANm85p
        9jIjTUZ89AwYCIMdrezY4l91RUDVayJflnUsYJpuWmqJtLhFcX4zXvVFfbsLeuVV
        ImK/ERZQ39Otlj7hUvJTRLO3AcA02l8w6/8BgG6ET7JKT+aU4tJe225CueHpM6/H
        Z4VXb314ppcLKCqNeD8YkbJxIglhWBLJXwJkE8wJSB++nZ3zlPVeOyOsG1FiF8n4
        zuB93oFMBcRW1pnKtO+dVSHppsphWVp4indeWNdmQ==
X-ME-Sender: <xms:fZDvWdPA81q1KWZxFPw1q0OHQZ1zt-7D76clEdT-ARMqG06f_5n0wg>
Received: from blue.animalcreek.com (ip68-3-119-204.ph.ph.cox.net [68.3.119.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC3F12484B;
        Tue, 24 Oct 2017 15:11:56 -0400 (EDT)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id 2358EA20801; Tue, 24 Oct 2017 12:11:56 -0700 (MST)
Date:   Tue, 24 Oct 2017 12:11:56 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        "Mark A . Greer" <mgreer@animalcreek.com>,
        Robert Baldyga <r.baldyga@hackerion.com>
Subject: Re: [PATCH V9 1/4] dma-mapping: Rework dma_get_cache_alignment()
Message-ID: <20171024191156.GA11341@animalcreek.com>
References: <1508742767-28366-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508742767-28366-1-git-send-email-chenhc@lemote.com>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <mgreer@animalcreek.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mgreer@animalcreek.com
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

On Mon, Oct 23, 2017 at 03:12:44PM +0800, Huacai Chen wrote:
> Make dma_get_cache_alignment() to accept a 'dev' argument. As a result,
> it can return different alignments due to different devices' I/O cache
> coherency.
> 
> Currently, ARM/ARM64 and MIPS support coherent & noncoherent devices
> co-exist. This may be extended in the future, so add a new function
> pointer (i.e, get_cache_alignment) in 'struct dma_map_ops' as a generic
> solution.
> 
> Cc: stable@vger.kernel.org
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Pawel Osciak <pawel@osciak.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Ivan Mikhaylov <ivan@ru.ibm.com>
> Cc: Tariq Toukan <tariqt@mellanox.com>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Robert Baldyga <r.baldyga@hackerion.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---

For the mpsc stuff:

Acked-by: Mark Greer <mgreer@animalcreek.com>
