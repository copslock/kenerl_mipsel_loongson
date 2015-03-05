Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 02:30:01 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:42444 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008152AbbCEB23zR2-N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Mar 2015 02:28:29 +0100
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t251RHOs006098;
        Wed, 4 Mar 2015 17:27:17 -0800
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
Subject: [PATCH v3 1/8] seccomp: allow COMPAT sigreturn overrides
Date:   Wed,  4 Mar 2015 17:27:01 -0800
Message-Id: <1425518828-16017-2-git-send-email-keescook@chromium.org>
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
X-archive-position: 46187
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

Some architectures may need to override the compat sigreturn definition,
as is already possible in the non-compat case.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/seccomp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/seccomp.h b/include/asm-generic/seccomp.h
index 9fa1f653ed3b..c9ccafa0d99a 100644
--- a/include/asm-generic/seccomp.h
+++ b/include/asm-generic/seccomp.h
@@ -17,7 +17,9 @@
 #define __NR_seccomp_read_32		__NR_read
 #define __NR_seccomp_write_32		__NR_write
 #define __NR_seccomp_exit_32		__NR_exit
+#ifndef __NR_seccomp_sigreturn_32
 #define __NR_seccomp_sigreturn_32	__NR_rt_sigreturn
+#endif
 #endif /* CONFIG_COMPAT && ! already defined */
 
 #define __NR_seccomp_read		__NR_read
-- 
1.9.1
