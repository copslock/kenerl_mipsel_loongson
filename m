Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 21:11:10 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41569 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859936AbaGETLHCCg5u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Jul 2014 21:11:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 352732873F4;
        Sat,  5 Jul 2014 21:09:04 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com [209.85.216.179])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8421028013C;
        Sat,  5 Jul 2014 21:09:03 +0200 (CEST)
Received: by mail-qc0-f179.google.com with SMTP id x3so2457897qcv.10
        for <multiple recipients>; Sat, 05 Jul 2014 12:11:04 -0700 (PDT)
X-Received: by 10.140.80.49 with SMTP id b46mr28912472qgd.102.1404587464249;
 Sat, 05 Jul 2014 12:11:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.209 with HTTP; Sat, 5 Jul 2014 12:10:44 -0700 (PDT)
In-Reply-To: <1404584812-12377-1-git-send-email-emilgoode@gmail.com>
References: <1404584812-12377-1-git-send-email-emilgoode@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 5 Jul 2014 21:10:44 +0200
Message-ID: <CAOiHx=nU7GvGnwrH0TqTkO9-mhX2RJU5gPzRRwb1OfHPcHmrqA@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Fix incorrect NULL check in local_flush_tlb_page()
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
X-archive-position: 41050
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

On Sat, Jul 5, 2014 at 8:26 PM, Emil Goode <emilgoode@gmail.com> wrote:
> We check that the struct vm_area_struct pointer vma is NULL and then
> dereference it a few lines below. The intent must have been to make sure
> that vma is not NULL and then to check the value from cpu_context() for
> the condition to be true.
>
> Signed-off-by: Emil Goode <emilgoode@gmail.com>
> ---
>
> v2: Updated the commit message with a better explanation.
>
>  arch/mips/mm/tlb-r3k.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
> index d657493..6546758 100644
> --- a/arch/mips/mm/tlb-r3k.c
> +++ b/arch/mips/mm/tlb-r3k.c
> @@ -158,7 +158,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
>  {
>         int cpu = smp_processor_id();
>
> -       if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
> +       if (vma && cpu_context(cpu, vma->vm_mm) != 0) {

Sorry for replying "too late", but grepping through the kernel code I
fail to find any caller that does not dereference vma before calling
(local)flush_tlb_page(). Also both tlb-4k and tlb-8k assume vma cannot
be NULL, so I would say it is safe to assume vma is never NULL, and
the NULL check can be removed completely.

Also it looks like this "bug" was there since at least 2.6.12, and
never seem to have bitten anyone.


Jonas
