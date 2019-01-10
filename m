Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A8C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A294020685
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfAJQ0p (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:26:45 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:55377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbfAJQ0o (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 11:26:44 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MY64R-1gmkJt0Yvd-00YU3m; Thu, 10 Jan 2019 17:25:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        firoz.khan@linaro.org, ebiederm@xmission.com,
        deepa.kernel@gmail.com, linux@dominikbrodowski.net,
        akpm@linux-foundation.org, dave@stgolabs.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 14/15] arch: add split IPC system calls where needed
Date:   Thu, 10 Jan 2019 17:24:34 +0100
Message-Id: <20190110162435.309262-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PwTwcqzC0fpvyGeS+vAcmjwlaVhIgjgqKpUNbO8jdK/MzyNDLxH
 AD43ww/mEbVyMlR/qBO/hkjHdcMLLros7Uhp2gNa5zLqweAyXbK92KKYYzxSiaXlEIhf96y
 c5q67JQboIHmgXAEjxzQ4irXT6aSruKmlUAsQ7aBg9/WtfSVK6H7RIzHVcKGsOVeUOmhOgG
 qQuRlraMboMxEyYeiTS3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/LZQ6iPTUJo=:EqDjBEG0B6YX9cPxWcmZ4u
 cP2kpeIGX4W+yVbjKy2g0qqgHXvErCiIrml9QEL3tCFMa0QtzRa+/cDXp5SbnIiXHB5RlPM9X
 L5RuU0uGnmDgYyzpEII8MSmLVxznYX9sb8Tt48CdJAjJU+mBsAgITdJrZNUUZccnTDEFfpjWl
 Zfy38hBzxYejOCZddJkP8IjbpmTMDpoWQAGY0TFZFQ91ihbiuvS9l0GjaAbckx4ICzEO0ZhcT
 Bk0uD1cr+NZTy8/FQkqWwLXqdl8LPvgoLe598rlBY2lHOJ0XjWEpuGxWaxD51dUfTAQc+REWK
 /3Ty9946jYoVF0sZSUqFkl9LXiczko0W5HsurvSQrW5FTZyfjBktySCDENYzcM5hr5Hbngs7l
 o8XPaM1vVycoPvjZctkwRJ46eTW/ou94RkDZhZpKmOfL5amcEhzSK3NL1777+uTtptIJ9kCNv
 PW+1Wv5Y6dbQf1h20iL2pRIv7SJryn/XomOOv2cA16N+EYFLPVjw2WFO99AzGqHxvXx75o6Dm
 ckRKzKveUqoCXRTy3I+QLMs3ACm5wNZSVi3itI8R1xhYqyTmQuq3ZpEEujuoCLpTffgsEr4EO
 fLT0CJKC/exVpy0AJBwMw7sK/yNR2hIDeVUWWXlJF+kAGJkYFkyetitnjCnV3JYeE3TdhqWC+
 3aj7J+QJ6DnYyDvWiSx9A3NOQMBBwQhKb0SFPJql3Fe4mTcxf9cr/QUTDuDB0mRfrHGRXnO9a
 6nTtAOkVR8W4WludGMZ/OQ1J8EBHxHuUkG6MPw==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The IPC system call handling is highly inconsistent across architectures,
some use sys_ipc, some use separate calls, and some use both.  We also
have some architectures that require passing IPC_64 in the flags, and
others that set it implicitly.

For the additon of a y2083 safe semtimedop() system call, I chose to only
support the separate entry points, but that requires first supporting
the regular ones with their own syscall numbers.

The IPC_64 is now implied by the new semctl/shmctl/msgctl system
calls even on the architectures that require passing it with the ipc()
multiplexer.

I'm not adding the new semtimedop() or semop() on 32-bit architectures,
those will get implemented using the new semtimedop_time64() version
that gets added along with the other time64 calls.
Three 64-bit architectures (powerpc, s390 and sparc) get semtimedop().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
One aspect here that might be a bit controversial is the use of
the same system call numbers across all architectures, synchronizing
all of them with the x86-32 numbers. With the new syscall.tbl
files, I hope we can just keep doing that in the future, and no
longer require the architecture maintainers to assign a number.

This is mainly useful for implementers of the C libraries: if
we can add future system calls everywhere at the same time, using
a particular version of the kernel headers also guarantees that
the system call number macro is visible.
---
 arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
 arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
 arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
 arch/s390/kernel/syscalls/syscall.tbl     | 12 ++++++++++++
 arch/sh/kernel/syscalls/syscall.tbl       | 11 +++++++++++
 arch/sparc/kernel/syscalls/syscall.tbl    | 12 ++++++++++++
 arch/x86/entry/syscalls/syscall_32.tbl    | 11 +++++++++++
 7 files changed, 80 insertions(+)

diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 85779d6ef935..5354ba02eed2 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -388,3 +388,14 @@
 378	common	pwritev2			sys_pwritev2
 379	common	statx				sys_statx
 380	common	seccomp				sys_seccomp
+# room for arch specific calls
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl
+397	common	shmat				sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd
+401	common	msgrcv				sys_msgrcv
+402	common	msgctl				sys_msgctl
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 3d5a47b80d2b..fa47ea8cc6ef 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -380,3 +380,14 @@
 366	o32	statx				sys_statx
 367	o32	rseq				sys_rseq
 368	o32	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+# room for arch specific calls
+393	o32	semget				sys_semget
+394	o32	semctl				sys_semctl			compat_sys_semctl
+395	o32	shmget				sys_shmget
+396	o32	shmctl				sys_shmctl			compat_sys_shmctl
+397	o32	shmat				sys_shmat			compat_sys_shmat
+398	o32	shmdt				sys_shmdt
+399	o32	msgget				sys_msgget
+400	o32	msgsnd				sys_msgsnd			compat_sys_msgsnd
+401	o32	msgrcv				sys_msgrcv			compat_sys_msgrcv
+402	o32	msgctl				sys_msgctl			compat_sys_msgctl
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index db3bbb8744af..1bffab54ff35 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -425,3 +425,15 @@
 386	nospu	pkey_mprotect			sys_pkey_mprotect
 387	nospu	rseq				sys_rseq
 388	nospu	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+# room for arch specific syscalls
+392	64	semtimedop			sys_semtimedop
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl			compat_sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl			compat_sys_shmctl
+397	common	shmat				sys_shmat			compat_sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl				sys_msgctl			compat_sys_msgctl
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 022fc099b628..428cf512a757 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -391,3 +391,15 @@
 381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
 382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
 383  common	rseq			sys_rseq			compat_sys_rseq
+# room for arch specific syscalls
+392	64	semtimedop		sys_semtimedop			-
+393  common	semget			sys_semget			sys_semget
+394  common	semctl			sys_semctl			compat_sys_semctl
+395  common	shmget			sys_shmget			sys_shmget
+396  common	shmctl			sys_shmctl			compat_sys_shmctl
+397  common	shmat			sys_shmat			compat_sys_shmat
+398  common	shmdt			sys_shmdt 			sys_shmdt
+399  common	msgget			sys_msgget			sys_msgget
+400  common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401  common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402  common	msgctl			sys_msgctl			compat_sys_msgctl
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index a70db013dbc7..6d0b84e3ef2d 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -391,3 +391,14 @@
 381	common	preadv2				sys_preadv2
 382	common	pwritev2			sys_pwritev2
 383	common	statx				sys_statx
+# room for arch specific syscalls
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl
+397	common	shmat				sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd
+401	common	msgrcv				sys_msgrcv
+402	common	msgctl				sys_msgctl
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index c8c77c05ea97..8c9580302422 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -407,3 +407,15 @@
 359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
 360	common	statx			sys_statx
 361	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+# room for arch specific syscalls
+392	64	semtimedop			sys_semtimedop
+393	common	semget			sys_semget
+394	common	semctl			sys_semctl			compat_sys_semctl
+395	common	shmget			sys_shmget
+396	common	shmctl			sys_shmctl			compat_sys_shmctl
+397	common	shmat			sys_shmat			compat_sys_shmat
+398	common	shmdt			sys_shmdt
+399	common	msgget			sys_msgget
+400	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl			sys_msgctl			compat_sys_msgctl
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3cf7b533b3d1..fef80b92eb7e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,3 +398,14 @@
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
+# room for arch specific syscalls
+393	i386	semget			sys_semget    			__ia32_sys_semget
+394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
+395	i386	shmget			sys_shmget    			__ia32_sys_shmget
+396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
+397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
+398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
+399	i386	msgget			sys_msgget    			__ia32_sys_msgget
+400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
+401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
+402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
-- 
2.20.0

