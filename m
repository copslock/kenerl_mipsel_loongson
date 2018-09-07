Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 12:33:34 +0200 (CEST)
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58643 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994649AbeIGKdZph106 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Sep 2018 12:33:25 +0200
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w87AWlb9018164;
        Fri, 7 Sep 2018 19:32:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w87AWlb9018164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536316368;
        bh=pJCv2283OBzHmxus/1+hSNzyq8ZyWd6ml6XFVuZWUYM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sfe2YE4ThYFGu9LJio64fEpbE9DERir1mv/+uUHFsLRO8QnNIPMyGCLc31/DKLXei
         OY7B6QMSJ3jacMZEDyIRnfyonmDoK5uXULCgRW/g76rQmuknyxBSYINJJ8VhuHnDRZ
         HCbZ7243HOLNchBJdolwgwiEN1/WnaSR6tva5L65mTOyS4kKg+KIX7jxzhSv5hPXdl
         S+xhHReWH+pHtIlOkFBLHrVttV6cuOH9EXoltLBOCe2U2xPfwkopDVwLKfHxucxO1t
         /Y4LptNfPAH7aqYofOL4aCb7W8133npcsNtyxI2WilGUNKTqEeWy5UlGo8t7hAD0ZJ
         CUdl2NwSXAFQQ==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id q7-v6so11515517uam.12;
        Fri, 07 Sep 2018 03:32:47 -0700 (PDT)
X-Gm-Message-State: APzg51A7R16Nlnru2EhTeuY/0HiuXcaSJS1EHG60hxg5hyFsdG04SADm
        KwhIwroXcIizUZFdHHvKyOWfpXIDcPND18UFurI=
X-Google-Smtp-Source: ANB0VdYaEnFs6/3bspLuGeaX6nRAUQylfwqUV/SJkYf2hLqlwEd626MZEDqI8CXyANhN8VfOK40L8HK7dPQn1bOQkkg=
X-Received: by 2002:a67:4441:: with SMTP id r62-v6mr2584846vsa.38.1536316366545;
 Fri, 07 Sep 2018 03:32:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 03:32:06 -0700 (PDT)
In-Reply-To: <20180905235327.5996-7-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org> <20180905235327.5996-7-robh@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 7 Sep 2018 19:32:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARD+_kV=XtJ66mZBU-CPMQgWF+oQtv4bGKaGGARNwzXiQ@mail.gmail.com>
Message-ID: <CAK7LNARD+_kV=XtJ66mZBU-CPMQgWF+oQtv4bGKaGGARNwzXiQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66140
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

2018-09-06 8:53 GMT+09:00 Rob Herring <robh@kernel.org>:
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
>
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
>
> This change enables support 'dtbs_install' on some arches which were
> missing the target.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-mips@linux-mips.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack so I can take the whole series via the DT tree.
>
> v2:
>  - Fix $arch/boot/dts path check for out of tree builds
>  - Fix dtc dependency for building built-in dtbs
>  - Fix microblaze built-in dtb building


This breaks parallel building
because two threads could descend into scripts/dtc
at the same time.

'all' depends on both 'scripts' and 'dtc'.

* 'scripts' target -- descends into scripts/, then scripts/dtc
* 'dtc' target     -- descents into scripts/dtc directly





-- 
Best Regards
Masahiro Yamada
