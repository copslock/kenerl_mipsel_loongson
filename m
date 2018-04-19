Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:41:14 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.73]:36455 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994666AbeDSOjDC2MmB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:39:03 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Mbyf0-1etIVT05wc-00JJ9z; Thu, 19 Apr 2018 16:38:01 +0200
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
Subject: [PATCH v3 16/17] y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop
Date:   Thu, 19 Apr 2018 16:37:36 +0200
Message-Id: <20180419143737.606138-17-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:taoylyHn9hPzLr8FvCdtoSclzmM7wtpNeibvAXK4GS65SL861VQ
 GVWSy7pErm1JOGiMO0VOzhm9fNOISb9xqito4CfsTGt3DzOCBp6R/kK0uODsoMyEV4y2VDf
 jBp3PyV98WDwgoZGFYXP7HUNuMJAGGiG3XyQpFUCHs0S0TESX0JweLqM8+ejD010uTrK9fL
 yCTQgNsVmi/xIwMSkzJTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wQXGZSTpe0U=:a/xBmS8XT/fFtn9/F9/ipp
 Y6bU55DSx34IJD2DR9vhY8W4gBLt1pQBF4swNmKRid5DyoGpkQkSSBuq3clFURdvSdreXTHPd
 o5cp4UrAdU8UHRZa4ePr04Igj1dJodu1ZjeIyfdREmGyTw66ND8BTVcEDQETzxEdn5ro8nIn1
 urhbE7cqq1GADF5lprGO1TV6azwqVdKM9Vtt6+A38DWb1jGMGx3baOHN+qsJaP4r2L6xqAPcd
 rJ6BaIhL1mzeg7nmWfzcyghexZB0H6+XAEuH3AMu9jqEjnLql9HCBGi1+YUnBKj1jzQYPObFp
 EJV2ERi/VPG+uB3/Mw/deLcTw/+wFdb+QFs8NnJTamZSeBa25aVEf8jfHoW7Lg51QBUQ1Eu+S
 rUrkiQJnrC8TVvrORGJFg/IdRu1LaYVQ2vcbrYy9f33278zFJ2/VGSWwg+koCfW+jRL2JiO7Q
 7weOL93sEVrqIZKYKxQ4QLTovcEfPT8P+Yh6yVqQnhguSKpPmQ2VPgNkEqHHzrvD2Ob7QbilG
 0uUK91A3w24KSn+Z9kAviq+nMVKe+2JXfhg7p42OqZY/utJ1OBuwrpxglMNYYiPmN6rjc4jiY
 pZ6JKIRt/BiMOpTA+ggj6mQKha71uNHr+zBMh8vBa6/vQ08oHxAsnyEnk+ozKocaL2RbGBuvF
 aQskQF2J3Kb0E3/esu5wGPlYsSAezYR29Wkc7Gy1WjESEzub8U8lx1qqZzu9wRvanhw5B/Fae
 DHMfIVamC4m3HSXx9c+8SZeh+uq64aLi7u3E8g==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63614
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

32-bit architectures implementing 64BIT_TIME and COMPAT_32BIT_TIME
need to have the traditional semtimedop() behavior with 32-bit timestamps
for sys_ipc() by calling compat_ksys_semtimedop(), while those that
are not yet converted need to keep using ksys_semtimedop() like
64-bit architectures do.

Note that I chose to not implement a new SEMTIMEDOP64 function that
corresponds to the new sys_semtimedop() with 64-bit timeouts. The reason
here is that sys_ipc() should no longer be used for new system calls,
and libc should just call the semtimedop syscall directly.

One open question remain to whether we want to completely avoid the
sys_ipc() system call for architectures that do not yet have all the
individual calls as they get converted to 64-bit time_t. Doing that
would require adding several extra system calls on m68k, mips, powerpc,
s390, sh, sparc, and x86-32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/syscall.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ipc/syscall.c b/ipc/syscall.c
index 77a883ef2eca..65d405f1ba0c 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -30,9 +30,14 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
 				       second, NULL);
 	case SEMTIMEDOP:
-		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
-				       second,
-				       (const struct timespec __user *)fifth);
+		if (IS_ENABLED(CONFIG_64BIT) || !IS_ENABLED(CONFIG_64BIT_TIME))
+			return ksys_semtimedop(first, ptr, second,
+			        (const struct __kernel_timespec __user *)fifth);
+		else if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return compat_ksys_semtimedop(first, ptr, second,
+			        (const struct compat_timespec __user *)fifth);
+		else
+			return -ENOSYS;
 
 	case SEMGET:
 		return ksys_semget(first, second, third);
@@ -130,6 +135,8 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		/* struct sembuf is the same on 32 and 64bit :)) */
 		return ksys_semtimedop(first, compat_ptr(ptr), second, NULL);
 	case SEMTIMEDOP:
+		if (!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return -ENOSYS;
 		return compat_ksys_semtimedop(first, compat_ptr(ptr), second,
 						compat_ptr(fifth));
 	case SEMGET:
-- 
2.9.0
