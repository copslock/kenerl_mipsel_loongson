Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2018 07:59:23 +0100 (CET)
Received: from userp2130.oracle.com ([156.151.31.86]:34748 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992289AbeKDG7DrQqiU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Nov 2018 07:59:03 +0100
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA46u6n9035325;
        Sun, 4 Nov 2018 06:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=Dv2JIDyr6hj+SI1f67+zM2v2M4uA+R2C7fKFV5CQ+kE=;
 b=Js7Nh27vbqOyY2gZ0UpqFfC92w4EMKr/VwCtgb/4hz0cpD+muu4dt9mHR/RIg7LXLRKM
 KSdQlyKUBJ0Wepu8UCnGYCRdHpxOUY3LSEVv1pS+k+mLUIjCdfn6slguWQuKOfCVqlp8
 L9lqOMCdjJaGmZq1nHUWfgmmHv1CnRaeRXXjaAPM2Xi2w1DSFM+8xUpoxcjRF6GwcHR2
 Q8VGkhI55EFSCNDiU2BqFcJrF9NDtefdCtLLfW7nm+lXI8yZIprvLVxRVTeAfWiOYVVD
 vSRxnGitTcbrLliDWcoiH4FzDASOny4srW6qN47aUOBPO6AznnIha2Je6/kcXA9kalmP rQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nh33tjd1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Nov 2018 06:57:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA46vJtx021700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Nov 2018 06:57:21 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA46urU6025556;
        Sun, 4 Nov 2018 06:56:56 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 03 Nov 2018 23:56:53 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181103183208.GA56850@google.com>
Date:   Sun, 4 Nov 2018 00:56:48 -0600
Cc:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        kvmarm@lists.cs.columbia.edu, Ley Foon Tan <lftan@altera.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vge.kvack.org, r.kernel.org@lithops.sigma-star.at,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, lokeshgidra@google.com,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, minchan@kernel.org,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Transfer-Encoding: 8BIT
Message-Id: <D6FB3C15-A8C1-4694-A434-A7489F590E05@oracle.com>
References: <20181103040041.7085-1-joelaf@google.com>
 <6886607.O3ZT5bM3Cy@blindfold>
 <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
 <20181103183208.GA56850@google.com>
To:     Joel Fernandes <joel@joelfernandes.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9066 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811040066
Return-Path: <william.kucharski@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: william.kucharski@oracle.com
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



> On Nov 3, 2018, at 12:32 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> Looks like more architectures don't define set_pmd_at. I am thinking the
> easiest way forward is to just do the following, instead of defining
> set_pmd_at for every architecture that doesn't care about it. Thoughts?
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 7cf6b0943090..31ad64dcdae6 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -281,7 +281,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> 			split_huge_pmd(vma, old_pmd, old_addr);
> 			if (pmd_trans_unstable(old_pmd))
> 				continue;
> -		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
> +		} else if (extent == PMD_SIZE) {
> +#ifdef CONFIG_HAVE_MOVE_PMD
> 			/*
> 			 * If the extent is PMD-sized, try to speed the move by
> 			 * moving at the PMD level if possible.
> @@ -296,6 +297,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> 				drop_rmap_locks(vma);
> 			if (moved)
> 				continue;
> +#endif
> 		}
> 
> 		if (pte_alloc(new_vma->vm_mm, new_pmd))
> 

That seems reasonable as there are going to be a lot of architectures that never have
mappings at the PMD level.

Have you thought about what might be needed to extend this paradigm to be able to
perform remaps at the PUD level, given many architectures already support PUD-mapped
pages?

    William Kucharski
From sashal@kernel.org Sun Nov  4 14:52:25 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2018 14:52:29 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:33462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992810AbeKDNwZBoLdg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Nov 2018 14:52:25 +0100
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A42F20866;
        Sun,  4 Nov 2018 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339543;
        bh=/BNA8wX7ezLJDRNO318yDehwFgvKzP2/YSC1SLXa0ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMM/Ode4B8ym5bxpHINVTpOaARBN1H3PeHhA9zO1FIYmcSrQLdbpWn31Ro2ZEzqlD
         PCozg49NJy0NNUoFAQF7fts18r8FCWwB+JFCe6wD64wBcbdc+AuLJ6V/ybj1Hd4/FU
         cTOYZkkip07EftpCziwfl5Hjp+rtB7dJxlFQf8Eo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <paul.burton@mips.com>, pburton@wavecomp.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        rachel.mozes@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 38/57] MIPS: kexec: Mark CPU offline before disabling local IRQ
Date:   Sun,  4 Nov 2018 08:51:25 -0500
Message-Id: <20181104135144.88324-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sashal@kernel.org
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

From: Dengcheng Zhu <dzhu@wavecomp.com>

[ Upstream commit dc57aaf95a516f70e2d527d8287a0332c481a226 ]

After changing CPU online status, it will not be sent any IPIs such as in
__flush_cache_all() on software coherency systems. Do this before disabling
local IRQ.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20571/
Cc: pburton@wavecomp.com
Cc: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Cc: rachel.mozes@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/crash.c         | 3 +++
 arch/mips/kernel/machine_kexec.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index d455363d51c3..4c07a43a3242 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -36,6 +36,9 @@ static void crash_shutdown_secondary(void *passed_regs)
 	if (!cpu_online(cpu))
 		return;
 
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
 	local_irq_disable();
 	if (!cpumask_test_cpu(cpu, &cpus_in_crash))
 		crash_save_cpu(regs, cpu);
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 8b574bcd39ba..4b3726e4fe3a 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -118,6 +118,9 @@ machine_kexec(struct kimage *image)
 			*ptr = (unsigned long) phys_to_virt(*ptr);
 	}
 
+	/* Mark offline BEFORE disabling local irq. */
+	set_cpu_online(smp_processor_id(), false);
+
 	/*
 	 * we do not want to be bothered.
 	 */
-- 
2.17.1
