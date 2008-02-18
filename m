Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 21:02:46 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:50662 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S28574353AbYBRVCn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 21:02:43 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 2471C8FFC55;
	Tue, 19 Feb 2008 00:02:38 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-10-189.pppoe.mtu-net.ru [85.140.10.189])
	by smtp06.mtu.ru (Postfix) with ESMTP id 002A38FFC3D;
	Tue, 19 Feb 2008 00:02:37 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [MIPS] Enable the timerfd_*() o32 system calls
Date:	Tue, 19 Feb 2008 00:02:37 +0300
Message-Id: <1203368557-32356-1-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch enables the system calls timerfd_create(), timerfd_settime()
and timerfd_gettime() for MIPS architecture.

Please see the following Bugzilla entry for more details:

http://bugzilla.kernel.org/show_bug.cgi?id=10038

This was tested using a Malta 4Kc board in both little-endian and
big-endian modes. The unit test program is available from the URL
above.

Note that only the "o32"-style system calls have been added. This is
due to the fact that I have no suitable equipment to test the other
flavors of MIPS ABI.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/kernel/scall32-o32.S |    3 +++
 include/asm-mips/unistd.h      |    7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index f798139..08a9c50 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -663,6 +663,9 @@ einval:	li	v0, -EINVAL
 	sys	sys_ni_syscall		0
 	sys	sys_eventfd		1
 	sys	sys_fallocate		6	/* 4320 */
+	sys	sys_timerfd_create	2
+	sys	sys_timerfd_gettime	2
+	sys	sys_timerfd_settime	4
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index fa9a587..7316b55 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -341,16 +341,19 @@
 #define __NR_timerfd			(__NR_Linux + 318)
 #define __NR_eventfd			(__NR_Linux + 319)
 #define __NR_fallocate			(__NR_Linux + 320)
+#define __NR_timerfd_create		(__NR_Linux + 321)
+#define __NR_timerfd_gettime		(__NR_Linux + 322)
+#define __NR_timerfd_settime		(__NR_Linux + 323)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		320
+#define __NR_Linux_syscalls		323
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		320
+#define __NR_O32_Linux_syscalls		323
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
-- 
1.5.3
