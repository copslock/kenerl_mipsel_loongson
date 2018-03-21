Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:23:42 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993994AbeCUTXQzfiAJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:23:16 +0100
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJMOQi117443
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:15 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gut67sc60-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:14 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:23:12 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:23:05 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJN5lY64880750;
        Wed, 21 Mar 2018 19:23:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EF2311C04A;
        Wed, 21 Mar 2018 19:15:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98E4F11C050;
        Wed, 21 Mar 2018 19:15:32 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:15:32 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:23:01 +0200
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 02/32] docs/vm: balance: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:18 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0008-0000-0000-000004E0DF6B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0009-0000-0000-00001E7403DD
Message-Id: <1521660168-14372-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63093
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
 Documentation/vm/balance | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/balance b/Documentation/vm/balance
index 9645954..6a1fadf 100644
--- a/Documentation/vm/balance
+++ b/Documentation/vm/balance
@@ -1,3 +1,9 @@
+.. _balance:
+
+================
+Memory Balancing
+================
+
 Started Jan 2000 by Kanoj Sarcar <kanoj@sgi.com>
 
 Memory balancing is needed for !__GFP_ATOMIC and !__GFP_KSWAPD_RECLAIM as
@@ -62,11 +68,11 @@ for non-sleepable allocations. Second, the HIGHMEM zone is also balanced,
 so as to give a fighting chance for replace_with_highmem() to get a
 HIGHMEM page, as well as to ensure that HIGHMEM allocations do not
 fall back into regular zone. This also makes sure that HIGHMEM pages
-are not leaked (for example, in situations where a HIGHMEM page is in 
+are not leaked (for example, in situations where a HIGHMEM page is in
 the swapcache but is not being used by anyone)
 
 kswapd also needs to know about the zones it should balance. kswapd is
-primarily needed in a situation where balancing can not be done, 
+primarily needed in a situation where balancing can not be done,
 probably because all allocation requests are coming from intr context
 and all process contexts are sleeping. For 2.3, kswapd does not really
 need to balance the highmem zone, since intr context does not request
@@ -89,7 +95,8 @@ pages is below watermark[WMARK_LOW]; in which case zone_wake_kswapd is also set.
 
 
 (Good) Ideas that I have heard:
+
 1. Dynamic experience should influence balancing: number of failed requests
-for a zone can be tracked and fed into the balancing scheme (jalvo@mbay.net)
+   for a zone can be tracked and fed into the balancing scheme (jalvo@mbay.net)
 2. Implement a replace_with_highmem()-like replace_with_regular() to preserve
-dma pages. (lkd@tantalophile.demon.co.uk)
+   dma pages. (lkd@tantalophile.demon.co.uk)
-- 
2.7.4
