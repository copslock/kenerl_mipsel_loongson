Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:36:50 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993612AbeCUTfVu5OFZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:35:21 +0100
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJYY69058413
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:35:20 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2guw151we2-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:35:20 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:25:11 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:25:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJP6s643909198;
        Wed, 21 Mar 2018 19:25:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1331C11C04A;
        Wed, 21 Mar 2018 19:17:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA61A11C04C;
        Wed, 21 Mar 2018 19:17:33 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:17:33 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:25:02 +0200
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
Subject: [PATCH 29/32] docs/vm: zsmalloc.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:45 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0044-0000-0000-0000053E7359
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0045-0000-0000-0000287D78FA
Message-Id: <1521660168-14372-30-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210224
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63138
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
 Documentation/vm/zsmalloc.txt | 60 ++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/Documentation/vm/zsmalloc.txt b/Documentation/vm/zsmalloc.txt
index 64ed63c..6e79893 100644
--- a/Documentation/vm/zsmalloc.txt
+++ b/Documentation/vm/zsmalloc.txt
@@ -1,5 +1,8 @@
+.. _zsmalloc:
+
+========
 zsmalloc
---------
+========
 
 This allocator is designed for use with zram. Thus, the allocator is
 supposed to work well under low memory conditions. In particular, it
@@ -31,40 +34,49 @@ be mapped using zs_map_object() to get a usable pointer and subsequently
 unmapped using zs_unmap_object().
 
 stat
-----
+====
 
 With CONFIG_ZSMALLOC_STAT, we could see zsmalloc internal information via
-/sys/kernel/debug/zsmalloc/<user name>. Here is a sample of stat output:
+``/sys/kernel/debug/zsmalloc/<user name>``. Here is a sample of stat output::
 
-# cat /sys/kernel/debug/zsmalloc/zram0/classes
+ # cat /sys/kernel/debug/zsmalloc/zram0/classes
 
  class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage
-    ..
-    ..
+    ...
+    ...
      9   176           0            1           186        129          8                4
     10   192           1            0          2880       2872        135                3
     11   208           0            1           819        795         42                2
     12   224           0            1           219        159         12                4
-    ..
-    ..
+    ...
+    ...
+
 
+class
+	index
+size
+	object size zspage stores
+almost_empty
+	the number of ZS_ALMOST_EMPTY zspages(see below)
+almost_full
+	the number of ZS_ALMOST_FULL zspages(see below)
+obj_allocated
+	the number of objects allocated
+obj_used
+	the number of objects allocated to the user
+pages_used
+	the number of pages allocated for the class
+pages_per_zspage
+	the number of 0-order pages to make a zspage
 
-class: index
-size: object size zspage stores
-almost_empty: the number of ZS_ALMOST_EMPTY zspages(see below)
-almost_full: the number of ZS_ALMOST_FULL zspages(see below)
-obj_allocated: the number of objects allocated
-obj_used: the number of objects allocated to the user
-pages_used: the number of pages allocated for the class
-pages_per_zspage: the number of 0-order pages to make a zspage
+We assign a zspage to ZS_ALMOST_EMPTY fullness group when n <= N / f, where
 
-We assign a zspage to ZS_ALMOST_EMPTY fullness group when:
-      n <= N / f, where
-n = number of allocated objects
-N = total number of objects zspage can store
-f = fullness_threshold_frac(ie, 4 at the moment)
+* n = number of allocated objects
+* N = total number of objects zspage can store
+* f = fullness_threshold_frac(ie, 4 at the moment)
 
 Similarly, we assign zspage to:
-      ZS_ALMOST_FULL  when n > N / f
-      ZS_EMPTY        when n == 0
-      ZS_FULL         when n == N
+
+* ZS_ALMOST_FULL  when n > N / f
+* ZS_EMPTY        when n == 0
+* ZS_FULL         when n == N
-- 
2.7.4
