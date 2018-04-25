Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:09:18 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.133]:49367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994669AbeDYPH0ZhkRC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:26 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M3rTW-1eL2b425uk-00rVbx; Wed, 25 Apr 2018 17:06:32 +0200
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
Subject: [PATCH v4 16/16] y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop
Date:   Wed, 25 Apr 2018 17:06:06 +0200
Message-Id: <20180425150606.954771-16-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Mlabpj+luf20+BILETO7JbXl11x+S63/lDeB9I8xRdnCyML+2y2
 SEv4/EcskLmyzHqtorUKLjUzHaKIwF3Ds0JuyIVnUSiBRzGFwo4mfePbv/NjOJUH7+wbjgP
 lmNVVsYy/PzzGz5xplirZQQTSika5eJxOseY0UxWAdqlH+uiS/Q2ThdtOzEu8I7kUv5JvvK
 72vyib/moYdduZzTS/ckg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SqN+npyaZdU=:2iB9BZauhQXqPesFdfkWfK
 vCbG8Vgy9eKVJKuVzfB9K58T37/tMsSYEdG8+iCyMd15rkm5zdQlv62xWWqATm1JnamavSIrR
 dOIBdlGpcbYB4xH9Mife2fCp7OBJUH3fVTNw2V7ifw/08z4c/Q0kJqO0g3f1lO0QZaGLYiNBP
 ylTKkLgcQSoOLgoDIi5sXktp/Jm3z99JasrSdmPovzve8flXC5KzbkHAR733KaU2ECqObcoHb
 meEIjmuEZdgLNXT80vCxhv7U+vkPOyxO7bVv2yvkkFYKxFUZCqELNcKwQSrbjJ+7ihgT3FlRf
 YcR6DDqEuDIA/2lfvZSyPPc9fS0BhmVvIdNNZhTo8xgwxByxHSStmnsV8I4lu7boEPgxLJFCH
 BhhoAwnIYKFA7VJSoD/4At0rDW2ZqHODq0bKsw9DF9KJXXS5Uu/QyFiQayyFT0H09/lawzzhs
 InT5i4GoJlQ7sbmeSXkFJ88kG2DnxEiJrUDyiVrBe4TaBtn4RUGT4VTCseE1lYIYT7CwYriMX
 AGT9xePhRrwJvDom+Z4537rZjggZWKyX66M0PuTgsJnTJhwekmiFkBtjlI7QzjtBMNVa7OIR4
 W4Jl92RwlQKgE0omplLfF7UPjdp4MFGW2JPNpMl5udI/k6mXxmq1YyXpYXE1eFwfFJBir05R9
 stWRpssw1H+8rGSMKvynbFlVuAPL0Rfsppk30AIFUKlYX/4rXvMuReQesL/csKce2Ewll5K9z
 ENLb1unuxr5CX6vSUO1teYurJEtv+ALHyMGYCg==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63770
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
