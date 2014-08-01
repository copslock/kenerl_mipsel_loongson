Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2014 15:38:04 +0200 (CEST)
Received: from mail-oa0-f51.google.com ([209.85.219.51]:42301 "EHLO
        mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860094AbaHANh4VQCoj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2014 15:37:56 +0200
Received: by mail-oa0-f51.google.com with SMTP id o6so3095093oag.24
        for <linux-mips@linux-mips.org>; Fri, 01 Aug 2014 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mYQ0sg3LXGctJKPPxuH12IfA06GzLqDNoE0Zuz1hzUw=;
        b=wHww18v/TwWTgvLItSXUq4jKgQIi3ZsGaVEPspaOq7wJa65/vOJmOkMlvUNk4uvJ4o
         njyQaTTm0tAcKa4cWfN5YgfBXupNX2v2jiyILQ0N9sUdEqBeuD5P7JqEGwNzVk3IOvGf
         NJH2YfkPafreXQRK9G3x64+Sy9SrLQA3OmWmajOb8aWiW37Mc2bnLWTxo4fyE9Vw9XHD
         7vA+87b2A7meEAQYWS28wmTgF+8gMAMQJvRDZZwmYpIUHf/Le58WUDjKBErn7tfpoG3v
         dS5aIFBB/miWAvWkDFXqur0+k+Ygo6E1FX1jQbWe38TmoeazJ/UstuMPBZvRl0ymuVXC
         srbA==
MIME-Version: 1.0
X-Received: by 10.182.204.102 with SMTP id kx6mr8422236obc.16.1406900269683;
 Fri, 01 Aug 2014 06:37:49 -0700 (PDT)
Received: by 10.76.130.47 with HTTP; Fri, 1 Aug 2014 06:37:49 -0700 (PDT)
In-Reply-To: <1406317427-10215-2-git-send-email-jcmvbkbc@gmail.com>
References: <1406317427-10215-1-git-send-email-jcmvbkbc@gmail.com>
        <1406317427-10215-2-git-send-email-jcmvbkbc@gmail.com>
Date:   Fri, 1 Aug 2014 17:37:49 +0400
Message-ID: <CAMo8BfKmYwG2tJym_97XeSP2zej7Oecw7_W9YNqf_Ogep-3-KA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/highmem: make kmap cache coloring aware
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Cc:     Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Steven Hill <Steven.Hill@imgtec.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

On Fri, Jul 25, 2014 at 11:43 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> VIPT cache with way size larger than MMU page size may suffer from
> aliasing problem: a single physical address accessed via different
> virtual addresses may end up in multiple locations in the cache.
> Virtual mappings of a physical address that always get cached in
> different cache locations are said to have different colors.
> L1 caching hardware usually doesn't handle this situation leaving it
> up to software. Software must avoid this situation as it leads to
> data corruption.
>
> One way to handle this is to flush and invalidate data cache every time
> page mapping changes color. The other way is to always map physical page
> at a virtual address with the same color. Low memory pages already have
> this property. Giving architecture a way to control color of high memory
> page mapping allows reusing of existing low memory cache alias handling
> code.
>
> Provide hooks that allow architectures with aliasing cache to align
> mapping address of high pages according to their color. Such architectures
> may enforce similar coloring of low- and high-memory page mappings and
> reuse existing cache management functions to support highmem.
>
> This code is based on the implementation of similar feature for MIPS by
> Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---

Ping? Is there anything else that can help making this patch better
and getting it merged?

> Changes v2->v3:
> - drop ARCH_PKMAP_COLORING, check gif et_pkmap_color is defined instead;
> - add comment stating that arch should place definitions into
>   asm/highmem.h, include it directly to mm/highmem.c;
> - replace macros with inline functions, change set_pkmap_color to
>   get_pkmap_color which better fits inline function model;
> - drop get_last_pkmap_nr;
> - replace get_next_pkmap_counter with get_pkmap_entries_count, leave
>   original counting code;
> - introduce get_pkmap_wait_queue_head and make sleeping/waking dependent
>   on mapping color;
> - move file-scope static variables last_pkmap_nr and pkmap_map_wait into
>   get_next_pkmap_nr and get_pkmap_wait_queue_head respectively;
> - document new functions;
> - expand patch description and change authorship.
>
> Changes v1->v2:
> - define set_pkmap_color(pg, cl) as do { } while (0) instead of /* */;
> - rename is_no_more_pkmaps to no_more_pkmaps;
> - change 'if (count > 0)' to 'if (count)' to better match the original
>   code behavior;
>
>  mm/highmem.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 11 deletions(-)
>
> diff --git a/mm/highmem.c b/mm/highmem.c
> index b32b70c..0d0cbbb 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -28,6 +28,9 @@
>  #include <linux/highmem.h>
>  #include <linux/kgdb.h>
>  #include <asm/tlbflush.h>
> +#ifdef CONFIG_HIGHMEM
> +#include <asm/highmem.h>
> +#endif
>
>
>  #if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
> @@ -44,6 +47,66 @@ DEFINE_PER_CPU(int, __kmap_atomic_idx);
>   */
>  #ifdef CONFIG_HIGHMEM
>
> +/*
> + * Architecture with aliasing data cache may define the following family of
> + * helper functions in its asm/highmem.h to control cache color of virtual
> + * addresses where physical memory pages are mapped by kmap.
> + */
> +#ifndef get_pkmap_color
> +
> +/*
> + * Determine color of virtual address where the page should be mapped.
> + */
> +static inline unsigned int get_pkmap_color(struct page *page)
> +{
> +       return 0;
> +}
> +#define get_pkmap_color get_pkmap_color
> +
> +/*
> + * Get next index for mapping inside PKMAP region for page with given color.
> + */
> +static inline unsigned int get_next_pkmap_nr(unsigned int color)
> +{
> +       static unsigned int last_pkmap_nr;
> +
> +       last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
> +       return last_pkmap_nr;
> +}
> +
> +/*
> + * Determine if page index inside PKMAP region (pkmap_nr) of given color
> + * has wrapped around PKMAP region end. When this happens an attempt to
> + * flush all unused PKMAP slots is made.
> + */
> +static inline int no_more_pkmaps(unsigned int pkmap_nr, unsigned int color)
> +{
> +       return pkmap_nr == 0;
> +}
> +
> +/*
> + * Get the number of PKMAP entries of the given color. If no free slot is
> + * found after checking that much entries, kmap will sleep waiting for
> + * someone to call kunmap and free PKMAP slot.
> + */
> +static inline int get_pkmap_entries_count(unsigned int color)
> +{
> +       return LAST_PKMAP;
> +}
> +
> +/*
> + * Get head of a wait queue for PKMAP entries of the given color.
> + * Wait queues for different mapping colors should be independent to avoid
> + * unnecessary wakeups caused by freeing of slots of other colors.
> + */
> +static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
> +{
> +       static DECLARE_WAIT_QUEUE_HEAD(pkmap_map_wait);
> +
> +       return &pkmap_map_wait;
> +}
> +#endif
> +
>  unsigned long totalhigh_pages __read_mostly;
>  EXPORT_SYMBOL(totalhigh_pages);
>
> @@ -68,13 +131,10 @@ unsigned int nr_free_highpages (void)
>  }
>
>  static int pkmap_count[LAST_PKMAP];
> -static unsigned int last_pkmap_nr;
>  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
>
>  pte_t * pkmap_page_table;
>
> -static DECLARE_WAIT_QUEUE_HEAD(pkmap_map_wait);
> -
>  /*
>   * Most architectures have no use for kmap_high_get(), so let's abstract
>   * the disabling of IRQ out of the locking in that case to save on a
> @@ -161,15 +221,17 @@ static inline unsigned long map_new_virtual(struct page *page)
>  {
>         unsigned long vaddr;
>         int count;
> +       unsigned int last_pkmap_nr;
> +       unsigned int color = get_pkmap_color(page);
>
>  start:
> -       count = LAST_PKMAP;
> +       count = get_pkmap_entries_count(color);
>         /* Find an empty entry */
>         for (;;) {
> -               last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
> -               if (!last_pkmap_nr) {
> +               last_pkmap_nr = get_next_pkmap_nr(color);
> +               if (no_more_pkmaps(last_pkmap_nr, color)) {
>                         flush_all_zero_pkmaps();
> -                       count = LAST_PKMAP;
> +                       count = get_pkmap_entries_count(color);
>                 }
>                 if (!pkmap_count[last_pkmap_nr])
>                         break;  /* Found a usable entry */
> @@ -181,12 +243,14 @@ start:
>                  */
>                 {
>                         DECLARE_WAITQUEUE(wait, current);
> +                       wait_queue_head_t *pkmap_map_wait =
> +                               get_pkmap_wait_queue_head(color);
>
>                         __set_current_state(TASK_UNINTERRUPTIBLE);
> -                       add_wait_queue(&pkmap_map_wait, &wait);
> +                       add_wait_queue(pkmap_map_wait, &wait);
>                         unlock_kmap();
>                         schedule();
> -                       remove_wait_queue(&pkmap_map_wait, &wait);
> +                       remove_wait_queue(pkmap_map_wait, &wait);
>                         lock_kmap();
>
>                         /* Somebody else might have mapped it while we slept */
> @@ -274,6 +338,8 @@ void kunmap_high(struct page *page)
>         unsigned long nr;
>         unsigned long flags;
>         int need_wakeup;
> +       unsigned int color = get_pkmap_color(page);
> +       wait_queue_head_t *pkmap_map_wait;
>
>         lock_kmap_any(flags);
>         vaddr = (unsigned long)page_address(page);
> @@ -299,13 +365,14 @@ void kunmap_high(struct page *page)
>                  * no need for the wait-queue-head's lock.  Simply
>                  * test if the queue is empty.
>                  */
> -               need_wakeup = waitqueue_active(&pkmap_map_wait);
> +               pkmap_map_wait = get_pkmap_wait_queue_head(color);
> +               need_wakeup = waitqueue_active(pkmap_map_wait);
>         }
>         unlock_kmap_any(flags);
>
>         /* do wake-up, if needed, race-free outside of the spin lock */
>         if (need_wakeup)
> -               wake_up(&pkmap_map_wait);
> +               wake_up(pkmap_map_wait);
>  }
>
>  EXPORT_SYMBOL(kunmap_high);
> --
> 1.8.1.4
>



-- 
Thanks.
-- Max
