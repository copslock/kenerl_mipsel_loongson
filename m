Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:23:24 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993890AbeCUTXMr-Xyj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:23:12 +0100
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJJ03T100591
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:10 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guv66up68-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:10 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:23:07 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:23:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJN13I59506710;
        Wed, 21 Mar 2018 19:23:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 406E442042;
        Wed, 21 Mar 2018 19:15:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2CE34203F;
        Wed, 21 Mar 2018 19:15:03 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:15:03 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:22:54 +0200
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
Subject: [PATCH 01/32] docs/vm: active_mm.txt convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:17 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0020-0000-0000-00000407E601
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0021-0000-0000-0000429C06AD
Message-Id: <1521660168-14372-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63092
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

Just add a label for cross-referencing and indent the text to make it
``literal``

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/active_mm.txt | 174 +++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 83 deletions(-)

diff --git a/Documentation/vm/active_mm.txt b/Documentation/vm/active_mm.txt
index dbf4581..c84471b 100644
--- a/Documentation/vm/active_mm.txt
+++ b/Documentation/vm/active_mm.txt
@@ -1,83 +1,91 @@
-List:       linux-kernel
-Subject:    Re: active_mm
-From:       Linus Torvalds <torvalds () transmeta ! com>
-Date:       1999-07-30 21:36:24
-
-Cc'd to linux-kernel, because I don't write explanations all that often,
-and when I do I feel better about more people reading them.
-
-On Fri, 30 Jul 1999, David Mosberger wrote:
->
-> Is there a brief description someplace on how "mm" vs. "active_mm" in
-> the task_struct are supposed to be used?  (My apologies if this was
-> discussed on the mailing lists---I just returned from vacation and
-> wasn't able to follow linux-kernel for a while).
-
-Basically, the new setup is:
-
- - we have "real address spaces" and "anonymous address spaces". The
-   difference is that an anonymous address space doesn't care about the
-   user-level page tables at all, so when we do a context switch into an
-   anonymous address space we just leave the previous address space
-   active.
-
-   The obvious use for a "anonymous address space" is any thread that
-   doesn't need any user mappings - all kernel threads basically fall into
-   this category, but even "real" threads can temporarily say that for
-   some amount of time they are not going to be interested in user space,
-   and that the scheduler might as well try to avoid wasting time on
-   switching the VM state around. Currently only the old-style bdflush
-   sync does that.
-
- - "tsk->mm" points to the "real address space". For an anonymous process,
-   tsk->mm will be NULL, for the logical reason that an anonymous process
-   really doesn't _have_ a real address space at all.
-
- - however, we obviously need to keep track of which address space we
-   "stole" for such an anonymous user. For that, we have "tsk->active_mm",
-   which shows what the currently active address space is.
-
-   The rule is that for a process with a real address space (ie tsk->mm is
-   non-NULL) the active_mm obviously always has to be the same as the real
-   one.
-
-   For a anonymous process, tsk->mm == NULL, and tsk->active_mm is the
-   "borrowed" mm while the anonymous process is running. When the
-   anonymous process gets scheduled away, the borrowed address space is
-   returned and cleared.
-
-To support all that, the "struct mm_struct" now has two counters: a
-"mm_users" counter that is how many "real address space users" there are,
-and a "mm_count" counter that is the number of "lazy" users (ie anonymous
-users) plus one if there are any real users.
-
-Usually there is at least one real user, but it could be that the real
-user exited on another CPU while a lazy user was still active, so you do
-actually get cases where you have a address space that is _only_ used by
-lazy users. That is often a short-lived state, because once that thread
-gets scheduled away in favour of a real thread, the "zombie" mm gets
-released because "mm_users" becomes zero.
-
-Also, a new rule is that _nobody_ ever has "init_mm" as a real MM any
-more. "init_mm" should be considered just a "lazy context when no other
-context is available", and in fact it is mainly used just at bootup when
-no real VM has yet been created. So code that used to check
-
-	if (current->mm == &init_mm)
-
-should generally just do
-
-	if (!current->mm)
-
-instead (which makes more sense anyway - the test is basically one of "do
-we have a user context", and is generally done by the page fault handler
-and things like that).
-
-Anyway, I put a pre-patch-2.3.13-1 on ftp.kernel.org just a moment ago,
-because it slightly changes the interfaces to accommodate the alpha (who
-would have thought it, but the alpha actually ends up having one of the
-ugliest context switch codes - unlike the other architectures where the MM
-and register state is separate, the alpha PALcode joins the two, and you
-need to switch both together).
-
-(From http://marc.info/?l=linux-kernel&m=93337278602211&w=2)
+.. _active_mm:
+
+=========
+Active MM
+=========
+
+::
+
+ List:       linux-kernel
+ Subject:    Re: active_mm
+ From:       Linus Torvalds <torvalds () transmeta ! com>
+ Date:       1999-07-30 21:36:24
+
+ Cc'd to linux-kernel, because I don't write explanations all that often,
+ and when I do I feel better about more people reading them.
+
+ On Fri, 30 Jul 1999, David Mosberger wrote:
+ >
+ > Is there a brief description someplace on how "mm" vs. "active_mm" in
+ > the task_struct are supposed to be used?  (My apologies if this was
+ > discussed on the mailing lists---I just returned from vacation and
+ > wasn't able to follow linux-kernel for a while).
+
+ Basically, the new setup is:
+
+  - we have "real address spaces" and "anonymous address spaces". The
+    difference is that an anonymous address space doesn't care about the
+    user-level page tables at all, so when we do a context switch into an
+    anonymous address space we just leave the previous address space
+    active.
+
+    The obvious use for a "anonymous address space" is any thread that
+    doesn't need any user mappings - all kernel threads basically fall into
+    this category, but even "real" threads can temporarily say that for
+    some amount of time they are not going to be interested in user space,
+    and that the scheduler might as well try to avoid wasting time on
+    switching the VM state around. Currently only the old-style bdflush
+    sync does that.
+
+  - "tsk->mm" points to the "real address space". For an anonymous process,
+    tsk->mm will be NULL, for the logical reason that an anonymous process
+    really doesn't _have_ a real address space at all.
+
+  - however, we obviously need to keep track of which address space we
+    "stole" for such an anonymous user. For that, we have "tsk->active_mm",
+    which shows what the currently active address space is.
+
+    The rule is that for a process with a real address space (ie tsk->mm is
+    non-NULL) the active_mm obviously always has to be the same as the real
+    one.
+
+    For a anonymous process, tsk->mm == NULL, and tsk->active_mm is the
+    "borrowed" mm while the anonymous process is running. When the
+    anonymous process gets scheduled away, the borrowed address space is
+    returned and cleared.
+
+ To support all that, the "struct mm_struct" now has two counters: a
+ "mm_users" counter that is how many "real address space users" there are,
+ and a "mm_count" counter that is the number of "lazy" users (ie anonymous
+ users) plus one if there are any real users.
+
+ Usually there is at least one real user, but it could be that the real
+ user exited on another CPU while a lazy user was still active, so you do
+ actually get cases where you have a address space that is _only_ used by
+ lazy users. That is often a short-lived state, because once that thread
+ gets scheduled away in favour of a real thread, the "zombie" mm gets
+ released because "mm_users" becomes zero.
+
+ Also, a new rule is that _nobody_ ever has "init_mm" as a real MM any
+ more. "init_mm" should be considered just a "lazy context when no other
+ context is available", and in fact it is mainly used just at bootup when
+ no real VM has yet been created. So code that used to check
+
+ 	if (current->mm == &init_mm)
+
+ should generally just do
+
+ 	if (!current->mm)
+
+ instead (which makes more sense anyway - the test is basically one of "do
+ we have a user context", and is generally done by the page fault handler
+ and things like that).
+
+ Anyway, I put a pre-patch-2.3.13-1 on ftp.kernel.org just a moment ago,
+ because it slightly changes the interfaces to accommodate the alpha (who
+ would have thought it, but the alpha actually ends up having one of the
+ ugliest context switch codes - unlike the other architectures where the MM
+ and register state is separate, the alpha PALcode joins the two, and you
+ need to switch both together).
+
+ (From http://marc.info/?l=linux-kernel&m=93337278602211&w=2)
-- 
2.7.4
