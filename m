Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2018 15:12:15 +0100 (CET)
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43048 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993829AbeK2OLBbzyQQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2018 15:11:01 +0100
Received: by mail-qk1-f196.google.com with SMTP id r71so1093595qkr.10;
        Thu, 29 Nov 2018 06:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wv38us1LrGaAtmbmo49i4wsBnN+kWL1/8/1UP+gxTYQ=;
        b=UnYT/AJ7Ot1Gv4TAVbGpLrzjPmMCPzQ47FivuoKVr8BFMK7//Dm39t/gTivl+Zz561
         GYflzqcuP9ZS/PGrbE6kUk4ArzVWjqwhZXP1yuLCkCRjmsZPpnInfBd7tioCeofrU0vE
         GWwi+151gCWpMhcG/bzgmMWRZpC2CECfcRyE2VjDC7lBgKzXQPidXB2Me/D+X8oaG8Aa
         jzwlsPXSKzGY80+uRp67JVDWy4tHnDurOzTQq1wPzJ4zJ4QyIk0T20wnv6/F10ipFsZn
         TqMxMyUOJRlNOdMEmWaeNYxyMmH0jjXBLKUpcc9f+nMAFenTGA4nDKRgnFced3R0jyH8
         cs1w==
X-Gm-Message-State: AA+aEWbcQwNWiHUWBUr3/E8vEFDDf/H1gx9c6ygiGA/UH3Y+R4m2fUd/
        MXZrD2F0CsIOtXVE/OgxTuGAQk2u5Ilq+xWjQwk=
X-Google-Smtp-Source: AFSGD/VRjXbNAIpsZr4dI3CXoXFX08aFmjLRqc+nKn9Ux1anF/pD33EoUiKp/HulBbq07qB9abOPjXVoHN09EbmMkg8=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr1407839qkf.330.1543500659952;
 Thu, 29 Nov 2018 06:10:59 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <1543481016-18500-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543481016-18500-2-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 15:10:42 +0100
Message-ID: <CAK8P3a1Pq=Y83p-cN9bf+m-2ZAmJdEYRaAY9FfEkVHvfSwNWNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mips: add __NR_syscalls along with __NR_Linux_syscalls
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67549
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

On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:

>  arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
> index f25dd1d..6914be5 100644
> --- a/arch/mips/include/uapi/asm/unistd.h
> +++ b/arch/mips/include/uapi/asm/unistd.h
> @@ -391,11 +391,14 @@
>  #define __NR_rseq                      (__NR_Linux + 367)
>  #define __NR_io_pgetevents             (__NR_Linux + 368)
>
> +#ifdef __KERNEL__
> +#define __NR_syscalls                  368
> +#endif
>
>  /*
>   * Offset of the last Linux o32 flavoured syscall
>   */
> -#define __NR_Linux_syscalls            368
> +#define __NR_Linux_syscalls            __NR_syscalls

This seems odd: you define __NR_Linux_syscalls outside of
#ifdef __KERNEL__, but the definition only works
with __NR_syscalls being defined first, which it isn't in
user space.

Since the macros are completely unused as well as unusable
now, how about removing them together with the other
ones removed in patch 2?

      Arnd
