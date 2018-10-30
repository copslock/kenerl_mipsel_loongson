Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 13:42:03 +0100 (CET)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:35948 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994198AbeJ3Ml448oQN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 13:41:56 +0100
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9UCf5Of018439;
        Tue, 30 Oct 2018 21:41:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9UCf5Of018439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540903265;
        bh=YairTKVKKa5Ofh3V0oC7nmntUB8w6vB+j3hvWIgrl34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yco7XL5+ps/5fu/LX2WJd/Vn6jCLrxfwZ99nRQvtiPwwqI1o/vCo73M6GdEEQB1D8
         O4xGcupg+I3OEEjPRl1grXpeKWqs5T+ooBWATik/2MCT2W/BV1USIbkd9biuLewaDH
         LrGwfvX4cPKqhts35oFByAXEShqP3QdiHqDtLoQpaMa2T/u9s3p5pU8nD4eCAOxgdx
         1aBt4Gx/yzFFKHcTIuf3yb0ZR8UFqT6WXNJMs8tH4XQ0tzeBvLQbhv6lYXqdBl3l4D
         cXcTBhf5KD/aR+tWFm6b/BlArTNHVN1RZEG47FjDsveG4a+AqhEw1bVR0f+okZW7Yl
         aVpyjtsMS8DjQ==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id m199-v6so2941383vke.9;
        Tue, 30 Oct 2018 05:41:05 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJuyn5a78rPb8dr8VLm0Tioqp22RQG2w7SU+BWkvymQnh4kKAuT
        vDRR39P/Ou0htsNCMwvLy6Yi36Z9ObMe4KiycPk=
X-Google-Smtp-Source: AJdET5eEUF99L4FtC2VlzofrvfFd1ZV/6/+V52Td1Afdq8arw8wITWqX1xauzd2VFT59Ji2hh1utOYimeSPgwecHJyM=
X-Received: by 2002:a1f:c08e:: with SMTP id q136mr7771310vkf.84.1540903264092;
 Tue, 30 Oct 2018 05:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com> <877ehzk3we.fsf@concordia.ellerman.id.au>
In-Reply-To: <877ehzk3we.fsf@concordia.ellerman.id.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 30 Oct 2018 21:40:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrdToqTrffe5XD+_LuK9+0=Bv8L_7ZWeN6iSivYe8Gmg@mail.gmail.com>
Message-ID: <CAK7LNASrdToqTrffe5XD+_LuK9+0=Bv8L_7ZWeN6iSivYe8Gmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

On Tue, Oct 30, 2018 at 9:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 17be664..338e827 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)             += $(call cc-option,-mabi=elfv1)
> >  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)   += -mabi=elfv2
> >  endif
> >
> > -ifneq ($(cc-name),clang)
> > +ifneq ($(CONFIG_CC_IS_CLANG),y)
> >    cflags-$(CONFIG_CPU_LITTLE_ENDIAN) += -mno-strict-align
> >  endif
> >
> > @@ -175,7 +175,7 @@ endif
> >  # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
> >  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
> >  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
> > -ifneq ($(cc-name),clang)
> > +ifneq ($(CONFIG_CC_IS_CLANG),y)
> >  CC_FLAGS_FTRACE      += $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
> >  endif
> >  endif
>
> Does this behave like other CONFIG variables, ie. it will not be defined
> when it's false?

Right.


> And if so can't we use ifdef/ifndef? eg:
>
> ifndef CONFIG_CC_IS_CLANG
>   CC_FLAGS_FTRACE       += $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
>
> That reads cleaner to me.


OK, will do respin if you prefer ifdef/ifndef style.




> Still this patch is fine as is:
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> cheers



-- 
Best Regards
Masahiro Yamada
