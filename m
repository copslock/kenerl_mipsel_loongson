Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 06:27:22 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:43046 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903558Ab1KTF1P convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Nov 2011 06:27:15 +0100
Received: by wwp14 with SMTP id 14so6458478wwp.24
        for <multiple recipients>; Sat, 19 Nov 2011 21:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DY0CrFf6ZVzGh18xpMODHrbKJlcCv12iJ3FPwbyQnNY=;
        b=H+pM/5jY5ypyfSuS9bHp8zjC5TTpkEKNojFnpy3vyCi9j+lIXlJJymy18VMJpHX3SV
         mMPwvaQw0QUvXkBjMI/dCCx3RbaStpy+qIw6bwD415GsdIeae0iX5W6DtXckFV85knqR
         3Z2RI1sOAd7c/clPvapq5g+xvBy6kgLeYRWu0=
MIME-Version: 1.0
Received: by 10.181.11.226 with SMTP id el2mr8971275wid.64.1321766830228; Sat,
 19 Nov 2011 21:27:10 -0800 (PST)
Received: by 10.216.45.11 with HTTP; Sat, 19 Nov 2011 21:27:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1111191855410.5457@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1111191855410.5457@chino.kir.corp.google.com>
Date:   Sun, 20 Nov 2011 13:27:10 +0800
Message-ID: <CAJd=RBBmODwpUi1_eObE47yCQVfEGLHyy45=aqUtxM-9Bpki6A@mail.gmail.com>
Subject: Re: [patch] mips, mm: avoid using HPAGE constants without CONFIG_HUGETLB_PAGE
From:   Hillf Danton <dhillf@gmail.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16600

with David Daney Cced

On Sun, Nov 20, 2011 at 10:56 AM, David Rientjes <rientjes@google.com> wrote:
> HPAGE_{MASK,SHIFT,SIZE} are only defined with CONFIG_HUGETLB_PAGE, so
> make sure to never use them unless that option is enabled.
>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  arch/mips/mm/tlb-r4k.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -124,9 +124,11 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>
>                ENTER_CRITICAL(flags);
>                if (huge) {
> +#ifdef CONFIG_HUGETLB_PAGE
>                        start = round_down(start, HPAGE_SIZE);
>                        end = round_up(end, HPAGE_SIZE);
>                        size = (end - start) >> HPAGE_SHIFT;
> +#endif
>                } else {
>                        start = round_down(start, PAGE_SIZE << 1);
>                        end = round_up(end, PAGE_SIZE << 1);
> @@ -135,15 +137,16 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                if (size <= current_cpu_data.tlbsize/2) {
>                        int oldpid = read_c0_entryhi();
>                        int newpid = cpu_asid(cpu, mm);
> +                       unsigned long incr = PAGE_SIZE << 1;
>
> -                       while (start < end) {
> +#ifdef CONFIG_HUGETLB_PAGE
> +                       if (huge)
> +                               incr = HPAGE_SIZE;
> +#endif
> +                       for (; start < end; start += incr) {

Here huge is included in #ifdef, but not the above huge, so readers a bit
confused. The following diff is what I mean.

Best regards
Hillf
---

--- a/arch/mips/include/asm/page.h	Sun Nov 20 13:08:44 2011
+++ b/arch/mips/include/asm/page.h	Sun Nov 20 13:17:43 2011
@@ -38,6 +38,11 @@
 #define HPAGE_SIZE	(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+#else
+#define HPAGE_SHIFT	({ BUG(); 0; })
+#define HPAGE_SIZE	({ BUG(); 0; })
+#define HPAGE_MASK	({ BUG(); 0; })
+#define HUGETLB_PAGE_ORDER	({ BUG(); 0; })
 #endif /* CONFIG_HUGETLB_PAGE */

 #ifndef __ASSEMBLY__
