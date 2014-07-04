Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 23:53:17 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39035 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834666AbaGDVxPhgi5- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jul 2014 23:53:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 25C5D284664;
        Fri,  4 Jul 2014 23:51:14 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com [209.85.192.53])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9BB73284340;
        Fri,  4 Jul 2014 23:51:12 +0200 (CEST)
Received: by mail-qg0-f53.google.com with SMTP id i50so1834248qgf.40
        for <multiple recipients>; Fri, 04 Jul 2014 14:53:11 -0700 (PDT)
X-Received: by 10.229.191.135 with SMTP id dm7mr22322776qcb.9.1404510791333;
 Fri, 04 Jul 2014 14:53:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.209 with HTTP; Fri, 4 Jul 2014 14:52:51 -0700 (PDT)
In-Reply-To: <1404493623-22705-1-git-send-email-emilgoode@gmail.com>
References: <1404493623-22705-1-git-send-email-emilgoode@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 4 Jul 2014 23:52:51 +0200
Message-ID: <CAOiHx==mR0eioTk=tc457z4ANbhFR2vS2A2y3wzw119jnCi2Pw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix incorrect NULL check in local_flush_tlb_page()
To:     Emil Goode <emilgoode@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <blogic@openwrt.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Fri, Jul 4, 2014 at 7:07 PM, Emil Goode <emilgoode@gmail.com> wrote:
> We check that the struct vm_area_struct pointer vma is NULL and
> then dereference it. The intent must have been to check that
> vma is not NULL before we dereference it in the next condition.

Actually if it is NULL, then it will short-cut and won't dereference
it (because !vma is true it can never become false again), so the
condition would be fine previously.

But, looking at the code a few lines into branch:

        if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
                unsigned long flags;
                int oldpid, newpid, idx;

#ifdef DEBUG_TLB
                printk("[tlbpage<%lu,0x%08lx>]", cpu_context(cpu,
vma->vm_mm), page);
#endif
                newpid = cpu_context(cpu, vma->vm_mm) & ASID_MASK;

it will be then dereferenced here, so the change is actually sensible,
even if the description isn't quite spot-on where it breaks.


Jonas
