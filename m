Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:04:35 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994663AbeIEQApcayaO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 18:00:45 +0200
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85FtUG5022416
        for <linux-mips@linux-mips.org>; Wed, 5 Sep 2018 12:00:44 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2maj548kge-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 05 Sep 2018 12:00:44 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 17:00:41 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 17:00:35 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85G0Yjh46268502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 16:00:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABCBA4C059;
        Wed,  5 Sep 2018 19:00:29 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 938924C058;
        Wed,  5 Sep 2018 19:00:27 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Sep 2018 19:00:27 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 05 Sep 2018 19:00:32 +0300
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
Subject: [RFC PATCH 17/29] memblock: replace alloc_bootmem_node with memblock_alloc_node
Date:   Wed,  5 Sep 2018 18:59:32 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18090516-0020-0000-0000-000002C1B2F3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090516-0021-0000-0000-0000210EE260
Message-Id: <1536163184-26356-18-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050164
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65974
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

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/alpha/kernel/pci_iommu.c   | 4 ++--
 arch/ia64/sn/kernel/io_common.c | 7 ++-----
 arch/ia64/sn/kernel/setup.c     | 4 ++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 6923b0d..b52d76f 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -74,7 +74,7 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
 
 #ifdef CONFIG_DISCONTIGMEM
 
-	arena = alloc_bootmem_node(NODE_DATA(nid), sizeof(*arena));
+	arena = memblock_alloc_node(sizeof(*arena), align, nid);
 	if (!NODE_DATA(nid) || !arena) {
 		printk("%s: couldn't allocate arena from node %d\n"
 		       "    falling back to system-wide allocation\n",
@@ -82,7 +82,7 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
 		arena = alloc_bootmem(sizeof(*arena));
 	}
 
-	arena->ptes = __alloc_bootmem_node(NODE_DATA(nid), mem_size, align, 0);
+	arena->ptes = memblock_alloc_node(sizeof(*arena), align, nid);
 	if (!NODE_DATA(nid) || !arena->ptes) {
 		printk("%s: couldn't allocate arena ptes from node %d\n"
 		       "    falling back to system-wide allocation\n",
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 102aaba..8b05d55 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -385,16 +385,13 @@ void __init hubdev_init_node(nodepda_t * npda, cnodeid_t node)
 {
 	struct hubdev_info *hubdev_info;
 	int size;
-	pg_data_t *pg;
 
 	size = sizeof(struct hubdev_info);
 
 	if (node >= num_online_nodes())	/* Headless/memless IO nodes */
-		pg = NODE_DATA(0);
-	else
-		pg = NODE_DATA(node);
+		node = 0;
 
-	hubdev_info = (struct hubdev_info *)alloc_bootmem_node(pg, size);
+	hubdev_info = (struct hubdev_info *)memblock_alloc_node(size, 0, node);
 
 	npda->pdinfo = (void *)hubdev_info;
 }
diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 5f6b6b4..ab2564f 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -511,7 +511,7 @@ static void __init sn_init_pdas(char **cmdline_p)
 	 */
 	for_each_online_node(cnode) {
 		nodepdaindr[cnode] =
-		    alloc_bootmem_node(NODE_DATA(cnode), sizeof(nodepda_t));
+		    memblock_alloc_node(sizeof(nodepda_t), 0, cnode);
 		memset(nodepdaindr[cnode]->phys_cpuid, -1,
 		    sizeof(nodepdaindr[cnode]->phys_cpuid));
 		spin_lock_init(&nodepdaindr[cnode]->ptc_lock);
@@ -522,7 +522,7 @@ static void __init sn_init_pdas(char **cmdline_p)
 	 */
 	for (cnode = num_online_nodes(); cnode < num_cnodes; cnode++)
 		nodepdaindr[cnode] =
-		    alloc_bootmem_node(NODE_DATA(0), sizeof(nodepda_t));
+		    memblock_alloc_node(sizeof(nodepda_t), 0, 0);
 
 	/*
 	 * Now copy the array of nodepda pointers to each nodepda.
-- 
2.7.4
