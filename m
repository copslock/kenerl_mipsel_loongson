Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2015 16:46:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35476 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012396AbbHTOqgc3pN4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2015 16:46:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4501C61B9D029;
        Thu, 20 Aug 2015 15:46:27 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 20 Aug
 2015 15:46:30 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([::1]) with mapi id 14.03.0174.001; Thu, 20 Aug 2015
 07:46:27 -0700
From:   Nikola Veljkovic <Nikola.Veljkovic@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Chris Dearman <Chris.Dearman@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Lazar Trsic <Lazar.Trsic@imgtec.com>
Subject: RE: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32
Thread-Topic: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32
Thread-Index: AdDZoDWdYYUUjfUKSkyGO9XRIv7l2QAT7T6AAFm3ySo=
Date:   Thu, 20 Aug 2015 14:46:26 +0000
Message-ID: <19CDB9880DBFC241860D925D8FAA94A00342F48A@BADAG02.ba.imgtec.org>
References: <19CDB9880DBFC241860D925D8FAA94A00342EAB8@BADAG02.ba.imgtec.org>,<20150818125605.GA25978@mchandras-linux.le.imgtec.org>
In-Reply-To: <20150818125605.GA25978@mchandras-linux.le.imgtec.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.40.117]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Nikola.Veljkovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Nikola.Veljkovic@imgtec.com
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

Hi,

 > I am not sure what the implication will be to userland with that change...
I could not find any code that explicitly checks for PER_LINUX[32]. Of course,
I might be missing something. Any suspects?

 > I presume you also need to fix the n32 case and then completely remove the 
 > sys_32_personality syscall from linux32.c. 
New patch below removes the syscall.

 > Moreover, I think you also need to fix the arch/mips/include/asm/elf.h
 > code to set LINUX32 for O32 and n32 (for both 32b and 64b kernels.)
Other archs (arm, intel) do not do that, so I think we should follow, and set 
PER_LINUX, but let userspace change this if it wants to. On the kernel side this
only affects uname. From the discussion [1] it seems like the right way to go.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/114506.html

 > If you are going to submit a new patch, can you please create a proper git patch
 > (using git format-patch) and include your Signed-off-by line as well? Thank you
If not obvious, my first post here, thanks for the tips.
------------------
From 6ce4addd17a333ad9935c1d6dc9fa9114e02b3fd Mon Sep 17 00:00:00 2001
From: Nikola Veljkovic <Nikola.Veljkovic@imgtec.com>
Date: Thu, 30 Jul 2015 13:54:26 +0200
Subject: [PATCH] Fix personality syscall for mips64-o32/n32
Content-Length: 5435
Lines: 139

Remove unnecessary sys_32_personality wrapper, which replaces
PER_LINUX32 with PER_LINUX.

Most other archs removed the wrapper even before 2.6.

Now that exec domains are gone, there is almost no kernel code using
personality flags - so set PER_LINUX and let userspace change it.

This fixes bionic test on Android, by making mips more like other
architectures. Change has been tested on mips64 (n64 and o32), there
were no regressions.

Signed-off-by: Nikola Veljkovic <Nikola.Veljkovic@imgtec.com>
---
 arch/mips/kernel/linux32.c     | 14 --------------
 arch/mips/kernel/scall64-n32.S |  2 +-
 arch/mips/kernel/scall64-o32.S |  2 +-
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 0b29646..0513e19 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -119,20 +119,6 @@ SYSCALL_DEFINE6(32_pwrite, unsigned int, fd, const char __user *, buf,
 	return sys_pwrite64(fd, buf, count, merge_64(a4, a5));
 }
 
