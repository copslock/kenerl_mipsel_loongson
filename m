Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 02:58:58 +0200 (CEST)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:44836 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861296AbaGVA6yLVf3u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 02:58:54 +0200
Received: by mail-ig0-f177.google.com with SMTP id hn18so3465205igb.10
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 17:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type;
        bh=TxZ2eDL72dxOrhuptbONIR/RKYqLcWnRcWwe2m536zs=;
        b=LcOgKILDI/ThBupuGJ6yvWJw8+1/SyULYjYDI5hjzRaDQHcK0uXj5mqkOTtHUFhiik
         wK2S3xDFAPe9aUEOFyIADVTdJi3cJCj+Xnt7gexx/4bscDg/JurvA7zyh3sT7N51H8Ti
         KOLnzOoDz+PYVzuocr93drct3O9nsUajQzbVwZAse29L+9xTdPIwPIBHgrmB1yC/Asm9
         /m5RYKRpR+pFZEThH8rRXO2iqJxhYmjnAJD3rCUT+fi/YmvVi1tKAtdtKL/rFZTguH/0
         vISj/QwrmjJYJOi2OXdjQeeBB9dpXmsUF77VRsNKQ9wYyajCJILroGyqtsvfJ4W1/cR7
         J2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=TxZ2eDL72dxOrhuptbONIR/RKYqLcWnRcWwe2m536zs=;
        b=E7D2cqDevUnmCDXR3J6ouiyfRPjd3+k7aqRcshOlqhgXardxlasAy8tYz9mBhQfwwX
         P/GIVcd+dJDyCPR3yEcd3b4SSjwJmpbF4WAUkdeTVojlMD003zAwuEdyse/259Rp7xCv
         Xrz830WA1kbsJiWcYOtmD4Cn3JuL5ZGE8E0wIrri/mCfGkOugRt6YG5KF0rtY/JZciao
         oB8zcxvxSSAvw/whBjYSvqIYyWA1mIey1mc8JDh/ppVCkrQd2HxzVLhykqw+8mhE4FtK
         EZymSWZmUIsLNCqQxFPR8F+3Oyi1fNsB1YdL7zfou0reFzBODwvMNz6Yw1VXIbxHX1/C
         A4hA==
X-Gm-Message-State: ALoCoQktbZkVxzGOqijeSIBSclOTMmeAE9AT+4IOnADECqJt2YQSN7vVLHEU0l8cxd2UB/sq/S6E
X-Received: by 10.42.68.15 with SMTP id v15mr17622627ici.79.1405990727879;
        Mon, 21 Jul 2014 17:58:47 -0700 (PDT)
Received: from [2620:0:1008:1101:e427:f43b:221b:a15c] ([2620:0:1008:1101:e427:f43b:221b:a15c])
        by mx.google.com with ESMTPSA id il3sm43803467igb.1.2014.07.21.17.58.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 17:58:47 -0700 (PDT)
Date:   Mon, 21 Jul 2014 17:58:46 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Max Filippov <jcmvbkbc@gmail.com>
cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
In-Reply-To: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com>
Message-ID: <alpine.DEB.2.02.1407211754350.7042@chino.kir.corp.google.com>
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rientjes@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
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

On Thu, 17 Jul 2014, Max Filippov wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> Provide hooks that allow architectures with aliasing cache to align
> mapping address of high pages according to their color. Such architectures
> may enforce similar coloring of low- and high-memory page mappings and
> reuse existing cache management functions to support highmem.
> 

Typically a change like this would be proposed along with a change to an 
architecture which would define this new ARCH_PKMAP_COLORING and have its 
own overriding definitions.  Based on who you sent this patch to, it looks 
like that would be mips and xtensa.  Now the only question is where are 
those patches to add the alternate definitions for those platforms?

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> [ Max: extract architecture-independent part of the original patch, clean
>   up checkpatch and build warnings. ]
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - fix description
> 
>  mm/highmem.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index b32b70c..6898a8b 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -44,6 +44,14 @@ DEFINE_PER_CPU(int, __kmap_atomic_idx);
>   */
>  #ifdef CONFIG_HIGHMEM
>  
> +#ifndef ARCH_PKMAP_COLORING
> +#define set_pkmap_color(pg, cl)		/* */

This is typically done with do {} while (0).

> +#define get_last_pkmap_nr(p, cl)	(p)
> +#define get_next_pkmap_nr(p, cl)	(((p) + 1) & LAST_PKMAP_MASK)
> +#define is_no_more_pkmaps(p, cl)	(!(p))

That's not gramatically proper.

> +#define get_next_pkmap_counter(c, cl)	((c) - 1)
> +#endif
> +
>  unsigned long totalhigh_pages __read_mostly;
>  EXPORT_SYMBOL(totalhigh_pages);
>  
> @@ -161,19 +169,24 @@ static inline unsigned long map_new_virtual(struct page *page)
>  {
>  	unsigned long vaddr;
>  	int count;
> +	int color __maybe_unused;
> +
> +	set_pkmap_color(page, color);
> +	last_pkmap_nr = get_last_pkmap_nr(last_pkmap_nr, color);
>  
>  start:
>  	count = LAST_PKMAP;
>  	/* Find an empty entry */
>  	for (;;) {
> -		last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
> -		if (!last_pkmap_nr) {
> +		last_pkmap_nr = get_next_pkmap_nr(last_pkmap_nr, color);
> +		if (is_no_more_pkmaps(last_pkmap_nr, color)) {
>  			flush_all_zero_pkmaps();
>  			count = LAST_PKMAP;
>  		}
>  		if (!pkmap_count[last_pkmap_nr])
>  			break;	/* Found a usable entry */
> -		if (--count)
> +		count = get_next_pkmap_counter(count, color);

And that's not equivalent at all, --count decrements the auto variable and 
then tests it for being non-zero.  Your get_next_pkmap_counter() never 
decrements count.

> +		if (count > 0)
>  			continue;
>  
>  		/*
