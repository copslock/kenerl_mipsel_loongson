Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:27:29 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994692AbeCUTYLSHN3s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:24:11 +0100
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJMWau078826
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:09 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2guwg9g2gn-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:08 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:24:06 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:24:01 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJO0Ci25493658;
        Wed, 21 Mar 2018 19:24:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37199AE045;
        Wed, 21 Mar 2018 19:14:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F79FAE04D;
        Wed, 21 Mar 2018 19:14:16 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:14:16 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:23:55 +0200
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
Subject: [PATCH 14/32] docs/vm: overcommit-accounting: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:30 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0020-0000-0000-00000407E60F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0021-0000-0000-0000429C06BB
Message-Id: <1521660168-14372-15-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63105
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
 Documentation/vm/overcommit-accounting | 107 ++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/Documentation/vm/overcommit-accounting b/Documentation/vm/overcommit-accounting
index cbfaaa6..0dd54bb 100644
--- a/Documentation/vm/overcommit-accounting
+++ b/Documentation/vm/overcommit-accounting
@@ -1,80 +1,87 @@
+.. _overcommit_accounting:
+
+=====================
+Overcommit Accounting
+=====================
+
 The Linux kernel supports the following overcommit handling modes
 
-0	-	Heuristic overcommit handling. Obvious overcommits of
-		address space are refused. Used for a typical system. It
-		ensures a seriously wild allocation fails while allowing
-		overcommit to reduce swap usage.  root is allowed to 
-		allocate slightly more memory in this mode. This is the 
-		default.
+0
+	Heuristic overcommit handling. Obvious overcommits of address
+	space are refused. Used for a typical system. It ensures a
+	seriously wild allocation fails while allowing overcommit to
+	reduce swap usage.  root is allowed to allocate slightly more
+	memory in this mode. This is the default.
 
-1	-	Always overcommit. Appropriate for some scientific
-		applications. Classic example is code using sparse arrays
-		and just relying on the virtual memory consisting almost
-		entirely of zero pages.
+1
+	Always overcommit. Appropriate for some scientific
+	applications. Classic example is code using sparse arrays and
+	just relying on the virtual memory consisting almost entirely
+	of zero pages.
 
-2	-	Don't overcommit. The total address space commit
-		for the system is not permitted to exceed swap + a
-		configurable amount (default is 50%) of physical RAM.
-		Depending on the amount you use, in most situations
-		this means a process will not be killed while accessing
-		pages but will receive errors on memory allocation as
-		appropriate.
+2
+	Don't overcommit. The total address space commit for the
+	system is not permitted to exceed swap + a configurable amount
+	(default is 50%) of physical RAM.  Depending on the amount you
+	use, in most situations this means a process will not be
+	killed while accessing pages but will receive errors on memory
+	allocation as appropriate.
 
-		Useful for applications that want to guarantee their
-		memory allocations will be available in the future
-		without having to initialize every page.
+	Useful for applications that want to guarantee their memory
+	allocations will be available in the future without having to
+	initialize every page.
 
-The overcommit policy is set via the sysctl `vm.overcommit_memory'.
+The overcommit policy is set via the sysctl ``vm.overcommit_memory``.
 
-The overcommit amount can be set via `vm.overcommit_ratio' (percentage)
-or `vm.overcommit_kbytes' (absolute value).
+The overcommit amount can be set via ``vm.overcommit_ratio`` (percentage)
+or ``vm.overcommit_kbytes`` (absolute value).
 
 The current overcommit limit and amount committed are viewable in
-/proc/meminfo as CommitLimit and Committed_AS respectively.
+``/proc/meminfo`` as CommitLimit and Committed_AS respectively.
 
 Gotchas
--------
+=======
 
 The C language stack growth does an implicit mremap. If you want absolute
-guarantees and run close to the edge you MUST mmap your stack for the 
+guarantees and run close to the edge you MUST mmap your stack for the
 largest size you think you will need. For typical stack usage this does
 not matter much but it's a corner case if you really really care
 
-In mode 2 the MAP_NORESERVE flag is ignored. 
+In mode 2 the MAP_NORESERVE flag is ignored.
 
 
 How It Works
-------------
+============
 
 The overcommit is based on the following rules
 
 For a file backed map
-	SHARED or READ-only	-	0 cost (the file is the map not swap)
-	PRIVATE WRITABLE	-	size of mapping per instance
+	| SHARED or READ-only	-	0 cost (the file is the map not swap)
+	| PRIVATE WRITABLE	-	size of mapping per instance
 
-For an anonymous or /dev/zero map
-	SHARED			-	size of mapping
-	PRIVATE READ-only	-	0 cost (but of little use)
-	PRIVATE WRITABLE	-	size of mapping per instance
+For an anonymous or ``/dev/zero`` map
+	| SHARED			-	size of mapping
+	| PRIVATE READ-only	-	0 cost (but of little use)
+	| PRIVATE WRITABLE	-	size of mapping per instance
 
 Additional accounting
-	Pages made writable copies by mmap
-	shmfs memory drawn from the same pool
+	| Pages made writable copies by mmap
+	| shmfs memory drawn from the same pool
 
 Status
-------
-
-o	We account mmap memory mappings
-o	We account mprotect changes in commit
-o	We account mremap changes in size
-o	We account brk
-o	We account munmap
-o	We report the commit status in /proc
-o	Account and check on fork
-o	Review stack handling/building on exec
-o	SHMfs accounting
-o	Implement actual limit enforcement
+======
+
+*	We account mmap memory mappings
+*	We account mprotect changes in commit
+*	We account mremap changes in size
+*	We account brk
+*	We account munmap
+*	We report the commit status in /proc
+*	Account and check on fork
+*	Review stack handling/building on exec
+*	SHMfs accounting
+*	Implement actual limit enforcement
 
 To Do
------
-o	Account ptrace pages (this is hard)
+=====
+*	Account ptrace pages (this is hard)
-- 
2.7.4