-SYSCALL_DEFINE1(32_personality, unsigned long, personality)
-{
-	unsigned int p = personality & 0xffffffff;
-	int ret;
-
-	if (personality(current->personality) == PER_LINUX32 &&
-	    personality(p) == PER_LINUX)
-		p = (p & ~PER_MASK) | PER_LINUX32;
-	ret = sys_personality(p);
-	if (ret != -1 && personality(ret) == PER_LINUX32)
-		ret = (ret & ~PER_MASK) | PER_LINUX;
-	return ret;
-}
-
 asmlinkage ssize_t sys32_readahead(int fd, u32 pad0, u64 a2, u64 a3,
 				   size_t count)
 {
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 4b20106..e4c036c 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -240,7 +240,7 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_sigaltstack
 	PTR	compat_sys_utime		/* 6130 */
 	PTR	sys_mknod
-	PTR	sys_32_personality
+	PTR	sys_personality
 	PTR	compat_sys_ustat
 	PTR	compat_sys_statfs
 	PTR	compat_sys_fstatfs		/* 6135 */
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f543ff4..9b3e881 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -363,7 +363,7 @@ EXPORT(sys32_call_table)
 	PTR	sys_fchdir
 	PTR	sys_bdflush
 	PTR	sys_sysfs			/* 4135 */
-	PTR	sys_32_personality
+	PTR	sys_personality
 	PTR	sys_ni_syscall			/* for afs_syscall */
 	PTR	sys_setfsuid
 	PTR	sys_setfsgid
-- 
2.4.0

________________________________________
From: Markos Chandras
Sent: Tuesday, August 18, 2015 2:56 PM
To: Nikola Veljkovic
Cc: linux-mips@linux-mips.org; ralf@linux-mips.org; Chris Dearman; Raghu Gandham; Miodrag Dinic; Petar Jovanovic; Lazar Trsic
Subject: Re: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32

On Tue, Aug 18, 2015 at 10:25:31AM +0000, Nikola Veljkovic wrote:
> There is a discrepancy in the personality() syscall on mips64.
>
> For a 32bit process (o32 or n32) sys_32_personality() [1] is called, which
> converts PER_LINUX32 -> PER_LINUX:
>
> ret = sys_personality(p);
> if (ret != -1 && (ret & PER_MASK) == PER_LINUX32)  // personality macro applied
>    ret = (ret & ~PER_MASK) | PER_LINUX;            // to make it clearer
>
> This is different than what Intel and ARM are doing. They directly invoke
> sys_personality(). On Android, this causes a bionic test to fail for mips, as it
> expects PER_LINUX32 but receives PER_LINUX, when ran on mips64 core.
>
> The code itself comes from older kernel versions (2.4), where it was also used
> by other architectures [2], [3], [4]. However, since kernel 2.6 other archs are
> invoking sys_personality() directly, for all ABIs.
>
> Is there any reason why we should do PER_LINUX32 -> PER_LINUX on mips? Also, if
> we do change this for o32, should we change it for n32, as well? There is no n32
> support for Android, so it would have to be tested elsewhere.
>
> Tested changing only o32 on Android, there were no regressions:
>
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index ab93427..b94ee4e 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -358,7 +358,7 @@ sys_call_table:
>         sys     sys_fchdir              1
>         sys     sys_bdflush             2
>         sys     sys_sysfs               3       /* 4135 */
> -       sys     sys_32_personality      1
> +       sys     sys_personality         1
>         sys     sys_ni_syscall          0       /* for afs_syscall */
>         sys     sys_setfsuid            1
>         sys     sys_setfsgid            1
> --
>
> [1] http://git.linux-mips.org/cgit/ralf/linux.git/tree/arch/mips/kernel/linux32.c#n122
> [2] http://git.linux-mips.org/cgit/ralf/linux.git/tree/include/asm-mips64/elf.h?h=linux-2.4#n124
> [3] http://git.linux-mips.org/cgit/ralf/linux.git/tree/arch/x86_64/ia32/sys_ia32.c?h=linux-2.4#n1974
> [4] http://git.linux-mips.org/cgit/ralf/linux.git/tree/arch/ia64/ia32/sys_ia32.c?h=linux-2.4#n4005
> --
> Nikola Veljkovic

Hi,

I am not sure what the implication will be to userland with that change...

I presume you also need to fix the n32 case and then completely remove the sys_32_personality
syscall from linux32.c. Moreover, I think you also need to fix the arch/mips/include/asm/elf.h
code to set LINUX32 for O32 and n32 (for both 32b and 64b kernels.)

If you are going to submit a new patch, can you please create a proper git patch
(using git format-patch) and include your Signed-off-by line as well? Thank you

--
markos
