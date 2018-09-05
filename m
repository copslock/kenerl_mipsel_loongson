Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:04:21 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994660AbeIEQAjKTuKO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 18:00:39 +0200
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85Fua57022474
        for <linux-mips@linux-mips.org>; Wed, 5 Sep 2018 12:00:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2magp9day2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 05 Sep 2018 12:00:35 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 17:00:31 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 17:00:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85G0QUx34734304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 16:00:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D94342045;
        Wed,  5 Sep 2018 19:00:21 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2468042057;
        Wed,  5 Sep 2018 19:00:19 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Sep 2018 19:00:19 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 05 Sep 2018 19:00:23 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [RFC PATCH 14/29] memblock: add align parameter to memblock_alloc_node()
Date:   Wed,  5 Sep 2018 18:59:29 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18090516-0008-0000-0000-0000026CBA33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090516-0009-0000-0000-000021D4D856
Message-Id: <1536163184-26356-15-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050164
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.vnet.ibm.com
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

With the align parameter memblock_alloc_node() can be used as drop in
replacement for alloc_bootmem_pages_node().

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 include/linux/bootmem.h | 4 ++--
 mm/sparse.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 7d91f0f..3896af2 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -157,9 +157,9 @@ static inline void * __init memblock_alloc_from_nopanic(
 }
 
 static inline void * __init memblock_alloc_node(
-						phys_addr_t size, int nid)
+		phys_addr_t size, phys_addr_t align, int nid)
 {
-	return memblock_alloc_try_nid(size, 0, BOOTMEM_LOW_LIMIT,
+	return memblock_alloc_try_nid(size, align, BOOTMEM_LOW_LIMIT,
 					    BOOTMEM_ALLOC_ACCESSIBLE, nid);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 04e97af..509828f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -68,7 +68,7 @@ static noinline struct mem_section __ref *sparse_index_alloc(int nid)
 	if (slab_is_available())
 		section = kzalloc_node(array_size, GFP_KERNEL, nid);
 	else
-		section = memblock_alloc_node(array_size, nid);
+		section = memblock_alloc_node(array_size, 0, nid);
 
 	return section;
 }
-- 
2.7.4
