Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 21:06:31 +0100 (CET)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40989 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826549Ab2KIUG3SO0v4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2012 21:06:29 +0100
Received: by mail-ie0-f177.google.com with SMTP id e14so6361586iej.36
        for <linux-mips@linux-mips.org>; Fri, 09 Nov 2012 12:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=ps9F3OozFRnjOImp/m72hD1u7Mhuu6WzLgAVJiPyixo=;
        b=LSp05w+oRkOl6yUzgh3vSZrhallojY+MzeiE44nQ2YoBPPW595Th9cajO5GYo/ic+B
         ARJe3EyjSsv6EVKPItUgTX6gSeV1onMsvp3S8feazIUCzgYNXzqv5apwajHJONovfDNY
         lx+ZsfOA3qe8JCz8HIdZyahmUnQjK1zAwOiX2MdkqAKy/JKriAd88ZBUu5OHrEqxAvLh
         LmCZpdHxomPFLGrGTEp1g86dnBJhXGeVUlxZBST4SW1vo4BUMyU7ni4ha+DJJ9/Rn+df
         C1TJPhFvV3U6M3kTPjf66zrD/yLMUcj6SqSD8J6sAAV8W5gwL9x+Ca66fi+MSJU51vGP
         dsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type:x-gm-message-state;
        bh=ps9F3OozFRnjOImp/m72hD1u7Mhuu6WzLgAVJiPyixo=;
        b=YlSGTR+V90JkfdYWjS6a2R6c1ja26XIVRgT/btyP+U9WSA3bpda0ipT0+xTViDkuHF
         d41j+hYEhIsFaPoRG9VkrfFnb/t05CMn7l7YqZ0M6dkdHYMeiPRsxXFUxWv0iKn6RwFs
         F5hw7/wjnGm89afobOVCqFbcIMyQP5wV1mmC7W7qdL46hl4pAD/FFxInxmprFKbofFI6
         IMh0yXa0r/enk9GoWGOrY7+fs/k/51ClZVLxu0NcBdyCXOzgJQg+1dF34m/ahyG39Guz
         4+1GzLTx/wvpXW0FNV9R+Sb20e6Ry8GhtChHg/UaJBgBnYY6rjYka3X172xjwSGk5HpY
         askQ==
Received: by 10.50.190.163 with SMTP id gr3mr2425464igc.28.1352491582893;
        Fri, 09 Nov 2012 12:06:22 -0800 (PST)
Received: from [192.168.59.228] ([216.239.55.196])
        by mx.google.com with ESMTPS id bh3sm1991166igc.0.2012.11.09.12.06.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Nov 2012 12:06:22 -0800 (PST)
Date:   Fri, 9 Nov 2012 12:06:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Sasha Levin <levinsasha928@gmail.com>
cc:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
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
In-Reply-To: <509D0F86.30607@gmail.com>
Message-ID: <alpine.LNX.2.00.1211091156120.3856@eggly.anvils>
References: <1352155633-8648-1-git-send-email-walken@google.com> <1352155633-8648-4-git-send-email-walken@google.com> <509D0F86.30607@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Gm-Message-State: ALoCoQlD6kkjssqJpOuinDV1iR1skiWT/sx0Dkp0G7SDGKTeGUy4Ixdy0xfYcrHAFuuIuR4rK/v5C8b3buRTL0v3iPKQGpQKvitnSWpl2hewSTn/jFxeNae/zbYsPyTEgMmOUHpbbYSw8Hg36f0Ts147wp+bvL35OhOAmMq549GDjphk1Xu8Q7yUUdS/CSS0t2hOmAoIO3vBUM+C35jyTKkJt7hnD6lEHQ==
X-archive-position: 34928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hughd@google.com
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

