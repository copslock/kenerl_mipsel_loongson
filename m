Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Nov 2017 05:09:51 +0100 (CET)
Received: from conssluserg-03.nifty.com ([210.131.2.82]:19628 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdKREJo3cIQX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Nov 2017 05:09:44 +0100
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id vAI498nQ019435;
        Sat, 18 Nov 2017 13:09:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com vAI498nQ019435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510978149;
        bh=73KPPMhYvXxlC/R3uUyYOxIh37T7/+gSYP/colYGGIA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PpqPr0EVrtvWb3iPguXE10/mAWoqDQNpbVNPGyjK4WIjJ6o/FxnD+GC24uFDStrIQ
         zBa+28UustuZlC1qea821II8U14/+4QWzAT1d34na6gOG1cdaWN5Jl7Fe05onfQdHP
         jWSedovrizkFCdcYqjEVclTjrArrV7DZlx96A70bhVV1ymr5lo5J9i5Dxh3p+WwYIL
         mjKrTaWCJ/bnelLAo+IomGVq9mHXaZDP/pF/K774aTe1OGatha69TgFfDD+K+XoYNs
         5PZjKcud/NebxKMZjOZpQ9VcA/1z4cYr++7GZO0UWYh+3shg4hTxlgCagBZ44Wt5Rn
         ChXhFjjeJoqUA==
X-Nifty-SrcIP: [209.85.161.169]
Received: by mail-yw0-f169.google.com with SMTP id q37so2405443ywa.12;
        Fri, 17 Nov 2017 20:09:08 -0800 (PST)
X-Gm-Message-State: AJaThX6eeG3tQTNrZ6fwg1WcGEfQbyazKjnLpQxVQbyoCkeiyzCbuPBl
        bAJXkW6Fbcwoi3eJ7+VCT9eUoCBVoRYoeMp+fHk=
X-Google-Smtp-Source: AGs4zMaxAsCbuhORjEiNGvhJD0NLHsIj5BC/hH1wSBUPgHf+DktMfUmIiHs0UVTI2kxBYmEUqvOnO8kuuXB9ps+wnM0=
X-Received: by 10.129.36.206 with SMTP id k197mr2708261ywk.485.1510978147860;
 Fri, 17 Nov 2017 20:09:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.110.139 with HTTP; Fri, 17 Nov 2017 20:08:27 -0800 (PST)
In-Reply-To: <1510072307-16819-3-git-send-email-yamada.masahiro@socionext.com>
References: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com> <1510072307-16819-3-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 18 Nov 2017 13:08:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMJMr-DSP=aukpbuOffBFwY-hP6a4NJenrCcivt5HmMw@mail.gmail.com>
Message-ID: <CAK7LNATMJMr-DSP=aukpbuOffBFwY-hP6a4NJenrCcivt5HmMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: remove all dummy assignments to obj-
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61000
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

2017-11-08 1:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Now kbuild core scripts create empty built-in.o where necessary.
> Remove "obj- := dummy.o" tricks.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/kbuild.

-- 
Best Regards
Masahiro Yamada
