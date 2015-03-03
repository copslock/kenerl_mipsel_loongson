Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 01:39:24 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:56377 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007628AbbCCAjS0jYQy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Mar 2015 01:39:18 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t230JrTM011893;
        Mon, 2 Mar 2015 16:19:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Borislav Petkov <bp@suse.de>,
        =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] mm: move randomize_et_dyn into ELF_ET_DYN_BASE
Date:   Mon,  2 Mar 2015 16:19:46 -0800
Message-Id: <1425341988-1599-4-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46087
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

In preparation for moving ET_DYN randomization into the ELF loader
(which requires a static ELF_ET_DYN_BASE), this redefines s390's existing
ET_DYN randomization away from a separate function (randomize_et_dyn)
and into ELF_ET_DYN_BASE and a call to arch_mmap_rnd(). This refactoring
results in the same ET_DYN randomization on s390. Additionally removes
a copy/pasted unused arm64 extern.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/elf.h |  1 -
 arch/s390/include/asm/elf.h  |  9 +++++----
 arch/s390/mm/mmap.c          | 11 -----------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 1f65be393139..f724db00b235 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -125,7 +125,6 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  * the loader.  We need to make sure that it is out of the way of the program
  * that it will "exec", and that there is sufficient room for the brk.
  */
-extern unsigned long randomize_et_dyn(unsigned long base);
 #define ELF_ET_DYN_BASE	(2 * TASK_SIZE_64 / 3)
 
 /*
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index c9df40b5c0ac..9ed68e7ee856 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -161,10 +161,11 @@ extern unsigned int vdso_enabled;
 /* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
    use of this is to invoke "./ld.so someprog" to test out a new version of
    the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
-extern unsigned long randomize_et_dyn(void);
-#define ELF_ET_DYN_BASE		randomize_et_dyn()
+   that it will "exec", and that there is sufficient room for the brk. 64-bit
+   tasks are aligned to 4GB. */
+#define ELF_ET_DYN_BASE (arch_mmap_rnd() + (is_32bit_task() ? \
+				(STACK_TOP / 3 * 2) : \
+				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1)))
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 77759e35671b..ec4c20448aef 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -179,17 +179,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-unsigned long randomize_et_dyn(void)
-{
-	unsigned long base;
-
-	base = STACK_TOP / 3 * 2;
-	if (!is_32bit_task())
-		/* Align to 4GB */
-		base &= ~((1UL << 32) - 1);
-	return base + arch_mmap_rnd();
-}
-
 #ifndef CONFIG_64BIT
 
 /*
-- 
1.9.1
