Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 17:59:15 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:40978
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeC1P7IcAN2X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 17:59:08 +0200
Received: by mail-io0-x243.google.com with SMTP id m83so4116029ioi.8
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2018 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qSDkcmbz+hhYmqe2ncZumACqLvxx9LwbFbBwrEiskLE=;
        b=RL0IGzUYK4VjO7BnzVR5zspETrUV5hikhNkV3/TKuuKQyc2NSeMP36w4nxksvwU4vG
         JvhH12V4osNL1UeOKGC15RdMh84F9BLhlg5KUJA91Moq9/8PdJr3OhjXk3H9HLyySi5P
         menS/9ctrNhaCPpppZtfo21xN8+L1nHITmDfqpAJAL3rVG73vsXN2Bkh049J+9jwaorz
         iQ4V2qdJtNZneAQ65nQU3FH1FQwNG+i3yAVVYJCxOzF9MULIf0FBEw6Nt8gwfsgQEOCG
         ZdagY+hnlhACFDWyppY2FityvSWLvJ6gt/2g4XEFvN/m4kmjlj0FUFMjeSbgJXhoekd0
         m+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qSDkcmbz+hhYmqe2ncZumACqLvxx9LwbFbBwrEiskLE=;
        b=PlZfBmU9FBRzmqLE7HyWeIbyWkOVgtwAto9CRElxmbRUMVq/V/C5+2LmDfwSRJ3TCS
         c8UaDd1/BTPkeVRAX5AWubyBal7X2M3cod6XixjK7ccv12sQTDrAgS0TMoNX2aXLbKbP
         w0j84K9mJIWE0TS+Xk9Ip1COUm/dbXwgfpryjW3WbSR7Lwhc5Ufc5qe8KsGwJoljseCR
         0bc9LzQlMbDmOyM9SLFMUqlaqC1w5e7Wo7wFIqlYuzCnOT9ea39EUghuuuEbQqUij/v1
         ar/pr/lYDUtM9ZqpY7xVRC+8vaD2fPCNbyZyCqCQU1HXc8JVhHEbVJ3wgED3U1G9dFZW
         jorA==
X-Gm-Message-State: AElRT7Eyn9RSaa+7iTUQQLKfhk9AGYFeRUoM0llWCBYmGsDD1qQSukkr
        8RESuCJu8osFnwdcLx9s5VFeDw==
X-Google-Smtp-Source: AG47ELss7e9gTw/EW5uReqslv5gSdy/QsSqOI9SxFyO+YGUYNMIXTL22ku6bXZmM+LXFQUNNTCNiQQ==
X-Received: by 10.107.10.219 with SMTP id 88mr51174837iok.259.1522252742117;
        Wed, 28 Mar 2018 08:59:02 -0700 (PDT)
Received: from [192.168.42.97] ([172.58.139.228])
        by smtp.googlemail.com with ESMTPSA id i20sm2805718iod.36.2018.03.28.08.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 08:59:01 -0700 (PDT)
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To:     Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
Date:   Wed, 28 Mar 2018 10:58:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 03/28/2018 10:26 AM, Shea Levy wrote:
> Now only those architectures that have custom initrd free requirements
> need to define free_initrd_mem.
...
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>  {
>  	free_initmem_default(-1);
>  }
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3f972e83909b..19d1c5594e2d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -47,6 +47,7 @@ config ARM
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> +	select HAVE_ARCH_FREE_INITRD_MEM
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU

Isn't this why weak symbols were invented?

Confused,

Rob
