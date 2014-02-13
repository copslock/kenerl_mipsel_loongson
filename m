Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2014 18:27:46 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10962 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867079AbaBMR1kItha- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Feb 2014 18:27:40 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-next@vger.kernel.org>, <linux-kernel@linux-mips.org>
Subject: [PATCH] samples/seccomp/Makefile: Do not build tests if cross-compiling for MIPS
Date:   Thu, 13 Feb 2014 17:27:40 +0000
Message-ID: <1392312460-24902-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_13_17_27_34
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The Makefile is designed to use the host toolchain so it may be
unsafe to build the tests if the kernel has been configured and built
for another architecture. This fixes a build problem when the kernel has
been configured and built for the MIPS architecture but the host is
not MIPS (cross-compiled). The MIPS syscalls are only defined
if one of the following is true:

1) _MIPS_SIM == _MIPS_SIM_ABI64
2) _MIPS_SIM == _MIPS_SIM_ABI32
3) _MIPS_SIM == _MIPS_SIM_NABI32

Of course, none of these make sense on a non-MIPS toolchain and the
following build problem occurs when building on a non-MIPS host.

linux/usr/include/linux/kexec.h:50:
userspace cannot reference function or variable defined in the kernel
samples/seccomp/bpf-direct.c: In function ‘emulator’:
samples/seccomp/bpf-direct.c:76:17: error:
‘__NR_write’ undeclared (first use in this function)

Cc: linux-next@vger.kernel.org
Cc: linux-kernel@linux-mips.org
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This problem is only reproducible on the linux-next tree at the moment
---
 samples/seccomp/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 7203e66..f6bda1c 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -17,9 +17,14 @@ HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
 HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
 bpf-direct-objs := bpf-direct.o
 
+# MIPS system calls are defined based on the -mabi that is passed
+# to the toolchain which may or may not be a valid option
+# for the host toolchain. So disable tests if target architecture
+# is mips but the host isn't.
+ifndef CONFIG_MIPS
 # Try to match the kernel target.
-ifndef CONFIG_64BIT
 ifndef CROSS_COMPILE
+ifndef CONFIG_64BIT
 
 # s390 has -m31 flag to build 31 bit binaries
 ifndef CONFIG_S390
@@ -40,3 +45,4 @@ endif
 
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
+endif
-- 
1.8.5.4
