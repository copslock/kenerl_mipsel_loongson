Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 18:23:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbdFHQXZbA-g3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 18:23:25 +0200
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v58GJTrl095832
        for <linux-mips@linux-mips.org>; Thu, 8 Jun 2017 12:23:23 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2axvmxvevg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 08 Jun 2017 12:23:23 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gerald.schaefer@de.ibm.com>;
        Thu, 8 Jun 2017 17:23:19 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 8 Jun 2017 17:23:13 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v58GNCSU16318798;
        Thu, 8 Jun 2017 16:23:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC2D6AE051;
        Thu,  8 Jun 2017 17:20:40 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C878AE045;
        Thu,  8 Jun 2017 17:20:40 +0100 (BST)
Received: from thinkpad (unknown [9.152.212.72])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jun 2017 17:20:40 +0100 (BST)
Date:   Thu, 8 Jun 2017 18:23:11 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
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
Subject: Re: [PATCH 19/44] s390: implement ->mapping_error
In-Reply-To: <20170608132609.32662-20-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
        <20170608132609.32662-20-hch@lst.de>
Organization: IBM Deutschland Research & Development GmbH / Vorsitzende des
 Aufsichtsrats: Martina Koederitz / Geschaeftsfuehrung: Dirk Wittkopp / Sitz
 der Gesellschaft: Boeblingen / Registergericht: Amtsgericht Stuttgart, HRB
 243294
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.23; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 17060816-0020-0000-0000-000003836630
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17060816-0021-0000-0000-000041FEF14B
Message-Id: <20170608182311.05cced9e@thinkpad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-06-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1703280000
 definitions=main-1706080286
Return-Path: <gerald.schaefer@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerald.schaefer@de.ibm.com
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

On Thu,  8 Jun 2017 15:25:44 +0200
Christoph Hellwig <hch@lst.de> wrote:

> s390 can also use noop_dma_ops, and while that currently does not return
> errors it will so in the future.  Implementing the mapping_error method
> is the proper way to have per-ops error conditions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
