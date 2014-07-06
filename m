Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jul 2014 12:23:01 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:33839 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818711AbaGFKW7RLEle (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Jul 2014 12:22:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A0FC42874F7;
        Sun,  6 Jul 2014 12:20:56 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com [209.85.216.170])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 53AF02811FA;
        Sun,  6 Jul 2014 12:20:45 +0200 (CEST)
Received: by mail-qc0-f170.google.com with SMTP id l6so2786330qcy.29
        for <multiple recipients>; Sun, 06 Jul 2014 03:22:45 -0700 (PDT)
X-Received: by 10.140.23.198 with SMTP id 64mr35014138qgp.84.1404642165320;
 Sun, 06 Jul 2014 03:22:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.209 with HTTP; Sun, 6 Jul 2014 03:22:25 -0700 (PDT)
In-Reply-To: <1404602638-16447-1-git-send-email-emilgoode@gmail.com>
References: <1404602638-16447-1-git-send-email-emilgoode@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 6 Jul 2014 12:22:25 +0200
Message-ID: <CAOiHx==kyY9ce5jjv5m36OXpG9Vk4NsPa9m+nfWuYWjxOnMisA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove incorrect NULL check in local_flush_tlb_page()
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
X-archive-position: 41058
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

On Sun, Jul 6, 2014 at 1:23 AM, Emil Goode <emilgoode@gmail.com> wrote:
> We check that the struct vm_area_struct pointer vma is NULL and then
> dereference it a few lines below. The intent was to make sure vma is
> not NULL but this is not necessary since the bug pre-dates GIT history
> and seem to never have caused a problem. The tlb-4k and tlb-8k versions
> of local_flush_tlb_page() don't bother checking if vma is NULL, also
> vma is dereferenced before being passed to local_flush_tlb_page(),
> thus it is safe to remove this NULL check.
>
> Signed-off-by: Emil Goode <emilgoode@gmail.com>

Looks good.

Reviewed-by: Jonas Gorski <jogo@openwrt.org>

> ---
>  arch/mips/mm/tlb-r3k.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
> index d657493..4094bbd 100644
> --- a/arch/mips/mm/tlb-r3k.c
> +++ b/arch/mips/mm/tlb-r3k.c
> @@ -158,7 +158,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
>  {
>         int cpu = smp_processor_id();
>
> -       if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
> +       if (cpu_context(cpu, vma->vm_mm) != 0) {
>                 unsigned long flags;
>                 int oldpid, newpid, idx;
>
> --
> 1.7.10.4
>
>
