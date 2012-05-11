Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 19:20:48 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:57473 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903691Ab2EKRUo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 19:20:44 +0200
Received: by lbbgg6 with SMTP id gg6so2560341lbb.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 10:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=ESsD0jOE+sOupE3CqV6PrcB+IIPWuXZ6kcCseJJLgwg=;
        b=PFBk6uHWLDkN+5ipFgK1Z/NbFRQszKXfTlRIU37SW0bBG8GBrunIkv6ZUqGSOe9+ES
         cq4C2h+FnrvMl5yj/IUImvpu7WprjdVtQ4R0qAH0s9P3EwRDuZ0EXWiSw1Zc9tUqgf1p
         44UgL9FTnUXUhZmPpzBP0CEhlvo19Jk2MOjfiQNGQfaawmLVWyel7U1WedzLKW+eyDfU
         OAPKvK63/w2bwwARUkffctHIRY+Q9vuOCw2Ds6wzNjKJoOG4c8SQUL+hSP46ZHTc8ZDe
         X9xEybD5eoUf7FSafutp5dDmVayrOCYcwTui3WVVh/xMN7WiTXoIjMZb0//2qy09F1Zp
         gYVg==
Received: by 10.112.103.8 with SMTP id fs8mr4188152lbb.29.1336756838644;
        Fri, 11 May 2012 10:20:38 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id nv7sm10008527lab.9.2012.05.11.10.20.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 10:20:36 -0700 (PDT)
Message-ID: <4FAD4A1C.70307@mvista.com>
Date:   Fri, 11 May 2012 21:19:24 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: Re: [PATCH v3] Revert fixrange_init() limiting to the FIXMAP region.
References: <1336755231-5678-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1336755231-5678-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm4bfXM/O4vXJKiRZiOy3k8zaPzWru/IauI3JVvPtv//1DHMwdF/GLz/KcinHSYTmAh4ioq
X-archive-position: 33262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/11/2012 08:53 PM, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> This patch refactors 464fd83e841a16f4ea1325b33eb08170ef5cd1f4 and

   Please also specify that commit's summary in parens.

> correctly calculates the right length while taking into account
> page table alignment by PMD.

> Signed-off-by: Leonid Yegoshin<yegoshin@mips.com>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
[...]

> diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
> index adc6911..5d27baf 100644
> --- a/arch/mips/mm/pgtable-32.c
> +++ b/arch/mips/mm/pgtable-32.c
[...]
> @@ -51,8 +52,11 @@ void __init pagetable_init(void)
>   	/*
>   	 * Fixed mappings:
>   	 */
> -	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1)&  PMD_MASK;
> -	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
> +	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
> +	/* Calculate real end before alignment. */
> +	vend = vaddr + FIXADDR_SIZE;
> +	vaddr = vaddr & PMD_MASK;

	vaddr &= PMD_MASK;

WBR, Sergei
