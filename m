Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2014 22:28:54 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:17966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831275AbaCEV2T5aPE1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Mar 2014 22:28:19 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s25LSFIZ025498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 5 Mar 2014 16:28:15 -0500
Received: from madcap2.tricolour.ca (vpn-49-50.rdu2.redhat.com [10.10.49.50])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s25LRupF018777;
        Wed, 5 Mar 2014 16:28:07 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Cc:     Richard Guy Briggs <rgb@redhat.com>, eparis@redhat.com,
        sgrubb@redhat.com, oleg@redhat.com,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        linux-mips@linux-mips.org, linux@openrisc.net,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Subject: [PATCH 2/6][RFC] audit: add arch field to seccomp event log
Date:   Wed,  5 Mar 2014 16:27:03 -0500
Message-Id: <7f3959e9f2c971e91d63287518beb30aff56d917.1393974970.git.rgb@redhat.com>
In-Reply-To: <cover.1393974970.git.rgb@redhat.com>
References: <cover.1393974970.git.rgb@redhat.com>
In-Reply-To: <cover.1393974970.git.rgb@redhat.com>
References: <cover.1393974970.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <rgb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rgb@redhat.com
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

The AUDIT_SECCOMP record looks something like this:

type=SECCOMP msg=audit(1373478171.953:32775): auid=4325 uid=4325 gid=4325 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0 pid=12381 comm="test" sig=31 syscall=231 compat=0 ip=0x39ea8bca89 code=0x0

In order to determine what syscall 231 maps to, we need to have the arch= field right before it.

To see the event, compile this test.c program:

=====
int main(void)
{
        return seccomp_load(seccomp_init(SCMP_ACT_KILL));
}
=====

gcc -g test.c -o test -lseccomp

After running the program, find the record by:  ausearch --start recent -m SECCOMP -i

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

---
 kernel/auditsc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3bc12d2..7317f46 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -67,6 +67,7 @@
 #include <linux/binfmts.h>
 #include <linux/highmem.h>
 #include <linux/syscalls.h>
+#include <asm/syscall.h>
 #include <linux/capability.h>
 #include <linux/fs_struct.h>
 #include <linux/compat.h>
@@ -2415,6 +2416,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 		return;
 	audit_log_task(ab);
 	audit_log_format(ab, " sig=%ld", signr);
+	audit_log_format(ab, " arch=%x",
+			 syscall_get_arch(current, task_pt_regs(current)));
 	audit_log_format(ab, " syscall=%ld", syscall);
 	audit_log_format(ab, " compat=%d", is_compat_task());
 	audit_log_format(ab, " ip=0x%lx", KSTK_EIP(current));
-- 
1.7.1
