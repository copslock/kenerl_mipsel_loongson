Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:12:06 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.130]:53179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994585AbeDYPL7BvgKC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:11:59 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M7yDJ-1eP93h2r0D-00vcU2; Wed, 25 Apr 2018 17:06:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        zackw@panix.com, noloader@gmail.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 06/16] y2038: arm64: Extend sysvipc compat data structures
Date:   Wed, 25 Apr 2018 17:05:56 +0200
Message-Id: <20180425150606.954771-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:fcRe0DNUcAVypwYlTp3IXYFjuFjQDfKycU59jL2OVL1JElO2Czw
 OE3O+8kugMP8MM8qSe0gl4B84vNx8+8fz8CM0FUk0juPvtVA5NIs2vXpuvE13AsmxMmxuWQ
 zAmwTXQC3OJAye3+ai4/1PSx820rUFtAlA13zxP95WAEKTVRPfspaYCR+JGE7Vc2mrI+6D6
 Q4DTVOwUDgW9NCviLvM4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5DF63PkmOZo=:aHh74NeT3u2ZSVdacBqemX
 +OgQnTWtvULVk3AyDRneAvKH3R/CC+2OEBKWWmZ47pfFbEuM7+OG44vQjTSD7aWscavqKlJE3
 D4dvgoDnYxHfRuzb7JWJJeVoHrFu089TjO05RGKg82S7i7DnMXiLihFnTUlTJ1qui+G8fMm0U
 KMnJgWaav9p7FrHCESq/tTzvtzhB0puPNTicKTVBIInsTFSsyXjBiJ2ynuCrTkslg7BIifFOf
 HI+gZ6lXmDQ+CysBvE6KiOmmrm4oOvJD6QMrK1/uODQqVhx69CYjPQytrNE4Whywbv8X/xSju
 olrd0EiPfTLFFrzpQ8tgOlJ2/aLpaJ2QNRuZj1pn7+YRw42r6GExgIA5kcpZvUwxAZEuH7lLE
 dlL+/gM+iKNsOxmqdeKhW2aULrnnObBT/M9zt1wadrhd6Rd43hsSM/g+WJj4P5lU+sXKmkAzM
 bU3BuyJ4urHe8HiTSSNvywsnvbjJJURyn6who2U5OZ3ltGomYF8D0qRgVCeP/MpOV4HC/9yK7
 DyN+VXaX3i31zpCCEQOZ0Ea5O8zTFYclkC11FOvloYIaxbW6uUx8N+kpwpuweAuTRKT2JHo0z
 5MENXYM4aJYUNNjDadPDn6hEYuHfq8jztoaSg+7lppghIwO6kei8lNZT5Xg39+GWSC4Esgv5u
 EB6WLUAuNpamsY10tyHcbHLB/zNmLu24NU7S0qMzWC/K8U9RfjAp+BIDFDFht9ElcSzutk8Uu
 l/9MKfuchOqX1rk7+wInQ0poBINe2fvOnxe+lw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

Both 32-bit amd 64-bit ARM use the asm-generic header files for their
sysvipc data structures, so no special care is needed to make those
work beyond y2038, with the one exception of compat mode: Since there
is no asm-generic definition of the compat mode IPC structures, ARM64
provides its own copy, and we make those match the changes in the native
asm-generic header files.

There is sufficient padding in these data structures to extend all
timestamps to 64 bit, but on big-endian ARM kernels, the padding
is in the wrong place, so the C library has to ensure it reassembles
a 64-bit time_t correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 0030f79808b3..1a037b94eba1 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -181,10 +181,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -192,12 +192,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -210,12 +210,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
-- 
2.9.0
