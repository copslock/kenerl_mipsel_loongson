Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:30:18 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994728AbeCUTYyTZJRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:24:54 +0100
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJIaNU064383
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:53 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gurspnwc1-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:52 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:24:49 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:24:43 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJOhIt47906974;
        Wed, 21 Mar 2018 19:24:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE71911C04C;
        Wed, 21 Mar 2018 19:17:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C0D611C04A;
        Wed, 21 Mar 2018 19:17:10 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:17:10 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:24:38 +0200
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
Subject: [PATCH 24/32] docs/vm: swap_numa.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:40 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0008-0000-0000-000004E0DF7A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0009-0000-0000-00001E7403F0
Message-Id: <1521660168-14372-25-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63115
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
 Documentation/vm/swap_numa.txt | 55 +++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/Documentation/vm/swap_numa.txt b/Documentation/vm/swap_numa.txt
index d5960c9..e0466f2 100644
--- a/Documentation/vm/swap_numa.txt
+++ b/Documentation/vm/swap_numa.txt
@@ -1,5 +1,8 @@
+.. _swap_numa:
+
+===========================================
 Automatically bind swap device to numa node
--------------------------------------------
+===========================================
 
 If the system has more than one swap device and swap device has the node
 information, we can make use of this information to decide which swap
@@ -7,15 +10,16 @@ device to use in get_swap_pages() to get better performance.
 
 
 How to use this feature
------------------------
+=======================
 
 Swap device has priority and that decides the order of it to be used. To make
 use of automatically binding, there is no need to manipulate priority settings
 for swap devices. e.g. on a 2 node machine, assume 2 swap devices swapA and
 swapB, with swapA attached to node 0 and swapB attached to node 1, are going
-to be swapped on. Simply swapping them on by doing:
-# swapon /dev/swapA
-# swapon /dev/swapB
+to be swapped on. Simply swapping them on by doing::
+
+	# swapon /dev/swapA
+	# swapon /dev/swapB
 
 Then node 0 will use the two swap devices in the order of swapA then swapB and
 node 1 will use the two swap devices in the order of swapB then swapA. Note
@@ -24,32 +28,39 @@ that the order of them being swapped on doesn't matter.
 A more complex example on a 4 node machine. Assume 6 swap devices are going to
 be swapped on: swapA and swapB are attached to node 0, swapC is attached to
 node 1, swapD and swapE are attached to node 2 and swapF is attached to node3.
-The way to swap them on is the same as above:
-# swapon /dev/swapA
-# swapon /dev/swapB
-# swapon /dev/swapC
-# swapon /dev/swapD
-# swapon /dev/swapE
-# swapon /dev/swapF
-
-Then node 0 will use them in the order of:
-swapA/swapB -> swapC -> swapD -> swapE -> swapF
+The way to swap them on is the same as above::
+
+	# swapon /dev/swapA
+	# swapon /dev/swapB
+	# swapon /dev/swapC
+	# swapon /dev/swapD
+	# swapon /dev/swapE
+	# swapon /dev/swapF
+
+Then node 0 will use them in the order of::
+
+	swapA/swapB -> swapC -> swapD -> swapE -> swapF
+
 swapA and swapB will be used in a round robin mode before any other swap device.
 
-node 1 will use them in the order of:
-swapC -> swapA -> swapB -> swapD -> swapE -> swapF
+node 1 will use them in the order of::
+
+	swapC -> swapA -> swapB -> swapD -> swapE -> swapF
+
+node 2 will use them in the order of::
+
+	swapD/swapE -> swapA -> swapB -> swapC -> swapF
 
-node 2 will use them in the order of:
-swapD/swapE -> swapA -> swapB -> swapC -> swapF
 Similaly, swapD and swapE will be used in a round robin mode before any
 other swap devices.
 
-node 3 will use them in the order of:
-swapF -> swapA -> swapB -> swapC -> swapD -> swapE
+node 3 will use them in the order of::
+
+	swapF -> swapA -> swapB -> swapC -> swapD -> swapE
 
 
 Implementation details
-----------------------
+======================
 
 The current code uses a priority based list, swap_avail_list, to decide
 which swap device to use and if multiple swap devices share the same
-- 
2.7.4
