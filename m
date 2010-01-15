Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2010 11:30:48 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:11883 "HELO
        imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with SMTP id S1492092Ab0AOKap (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2010 11:30:45 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
        by imap.sh.mvista.com (Postfix) with SMTP
        id 678313EDC; Fri, 15 Jan 2010 02:30:33 -0800 (PST)
Message-ID: <4B5043B2.5060009@ru.mvista.com>
Date:   Fri, 15 Jan 2010 13:30:10 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add support of LZO-compressed kernels
References: <1263540676-26295-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1263540676-26295-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 25597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10090

Hello.

Wu Zhangjin wrote:
> The commit "lib: add support for LZO-compressed kernels" has been merged
> into linus' 2.6.33-rc4 tree, so, It is time to add the support for MIPS.
>
> NOTE: to enable this support, the lzop application is needed.
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
>   
[...]
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 671d344..e3c93f8 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -41,9 +41,11 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
>  suffix_$(CONFIG_KERNEL_GZIP)  = gz
>  suffix_$(CONFIG_KERNEL_BZIP2) = bz2
>  suffix_$(CONFIG_KERNEL_LZMA)  = lzma
> +suffix_$(CONFIG_KERNEL_LZO)  = lzo
>  tool_$(CONFIG_KERNEL_GZIP)    = gzip
>  tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
>  tool_$(CONFIG_KERNEL_LZMA)    = lzma
> +tool_$(CONFIG_KERNEL_LZO)    = lzo
>   

   You should align "lzo" with the rest of the suffixes/tool names.

WBR, Sergei
