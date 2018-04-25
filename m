Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 16:58:33 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:49734 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbeDYO60rwcqC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 16:58:26 +0200
Received: from localhost (67.110.78.66.ptr.us.xo.net [67.110.78.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E0431133F640E;
        Wed, 25 Apr 2018 07:58:21 -0700 (PDT)
Date:   Wed, 25 Apr 2018 10:58:20 -0400 (EDT)
Message-Id: <20180425.105820.1294383479112934639.davem@davemloft.net>
To:     hch@lst.de
Cc:     konrad.wilk@oracle.com, iommu@lists.linux-foundation.org,
        sstabellini@kernel.org, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/13] iommu-common: move to arch/sparc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180425051539.1989-2-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
        <20180425051539.1989-2-hch@lst.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Apr 2018 07:58:23 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 25 Apr 2018 07:15:27 +0200

> This code is only used by sparc, and all new iommu drivers should use the
> drivers/iommu/ framework.  Also remove the unused exports.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>
