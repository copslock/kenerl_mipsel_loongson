Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Mar 2013 06:50:12 +0100 (CET)
Received: from [222.92.8.138] ([222.92.8.138]:50339 "EHLO mail.lemote.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823116Ab3CTFuKCLcRA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Mar 2013 06:50:10 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 911F22270D;
        Wed, 20 Mar 2013 13:50:01 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J6Ny9pxmfxz6; Wed, 20 Mar 2013 13:50:01 +0800 (CST)
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com [209.85.215.49])
        (Authenticated sender: chenj@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPSA id 8B427226B0;
        Wed, 20 Mar 2013 13:49:55 +0800 (CST)
Received: by mail-la0-f49.google.com with SMTP id fs13so2432027lab.36
        for <multiple recipients>; Tue, 19 Mar 2013 22:49:40 -0700 (PDT)
X-Received: by 10.152.116.45 with SMTP id jt13mr4453637lab.0.1363758580504;
 Tue, 19 Mar 2013 22:49:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.62.178 with HTTP; Tue, 19 Mar 2013 22:49:20 -0700 (PDT)
In-Reply-To: <1363524614-3823-1-git-send-email-chenhc@lemote.com>
References: <1363524614-3823-1-git-send-email-chenhc@lemote.com>
From:   Chen Jie <chenj@lemote.com>
Date:   Wed, 20 Mar 2013 13:49:20 +0800
Message-ID: <CAGXxSxXscpbrFmmxJZZc9tcgdZ5fmrsAZNjLnSRYMApStYxiOg@mail.gmail.com>
Subject: Re: [PATCH V2 02/02] MIPS: Init new mmu_context for each possible CPU
 to avoid memory corruption
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

2013/3/17 Huacai Chen <chenhc@lemote.com>:
> Currently, init_new_context() only for each online CPU, this may cause
> memory corruption when CPU hotplug and fork() happens at the same time.
> To avoid this, we make init_new_context() cover each possible CPU.
>
> Scenario:
> 1, CPU#1 is being offline;
> 2, On CPU#0, do_fork() call dup_mm() and copy a mm_struct to the child;
> 3, On CPU#0, dup_mm() call init_new_context(), since CPU#1 is offline
>    and init_new_context() only covers the online CPUs, child has the
>    same asid as its parent on CPU#1 (however, child's asid should be 0);
> 4, CPU#1 is being online;
> 5, Now, if both parent and child run on CPU#1, memory corruption (e.g.
>    segfault, bus error, etc.) will occur.
Adds some further explanations about point 5:
5.1) The parent process runs on CPU#1, the version field of its
asid[CPU#1] and CPU#1's asid cache may match, thus the parent
process's asid[CPU#1] is used in TLB refilling routine.

5.2) Then the child process runs on CPU#1 which probably has the same
asid[CPU#1] as its parent(as pointed by point 3).

5.3) The child process may access address space of its parent.

It can also be solved by increasing version field of asid cache when
plugin a CPU,  may be a better way?



Regards,
-- Chen Jie
