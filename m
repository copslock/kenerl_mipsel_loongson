Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 14:54:10 +0200 (CEST)
Received: from ozlabs.org ([IPv6:2401:3900:2:1::2]:59003 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990498AbeDQMyBgl03P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Apr 2018 14:54:01 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 40QQDL2X31z9s0W;
        Tue, 17 Apr 2018 22:53:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        David Miller <davem@davemloft.net>, khandual@linux.vnet.ibm.com
Cc:     hch@lst.de, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
In-Reply-To: <f5741528-427d-3537-5498-2080766df0fe@linux.vnet.ibm.com>
References: <20180415145947.1248-1-hch@lst.de> <20180415145947.1248-2-hch@lst.de> <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com> <20180416.095833.969403163564136309.davem@davemloft.net> <f5741528-427d-3537-5498-2080766df0fe@linux.vnet.ibm.com>
Date:   Tue, 17 Apr 2018 22:53:53 +1000
Message-ID: <87wox60za6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> On 04/16/2018 07:28 PM, David Miller wrote:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Date: Mon, 16 Apr 2018 14:26:07 +0530
>> 
>>> On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
>>>> This code is only used by sparc, and all new iommu drivers should use the
>>>> drivers/iommu/ framework.  Also remove the unused exports.
>>>>
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Right, these functions are used only from SPARC architecture. Simple
>>> git grep confirms it as well. Hence it makes sense to move them into
>>> arch code instead.
>> 
>> Well, we put these into a common location and used type friendly for
>> powerpc because we hoped powerpc would convert over to using this
>> common piece of code as well.
>> 
>> But nobody did the powerpc work.
 
Sorry.

>> If you look at the powerpc iommu support, it's the same code basically
>> for entry allocation.
>
> I understand. But there are some differences in iommu_table structure,
> how both regular and large IOMMU pools are being initialized etc. So
> if the movement of code into SPARC help cleaning up these generic config
> options in general, I guess we should do that. But I will leave it upto
> others who have more experience in this area.
>
> +mpe

This is the first I've heard of it, I guess it's probably somewhere on
Ben's append-only TODO list.

Some of the code does look very similar, but not 100%. So someone would
need to do some work to reconcile the two and test the result. TBH I
doubt we're going to get around to it any time soon. Unless we have a
volunteer?

cheers
