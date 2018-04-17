Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 07:51:19 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990409AbeDQFvMaRbZF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2018 07:51:12 +0200
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3H5nVwU090234
        for <linux-mips@linux-mips.org>; Tue, 17 Apr 2018 01:51:09 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hd7dcrj9q-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 17 Apr 2018 01:51:09 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <khandual@linux.vnet.ibm.com>;
        Tue, 17 Apr 2018 06:51:07 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 17 Apr 2018 06:51:03 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w3H5p2v550200584;
        Tue, 17 Apr 2018 05:51:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B2394C046;
        Tue, 17 Apr 2018 06:43:34 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 245844C044;
        Tue, 17 Apr 2018 06:43:31 +0100 (BST)
Received: from [9.202.15.240] (unknown [9.202.15.240])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Apr 2018 06:43:30 +0100 (BST)
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
To:     David Miller <davem@davemloft.net>, khandual@linux.vnet.ibm.com
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-2-hch@lst.de>
 <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
 <20180416.095833.969403163564136309.davem@davemloft.net>
Cc:     hch@lst.de, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Tue, 17 Apr 2018 11:20:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180416.095833.969403163564136309.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041705-0044-0000-0000-00000549079A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041705-0045-0000-0000-00002889132F
Message-Id: <f5741528-427d-3537-5498-2080766df0fe@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170052
Return-Path: <khandual@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63572
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

On 04/16/2018 07:28 PM, David Miller wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Date: Mon, 16 Apr 2018 14:26:07 +0530
> 
>> On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
>>> This code is only used by sparc, and all new iommu drivers should use the
>>> drivers/iommu/ framework.  Also remove the unused exports.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Right, these functions are used only from SPARC architecture. Simple
>> git grep confirms it as well. Hence it makes sense to move them into
>> arch code instead.
> 
> Well, we put these into a common location and used type friendly for
> powerpc because we hoped powerpc would convert over to using this
> common piece of code as well.
> 
> But nobody did the powerpc work.
> 
> If you look at the powerpc iommu support, it's the same code basically
> for entry allocation.

I understand. But there are some differences in iommu_table structure,
how both regular and large IOMMU pools are being initialized etc. So
if the movement of code into SPARC help cleaning up these generic config
options in general, I guess we should do that. But I will leave it upto
others who have more experience in this area.

+mpe
