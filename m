Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 09:12:19 +0200 (CEST)
Received: from mail-it0-f65.google.com ([209.85.214.65]:35045 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041686AbcFBHMQv87f0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 09:12:16 +0200
Received: by mail-it0-f65.google.com with SMTP id z123so1721413itg.2;
        Thu, 02 Jun 2016 00:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=YxycRMpteEAxbeZoMTHg2DDtT1+pOhZQtCU6Syxguk4=;
        b=S/q4qVS3WGlSuZVnSxu8OaEOqm4jxZ4Zv9hmePTZTuRRAwUPxA0i8+qFzSlNrTWEDK
         PwIMdb4j1Xi4eriNW34CDwXrv80AXH1oD5zOegv4iElpYxrup2ej43s6mfc+yh/w3j0U
         v6RNa3n+TT3SDbWZrbhs5RP3NTkIHRkcUrtUbt3LIwuiUFlQDOmKbnZTyS85mdMsszZe
         IqNCQe9BGRT7dNAa+2uZUEc2aOelO33diIfYiB7jYhliGC7Idob2z4eHycPUI9Aj1Vfu
         5xkciOTuW8Y2BikSQL7p2LBwx0o9LP5Duwc8nfzLzfwwCXp8YteQdZU8yUXl/cCyH0aO
         OK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YxycRMpteEAxbeZoMTHg2DDtT1+pOhZQtCU6Syxguk4=;
        b=CzgJ1ww8PmQsSJXUBnShdzrKTaAi93IJ/h3rrVcpls530+DHtBuyCGM8DA/ciQaFLk
         J88c02DIq4iZIPLiRLoWquZkb7b8DgIo+inAv/UKgc75ihbUpsLyk++yvVrmiSGl170t
         KC/KYOJnthCn2tPc0oupdvE49HOD3f2w6GS/oHkK76xmhzCymxCbzTfkIE8H6ZOhryoW
         anTan1uvzxs+i0CZi5F+6nTIwLnXhP9QDyzZJEqafkXUWdNPuOYRpym3TQgdMdx6ixF4
         hzebI13gAUGbaXRTtU0iSSkpIF3jbuEp/ubP9TI+XyPCfE2VY2BdVrM+g0wv808+dYXs
         CKTQ==
X-Gm-Message-State: ALyK8tIQu52e8xO0uJyTF4Q6izML2ERm4ST/hDQah4z4pRQKS1GFQ7eomNmez8Y0UxiXGL/zH14pyQRsD3W53g==
MIME-Version: 1.0
X-Received: by 10.36.110.214 with SMTP id w205mr1967420itc.47.1464851530936;
 Thu, 02 Jun 2016 00:12:10 -0700 (PDT)
Received: by 10.36.94.70 with HTTP; Thu, 2 Jun 2016 00:12:10 -0700 (PDT)
In-Reply-To: <20160601211120.GA16149@linux-mips.org>
References: <20160601211120.GA16149@linux-mips.org>
Date:   Thu, 2 Jun 2016 15:12:10 +0800
X-Google-Sender-Auth: 0cnfO1AMsL0dMv0-Kn26lvaMtlw
Message-ID: <CAAhV-H7-d-rs1h0M+BoGvHYy_zOXJ_48FD4SJcoqB=LKex4e-A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Longson 3: Fix fast refill handler for 32 bit kernels
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Ralf,

Your change is correct, but I suggest modify
read_c0_pgd()/write_c0_pgd() as well.

Huacai

On Thu, Jun 2, 2016 at 5:11 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> A recent merge has broken the LLVMLinux build for 32-bit little endian. I've
> bisected it to 380cd58 and it looks like a bug in the kernel to me. Clang is
> rejecting the inline assembly in the expansion of 'write_c0_kpgd
> (swapper_pg_dir)' of tlbex.c. The relevant inline assembly can be found in
> __write_64bit_c0_split() and is attempting to use the 'L' and 'M' print
> modifiers on swapper_pg_dir which is a 32-bit unsigned long. These print
> modifiers only make sense for 64-bit values so I think the kernel source is
> incorrect.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Reported-by: Daniel Sanders <Daniel.Sanders@imgtec.com>
> Cc: Huacai Chen <chenhc@lemote.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Fuxin Zhang <zhangfx@lemote.com>
> Cc: Zhangjin Wu <wuzhangjin@gmail.com>
> ---
> I don't have Loongson 3 hardware for testing, could somebody of the Loongson
> folks please review / test this?  Thanks!
>
>  arch/mips/include/asm/mipsregs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index e1ca65c..044fab6 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -1652,8 +1652,8 @@ do {                                                                      \
>  #define read_c0_pgd()          __read_64bit_c0_register($9, 7)
>  #define write_c0_pgd(val)      __write_64bit_c0_register($9, 7, val)
>
> -#define read_c0_kpgd()         __read_64bit_c0_register($31, 7)
> -#define write_c0_kpgd(val)     __write_64bit_c0_register($31, 7, val)
> +#define read_c0_kpgd()         __read_ulong_c0_register($31, 7)
> +#define write_c0_kpgd(val)     __write_ulong_c0_register($31, 7, val)
>
>  /* Cavium OCTEON (cnMIPS) */
>  #define read_c0_cvmcount()     __read_ulong_c0_register($9, 6)
>
