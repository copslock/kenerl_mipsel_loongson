Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 02:28:54 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:48713 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008111AbbCEB22Lh0El (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Mar 2015 02:28:28 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t251RNWX006133;
        Wed, 4 Mar 2015 17:27:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Laura Abbott <lauraa@codeaurora.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 7/8] sparc: switch to using asm-generic for seccomp.h
Date:   Wed,  4 Mar 2015 17:27:07 -0800
Message-Id: <1425518828-16017-8-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46183
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

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. The obsolete sigreturn in COMPAT mode
is retained as an override. Remaining definitions are identical. Also
corrected missing #define for header reinclusion protection.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/include/asm/seccomp.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/seccomp.h b/arch/sparc/include/asm/seccomp.h
index adca1bce41d4..5ef8826d44f8 100644
--- a/arch/sparc/include/asm/seccomp.h
+++ b/arch/sparc/include/asm/seccomp.h
@@ -1,15 +1,10 @@
 #ifndef _ASM_SECCOMP_H
+#define _ASM_SECCOMP_H
 
 #include <linux/unistd.h>
 
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
 #define __NR_seccomp_sigreturn_32 __NR_sigreturn
 
+#include <asm-generic/seccomp.h>
+
 #endif /* _ASM_SECCOMP_H */
-- 
1.9.1