On Fri, 9 Nov 2012, Sasha Levin wrote:
> On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> > When CONFIG_DEBUG_VM_RB is enabled, check that rb_subtree_gap is
> > correctly set for every vma and that mm->highest_vm_end is also correct.
> > 
> > Also add an explicit 'bug' variable to track if browse_rb() detected any
> > invalid condition.
> > 
> > Signed-off-by: Michel Lespinasse <walken@google.com>
> > Reviewed-by: Rik van Riel <riel@redhat.com>
> > 
> > ---
> 
> Hi all,
> 
> While fuzzing with trinity inside a KVM tools (lkvm) guest, using today's -next
> kernel, I'm getting these:
> 
> 
> [  117.007714] free gap 7fba0dd1c000, correct 7fba0dcfb000
> [  117.019773] map_count 750 rb -1
> [  117.028362] ------------[ cut here ]------------
> [  117.029813] kernel BUG at mm/mmap.c:439!
> [  117.031024] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
> [  117.032933] Dumping ftrace buffer:
> [  117.033972]    (ftrace buffer empty)
> [  117.035085] CPU 4
> [  117.035676] Pid: 6859, comm: trinity-child46 Tainted: G        W    3.7.0-rc4-next-20121109-sasha-00013-g9407f3c #124
> [  117.038217] RIP: 0010:[<ffffffff81236687>]  [<ffffffff81236687>] validate_mm+0x297/0x2c0
> [  117.041056] RSP: 0018:ffff880016a4fdf8  EFLAGS: 00010296
> [  117.041056] RAX: 0000000000000013 RBX: 00000000ffffffff RCX: 0000000000000006
> [  117.041056] RDX: 0000000000005270 RSI: ffff880024120910 RDI: 0000000000000286
> [  117.052131] RBP: ffff880016a4fe48 R08: 0000000000000000 R09: 0000000000000000
> [  117.052131] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000000002ee
> [  117.052131] R13: 00007fffea1fc000 R14: ffff88002412c000 R15: 0000000000000000
> [  117.052131] FS:  00007fba129db700(0000) GS:ffff880063600000(0000) knlGS:0000000000000000
> [  117.052131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  117.052131] CR2: 0000000003323288 CR3: 00000000169b2000 CR4: 00000000000406e0
> [  117.052131] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  117.052131] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  117.052131] Process trinity-child46 (pid: 6859, threadinfo ffff880016a4e000, task ffff880024120000)
> [  117.052131] Stack:
> [  117.052131]  ffffffff8489e201 ffffffff81235aa0 ffff88000885cac8 0000000100000000
> [  117.052131]  ffffffff812361b9 ffff88002412c000 ffff88000885cac8 ffff88000885cdc8
> [  117.052131]  ffff88000885cdd0 ffff88002412c000 ffff880016a4fe98 ffffffff812367b4
> [  117.052131] Call Trace:
> [  117.052131]  [<ffffffff81235aa0>] ? vma_compute_subtree_gap+0x40/0x40
> [  117.052131]  [<ffffffff812361b9>] ? vma_gap_update+0x19/0x30
> [  117.052131]  [<ffffffff812367b4>] vma_link+0x94/0xe0
> [  117.052131]  [<ffffffff812386c4>] do_brk+0x2c4/0x380
> [  117.052131]  [<ffffffff812387bf>] ? sys_brk+0x3f/0x190
> [  117.052131]  [<ffffffff812388ce>] sys_brk+0x14e/0x190
> [  117.052131]  [<ffffffff83be2618>] tracesys+0xe1/0xe6
> [  117.052131] Code: d8 41 8b 76 60 39 de 74 1b 89 da 48 c7 c7 c6 d9 89 84 31 c0 e8 01 76 94 02 eb 10 66 0f 1f 84 00 00 00 00 00
> 8b 45 c8 85 c0 74 18 <0f> 0b 4c 8d 48 e0 48 8b 70 e0 31 db c7 45 cc 00 00 00 00 e9 f4
> [  117.052131] RIP  [<ffffffff81236687>] validate_mm+0x297/0x2c0
> [  117.052131]  RSP <ffff880016a4fdf8>
> [  117.136092] ---[ end trace 5ce250e0bf6d040c ]---
> 
> Note that they are very easy to reproduce.
> 
> Also, I see that lots of the code there has a local variable named 'bug' thats tracking
> whether we should BUG() later on. Why does it work that way and the BUG() isn't immediate?

3.7.0-rc4-mm1 BUGged on mm/mmap.c:439 as soon as I tried to rebuild
that kernel with Alan's tty/vt/fb patch included, no fuzzing required.

free_gap 55551d077000, correct 55551ccd2000 in my case.

It should only be affecting the minority with CONFIG_DEBUG_VM_RB=y.
I've put #if 0 around the rb_subtree_gap checking block in browse_rb(),
and running okay so far with that - but not yet done much with it.

Hugh
