Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 01:46:20 +0100 (CET)
Received: from vmicros1.altlinux.org ([194.107.17.57]:36552 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbdCBAqNAXcw9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 01:46:13 +0100
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 71F4F72EF7A;
        Thu,  2 Mar 2017 03:46:07 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 646DD7CCE22; Thu,  2 Mar 2017 03:46:07 +0300 (MSK)
Date:   Thu, 2 Mar 2017 03:46:07 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: fix another asm/shmbuf.h userspace compilation error
Message-ID: <20170302004607.GE27132@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <ldv@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldv@altlinux.org
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

Replace size_t with __kernel_size_t to fix asm/shmbuf.h userspace
compilation errors like this:

/usr/include/asm-generic/shmbuf.h:28:2: error: unknown type name 'size_t'
  size_t   shm_segsz; /* size of segment (bytes) */

x32 is the only architecture where sizeof(size_t) is less than
sizeof(__kernel_size_t), but as the kernel treats shm_segsz field as
__kernel_size_t anyway, UAPI should follow.  Thanks to little-endiannes
of x32 and 64-bit alignment of the field following shm_segsz, this
change doesn't break ABI, and the difference doesn't manifest itself
easily.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/asm-generic/shmbuf.h      | 2 +-
 arch/alpha/include/uapi/asm/shmbuf.h   | 2 +-
 arch/avr32/include/uapi/asm/shmbuf.h   | 2 +-
 arch/frv/include/uapi/asm/shmbuf.h     | 2 +-
 arch/ia64/include/uapi/asm/shmbuf.h    | 2 +-
 arch/m32r/include/uapi/asm/shmbuf.h    | 2 +-
 arch/mips/include/uapi/asm/shmbuf.h    | 2 +-
 arch/mn10300/include/uapi/asm/shmbuf.h | 2 +-
 arch/powerpc/include/uapi/asm/shmbuf.h | 2 +-
 arch/s390/include/uapi/asm/shmbuf.h    | 2 +-
 arch/sparc/include/uapi/asm/shmbuf.h   | 2 +-
 arch/xtensa/include/uapi/asm/shmbuf.h  | 4 ++--
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 2a6d508..0756934 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -25,7 +25,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 #if __BITS_PER_LONG != 64
 	unsigned long		__unused1;
diff --git a/arch/alpha/include/uapi/asm/shmbuf.h b/arch/alpha/include/uapi/asm/shmbuf.h
index 6156099..e32ed1f 100644
--- a/arch/alpha/include/uapi/asm/shmbuf.h
+++ b/arch/alpha/include/uapi/asm/shmbuf.h
@@ -14,7 +14,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	__kernel_time_t		shm_dtime;	/* last detach time */
 	__kernel_time_t		shm_ctime;	/* last change time */
diff --git a/arch/avr32/include/uapi/asm/shmbuf.h b/arch/avr32/include/uapi/asm/shmbuf.h
index c8e5234..2804f25 100644
--- a/arch/avr32/include/uapi/asm/shmbuf.h
+++ b/arch/avr32/include/uapi/asm/shmbuf.h
@@ -15,7 +15,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	unsigned long		__unused1;
 	__kernel_time_t		shm_dtime;	/* last detach time */
diff --git a/arch/frv/include/uapi/asm/shmbuf.h b/arch/frv/include/uapi/asm/shmbuf.h
index 943746c..2af199f 100644
--- a/arch/frv/include/uapi/asm/shmbuf.h
+++ b/arch/frv/include/uapi/asm/shmbuf.h
@@ -15,7 +15,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	unsigned long		__unused1;
 	__kernel_time_t		shm_dtime;	/* last detach time */
diff --git a/arch/ia64/include/uapi/asm/shmbuf.h b/arch/ia64/include/uapi/asm/shmbuf.h
index ca81d77e..8e35495 100644
--- a/arch/ia64/include/uapi/asm/shmbuf.h
+++ b/arch/ia64/include/uapi/asm/shmbuf.h
@@ -14,7 +14,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	__kernel_time_t		shm_dtime;	/* last detach time */
 	__kernel_time_t		shm_ctime;	/* last change time */
diff --git a/arch/m32r/include/uapi/asm/shmbuf.h b/arch/m32r/include/uapi/asm/shmbuf.h
index 714de6e..fa36b9e 100644
--- a/arch/m32r/include/uapi/asm/shmbuf.h
+++ b/arch/m32r/include/uapi/asm/shmbuf.h
@@ -15,7 +15,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	unsigned long		__unused1;
 	__kernel_time_t		shm_dtime;	/* last detach time */
diff --git a/arch/mips/include/uapi/asm/shmbuf.h b/arch/mips/include/uapi/asm/shmbuf.h
index f47d193..95c53ff 100644
--- a/arch/mips/include/uapi/asm/shmbuf.h
+++ b/arch/mips/include/uapi/asm/shmbuf.h
@@ -14,7 +14,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	__kernel_time_t		shm_dtime;	/* last detach time */
 	__kernel_time_t		shm_ctime;	/* last change time */
diff --git a/arch/mn10300/include/uapi/asm/shmbuf.h b/arch/mn10300/include/uapi/asm/shmbuf.h
index 71df684..e156878 100644
--- a/arch/mn10300/include/uapi/asm/shmbuf.h
+++ b/arch/mn10300/include/uapi/asm/shmbuf.h
@@ -15,7 +15,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	unsigned long		__unused1;
 	__kernel_time_t		shm_dtime;	/* last detach time */
diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
index 7937289..a2425e5 100644
--- a/arch/powerpc/include/uapi/asm/shmbuf.h
+++ b/arch/powerpc/include/uapi/asm/shmbuf.h
@@ -38,7 +38,7 @@ struct shmid64_ds {
 #ifndef __powerpc64__
 	unsigned long		__unused4;
 #endif
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
diff --git a/arch/s390/include/uapi/asm/shmbuf.h b/arch/s390/include/uapi/asm/shmbuf.h
index 9ce1d9f..9ddf9e0 100644
--- a/arch/s390/include/uapi/asm/shmbuf.h
+++ b/arch/s390/include/uapi/asm/shmbuf.h
@@ -15,7 +15,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 #ifndef __s390x__
 	unsigned long		__unused1;
diff --git a/arch/sparc/include/uapi/asm/shmbuf.h b/arch/sparc/include/uapi/asm/shmbuf.h
index f651952..ed72656 100644
--- a/arch/sparc/include/uapi/asm/shmbuf.h
+++ b/arch/sparc/include/uapi/asm/shmbuf.h
@@ -27,7 +27,7 @@ struct shmid64_ds {
 	__kernel_time_t		shm_dtime;	/* last detach time */
 	PADDING(__pad3)
 	__kernel_time_t		shm_ctime;	/* last change time */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
diff --git a/arch/xtensa/include/uapi/asm/shmbuf.h b/arch/xtensa/include/uapi/asm/shmbuf.h
index ad90d05..8d9206e 100644
--- a/arch/xtensa/include/uapi/asm/shmbuf.h
+++ b/arch/xtensa/include/uapi/asm/shmbuf.h
@@ -24,7 +24,7 @@
 #if defined (__XTENSA_EL__)
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	unsigned long		__unused1;
 	__kernel_time_t		shm_dtime;	/* last detach time */
@@ -40,7 +40,7 @@ struct shmid64_ds {
 #elif defined (__XTENSA_EB__)
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
 	unsigned long		__unused1;
 	__kernel_time_t		shm_dtime;	/* last detach time */
-- 
ldv
