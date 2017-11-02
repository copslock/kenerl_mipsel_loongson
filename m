Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 10:09:12 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:53703
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993306AbdKBJJEyRKkA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 10:09:04 +0100
Received: by mail-ot0-x244.google.com with SMTP id f18so949029otd.10;
        Thu, 02 Nov 2017 02:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NP/UeKGOFxvrbzcHNL6omhO18y91zlkSxU1FfgzGsb4=;
        b=GfUG8Qn+ZyRs1tbyveUp4aGH+DZJMljHwpbP8NzfJigc4ZsdQ4mlzuqnb5CgvQMu7w
         9SOcCq9wtqRLn4H34471ZBtuV1XD2aFaRdDvTObutoqFn6k2dTfORdAXXqCI90bwU3Yd
         TXTjN87w156MxF4KYSwsJPGaps8/XucTMcb9MWe4lGAzYgaMTz8FHQitUdC9QOw/qKd1
         Dr3Hr/VBRv5c7WfJIcq2/0ROROloQlwGYXCyhr7faQbtgidOUiLNrlaVCzAoIG+f9zAK
         27srfEURgPqkvT12hfBIxL2Y39RNH6FzpwZ31GO/2KIEjks8k/EmHgy43NYmtyJ80GJi
         vUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NP/UeKGOFxvrbzcHNL6omhO18y91zlkSxU1FfgzGsb4=;
        b=iPhb+0M7rCR4TVbR3JwYa/TCrncxCYiFwDL2bh48cdf4hdW80CK2VXBGU7zzPo3wio
         FKezNLJrHQF6RMV7otfSg7bpAjTKhjrbVvqEchH/Sd0HzxNsC6OwfIudWgEEbSQHxw7L
         kdJtZaVegcoq0ow9HZ/xZ+HEkmrYVKg25LeKQp2KnFDpeu1JQB7MdOv2/WExY2QPWNnY
         Gi1iea3mQvCH8Ugtx6YiGwFXn/G8rIhgQ/4vCLzi3HIAQrTr68INQZesgoZtGCsRDiEB
         8IjYRVgvPixR/HyVIi1wVu9zFpJSbRh+ZKVVi868enBKy5fU5cEYynzDoJRuyHhDIsFr
         plyA==
X-Gm-Message-State: AJaThX4jh9h5cqZSd3aUOks0BJhkbsHvukK0Xb2YRLptMSXqp18tV5fj
        EChP79GCVS3sK/GDTd3gK3nLGOKp12gO8tQCBCQ=
X-Google-Smtp-Source: ABhQp+RGVm93dM9G0cpEGa53b00y46kgd+4JuhvgYbHMilD4a2D4MAwh9dmhXyH+kuCmmS4WEIoXszWbQ5vLHx86Dd8=
X-Received: by 10.157.17.72 with SMTP id p8mr1698296otp.305.1509613738475;
 Thu, 02 Nov 2017 02:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.28.152 with HTTP; Thu, 2 Nov 2017 02:08:58 -0700 (PDT)
In-Reply-To: <bb7c1a637afa47e8943ce494798f957c@SOC-EX01V.e01.socionext.com>
References: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3FoRJeO=TQGMRf6t4-bP8nP6KUEhkCrHP6L8XaF1Ee7g@mail.gmail.com> <bb7c1a637afa47e8943ce494798f957c@SOC-EX01V.e01.socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Nov 2017 10:08:58 +0100
X-Google-Sender-Auth: 7d_aHD08P3vuixLU4fzGX0jTN8k
Message-ID: <CAK8P3a0r=un9H8y2AizW3v5KzkTEGgb70hfBx8C88qphDjJksg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
 top-level Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thu, Nov 2, 2017 at 9:48 AM,  <yamada.masahiro@socionext.com> wrote:

>>       Arnd
>
> Yeah, I had also noticed this race problem on parallel building
> with CONFIG_OF_ALL_DTBS.
>
> I was planning to do it
> when I come up with a clean implementation.
>
> One idea is to handle dtb-y and CONFIG_OF_ALL_DTBS
> natively in scripts/Makefile.build or somewhere
> as scripts/Makefile.dtbinst already recognizes dtb-y as a special variable.

Ah, nice, that does sound better, yes.

      Arnd
