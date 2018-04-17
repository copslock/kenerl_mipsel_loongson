Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 08:10:57 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990422AbeDQGKsUI-bF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2018 08:10:48 +0200
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3H6AJMU061051
        for <linux-mips@linux-mips.org>; Tue, 17 Apr 2018 02:10:46 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hdb348pkb-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 17 Apr 2018 02:10:46 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <khandual@linux.vnet.ibm.com>;
        Tue, 17 Apr 2018 07:10:44 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 17 Apr 2018 07:10:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w3H6AdV59306414;
        Tue, 17 Apr 2018 06:10:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95BCB42041;
        Tue, 17 Apr 2018 07:02:13 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D84B42056;
        Tue, 17 Apr 2018 07:02:11 +0100 (BST)
Received: from [9.202.15.240] (unknown [9.202.15.240])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Apr 2018 07:02:11 +0100 (BST)
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
 lib/Kconfig
To:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-12-hch@lst.de>
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Tue, 17 Apr 2018 11:40:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180415145947.1248-12-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041706-0044-0000-0000-000005490966
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041706-0045-0000-0000-000028891516
Message-Id: <1c4007b5-c0d4-7077-b2c1-767c6abbf79f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170056
Return-Path: <khandual@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63573
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
> This way we have one central definition of it, and user can select it as
> needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
> indicate the architecture supports swiotlb at all, so that we can still
> make the usage optional for a few architectures that want this feature
> to be user selectable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


snip

> +
> +config SWIOTLB
> +	bool "SWIOTLB support"
> +	default ARCH_HAS_SWIOTLB
> +	select DMA_DIRECT_OPS
> +	select NEED_DMA_MAP_STATE
> +	select NEED_SG_DMA_LENGTH
> +	---help---
> +	  Support for IO bounce buffering for systems without an IOMMU.
> +	  This allows us to DMA to the full physical address space on
> +	  platforms where the size of a physical address is larger
> +	  than the bus address.  If unsure, say Y.
> +
>  config CHECK_SIGNATURE
>  	bool

Pulling DMA_DIRECT_OPS config option by default when SWIOTLB is enabled
makes sense. This option was also needed to be enabled separately even
to use swiotlb_dma_ops.
