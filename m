Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 22:13:13 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:42145 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008122AbbCDVMEPBp6f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Mar 2015 22:12:04 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t24LAuCh020851;
        Wed, 4 Mar 2015 13:10:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll <iripoll@upv.es>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Borislav Petkov <bp@suse.de>,
        =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 02/10] x86: standardize mmap_rnd() usage
Date:   Wed,  4 Mar 2015 13:10:46 -0800
Message-Id: <1425503454-7531-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

In preparation for splitting out ET_DYN ASLR, this refactors the use of
mmap_rnd() to be used similarly to arm, and extracts the checking of
PF_RANDOMIZE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/mm/mmap.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index df4552bd239e..ebfa52030d5c 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -67,22 +67,21 @@ static int mmap_is_legacy(void)
 
 static unsigned long mmap_rnd(void)
 {
-	unsigned long rnd = 0;
+	unsigned long rnd;
 
 	/*
-	*  8 bits of randomness in 32bit mmaps, 20 address space bits
-	* 28 bits of randomness in 64bit mmaps, 40 address space bits
-	*/
-	if (current->flags & PF_RANDOMIZE) {
-		if (mmap_is_ia32())
-			rnd = get_random_int() % (1<<8);
-		else
-			rnd = get_random_int() % (1<<28);
-	}
+	 *  8 bits of randomness in 32bit mmaps, 20 address space bits
+	 * 28 bits of randomness in 64bit mmaps, 40 address space bits
+	 */
+	if (mmap_is_ia32())
+		rnd = (unsigned long)get_random_int() % (1<<8);
+	else
+		rnd = (unsigned long)get_random_int() % (1<<28);
+
 	return rnd << PAGE_SHIFT;
 }
 
-static unsigned long mmap_base(void)
+static unsigned long mmap_base(unsigned long rnd)
 {
 	unsigned long gap = rlimit(RLIMIT_STACK);
 
@@ -91,19 +90,19 @@ static unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(TASK_SIZE - gap - mmap_rnd());
+	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
 }
 
 /*
  * Bottom-up (legacy) layout on X86_32 did not support randomization, X86_64
  * does, but not when emulating X86_32
  */
-static unsigned long mmap_legacy_base(void)
+static unsigned long mmap_legacy_base(unsigned long rnd)
 {
 	if (mmap_is_ia32())
 		return TASK_UNMAPPED_BASE;
 	else
-		return TASK_UNMAPPED_BASE + mmap_rnd();
+		return TASK_UNMAPPED_BASE + rnd;
 }
 
 /*
@@ -112,13 +111,18 @@ static unsigned long mmap_legacy_base(void)
  */
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
-	mm->mmap_legacy_base = mmap_legacy_base();
-	mm->mmap_base = mmap_base();
+	unsigned long random_factor = 0UL;
+
+	if (current->flags & PF_RANDOMIZE)
+		random_factor = mmap_rnd();
+
+	mm->mmap_legacy_base = mmap_legacy_base(random_factor);
 
 	if (mmap_is_legacy()) {
 		mm->mmap_base = mm->mmap_legacy_base;
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
+		mm->mmap_base = mmap_base(random_factor);
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
-- 
1.9.1
