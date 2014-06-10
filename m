Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 01:06:32 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:38660 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859998AbaFJXESvLiuy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jun 2014 01:04:18 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s5AN2RFn021964;
        Tue, 10 Jun 2014 16:02:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        John Johansen <john.johansen@canonical.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "David A. Long" <dave.long@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kevin Hilman <khilman@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Juri Lelli <juri.lelli@gmail.com>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Dario Faggioli <raistlin@linux.it>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rik van Riel <riel@redhat.com>,
        Daeseok Youn <daeseok.youn@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Eric Paris <eparis@redhat.com>,
        Fabian Frederick <fabf@skynet.be>, Robin Holt <holt@sgi.com>,
        Dongsheng Yang <yangds.fnst@cn.fujitsu.com>,
        liguang <lig.fnst@cn.fujitsu.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Thorlton <athorlton@sgi.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v6 8/9] ARM: add seccomp syscall
Date:   Tue, 10 Jun 2014 16:01:53 -0700
Message-Id: <1402441314-7447-9-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1402441314-7447-1-git-send-email-keescook@chromium.org>
References: <1402441314-7447-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40471
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

Wires up the new seccomp syscall.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/uapi/asm/unistd.h |    1 +
 arch/arm/kernel/calls.S            |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index ba94446c72d9..e21b4a069701 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -409,6 +409,7 @@
 #define __NR_sched_setattr		(__NR_SYSCALL_BASE+380)
 #define __NR_sched_getattr		(__NR_SYSCALL_BASE+381)
 #define __NR_renameat2			(__NR_SYSCALL_BASE+382)
+#define __NR_seccomp			(__NR_SYSCALL_BASE+383)
 
 /*
  * This may need to be greater than __NR_last_syscall+1 in order to
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 8f51bdcdacbb..bea85f97f363 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -392,6 +392,7 @@
 /* 380 */	CALL(sys_sched_setattr)
 		CALL(sys_sched_getattr)
 		CALL(sys_renameat2)
+		CALL(sys_seccomp)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
-- 
1.7.9.5
