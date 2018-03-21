Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:24:20 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994649AbeCUTXZvxSXx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:23:25 +0100
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJMXeH078887
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2guwg9g1f2-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:23 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:23:21 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:23:15 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJNEcx61472864;
        Wed, 21 Mar 2018 19:23:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 776C6AE055;
        Wed, 21 Mar 2018 19:13:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BA22AE045;
        Wed, 21 Mar 2018 19:13:31 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:13:31 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:23:10 +0200
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
Subject: [PATCH 04/32] docs/vm: frontswap.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:20 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0020-0000-0000-00000407E603
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0021-0000-0000-0000429C06B1
Message-Id: <1521660168-14372-5-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63095
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
 Documentation/vm/frontswap.txt | 59 ++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/Documentation/vm/frontswap.txt b/Documentation/vm/frontswap.txt
index c71a019..1979f43 100644
--- a/Documentation/vm/frontswap.txt
+++ b/Documentation/vm/frontswap.txt
@@ -1,13 +1,20 @@
+.. _frontswap:
+
+=========
+Frontswap
+=========
+
 Frontswap provides a "transcendent memory" interface for swap pages.
 In some environments, dramatic performance savings may be obtained because
 swapped pages are saved in RAM (or a RAM-like device) instead of a swap disk.
 
-(Note, frontswap -- and cleancache (merged at 3.0) -- are the "frontends"
+(Note, frontswap -- and :ref:`cleancache` (merged at 3.0) -- are the "frontends"
 and the only necessary changes to the core kernel for transcendent memory;
 all other supporting code -- the "backends" -- is implemented as drivers.
-See the LWN.net article "Transcendent memory in a nutshell" for a detailed
-overview of frontswap and related kernel parts:
-https://lwn.net/Articles/454795/ )
+See the LWN.net article `Transcendent memory in a nutshell`_
+for a detailed overview of frontswap and related kernel parts)
+
+.. _Transcendent memory in a nutshell: https://lwn.net/Articles/454795/
 
 Frontswap is so named because it can be thought of as the opposite of
 a "backing" store for a swap device.  The storage is assumed to be
@@ -50,19 +57,27 @@ or the store fails AND the page is invalidated.  This ensures stale data may
 never be obtained from frontswap.
 
 If properly configured, monitoring of frontswap is done via debugfs in
-the /sys/kernel/debug/frontswap directory.  The effectiveness of
+the `/sys/kernel/debug/frontswap` directory.  The effectiveness of
 frontswap can be measured (across all swap devices) with:
 
-failed_stores	- how many store attempts have failed
-loads		- how many loads were attempted (all should succeed)
-succ_stores	- how many store attempts have succeeded
-invalidates	- how many invalidates were attempted
+``failed_stores``
+	how many store attempts have failed
+
+``loads``
+	how many loads were attempted (all should succeed)
+
+``succ_stores``
+	how many store attempts have succeeded
+
+``invalidates``
+	how many invalidates were attempted
 
 A backend implementation may provide additional metrics.
 
 FAQ
+===
 
-1) Where's the value?
+* Where's the value?
 
 When a workload starts swapping, performance falls through the floor.
 Frontswap significantly increases performance in many such workloads by
@@ -117,8 +132,8 @@ A KVM implementation is underway and has been RFC'ed to lkml.  And,
 using frontswap, investigation is also underway on the use of NVM as
 a memory extension technology.
 
-2) Sure there may be performance advantages in some situations, but
-   what's the space/time overhead of frontswap?
+* Sure there may be performance advantages in some situations, but
+  what's the space/time overhead of frontswap?
 
 If CONFIG_FRONTSWAP is disabled, every frontswap hook compiles into
 nothingness and the only overhead is a few extra bytes per swapon'ed
@@ -148,8 +163,8 @@ pressure that can potentially outweigh the other advantages.  A
 backend, such as zcache, must implement policies to carefully (but
 dynamically) manage memory limits to ensure this doesn't happen.
 
-3) OK, how about a quick overview of what this frontswap patch does
-   in terms that a kernel hacker can grok?
+* OK, how about a quick overview of what this frontswap patch does
+  in terms that a kernel hacker can grok?
 
 Let's assume that a frontswap "backend" has registered during
 kernel initialization; this registration indicates that this
@@ -188,9 +203,9 @@ and (potentially) a swap device write are replaced by a "frontswap backend
 store" and (possibly) a "frontswap backend loads", which are presumably much
 faster.
 
-4) Can't frontswap be configured as a "special" swap device that is
-   just higher priority than any real swap device (e.g. like zswap,
-   or maybe swap-over-nbd/NFS)?
+* Can't frontswap be configured as a "special" swap device that is
+  just higher priority than any real swap device (e.g. like zswap,
+  or maybe swap-over-nbd/NFS)?
 
 No.  First, the existing swap subsystem doesn't allow for any kind of
 swap hierarchy.  Perhaps it could be rewritten to accommodate a hierarchy,
@@ -240,9 +255,9 @@ installation, frontswap is useless.  Swapless portable devices
 can still use frontswap but a backend for such devices must configure
 some kind of "ghost" swap device and ensure that it is never used.
 
-5) Why this weird definition about "duplicate stores"?  If a page
-   has been previously successfully stored, can't it always be
-   successfully overwritten?
+* Why this weird definition about "duplicate stores"?  If a page
+  has been previously successfully stored, can't it always be
+  successfully overwritten?
 
 Nearly always it can, but no, sometimes it cannot.  Consider an example
 where data is compressed and the original 4K page has been compressed
@@ -254,7 +269,7 @@ the old data and ensure that it is no longer accessible.  Since the
 swap subsystem then writes the new data to the read swap device,
 this is the correct course of action to ensure coherency.
 
-6) What is frontswap_shrink for?
+* What is frontswap_shrink for?
 
 When the (non-frontswap) swap subsystem swaps out a page to a real
 swap device, that page is only taking up low-value pre-allocated disk
@@ -267,7 +282,7 @@ to "repatriate" pages sent to a remote machine back to the local machine;
 this is driven using the frontswap_shrink mechanism when memory pressure
 subsides.
 
-7) Why does the frontswap patch create the new include file swapfile.h?
+* Why does the frontswap patch create the new include file swapfile.h?
 
 The frontswap code depends on some swap-subsystem-internal data
 structures that have, over the years, moved back and forth between
-- 
2.7.4
