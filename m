Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 20:27:56 +0100 (CET)
Received: from mail-qt0-x22b.google.com ([IPv6:2607:f8b0:400d:c0d::22b]:42052
        "EHLO mail-qt0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990482AbdK1T1tvqj7S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 20:27:49 +0100
Received: by mail-qt0-x22b.google.com with SMTP id g9so1306465qth.9
        for <linux-mips@linux-mips.org>; Tue, 28 Nov 2017 11:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Y+UoMGwgmM7GL1NN2LOgYEPE7uLsEdBykzTmE5b8jOk=;
        b=hkcPJaeJCMkikSDHU1K6DlMfWJcNXcXV93cTdiHJUQYGqi9h0Xgm/9XFR7fc6GNipP
         hkWqoJXU65nWtLYmJaxf63nWFcyCt2nINxBAsQuHHvfpj81IN/q9LGP++N8MiEsKvhbu
         +vxSzgJsaPrzVXo6Alu9Q9dillULZWFHTxEAmKl/jl9A4YjcxRp/1QM3G1t33JIYkRv6
         akcf61ktdEm5kUoBNAVv8DKO6bAnyhLLkVxyD+7ZnvjsUce2x4TGzz2fDAblBSGMSUHk
         LCgySzkKk2tJVxm0Nu/JmctWmqn4kGFhF0pKBwwfvKJIFO14Iy0gLRW4ISjap7pQWkSO
         9bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Y+UoMGwgmM7GL1NN2LOgYEPE7uLsEdBykzTmE5b8jOk=;
        b=EvvCPnmjB1DgxWFzX8YnlQVY2CDAHHEYxGWVCkufqBPByDjDj9E8dE4KNN/ULOP5OZ
         O3ezC2wbYyhJChQEy9LKS8bcNaIEg9xu2kVVWiWbWSfxr9O714hI2fErEOrP5W8laOi3
         gLibev2uZQPx/X4KH+OqxifPxVTZ87RNR2SDxEXOAXbfheE8y3BWm0UCalcPyDGRTW1h
         Pd0jfHBpIuKXdidtEhvb5etdFwpb6TtGKAuaM5x9Sp7K0SJy/mtWtVyA2U1I9aiFug5D
         0lJ6JADMi5fw4OZFx0BOtgY8x/qIbQxJydrHqJWnTQaKJeovhF50iK97Ul2jgmZwyqdR
         HvfQ==
X-Gm-Message-State: AJaThX5xTWo5pOsEvRRmaFUEt87O2OcIRR8uQYpYHaHhxPXcDWwa+1qF
        7QOIVTdKGo4uhdx4h14rZ3HJ4/7whbrDCDNQ7GU=
X-Google-Smtp-Source: AGs4zMYd9pITlnLkpCRXrbSHyOoGELny1mI0W+hQUCYcXpuba4pz+3//nZpNBl6NTguyeVN4tbvNNmhbnbXWI8nfzhM=
X-Received: by 10.200.3.65 with SMTP id w1mr402544qtg.297.1511897263663; Tue,
 28 Nov 2017 11:27:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.44.66 with HTTP; Tue, 28 Nov 2017 11:27:43 -0800 (PST)
In-Reply-To: <CAKwvOdmcthyd1KbxRr54QztBcmeZ7JA=M_7N1xfmVurVOG=77w@mail.gmail.com>
References: <CAK7LNAS1NaqPRhK6FOXN=YTMhLagpSrR2=tXn-uWZbpzr=NeoQ@mail.gmail.com>
 <20171115204231.34914-1-ndesaulniers@google.com> <CAK7LNAQNEHRapzFem3nr7=EWJPYvZby9K7vem-R99ijYNoguEg@mail.gmail.com>
 <CAK7LNASGYZfQFkM3yMRQaHLUwW5Lhp8CxHGX0bJ9sVja0f=n+A@mail.gmail.com> <CAKwvOdmcthyd1KbxRr54QztBcmeZ7JA=M_7N1xfmVurVOG=77w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Nov 2017 20:27:43 +0100
X-Google-Sender-Auth: ZI-j_13_ropaY8NGC2kZ4c0gfUg
Message-ID: <CAMuHMdVcs6zYtP=TN6BwH-CPDnJ3PhZ789c0Zd-89BgO+VNHZA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Set KBUILD_CFLAGS before incl. arch Makefile
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Michal Marek <mmarek@suse.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
        Chris Fries <cfries@google.com>,
        Mark Charlebois <charlebm@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Tue, Nov 28, 2017 at 7:18 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Thanks for merging Chris' patch, and sorry for taking so long to respond.
>
> On Wed, Nov 22, 2017 at 8:24 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Linus suggests to move compiler flag testing to Kconfig.
>
> Do you have an LKML link for context?
>
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

And inside "ifneq ($(SUBARCH),$(ARCH))", so the prefix is not used for
native compilation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
