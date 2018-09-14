Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 14:14:27 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993094AbeINMM3AjrpF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 14:12:29 +0200
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EC4mx4026813
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 08:12:27 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mg9c78dud-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 08:12:27 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 13:12:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 13:12:12 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ECCBd065732816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 12:12:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5FF242042;
        Fri, 14 Sep 2018 15:12:01 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B6542041;
        Fri, 14 Sep 2018 15:11:56 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Sep 2018 15:11:56 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 14 Sep 2018 15:12:05 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 13/30] memblock: replace __alloc_bootmem_nopanic with memblock_alloc_from_nopanic
Date:   Fri, 14 Sep 2018 15:10:28 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091412-0028-0000-0000-000002F958B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091412-0029-0000-0000-000023B30121
Message-Id: <1536927045-23536-14-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=646 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140129
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66271
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

When __alloc_bootmem_nopanic() is used with explicit lower limit for the
allocation it attempts to allocate memory at or above that limit and falls
back to allocation with no limit set.

The memblock_alloc_from_nopanic() does exactly the same thing and can be
used as a replacement for __alloc_bootmem_nopanic() is such cases.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/arc/kernel/unwind.c       | 4 ++--
 arch/x86/kernel/setup_percpu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 183391d..2a01dd1 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -181,8 +181,8 @@ static void init_unwind_hdr(struct unwind_table *table,
  */
 static void *__init unw_hdr_alloc_early(unsigned long sz)
 {
-	return __alloc_bootmem_nopanic(sz, sizeof(unsigned int),
-				       MAX_DMA_ADDRESS);
+	return memblock_alloc_from_nopanic(sz, sizeof(unsigned int),
+					   MAX_DMA_ADDRESS);
 }
 
 static void *unw_hdr_alloc(unsigned long sz)
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 67d48e26..041663a 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -106,7 +106,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 	void *ptr;
 
 	if (!node_online(node) || !NODE_DATA(node)) {
-		ptr = __alloc_bootmem_nopanic(size, align, goal);
+		ptr = memblock_alloc_from_nopanic(size, align, goal);
 		pr_info("cpu %d has no node %d or node-local memory\n",
 			cpu, node);
 		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
@@ -121,7 +121,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 	}
 	return ptr;
 #else
-	return __alloc_bootmem_nopanic(size, align, goal);
+	return memblock_alloc_from_nopanic(size, align, goal);
 #endif
 }
 
-- 
2.7.4
