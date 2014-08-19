Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2014 01:22:08 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36311 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855322AbaHSXWBjCvkT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Aug 2014 01:22:01 +0200
Received: by mail-ig0-f182.google.com with SMTP id c1so10421549igq.15
        for <multiple recipients>; Tue, 19 Aug 2014 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Iv9ygOgYIGH7UibDk5wMEfFQkkkv5XG5RfoUvpiZYds=;
        b=j+iZA4bDhrDjZHj0IZ1pzjrVveA+IoCZOApOZwvOXWVMRtss+6/dVDxUZY7czMBgfd
         dvXlEWHgYryo5VYH5VQag7ZXHaiuKiXYvI7g2afqnmCmwuoHENeLHECpC+LKi2OK6uA3
         YpYnx6PvdsSxFYujC9lmoZDnzoVaEU6K1rSx0RgnPOGLzKkn4/mVk5cIskfkXbEA4OIh
         BKutdMPsp41WvgEZgShAHeFMZPeG3Ou7S5G+8xypxfiQTcIlepNMFiHsxQe1DWruImBc
         WlYNAP2XMHQUX/p1zpKxmmvuLwTAMNg/5f0NxGsjXUyc0inmUTYvvF2XKHg59NWEQM6z
         0iyA==
X-Received: by 10.43.158.201 with SMTP id lv9mr14495681icc.58.1408490515235;
        Tue, 19 Aug 2014 16:21:55 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id yt6sm3549660igb.10.2014.08.19.16.21.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 Aug 2014 16:21:54 -0700 (PDT)
Message-ID: <53F3DC11.1080208@gmail.com>
Date:   Tue, 19 Aug 2014 16:21:53 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     chenj <chenj@lemote.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
CC:     chenhc@lemote.com
Subject: Re: [v2] mips: use wsbh/dsbh/dshd on Loongson 3A
References: <CAGXxSxXGpRBJm+8sYfYXN4-20OYdmJ4FgBDnPknv9uMBN9zBsQ@mail.gmail.com> <1408093018-25436-1-git-send-email-chenj@lemote.com>
In-Reply-To: <1408093018-25436-1-git-send-email-chenj@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 08/15/2014 01:56 AM, chenj wrote:
> Signed-off-by: chenj <chenj@lemote.com>
> ---
> This patch is modified from http://patchwork.linux-mips.org/patch/7054/
> The original author is ralf.
>
> v2: using "#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)"
> instead of "#if cpu_has_wsbh" in csum_partial.S
>
>   arch/mips/include/asm/cpu-features.h                       | 10 ++++++++++
>   .../include/asm/mach-cavium-octeon/cpu-feature-overrides.h |  1 +
>   .../mips/include/asm/mach-loongson/cpu-feature-overrides.h |  2 ++
>   arch/mips/include/uapi/asm/swab.h                          | 14 ++++++++++++--
>   arch/mips/lib/csum_partial.S                               | 10 ++++++++--
>   arch/mips/net/bpf_jit.c                                    |  2 +-
>   6 files changed, 34 insertions(+), 5 deletions(-)
>
[...]
> diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
> index ac9a8f9..20b884a 100644
> --- a/arch/mips/include/uapi/asm/swab.h
> +++ b/arch/mips/include/uapi/asm/swab.h
[...]
> @@ -46,8 +53,11 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>   static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
>   {
>   	__asm__(
> +	"	.set	push			\n"
> +	"	.set	arch=mips64r2		\n"
>   	"	dsbh	%0, %1\n"
>   	"	dshd	%0, %0"
> +	"	.set	pop			\n"
>   	: "=r" (x)
>   	: "r" (x));
>

This section of the patch is defective.  It appears to have not been 
compile tested.

On mips-for-linux-next commit d4c5edf76f14720a32805202129dfa8206560035 
produces:

.
.
.
   mips64-octeon-linux-gnu-gcc -Wp,-MD,kernel/bpf/.core.o.d  -nostdinc 
-isystem 
/nfs/sdk/daily/tools-140726/bin/../lib/gcc/mips64-octeon-linux-gnu/4.7.0/include 
-I./arch/mips/include -Iarch/mips/include/generated  -Iinclude 
-I./arch/mips/include/uapi -Iarch/mips/include/generated/uapi 
-I./include/uapi -Iinclude/generated/uapi -include 
./include/linux/kconfig.h -D__KERNEL__ 
-DVMLINUX_LOAD_ADDRESS=0xffffffff81100000 -DDATAOFFSET=0 -Wall -Wundef 
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
-Werror-implicit-function-declaration -Wno-format-security 
-mno-check-zero-division -mabi=64 -G 0 -mno-abicalls -fno-pic -pipe 
-msoft-float -ffreestanding -march=octeon -Wa,--trap -Wa,-mfix-cn63xxp1 
-I./arch/mips/include/asm/mach-cavium-octeon 
-I./arch/mips/include/asm/mach-generic -msym32 -DKBUILD_64BIT_SYM32 
-fno-delete-null-pointer-checks -O2 --param=allow-store-data-races=0 
-Wframe-larger-than=2048 -fno-stack-protector 
-Wno-unused-but-set-variable -fomit-frame-pointer 
-fno-var-tracking-assignments -g -Wdeclaration-after-statement 
-Wno-pointer-sign -fno-strict-overflow -fconserve-stack 
-Werror=implicit-int -Werror=strict-prototypes -DCC_HAVE_ASM_GOTO 
-D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(core)" 
-D"KBUILD_MODNAME=KBUILD_STR(core)" -c -o kernel/bpf/core.o 
kernel/bpf/core.c
{standard input}: Assembler messages:
{standard input}:3016: Error: Illegal operands `dshd $3,$3 .set pop'
.
.
.


Each line except the final line needs to be terminated with a '\n', but 
you did not do this following the "dshd" line.

David Daney
