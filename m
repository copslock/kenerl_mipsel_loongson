Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:25:56 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994675AbeCUTXsArvQP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:23:48 +0100
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJIaS5099120
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:46 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guv66uq27-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:46 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:23:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:23:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJNaJH56033476;
        Wed, 21 Mar 2018 19:23:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36FF511C050;
        Wed, 21 Mar 2018 19:16:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 178BD11C04C;
        Wed, 21 Mar 2018 19:16:04 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:16:03 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:23:32 +0200
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
Subject: [PATCH 09/32] docs/vm: hwpoison.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:25 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0044-0000-0000-0000053E733C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0045-0000-0000-0000287D78DF
Message-Id: <1521660168-14372-10-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63100
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
 Documentation/vm/hwpoison.txt | 141 +++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 71 deletions(-)

diff --git a/Documentation/vm/hwpoison.txt b/Documentation/vm/hwpoison.txt
index e912d7e..b1a8c24 100644
--- a/Documentation/vm/hwpoison.txt
+++ b/Documentation/vm/hwpoison.txt
@@ -1,7 +1,14 @@
+.. hwpoison:
+
+========
+hwpoison
+========
+
 What is hwpoison?
+=================
 
 Upcoming Intel CPUs have support for recovering from some memory errors
-(``MCA recovery''). This requires the OS to declare a page "poisoned",
+(``MCA recovery``). This requires the OS to declare a page "poisoned",
 kill the processes associated with it and avoid using it in the future.
 
 This patchkit implements the necessary infrastructure in the VM.
@@ -46,9 +53,10 @@ address. This in theory allows other applications to handle
 memory failures too. The expection is that near all applications
 won't do that, but some very specialized ones might.
 
----
+Failure recovery modes
+======================
 
-There are two (actually three) modi memory failure recovery can be in:
+There are two (actually three) modes memory failure recovery can be in:
 
 vm.memory_failure_recovery sysctl set to zero:
 	All memory failures cause a panic. Do not attempt recovery.
@@ -67,9 +75,8 @@ late kill
 	This is best for memory error unaware applications and default
 	Note some pages are always handled as late kill.
 
----
-
-User control:
+User control
+============
 
 vm.memory_failure_recovery
 	See sysctl.txt
@@ -79,11 +86,19 @@ vm.memory_failure_early_kill
 
 PR_MCE_KILL
 	Set early/late kill mode/revert to system default
-	arg1: PR_MCE_KILL_CLEAR: Revert to system default
-	arg1: PR_MCE_KILL_SET: arg2 defines thread specific mode
-		PR_MCE_KILL_EARLY: Early kill
-		PR_MCE_KILL_LATE:  Late kill
-		PR_MCE_KILL_DEFAULT: Use system global default
+
+	arg1: PR_MCE_KILL_CLEAR:
+		Revert to system default
+	arg1: PR_MCE_KILL_SET:
+		arg2 defines thread specific mode
+
+		PR_MCE_KILL_EARLY:
+			Early kill
+		PR_MCE_KILL_LATE:
+			Late kill
+		PR_MCE_KILL_DEFAULT
+			Use system global default
+
 	Note that if you want to have a dedicated thread which handles
 	the SIGBUS(BUS_MCEERR_AO) on behalf of the process, you should
 	call prctl(PR_MCE_KILL_EARLY) on the designated thread. Otherwise,
@@ -92,77 +107,64 @@ PR_MCE_KILL
 PR_MCE_KILL_GET
 	return current mode
 
+Testing
+=======
 
----
-
-Testing:
-
-madvise(MADV_HWPOISON, ....)
-	(as root)
-	Poison a page in the process for testing
-
+* madvise(MADV_HWPOISON, ....) (as root) - Poison a page in the
+  process for testing
 
-hwpoison-inject module through debugfs
+* hwpoison-inject module through debugfs ``/sys/kernel/debug/hwpoison/``
 
-/sys/kernel/debug/hwpoison/
+  corrupt-pfn
+	Inject hwpoison fault at PFN echoed into this file. This does
+	some early filtering to avoid corrupted unintended pages in test suites.
 
