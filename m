Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2014 03:20:43 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38936 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822677AbaFBBUjg89cK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Jun 2014 03:20:39 +0200
Received: by mail-ig0-f171.google.com with SMTP id c1so2797664igq.10
        for <linux-mips@linux-mips.org>; Sun, 01 Jun 2014 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=1SyNvKMJ1KWXSH21HxzdreLdauWQGXxAxagAGXplVW0=;
        b=xleVfkVoDKtUT59W6NYDa3JEILgD5PNgcN3a9GYA66QBJR1ChIaWH5JrMOYTtdpBQU
         cRq4ncJjSP8tJu3xU54l7Olb2hS1dYclSYoqYKIAm/EsYOKd1EWdM/F5vGPmc/O6jbOq
         0BfK9zipI0qdnoALVQ26huSdnFDwnH4BNzxiaQhKC8VJmHmeVGs1YZlUfgna1/vy8eQS
         7urYMl6wtuC1KrInoNcQESDu2C/nXKSRPNG8ceRwPePyEsj9qBbd3MFwxBnPUQEcUkTK
         y4qXsf0us/lxt7uyhjjE7pEPJvGoaNSGOrxbo2YvXpzDvOXEszZAvMGnJalaokzIigI3
         JZDA==
MIME-Version: 1.0
X-Received: by 10.50.119.129 with SMTP id ku1mr13932817igb.6.1401672033380;
 Sun, 01 Jun 2014 18:20:33 -0700 (PDT)
Received: by 10.64.137.71 with HTTP; Sun, 1 Jun 2014 18:20:33 -0700 (PDT)
In-Reply-To: <or61klqft0.fsf@free.home>
References: <tencent_03F1BF0862C094496B5D0360@qq.com>
        <or61klqft0.fsf@free.home>
Date:   Mon, 2 Jun 2014 09:20:33 +0800
X-Google-Sender-Auth: 7B8V0PA6vUDl5nzeKH-FEfKWibs
Message-ID: <CAAhV-H4r0-Ezv1-Z=WxMy=dyNNCRNUmT216KVGh_UCWW556F=A@mail.gmail.com>
Subject: Re: MIPS: Hibernate: Flush TLB entries in swsusp_arch_resume()
From:   Huacai Chen <chenhc@lemote.com>
To:     Alexandre Oliva <oliva@gnu.org>
Cc:     wuzhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40403
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

Hi,

Could you please let's have a look at your error log?

Huacai

On Sun, Jun 1, 2014 at 2:55 PM, Alexandre Oliva <oliva@gnu.org> wrote:
> Hi,
>
> Thanks for your response,
>
> On Jun  1, 2014, "陈华才" <chenhc@lemote.com> wrote:
>
>> The original code flush both TLB and cache, and I think the original author (Wu Zhangjin) has tested his code. In my patch I only restore the TLB flush, but not the cache flush. Since Loongson-3A maintain cache coherency by hardware, with or without cache flush will both OK. But for Loongson-2F, I guess cache flush is also needed, but I have no Yeelong-2F to test now.
>
> I'm afraid reintroducing the cache flush is not enough to bring the
> kernel back to a working state, hibernation wise.  The last oops message
> I saw, after the ones that flew by, had __arch_local_irq_restore at the
> top of the backtrace, called by some function with resume in its name.
>
> Any other suggestions?
>
>
> Here's the patch I tried on top of yours, as an alternative to reverting
> it, unfortunately without success:
>
> --- arch/mips/power/hibernate.S
> +++ arch/mips/power/hibernate.S
> @@ -43,6 +43,9 @@
>         bne t1, t3, 1b
>         PTR_L t0, PBE_NEXT(t0)
>         bnez t0, 0b
> +       /* flush caches to make sure context is in memory */
> +       PTR_L t0, __flush_cache_all
> +       jalr t0
>         jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
>         PTR_LA t0, saved_regs
>         PTR_L ra, PT_R31(t0)
>
>
> --
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
>
