Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:40:27 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:55751 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994627AbeDSOi6Qrq0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:38:58 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MPp3a-1f5LCf3dR4-00545j; Thu, 19 Apr 2018 16:37:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 05/17] y2038: arm64: Extend sysvipc compat data structures
Date:   Thu, 19 Apr 2018 16:37:25 +0200
Message-Id: <20180419143737.606138-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:0JzYSZcHr7NxbSRG/1MxgZaJ5JU+b3m4LiNGtOkxl/QzRgNqGf9
 HDvtz0qrMIjJMP1YuATtpumjuElGmO3EPCUs2FdfOtyJAJxiyzWX+oSL4Oad9KGjqQ0LLY/
 fK/s1hgkMF2ydYQatBY4p2CWjH0UybJtbktZR/PkiyJazDMpQej0ek+vTUtcXxvo+95GFTt
 qPX8dlcqBNUzSaaGi+7DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yqv5fC47tG0=:pnVW2fG3BmXOs6HCM/g/Fi
 kaWsTJEz6m3QVPtBL+1rMrb/IWI3iJc24yNU9uM7fgC5tshukHsB5u7DFEgE4dBu5/afNgvit
 JubdB2GJHb+C0IMhPRWlg7WQxlFF/wo3DurvbPpYvuFWDJFYQ+eqdEKtrfyCBmD8/ztCeDUWY
 MABvtlTPUNlXzajX7Bj/XPF8s6wPNaUMXBHd24E4wtAwqQnah0WI5W/C4jqv9Y8oLa620ShEc
 ObzDvuoxm1fkaJBEKaSat7pP162+r0pF5T3BuuVtaJfBR39XojRYXuNuiTG8gePnRfaWqf99K
 XA0idEDa4WNW6tIFoh9SXQyhoDbXPskOMdZrJj3xAON5IdTi4rh5aWwKaZ4RVhs80El5WHDZD
 Yj5jutOkcGUjw904K3RXhginebeUVy/tBny9elvakEt3tMKZgTYr9aK0ppSNrrc1rH9R3Csmq
 MUZrWRt+uSKJUZJKpaezFKGxD9bf/PFVBoCAdfnsJVJ8qOiK+oR7+0pJKhZR/L1wg7/4xYlzU
 /bo+4e4sWK2UiREfL16ll4Qq5p57Omqm0j5+zH1fnTADBp0Y8jG1654xluyDQn7AxzXflJf29
 sSiLnCRHV2G+CmNIiV+tSNWvGbVxuSC3pjmFccCJwzcqVLiHpdULQn5WFFp0jNCGRILvlKLWV
 djUwOvdXzN798OtHSlo9GnACZfgGU6BfP24DztxUeVlKX1hg5/sS/vF5joRP1Cr5fvAmjOSS7
 svQXWOUUGmfMqYn47kAV+ti4RbBUuCQ4sofKiw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63611
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
