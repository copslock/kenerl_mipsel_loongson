Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 03:33:26 +0200 (CEST)
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26280 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeEaBdTNtdHA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2018 03:33:19 +0200
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com [209.85.213.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w4V1WU7p024687;
        Thu, 31 May 2018 10:32:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4V1WU7p024687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1527730352;
        bh=umFZwwKoVrClAkiEXAXVy8YYb3HJpBcwey/N9CUPxSs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VAvKJ+MTvOdzLeE09T1Gf56SjhnENe8U4JYl/PgioOZZQ9CiKOeSChboAlqQ68QAL
         GeLZRh6WZkIrMS62MJQGNaiDJ3dHXCWma5rHPcc2yGLtvhov/EGLLIC7Mfk4Gb05Va
         MWn6iCaY6mMddRDSsu1j14qfAPXQgd7uMH5HbsTNMDAwewjN9udLsxBKUJXaCVftti
         1CRgJz7kIPQm8LMjtIzISgIb2xBQYVJHv77aYXvpoUg/zpqw0BUGeNM4LvX0hPPT94
         XfQPLTdFm/bc22bShI5ZqrupLngYIcSpvw48YhuGMM+R6TJlpeKnLd+4mSKhA3up6b
         e4So532AnPZGw==
X-Nifty-SrcIP: [209.85.213.44]
Received: by mail-vk0-f44.google.com with SMTP id g72-v6so12339487vke.2;
        Wed, 30 May 2018 18:32:31 -0700 (PDT)
X-Gm-Message-State: ALKqPwdxhTe66n+pbMzHopTAn9hdSgfVxmRixpOCaUWmpm2VGMTZumss
        EHoF/baYI+HZEw0PHR1+VcyQHAG03P+98w3HEks=
X-Google-Smtp-Source: ADUXVKLxNBy4CVF7u2XGFtJU2Bi+wuqtTkZfbCWGb3LKRWdLJ4ZvlGXoqV6VDqMCJj5hoKzRGwdKywgeyH/+nb5rVFo=
X-Received: by 2002:a1f:b143:: with SMTP id a64-v6mr2965349vkf.65.1527730350158;
 Wed, 30 May 2018 18:32:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 30 May 2018 18:31:49
 -0700 (PDT)
In-Reply-To: <CAMHZB6GXVPvr1uwbemuxqPPtNzYT7jeVokR6q9tz2mS_=TG6vA@mail.gmail.com>
References: <20180530204838.22079-1-luc.vanoostenryck@gmail.com>
 <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de> <CAMHZB6GXVPvr1uwbemuxqPPtNzYT7jeVokR6q9tz2mS_=TG6vA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 31 May 2018 10:31:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYP9T4pfuA32KrnP4-8_S+BPkvGBVyFgWXp_roXfQV7w@mail.gmail.com>
Message-ID: <CAK7LNARYP9T4pfuA32KrnP4-8_S+BPkvGBVyFgWXp_roXfQV7w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add machine size to CHEKCFLAGS
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64133
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

2018-05-31 8:06 GMT+09:00 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>:
> On Thu, May 31, 2018 at 12:00 AM, Andreas Färber <afaerber@suse.de> wrote:
>> Hi Luc,
>>
>> The typo in the subject made me curious...
>>
>> Am 30.05.2018 um 22:48 schrieb Luc Van Oostenryck:
>>> By default, sparse assumes a 64bit machine when compiled on x86-64
>>> and 32bit when compiled on anything else.
>>>
>>> This can of course create all sort of problems for the other archs, like
>>> issuing false warnings ('shift too big (32) for type unsigned long'), or
>>> worse, failing to emit legitimate warnings.
>>>
>>> Fix this by adding the -m32/-m64 flag, depending on CONFIG_64BIT,
>>> to CHECKFLAGS in the main Makefile (and so for all archs).
>>> Also, remove the now unneeded -m32/-m64 in arch specific Makefiles.
>>>
>>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>> ---
>>>  Makefile             | 3 +++
>>>  arch/alpha/Makefile  | 2 +-
>>>  arch/arm/Makefile    | 2 +-
>>>  arch/arm64/Makefile  | 2 +-
>>>  arch/ia64/Makefile   | 2 +-
>>>  arch/mips/Makefile   | 3 ---
>>>  arch/parisc/Makefile | 2 +-
>>>  arch/sparc/Makefile  | 2 +-
>>>  arch/x86/Makefile    | 2 +-
>>>  9 files changed, 10 insertions(+), 10 deletions(-)
>>
>> What about the architectures not touched by your patch that previously
>> had no -m32/-m64? (arc, c6x, h8300, hexagon, m68k, microblaze, nds32,
>> nios2, openrisc, powerpc, riscv, s390, sh, unicore32, xtensa)
>
> As explained in the patch, by default sparse uses -m64 if compiled on x86-64
> and 32bit on everything else (well, more recent versions use -m64 if
> compiled on any 64 bit machine). I think that most ppc devs use a ppc
> machine and so ppc was most probably fine (at least ppc64) but I suspect
> that most of these others archs either had never sparse used on them
> or had a lot of wrong warnings. IOW, it was maybe OK but most probably
> incorrect for them and now it is OK.
>
>> You forgot to CC them on this patch.
>
> I didn't thought/knew  it was needed and the CC list is already
> quite long but, if needed, no problem for me.
>
>> Have you really checked that all their toolchains support the -m32/-m64
>> flags you newly introduce for them? Apart from non-biarch architectures,
>> I'm thinking of 31-bit s390 as a corner case where !64 != 32.
>
> Hmm, there is no change to anything I call 'toolchain related', like
> compiler and linker. The only change is sparse (or any other checker)
> receiving now a correct and explicit -m32 or -m64.


Right.  We are talking about sparse.
Nobody needs to test vmlinux or whatever objects.

Except the typo in the subject (I can locally fix it up, though),
this patch looks good to me.






> For s390, as far as I know:
> 1) it has CONFIG_64BIT unconditionally definee (because the old 31bit
>    is no more supported, now everything is s390x only).
> 2) even if the *address space* was only 31 bit, I'm very sure
>    that sizeof(long) and sizeof(void*) was 4 on these machine
>    hence -m32 would have been correct.
>
> Best regards,
> -- Luc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
