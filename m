Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 10:56:27 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990391AbeDPI4Ukjnt- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 10:56:20 +0200
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3G8sHFI064924
        for <linux-mips@linux-mips.org>; Mon, 16 Apr 2018 04:56:18 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hcqfnbrr1-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 16 Apr 2018 04:56:17 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <khandual@linux.vnet.ibm.com>;
        Mon, 16 Apr 2018 09:56:15 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 16 Apr 2018 09:56:11 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w3G8uBXG12386754;
        Mon, 16 Apr 2018 08:56:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1CFC5203F;
        Mon, 16 Apr 2018 08:47:01 +0100 (BST)
Received: from [9.202.15.240] (unknown [9.202.15.240])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6C99052045;
        Mon, 16 Apr 2018 08:46:59 +0100 (BST)
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
To:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-2-hch@lst.de>
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Mon, 16 Apr 2018 14:26:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180415145947.1248-2-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041608-0044-0000-0000-00000548AD5F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041608-0045-0000-0000-00002888B38F
Message-Id: <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160082
Return-Path: <khandual@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khandual@linux.vnet.ibm.com
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

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This code is only used by sparc, and all new iommu drivers should use the
> drivers/iommu/ framework.  Also remove the unused exports.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Right, these functions are used only from SPARC architecture. Simple
git grep confirms it as well. Hence it makes sense to move them into
arch code instead.

git grep iommu_tbl_pool_init
----------------------------

arch/sparc/include/asm/iommu-common.h:extern void iommu_tbl_pool_init(struct iommu_map_table *iommu,
arch/sparc/kernel/iommu-common.c:void iommu_tbl_pool_init(struct iommu_map_table *iommu,
arch/sparc/kernel/iommu.c:      iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,
arch/sparc/kernel/ldc.c:        iommu_tbl_pool_init(iommu, num_tsb_entries, PAGE_SHIFT,
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_pool_init(&atu->tbl, num_iotte, IO_PAGE_SHIFT,
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,

git grep iommu_tbl_range_alloc
------------------------------

arch/sparc/include/asm/iommu-common.h:extern unsigned long iommu_tbl_range_alloc(struct device *dev,
arch/sparc/kernel/iommu-common.c:unsigned long iommu_tbl_range_alloc(struct device *dev,
arch/sparc/kernel/iommu.c:      entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL,
arch/sparc/kernel/iommu.c:              entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
arch/sparc/kernel/ldc.c:        entry = iommu_tbl_range_alloc(NULL, &iommu->iommu_map_table,
arch/sparc/kernel/pci_sun4v.c:  entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
arch/sparc/kernel/pci_sun4v.c:  entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
arch/sparc/kernel/pci_sun4v.c:          entry = iommu_tbl_range_alloc(dev, tbl, npages,

git grep iommu_tbl_range_free
-----------------------------

arch/sparc/include/asm/iommu-common.h:extern void iommu_tbl_range_free(struct iommu_map_table *iommu,
arch/sparc/kernel/iommu-common.c:void iommu_tbl_range_free(struct iommu_map_table *iommu, u64 dma_addr,
arch/sparc/kernel/iommu.c:      iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/iommu.c:      iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/iommu.c:                      iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
arch/sparc/kernel/iommu.c:              iommu_tbl_range_free(&iommu->tbl, dma_handle, npages,
arch/sparc/kernel/ldc.c:        iommu_tbl_range_free(&iommu->iommu_map_table, cookie, npages, entry);
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_range_free(tbl, *dma_addrp, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_range_free(tbl, dvma, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/pci_sun4v.c:                  iommu_tbl_range_free(tbl, vaddr, npages,
arch/sparc/kernel/pci_sun4v.c:          iommu_tbl_range_free(tbl, dma_handle, npages,

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
