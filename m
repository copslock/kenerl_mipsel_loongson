Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2015 12:25:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24932 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011740AbbHRKZkOnhlu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Aug 2015 12:25:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C4318BD7BA95A;
        Tue, 18 Aug 2015 11:25:31 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 18 Aug
 2015 11:25:34 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([::1]) with mapi id 14.03.0174.001; Tue, 18 Aug 2015
 03:25:31 -0700
From:   Nikola Veljkovic <Nikola.Veljkovic@imgtec.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Chris Dearman <Chris.Dearman@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Lazar Trsic <Lazar.Trsic@imgtec.com>
Subject: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32
Thread-Topic: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32
Thread-Index: AdDZoDWdYYUUjfUKSkyGO9XRIv7l2Q==
Date:   Tue, 18 Aug 2015 10:25:31 +0000
Message-ID: <19CDB9880DBFC241860D925D8FAA94A00342EAB8@BADAG02.ba.imgtec.org>
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
X-archive-position: 48937
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

There is a discrepancy in the personality() syscall on mips64.

For a 32bit process (o32 or n32) sys_32_personality() [1] is called, which
converts PER_LINUX32 -> PER_LINUX:

ret = sys_personality(p);
if (ret != -1 && (ret & PER_MASK) == PER_LINUX32)  // personality macro applied
   ret = (ret & ~PER_MASK) | PER_LINUX;            // to make it clearer

This is different than what Intel and ARM are doing. They directly invoke
sys_personality(). On Android, this causes a bionic test to fail for mips, as it
expects PER_LINUX32 but receives PER_LINUX, when ran on mips64 core.

The code itself comes from older kernel versions (2.4), where it was also used
by other architectures [2], [3], [4]. However, since kernel 2.6 other archs are
invoking sys_personality() directly, for all ABIs.

Is there any reason why we should do PER_LINUX32 -> PER_LINUX on mips? Also, if
we do change this for o32, should we change it for n32, as well? There is no n32
support for Android, so it would have to be tested elsewhere.

Tested changing only o32 on Android, there were no regressions:

diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index ab93427..b94ee4e 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -358,7 +358,7 @@ sys_call_table:
        sys     sys_fchdir              1
        sys     sys_bdflush             2
        sys     sys_sysfs               3       /* 4135 */
-       sys     sys_32_personality      1
+       sys     sys_personality         1
        sys     sys_ni_syscall          0       /* for afs_syscall */
        sys     sys_setfsuid            1
        sys     sys_setfsgid            1
--

[1] http://git.linux-mips.org/cgit/ralf/linux.git/tree/arch/mips/kernel/linux32.c#n122
[2] http://git.linux-mips.org/cgit/ralf/linux.git/tree/include/asm-mips64/elf.h?h=linux-2.4#n124
[3] http://git.linux-mips.org/cgit/ralf/linux.git/tree/arch/x86_64/ia32/sys_ia32.c?h=linux-2.4#n1974
[4] http://git.linux-mips.org/cgit/ralf/linux.git/tree/arch/ia64/ia32/sys_ia32.c?h=linux-2.4#n4005
--
Nikola Veljkovic
From Markos.Chandras@imgtec.com Tue Aug 18 14:56:12 2015
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2015 14:56:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8845 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012310AbbHRM4MYiHU- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Aug 2015 14:56:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 356EA9FEB21C2;
        Tue, 18 Aug 2015 13:56:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 18 Aug 2015 13:56:06 +0100
Received: from localhost (192.168.154.168) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 18 Aug
 2015 13:56:05 +0100
Date:   Tue, 18 Aug 2015 13:56:05 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Nikola Veljkovic <Nikola.Veljkovic@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Chris Dearman <Chris.Dearman@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        "Miodrag Dinic" <Miodrag.Dinic@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Lazar Trsic <Lazar.Trsic@imgtec.com>
Subject: Re: [PATCH] MIPS: personality syscall discrepancy on mips64-o32/n32
Message-ID: <20150818125605.GA25978@mchandras-linux.le.imgtec.org>
References: <19CDB9880DBFC241860D925D8FAA94A00342EAB8@BADAG02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <19CDB9880DBFC241860D925D8FAA94A00342EAB8@BADAG02.ba.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48938
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
Content-Length: 2753
Lines: 59

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
