Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 20:33:06 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:36136 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491106Ab1AXTdC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 20:33:02 +0100
Received: by eyd9 with SMTP id 9so1969873eyd.36
        for <multiple recipients>; Mon, 24 Jan 2011 11:33:01 -0800 (PST)
Received: by 10.213.29.16 with SMTP id o16mr5492218ebc.58.1295897530812;
        Mon, 24 Jan 2011 11:32:10 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id u1sm10439404eeh.22.2011.01.24.11.32.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Jan 2011 11:32:09 -0800 (PST)
Message-ID: <4D3DD366.8000704@mvista.com>
Date:   Mon, 24 Jan 2011 22:30:46 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Yoichi Yuasa <yuasa@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips <linux-mips@linux-mips.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix build error when CONFIG_SWAP is not set
References: <20110124210813.ba743fc5.yuasa@linux-mips.org>
In-Reply-To: <20110124210813.ba743fc5.yuasa@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Yoichi Yuasa wrote:

> In file included from
> linux-2.6/arch/mips/include/asm/tlb.h:21,
>                  from mm/pgtable-generic.c:9:
> include/asm-generic/tlb.h: In function 'tlb_flush_mmu':
> include/asm-generic/tlb.h:76: error: implicit declaration of function
> 'release_pages'
> include/asm-generic/tlb.h: In function 'tlb_remove_page':
> include/asm-generic/tlb.h:105: error: implicit declaration of function
> 'page_cache_release'
> make[1]: *** [mm/pgtable-generic.o] Error 1
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
[...]

> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4d55932..92c1be6 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -8,6 +8,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/sched.h>
>  #include <linux/node.h>
> +#include <linux/pagemap.h>

    Hm, if the errors are in <asm-generic/tlb.h>, why add #include in 
<linux/swap.h>?

WBR. Sergei
