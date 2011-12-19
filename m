Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2011 00:07:51 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:59938 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903750Ab1LSXHo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Dec 2011 00:07:44 +0100
Received: by ghrr15 with SMTP id r15so2069023ghr.36
        for <multiple recipients>; Mon, 19 Dec 2011 15:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YaiQwu1+uOsLwZXQ+JgvA7b9vleTNIWNeP9DIqLm1xs=;
        b=YAdam6Qpw7tFPQ7u5z2ELh2uhxQ893o4Y1Mw421tcIsIb4Q0KewiX0mpfPe8dcNlZx
         n120/exhBxb7BXgOZQdIRGUMmliT9lwT4B9SYoQQG/BZ9f98YllpvZfxo0PrGItuQs5K
         SOOZmJyduR5fO+omDi42n129MuxdH9d1L0T0k=
Received: by 10.236.175.72 with SMTP id y48mr32376564yhl.17.1324336057716;
        Mon, 19 Dec 2011 15:07:37 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id w68sm32488441yhe.14.2011.12.19.15.07.36
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 15:07:36 -0800 (PST)
Message-ID: <4EEFC3B7.9020008@gmail.com>
Date:   Mon, 19 Dec 2011 15:07:35 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
CC:     linux-kernel@vger.kernel.org, Jason Baron <jbaron@redhat.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2a] jump-label: initialize jump-label subsystem somewhat
 later
References: <1323885279-26850-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1323885279-26850-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15587

On 12/14/2011 09:54 AM, David Daney wrote:
> From: David Daney<david.daney@cavium.com>
>
> commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa
> (jump-label: initialize jump-label subsystem much earlier) breaks MIPS.
>
> The jump-label initialization does I-Cache flushing after modifying
> code.  On MIPS this is done by calling through the function pointer
> flush_icache_range().  This function pointer is initialized by
> trap_init().
>
> As things stand, we cannot be calling jump_label_init() until after
> trap_init() completes, so we move the call down to satisfy this
> constraint.
>
> Signed-off-by: David Daney<david.daney@cavium.com>

NACK to myself:

I now have a patch for MIPS that makes this one unnecessary.

David Daney

> ---
>
> Sorry for spamming this out again, but Sergei keeps flagging my poor
> grammar.
>
> Difference from v2: Fix grammar and spelling issues in changelog.  No
>                      change to the patch.
>
> Difference from v1: Move jump_label_init() up one so it is now before
>                      mm_init() instead of after it.
>
>
>   init/main.c |    3 +--
>   1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/init/main.c b/init/main.c
> index 217ed23..68ab12b 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -513,8 +513,6 @@ asmlinkage void __init start_kernel(void)
>   		   __stop___param - __start___param,
>   		&unknown_bootoption);
>
> -	jump_label_init();
> -
>   	/*
>   	 * These use large bootmem allocations and must precede
>   	 * kmem_cache_init()
> @@ -524,6 +522,7 @@ asmlinkage void __init start_kernel(void)
>   	vfs_caches_init_early();
>   	sort_main_extable();
>   	trap_init();
> +	jump_label_init();
>   	mm_init();
>
>   	/*
