Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 12:27:05 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35143 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823099Ab2KML1C6BWDs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 12:27:02 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2785715bkw.36
        for <multiple recipients>; Tue, 13 Nov 2012 03:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=2s38WEZFZ1gLTnWzKoM0QX8B7GA+MUPnaehQ+xSvl44=;
        b=NKvsSLgVh/pGBXeMVgSrIjK0Dc22lGKlV7Bizpdxj5jHu1GLuullSdEWfCyStXnFMF
         5dSAYfR30ZTNXeIogywNefdnwo+GGvLmsr+2YOS4H6MiqHSu4x/pchN6F2BY/1iHb7Hd
         z8mUeobD9qbgrQQpWqhhH8BaaReH/hg3f01Bb/WI5c8Rf9WzugYvTPczudNfq2RDbFE5
         0cJ6Gke2ndL2OVnUgq82jdMaNDYkALajs45fnvWx2QhlYx9ZcpoZTgvO9yPjoLnQfqJM
         E9rogg1+8prPiZMEC/bkhPGC/3sKick5g++Ol4hNzRVWx2Q3CFYVA0ExXisiQ2DU3s+u
         jRRg==
Received: by 10.204.11.141 with SMTP id t13mr7925639bkt.65.1352806014077;
        Tue, 13 Nov 2012 03:26:54 -0800 (PST)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id go4sm4870382bkc.15.2012.11.13.03.26.52
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 03:26:53 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org, wuzhangjin@gmail.com
Subject: Re: [PATCH] MIPS: decompressor: fix build failure on memcpy() in decompress.c
Date:   Tue, 13 Nov 2012 12:25:15 +0100
Message-ID: <2522606.hXbg5cgH5o@flexo>
Organization: OpenWrt
User-Agent: KMail/4.9.2 (Linux/3.5.0-17-generic; KDE/4.9.2; x86_64; ; )
In-Reply-To: <1352720818-9192-1-git-send-email-florian@openwrt.org>
References: <1352720818-9192-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

On Monday 12 November 2012 12:46:58 Florian Fainelli wrote:
> The decompress.c file includes linux/kernel.h which causes the following
> inclusion chain to be pulled:
> linux/kernel.h ->
> 	linux/dynamic_debug.h ->
> 		linux/string.h ->
> 			asm/string.h
> 
> We end up having a the GCC builtin + architecture specific memcpy() expanding
> into this:
> 
> void *({ size_t __len = (size_t n); void *__ret; if
> (__builtin_constant_p(size_t n) && __len >= 64) __ret = memcpy((void *dest),
> (const void *src), __len); else __ret = __builtin_memcpy((void *dest), (const
> void *src), __len); __ret; })

After some more debugging, this expansion "failure" actually comes from one
of our OpenWrt patch which allows the use of GCC builtins for memcpy and
friends. The fix remains valid anyway.

> {
>  [memcpy implementation in decompress.c starts here]
>  int i;
>  const char *s = src;
>  char *d = dest;
> 
>  for (i = 0; i < n; i++)
>   d[i] = s[i];
>  return dest;
> }
> 
> raising the following compilation error:
> arch/mips/boot/compressed/decompress.c:46:8: error: expected identifier or '('
> before '{' token
> 
> There are at least three possibilities to fix this issue:
> 
> 1) define _LINUX_STRING_H_ at the beginning of decompress.c to prevent
>    further linux/string.h definitions and declarations from being used, and add
>    an explicit strstr() declaration for linux/dynamic_debug.h
> 
> 2) remove the inclusion of linux/kernel.h because we actually use no definition
>    or declaration from this header file
> 
> 3) undefine memcpy or re-define memcpy to memcpy thus resulting in picking up
>    the local memcpy() implementation to this compilation unit
> 
> This patch uses the second option which is the less intrusive one.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/boot/compressed/decompress.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index 5cad0fa..d6c5586 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -10,9 +10,7 @@
>   * Free Software Foundation;  either version 2 of the  License, or (at your
>   * option) any later version.
>   */
> -
>  #include <linux/types.h>
> -#include <linux/kernel.h>
>  
>  #include <asm/addrspace.h>
>  
> -- 
> 1.7.10.4
> 
