Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 03:41:23 +0100 (CET)
Received: from conssluserg-03.nifty.com ([210.131.2.82]:46212 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbdK2ClQPQIM0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 03:41:16 +0100
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com [209.85.217.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id vAT2ee39005182
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 11:40:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com vAT2ee39005182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1511923241;
        bh=qAjoTno41Dv9LDZ35E1XDC7sx8mTryifl2lBor+TlKg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=0LaB+DfjhOPQSnS8GutagD4qHZZLAY4TN31zLSZ5Zcdi7xGoK+LMlGLi3NAdczWqV
         8smGVqh5vyacgYDmdwQvBiWhbkhQUDVnxVkJZAdLZc5X92LmK9KRCHs5Mk2wsexk+9
         nZcYu4naMv9XTpjsVxgJZ4i2bCrFRSYydgEXuhUWfaLXEYqZJljnZ+8QmlM+jcOSTK
         btDYrTv1POOD75Tyjdn+cIcrE/F6PZbBkpIvSfp5jzHzRMBfoSbCPhUe/ELszqjgwD
         iQM9PaEEYWgGg78qbq5ECTUh1f8g1jtOTNByxWQUFztYJme4EBn+eT+wMIQAdymFA4
         f2ufifetpnR1Q==
X-Nifty-SrcIP: [209.85.217.180]
Received: by mail-ua0-f180.google.com with SMTP id p33so2436183uag.9
        for <linux-mips@linux-mips.org>; Tue, 28 Nov 2017 18:40:41 -0800 (PST)
X-Gm-Message-State: AJaThX60szl0MpAqFJW9a+8bNYM5y1CeWNatYNdodkCwp/NIIOgeJ/PF
        V3mPVPxt7hx+AZkOtjCdTVz5vqMpKH2ACzrnRzs=
X-Google-Smtp-Source: AGs4zMYzK4TCYhdY5iuHARBqL9JVqnXAF1IF0Ki8KGcne5Ymz0R6JGJ1MgnHzDeHJy1GlXzHGWK0OlMOJvuwrAGE9U8=
X-Received: by 10.176.67.228 with SMTP id l91mr1133498ual.181.1511923240042;
 Tue, 28 Nov 2017 18:40:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.47.19 with HTTP; Tue, 28 Nov 2017 18:39:59 -0800 (PST)
In-Reply-To: <CAKwvOdmcthyd1KbxRr54QztBcmeZ7JA=M_7N1xfmVurVOG=77w@mail.gmail.com>
References: <CAK7LNAS1NaqPRhK6FOXN=YTMhLagpSrR2=tXn-uWZbpzr=NeoQ@mail.gmail.com>
 <20171115204231.34914-1-ndesaulniers@google.com> <CAK7LNAQNEHRapzFem3nr7=EWJPYvZby9K7vem-R99ijYNoguEg@mail.gmail.com>
 <CAK7LNASGYZfQFkM3yMRQaHLUwW5Lhp8CxHGX0bJ9sVja0f=n+A@mail.gmail.com> <CAKwvOdmcthyd1KbxRr54QztBcmeZ7JA=M_7N1xfmVurVOG=77w@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 29 Nov 2017 11:39:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATx=3k3o+hEpa2k3f67MfsEnWAyWsBSkKmPYQTUK9RYmg@mail.gmail.com>
Message-ID: <CAK7LNATx=3k3o+hEpa2k3f67MfsEnWAyWsBSkKmPYQTUK9RYmg@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Set KBUILD_CFLAGS before incl. arch Makefile
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Behan Webster <behanw@converseincode.com>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Chris Fries <cfries@google.com>,
        Michal Marek <mmarek@suse.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61180
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

Hi Nick,

2017-11-29 3:18 GMT+09:00 Nick Desaulniers <ndesaulniers@google.com>:
> Hi Masahiro,
>
> Thanks for merging Chris' patch, and sorry for taking so long to respond.
>
> On Wed, Nov 22, 2017 at 8:24 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Linus suggests to move compiler flag testing to Kconfig.
>
> Do you have an LKML link for context?


https://lkml.org/lkml/2017/11/19/291



> On Wed, Nov 15, 2017 at 6:32 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> BTW, I notice another issue.
>>
>> If we move clang settings before including arch Makefile,
>> "ifneq ($(CROSS_COMPILE),)" comes early.
>>
>> Some arch Makefiles (arch/mips/Makefile, arch/blackfin/Makefile, etc.)
>> set CROSS_COMPILE there if CROSS_COMPILE is not given.
>>
>> Then, we have a conflict between two requirements among arch.
>>
>> [1] arm64, powerpc use ld-option in their Makefile.
>>     So, clang flags must be set before inc. arch Makefile.
>> [2] mips, blackfin, etc. may set CROSS_COMPILE in their Makefile.
>>     So, we want to reference CROSS_COMPILE only after inc. arch Makefile
>>
>> I have no idea how to solve it.
>>
>> At this moment, I guess clang is intended to support
>> only limited architectures.
>>
>> It might be OK to be compromised here.
>
> I definitely find it curious that certain arch's define CROSS_COMPILE
> themselves.  The benefit is one less argument to supply at compile
> time, but it assumes that the toolchain always has a certain prefix.
> This makes sense to me when cross compiling, but seems odd when
> compiling natively on that arch as the host and target.  Maybe those
> arch's use that convention, or simply are always cross compiled for?
>
> Taking a survey of all arch's currently in the kernel via `cd arch; ag
> CROSS_COMPILE` and quickly eyeballing the result:
>
> m68k if not set
> arc if not set
> openrisc for some configs (openrisc/configs/or1ksim_defconfig,
> openrisc/configs/simple_smp_defconfig)
> blackfin if not set
> hexagon for some configs (hexagon/configs/comet_defconfig)
> parisc if not set
> sh if not set
> xtensa if not set
> score always
> arm for some configs (arm/configs/lpc18xx_defconfig)
> h8300 if not set
> mips if not set (and explicitly emptied for some configs,
> mips/configs/nlm_xlr_defconfig )
> unicore32 if not set
> tile if not set
>
> The * if not set (or not being on the list) seems correct, as the top
> level Makefile will handle this correctly.  Setting it for some
> configs seems curious (not necessarily wrong?),

Perhaps, the maintainer of those platforms may want to save
one command-line argument at compile time.

> emptying it/always
> setting it via config sounds wrong to me,

arch/mips/configs/nlm_xlr_defconfig explicitly empties it.
It is just redundant because CONFIG_CROSS_COMPILE=""
is the default in Kconfig.
Not necessarily wrong, I think.


> but maybe those hosts don't
> have toolchains and must always be cross compiled for?
>
> For reference, this file in LLVM source defines the supported backend
> targets: https://llvm.org/doxygen/Triple_8h_source.html
>
> Either way, it sounds like we're all set here, I guess I'm just
> curious about the LKML link/context and why some configs set
> CROSS_COMPILE themselves?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
