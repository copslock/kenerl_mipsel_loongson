Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2018 01:35:31 +0200 (CEST)
Received: from conssluserg-04.nifty.com ([210.131.2.83]:42191 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994687AbeFTXfYnIwn5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2018 01:35:24 +0200
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5KNYV3S002735;
        Thu, 21 Jun 2018 08:34:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5KNYV3S002735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529537672;
        bh=nPH5dK8HoG7OINvLKvZz+OBq0SDH5ngVJJZVXAH2ReI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pFe3VT5exxYyWZJ5PRez6iEtcnAIAuBza14RPIX86r5oj/l4iz8avohiHtRkmTQej
         nYt0vs9JinGo3T/7juRlSbN4izMVcyKSUW1uypaLT106txKZY3qC65WC5/eroNr6Fg
         1OC/BaJayZ3ghz5J+gHuQhG/bqoDE0RC1dyQWIhVmn1c9EOvSx1Szh2yRGYMCWogjI
         MdoKNuQX9TLng9vCeelreIFUVZ85zThEKGmak6cmLs+OcyJukYSFLKzmmuT3JhOuBX
         2N8ktdTuSQDxntScK7XSoVGpqO3blLZjyq9x8Fw3CUIypqhZheyfdnKgut/TLpNDwD
         wYEmlVG1ek+3Q==
X-Nifty-SrcIP: [209.85.217.182]
Received: by mail-ua0-f182.google.com with SMTP id 59-v6so848832uas.5;
        Wed, 20 Jun 2018 16:34:32 -0700 (PDT)
X-Gm-Message-State: APt69E2lE+E+WL7ullXqmnDdJB4ED6uphhfVJ7+SAm2qpissrY9pBheb
        bxOtNPE69d3ZKQX8L8ZWHrUaZXfsIfdtRY4fepQ=
X-Google-Smtp-Source: ADUXVKLO8XEZffQsGs5D3rLTEn75bLl3W3qtF/qn/rnM4TY42m2Ptkunj6rlT9gqr7uVUF2QalNSF/CjHw6SRAI4W68=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr14663156uae.140.1529537670921;
 Wed, 20 Jun 2018 16:34:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 16:33:50
 -0700 (PDT)
In-Reply-To: <20180620002229.xsh4bupxa72nhjoh@pburton-laptop>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
 <1523890067-13641-5-git-send-email-yamada.masahiro@socionext.com> <20180620002229.xsh4bupxa72nhjoh@pburton-laptop>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Jun 2018 08:33:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_z_o0M2OuHyT0XGkUqCncdVxyL9oH5yXZoM3yDyuM-g@mail.gmail.com>
Message-ID: <CAK7LNAS_z_o0M2OuHyT0XGkUqCncdVxyL9oH5yXZoM3yDyuM-g@mail.gmail.com>
Subject: Re: [PATCH 4/7] MIPS: boot: correct prerequisite image of vmlinux.*.its
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64405
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

Hi Paul,

2018-06-20 9:22 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> Hi Masahiro,
>
> Thanks for these - I've applied patches 1-3, 5 & 6 to mips-next for
> 4.19.
>
> On Mon, Apr 16, 2018 at 07:47:44AM -0700, Masahiro Yamada wrote:
>> vmlinux.*.its does not directly depend on $(VMLINUX) but
>> vmlinux.bin.*
>
> This isn't really true - to generate the .its we actually do depend on
> the ELF, which we read the entry address from (entry-y in
> arch/mips/Makefile, provided to arch/mips/boot/Makefile as
> VMLINUX_ENTRY_ADDRESS). In practice $(VMLINUX) is built before this
> makefile is ever invoked anyway, but the dependency is there.
>
> We don't need the vmlinux.bin.* file until we generate the .itb, so it
> should be fine for the .its & .bin steps to be executed in parallel
> which this patch would prevent.


You are right.

Thanks for catching this.




-- 
Best Regards
Masahiro Yamada
