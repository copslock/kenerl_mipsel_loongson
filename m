Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 15:59:05 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:40746 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeDPN66i4BSw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 15:58:58 +0200
Received: from localhost (pool-173-77-163-229.nycmny.fios.verizon.net [173.77.163.229])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 69DF613C55991;
        Mon, 16 Apr 2018 06:58:46 -0700 (PDT)
Date:   Mon, 16 Apr 2018 09:58:33 -0400 (EDT)
Message-Id: <20180416.095833.969403163564136309.davem@davemloft.net>
To:     khandual@linux.vnet.ibm.com
Cc:     hch@lst.de, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
References: <20180415145947.1248-1-hch@lst.de>
        <20180415145947.1248-2-hch@lst.de>
        <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Apr 2018 06:58:47 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63558
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

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 14:26:07 +0530

> On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
>> This code is only used by sparc, and all new iommu drivers should use the
>> drivers/iommu/ framework.  Also remove the unused exports.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Right, these functions are used only from SPARC architecture. Simple
> git grep confirms it as well. Hence it makes sense to move them into
> arch code instead.

Well, we put these into a common location and used type friendly for
powerpc because we hoped powerpc would convert over to using this
common piece of code as well.

But nobody did the powerpc work.

If you look at the powerpc iommu support, it's the same code basically
for entry allocation.
