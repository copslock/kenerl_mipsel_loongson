Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84770C43612
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EED7206B7
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfAJQ13 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:27:29 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbfAJQ0W (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 11:26:22 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MStGi-1gqtJn10Qg-00UNaT; Thu, 10 Jan 2019 17:25:13 +0100
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
Subject: [PATCH 06/15] ARM: add migrate_pages() system call
Date:   Thu, 10 Jan 2019 17:24:26 +0100
Message-Id: <20190110162435.309262-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xU1TfvUWuXdLttcRhOwMDdJJXZRPbxZEzH/siDEOVU0h6xSKutI
 9QsRxUZDYmciiqijchskFcKTpq+zTdu1Z3OJ6HXVSfUcAA+HxeciwrBeeSL6Ckg3kR4vhW6
 M00Lmj5s9Y3w6Le9cFFx9VvdHdeeOpVNHkzmK9YN7A4Vyz/gVMPCkuNCa3YGL4MWEdk3Y2L
 uZjLpOEPaYJJ39nJiErlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iEETSAcdels=:snhz2M6ZDU1wMmINknfiml
 8rIFJhUvhs+Ay8kN3BD7oJb2etgmtw72I2WkvaCrrbpRNfkB2lNhIHVSPih1sMYmqO8aNQhJC
 BAYxAg9zPjIUiMPXEQFroevk1mcSjtKSEWh8quV/Sx6szi6sr9kr3xbVBCzBSqoiFxOEDf2Yz
 P0ln4ZJrlRLi3JmoA4TJnA0yYWSVQY8ix4z2XMx3D1T3kARsBL0FbF1VNr3Dh6ztv7puylfk2
 iBvTE5iVFltU/ODVCuFvJ0hzNmUh1J5n0ncgn+EUazsxZ6mzE1/hQKnFBwZyb6tyFNVARadXx
 sZ7PtBxJJiJyHdENuekRI3RL2e3+puXXmNss+Kw/wkN/vaN3tNJDO/wO8L32tp928ltxYFMVc
 Qr/oNbqfPdYiEI1z+T1yD4v72J+I8GXPuigetbee+wGFI7e5tGWKbiFzc3yfC9d3v8ropk7I5
 ud80M0hnDuJTSKJ8AK1sIXep07Gs1X82o9ea+Voj3XjdYuH1dPb+6il6FeI6tPnB83kNY2vCW
 ZwZ614d05NhmsbiVlfK/xAkzjOArgomBg7WKFPSBQTRQWj41UA+qTNOIVNaFEK8QletG2TSZU
 nboVUxJ7xylPRFuUPMs5pUCVkgj7ZUWXtqlgVO81GqQwQw0RlUkcJHOxtO8DrbTDsbo5Fc6J8
 hyFARcweFgLqPmYrPk1mavinSjYCbldtqMnzC+do764FjEsm1c0Uup3bQg5DXq4LiYGyrIjVz
 ncFrswlP2h/DpgfzhfuJvMrTWN6BYDXT8cD1iQ==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The migrate_pages system call has an assigned number on all architectures
except ARM. When it got added initially in commit d80ade7b3231 ("ARM:
Fix warning: #warning syscall migrate_pages not implemented"), it was
intentionally left out based on the observation that there are no 32-bit
ARM NUMA systems.

However, there are now arm64 NUMA machines that can in theory run 32-bit
kernels (actually enabling NUMA there would require additional work)
as well as 32-bit user space on 64-bit kernels, so that argument is no
longer very strong.

Assigning the number lets us use the system call on 64-bit kernels as well
as providing a more consistent set of syscalls across architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/unistd.h     | 1 -
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 88ef2ce1f69a..d713587dfcf4 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -45,7 +45,6 @@
  * Unimplemented (or alternatively implemented) syscalls
  */
 #define __IGNORE_fadvise64_64
-#define __IGNORE_migrate_pages
 
 #ifdef __ARM_EABI__
 /*
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 8edf93b4490f..86de9eb34296 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -414,3 +414,4 @@
 397	common	statx			sys_statx
 398	common	rseq			sys_rseq
 399	common	io_pgetevents		sys_io_pgetevents
+400	common	migrate_pages		sys_migrate_pages
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a7b1fc58ffdf..261216c3336e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		400
+#define __NR_compat_syscalls		401
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 04ee190b90fe..355fe2bc035b 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_io_pgetevents 399
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_migrate_pages 400
+__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0

