Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2018 03:02:16 +0200 (CEST)
Received: from conssluserg-01.nifty.com ([210.131.2.80]:20331 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeILBCMWWrgB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2018 03:02:12 +0200
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8C11UNj032351;
        Wed, 12 Sep 2018 10:01:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8C11UNj032351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536714091;
        bh=QeR2jC6phsbZ9/XJLedlSyKoqInOa+fbx6qHHIKcQD0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VHfkPfSecVyxBrIPgN/YXgFKPn8I2TmleTc5K6JmUzCPuliH0Roc3dLuVTP8IgU9W
         T0YzueTLISyNzjNBlSutW2N2yBoqocXMMmql+xMamb6xzHdSt2HGMMv4OLOvh3JAtW
         AylL3+ctGVtU3xr3ZwhnD9u7NqPUIw7JWVeR7tHin2hQxvxi4Af44SyeiO9EvdxRuX
         81Z76OnCOEuYB+3bIKzFbEDF4ZIqo6uZxzTzW9QBLWoHBaZsnFp48wOSKmVv/pRBNp
         oTX1SLk/jV6EAVHcl45NE7ffeE0aTcZDuik7wLkaEtXoExPm7N6X1/Ij75tDTmL3u1
         D7nnEosa5toiA==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id u11-v6so178475uan.13;
        Tue, 11 Sep 2018 18:01:31 -0700 (PDT)
X-Gm-Message-State: APzg51BBmIcvXO4/+ZS9MVrJodEX1CyqHBBp/YmZh2FrQaOLWUwSrvSW
        U9hugNXpK7KpSju7WX4s+IcLBH8l3WLvEixI2EQ=
X-Google-Smtp-Source: ANB0VdZED+0Yg6z4iR9GdtGePE1mGIlRUNsQvEcDjpbMSkmZhswenYcTWSoxlNKvnuu30n/JnaUWpGCeBbjenmeGLCY=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr10050495uah.135.1536714090023;
 Tue, 11 Sep 2018 18:01:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 18:00:49
 -0700 (PDT)
In-Reply-To: <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Sep 2018 10:00:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
Message-ID: <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66213
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

2018-09-12 0:40 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
>>
>> There is nothing arch specific about building dtb files other than their
>> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
>> The dependencies and supported targets are all slightly different.
>> Also, a cross-compiler for each arch is needed, but really the host
>> compiler preprocessor is perfectly fine for building dtbs. Move the
>> build rules to a common location and remove the arch specific ones. This
>> is done in a single step to avoid warnings about overriding rules.
>>
>> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
>> These pull in several dependencies some of which need a target compiler
>> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
>> All that is really needed is dtc, so adjust the dependencies to only be
>> dtc.
>>
>> This change enables support 'dtbs_install' on some arches which were
>> missing the target.
>
> [...]
>
>> @@ -1215,6 +1215,33 @@ kselftest-merge:
>>                 $(srctree)/tools/testing/selftests/*/config
>>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>>
>> +# ---------------------------------------------------------------------------
>> +# Devicetree files
>> +
>> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
>> +dtstree := arch/$(SRCARCH)/boot/dts
>> +endif
>> +
>> +ifdef CONFIG_OF_EARLY_FLATTREE
>
> This can be true when dtstree is unset. So this line should be this
> instead to fix the 0-day reported error:
>
> ifneq ($(dtstree),)
>
>> +
>> +%.dtb : scripts_dtc
>> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>> +
>> +PHONY += dtbs dtbs_install
>> +dtbs: scripts_dtc
>> +       $(Q)$(MAKE) $(build)=$(dtstree)
>> +
>> +dtbs_install: dtbs
>> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
>> +
>> +all: dtbs
>> +
>> +endif


Ah, right.
Even x86 can enable OF and OF_UNITTEST.



Another solution might be,
guard it by 'depends on ARCH_SUPPORTS_OF'.



This is actually what ACPI does.

menuconfig ACPI
        bool "ACPI (Advanced Configuration and Power Interface) Support"
        depends on ARCH_SUPPORTS_ACPI
         ...





-- 
Best Regards
Masahiro Yamada