-corrupt-pfn
+  unpoison-pfn
+	Software-unpoison page at PFN echoed into this file. This way
+	a page can be reused again.  This only works for Linux
+	injected failures, not for real memory failures.
 
-Inject hwpoison fault at PFN echoed into this file. This does
-some early filtering to avoid corrupted unintended pages in test suites.
+  Note these injection interfaces are not stable and might change between
+  kernel versions
 
-unpoison-pfn
+  corrupt-filter-dev-major, corrupt-filter-dev-minor
+	Only handle memory failures to pages associated with the file
+	system defined by block device major/minor.  -1U is the
+	wildcard value.  This should be only used for testing with
+	artificial injection.
 
-Software-unpoison page at PFN echoed into this file. This
-way a page can be reused again.
-This only works for Linux injected failures, not for real
-memory failures.
+  corrupt-filter-memcg
+	Limit injection to pages owned by memgroup. Specified by inode
+	number of the memcg.
 
-Note these injection interfaces are not stable and might change between
-kernel versions
+	Example::
 
-corrupt-filter-dev-major
-corrupt-filter-dev-minor
+		mkdir /sys/fs/cgroup/mem/hwpoison
 
-Only handle memory failures to pages associated with the file system defined
-by block device major/minor.  -1U is the wildcard value.
-This should be only used for testing with artificial injection.
+	        usemem -m 100 -s 1000 &
+		echo `jobs -p` > /sys/fs/cgroup/mem/hwpoison/tasks
 
-corrupt-filter-memcg
+		memcg_ino=$(ls -id /sys/fs/cgroup/mem/hwpoison | cut -f1 -d' ')
+		echo $memcg_ino > /debug/hwpoison/corrupt-filter-memcg
 
-Limit injection to pages owned by memgroup. Specified by inode number
-of the memcg.
+		page-types -p `pidof init`   --hwpoison  # shall do nothing
+		page-types -p `pidof usemem` --hwpoison  # poison its pages
 
-Example:
-        mkdir /sys/fs/cgroup/mem/hwpoison
+  corrupt-filter-flags-mask, corrupt-filter-flags-value
+	When specified, only poison pages if ((page_flags & mask) ==
+	value).  This allows stress testing of many kinds of
+	pages. The page_flags are the same as in /proc/kpageflags. The
+	flag bits are defined in include/linux/kernel-page-flags.h and
+	documented in Documentation/vm/pagemap.txt
 
-        usemem -m 100 -s 1000 &
-        echo `jobs -p` > /sys/fs/cgroup/mem/hwpoison/tasks
+* Architecture specific MCE injector
 
-        memcg_ino=$(ls -id /sys/fs/cgroup/mem/hwpoison | cut -f1 -d' ')
-        echo $memcg_ino > /debug/hwpoison/corrupt-filter-memcg
+  x86 has mce-inject, mce-test
 
-        page-types -p `pidof init`   --hwpoison  # shall do nothing
-        page-types -p `pidof usemem` --hwpoison  # poison its pages
+  Some portable hwpoison test programs in mce-test, see below.
 
-corrupt-filter-flags-mask
-corrupt-filter-flags-value
-
-When specified, only poison pages if ((page_flags & mask) == value).
-This allows stress testing of many kinds of pages. The page_flags
-are the same as in /proc/kpageflags. The flag bits are defined in
-include/linux/kernel-page-flags.h and documented in
-Documentation/vm/pagemap.txt
-
-Architecture specific MCE injector
-
-x86 has mce-inject, mce-test
-
-Some portable hwpoison test programs in mce-test, see blow.
-
----
-
-References:
+References
+==========
 
 http://halobates.de/mce-lc09-2.pdf
 	Overview presentation from LinuxCon 09
@@ -174,14 +176,11 @@ git://git.kernel.org/pub/scm/utils/cpu/mce/mce-inject.git
 	x86 specific injector
 
 
----
-
-Limitations:
-
+Limitations
+===========
 - Not all page types are supported and never will. Most kernel internal
-objects cannot be recovered, only LRU pages for now.
+  objects cannot be recovered, only LRU pages for now.
 - Right now hugepage support is missing.
 
 ---
 Andi Kleen, Oct 2009
-
-- 
2.7.4
