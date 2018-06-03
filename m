Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jun 2018 05:00:42 +0200 (CEST)
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64004 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeFCDAfmY8Qd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jun 2018 05:00:35 +0200
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com [209.85.213.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w53304qd028668;
        Sun, 3 Jun 2018 12:00:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w53304qd028668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1527994805;
        bh=RfwPwMMDl1+QYwFjlPqM5nZ/xKMMnLO9++EcwDdoOA8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NvwKHQoqxRRoEMLrjejqHRh/Gi278oBFOEvFLFZrbUGwmhsL2jKIulTTnlpbJV+eX
         8GwT1S/ensyORGuydEs2nJDKuV/9JcHCLCMToIkV/Xxl/bgzPQM2AkagOlPzdcTR86
         PE3/TtsNP//qLURepOnhgElVS+L7X/qNw0kSDRdl6DeRxH217nGNvEz9P/vWJa8EII
         GhtXLvwHmYq17b/HRc+PlfVJP0Y+4fdd1Zt/9GOvc+26ii+ave/ieHSDe77zQom8Uf
         fFVzPtcHOeFlYhULewu9nvoshwWn5IfwBtIcbn6VFeCS/jt8xE+dOCCqWRq9UV5kpw
         F39YrxMvOjamg==
X-Nifty-SrcIP: [209.85.213.43]
Received: by mail-vk0-f43.google.com with SMTP id s187-v6so6066850vke.9;
        Sat, 02 Jun 2018 20:00:05 -0700 (PDT)
X-Gm-Message-State: ALKqPwdch7a+yOzlbeKRRd31mnFeA+e8/egBi4+nC1xwMi+/iLWiDTmr
        H/ik6L/Sy+ljyR21BOjmshYWvOXccKRzZhlNh+U=
X-Google-Smtp-Source: ADUXVKKbtWuQ2XDA6bas/U7ksZ78CaL4986Vavjo5apousx9DRSm4SloLSZgBdufaNWBWfJrAb/Q0RxvdcRTOWOFYg4=
X-Received: by 2002:a1f:acc4:: with SMTP id v187-v6mr9925292vke.11.1527994804040;
 Sat, 02 Jun 2018 20:00:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 2 Jun 2018 19:59:23 -0700 (PDT)
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 3 Jun 2018 11:59:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7tCC93Ep=5QJ4VQmS83HJ7MhEyLwE1ohTMUbzCnDkqg@mail.gmail.com>
Message-ID: <CAK7LNAQ7tCC93Ep=5QJ4VQmS83HJ7MhEyLwE1ohTMUbzCnDkqg@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: boot: fix various problems in arch/mips/boot/Makefile
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64151
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

Hi MIPS maintainers,

2018-04-16 23:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> When I was trying to fix commit 0f9da844d877 in a more correct way,
> I found various problems in arch/mips/boot/Makefile.
>
> ITS is always rebuilt when you rebuild the kernel without touching
> anything.  Many build rules are wrong.
>
> If you look at the last patch in this series, you may realize
> supporting ITB building in the kernel can cause nasty problems.
> Personally, I do not like it, but I tried my best to fix the problems.
>
> With this series, ITB is rebuilt only when necessary.
>

Is any part of this series applicable?
At least, patch 1-4 look simple to me.


Patch 5-7 should be applied together.
The last one is a bit tricky, so you can ignore 5-7 if you do not like them.
(Only the problem is, ITB files are always rebuilt even if nothing is changed.)

>
> Masahiro Yamada (7):
>   Revert "MIPS: boot: Define __ASSEMBLY__ for its.S build"
>   MIPS: boot: do not include $(cpp_flags) for preprocessing ITS
>   MIPS: boot: fix build rule of vmlinux.its.S
>   MIPS: boot: correct prerequisite image of vmlinux.*.its
>   MIPS: boot: add missing targets for vmlinux.*.its
>   MIPS: boot: merge build rules of vmlinux.*.itb by using pattern rule
>   MIPS: boot: rebuild ITB when contained DTB is updated
>
>  arch/mips/boot/Makefile | 69 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 32 deletions(-)
>
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
