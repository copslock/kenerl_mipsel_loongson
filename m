Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 15:14:03 +0100 (CET)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:53522 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825660Ab2KIOOAk5HaU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2012 15:14:00 +0100
Received: by mail-vc0-f177.google.com with SMTP id p16so3845779vcq.36
        for <multiple recipients>; Fri, 09 Nov 2012 06:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZAhi5bwCMNWCs9gw1zxMlc0gYoc2IVsfQc7vjp3edkk=;
        b=UYJWYsGwYTG1gRX0HkgNL2Dd6jG0TKQN/i0ZokMWI5u2tCV+rLuZh0GFe+vyzaUG64
         13zpsWJcXN1ZQba+zzeDwVAcRDi2N+Fe6dWuRxfDnXrhpeRpZI/5BBBbloI36ELPKUcv
         wjFtn210HXa7t4DwURlgu4kkbUMkZNsIs5CyQXgfrePDPSnpN7l0g5AsbIXSVM/tBB8g
         +QP43HnP3l1NpupSW/PZ/Cxo8ZW/v1vUS0qYAOJXXwCNaSf+crvKo2Kk3fFGprPLY5/i
         Hr8uTR5uFxilaQbWnaa8Zwh+v65rR0nx08GS5840EYWbh+ufMSevJNQP6uzTAWhfXqS7
         coPw==
Received: by 10.220.153.15 with SMTP id i15mr10269586vcw.6.1352470434108;
        Fri, 09 Nov 2012 06:13:54 -0800 (PST)
Received: from [192.168.1.116] (c-50-133-228-71.hsd1.ma.comcast.net. [50.133.228.71])
        by mx.google.com with ESMTPS id q7sm15049226vdw.22.2012.11.09.06.13.52
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Nov 2012 06:13:53 -0800 (PST)
Message-ID: <509D0F86.30607@gmail.com>
Date:   Fri, 09 Nov 2012 09:13:26 -0500
From:   Sasha Levin <levinsasha928@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121024 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Michel Lespinasse <walken@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 03/16] mm: check rb_subtree_gap correctness
References: <1352155633-8648-1-git-send-email-walken@google.com> <1352155633-8648-4-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-4-git-send-email-walken@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levinsasha928@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> When CONFIG_DEBUG_VM_RB is enabled, check that rb_subtree_gap is
> correctly set for every vma and that mm->highest_vm_end is also correct.
> 
> Also add an explicit 'bug' variable to track if browse_rb() detected any
> invalid condition.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Rik van Riel <riel@redhat.com>
> 
> ---

Hi all,

While fuzzing with trinity inside a KVM tools (lkvm) guest, using today's -next
kernel, I'm getting these:


[  117.007714] free gap 7fba0dd1c000, correct 7fba0dcfb000
[  117.019773] map_count 750 rb -1
[  117.028362] ------------[ cut here ]------------
[  117.029813] kernel BUG at mm/mmap.c:439!
[  117.031024] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[  117.032933] Dumping ftrace buffer:
[  117.033972]    (ftrace buffer empty)
[  117.035085] CPU 4
[  117.035676] Pid: 6859, comm: trinity-child46 Tainted: G        W    3.7.0-rc4-next-20121109-sasha-00013-g9407f3c #124
[  117.038217] RIP: 0010:[<ffffffff81236687>]  [<ffffffff81236687>] validate_mm+0x297/0x2c0
[  117.041056] RSP: 0018:ffff880016a4fdf8  EFLAGS: 00010296
[  117.041056] RAX: 0000000000000013 RBX: 00000000ffffffff RCX: 0000000000000006
[  117.041056] RDX: 0000000000005270 RSI: ffff880024120910 RDI: 0000000000000286
[  117.052131] RBP: ffff880016a4fe48 R08: 0000000000000000 R09: 0000000000000000
[  117.052131] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000000002ee
[  117.052131] R13: 00007fffea1fc000 R14: ffff88002412c000 R15: 0000000000000000
[  117.052131] FS:  00007fba129db700(0000) GS:ffff880063600000(0000) knlGS:0000000000000000
[  117.052131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  117.052131] CR2: 0000000003323288 CR3: 00000000169b2000 CR4: 00000000000406e0
[  117.052131] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  117.052131] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  117.052131] Process trinity-child46 (pid: 6859, threadinfo ffff880016a4e000, task ffff880024120000)
[  117.052131] Stack:
[  117.052131]  ffffffff8489e201 ffffffff81235aa0 ffff88000885cac8 0000000100000000
[  117.052131]  ffffffff812361b9 ffff88002412c000 ffff88000885cac8 ffff88000885cdc8
[  117.052131]  ffff88000885cdd0 ffff88002412c000 ffff880016a4fe98 ffffffff812367b4
[  117.052131] Call Trace:
[  117.052131]  [<ffffffff81235aa0>] ? vma_compute_subtree_gap+0x40/0x40
[  117.052131]  [<ffffffff812361b9>] ? vma_gap_update+0x19/0x30
[  117.052131]  [<ffffffff812367b4>] vma_link+0x94/0xe0
[  117.052131]  [<ffffffff812386c4>] do_brk+0x2c4/0x380
[  117.052131]  [<ffffffff812387bf>] ? sys_brk+0x3f/0x190
[  117.052131]  [<ffffffff812388ce>] sys_brk+0x14e/0x190
[  117.052131]  [<ffffffff83be2618>] tracesys+0xe1/0xe6
[  117.052131] Code: d8 41 8b 76 60 39 de 74 1b 89 da 48 c7 c7 c6 d9 89 84 31 c0 e8 01 76 94 02 eb 10 66 0f 1f 84 00 00 00 00 00
8b 45 c8 85 c0 74 18 <0f> 0b 4c 8d 48 e0 48 8b 70 e0 31 db c7 45 cc 00 00 00 00 e9 f4
[  117.052131] RIP  [<ffffffff81236687>] validate_mm+0x297/0x2c0
[  117.052131]  RSP <ffff880016a4fdf8>
[  117.136092] ---[ end trace 5ce250e0bf6d040c ]---

Note that they are very easy to reproduce.

Also, I see that lots of the code there has a local variable named 'bug' thats tracking
whether we should BUG() later on. Why does it work that way and the BUG() isn't immediate?


Thanks,
Sasha
