Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 18:06:16 +0100 (CET)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:42635
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeABRGJiDFep (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 18:06:09 +0100
Received: by mail-ua0-x244.google.com with SMTP id q22so23132567uaa.9;
        Tue, 02 Jan 2018 09:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pp8eIKhnEz0UikwMi5pPOuqzFNs574SObiy4QNARUxs=;
        b=CVPe650nxRFBKetYgkFUkncMgHkLDU2Ey/t252nkNqly7+Vjz9T6ecw72oh5i1NUGs
         Q8izDVnuh8x0fdS21jyMbOYhJ6CHFi8mTREtninWD7A/SMHfh3UN1l3Hdc1hPHNgzn1w
         E2d827y7LLeiCQX8+IawoEnT6cfHkQ5zul2NB/RcaqPt+bdWtzCpZCRrFzrkfali749N
         FDANo0wVnTnTDqbgGH11KD7vPQFN8jKtaTP1B0hRB1mvf1kNwUoCGoA+UvwVF4pnglAN
         RR5AhrCom0cOUnys/b5KzLSClBvJXvd5Tyf9yvtNT8Aw+o5GNIQR7pAl6V2jhqAJTnzH
         K8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pp8eIKhnEz0UikwMi5pPOuqzFNs574SObiy4QNARUxs=;
        b=fJselgBW1sA1oApPmnkQQbQL6TGLAhryGP4J/OnGCgUPK5QeQVJ6K4eF1oQH380XoF
         t1f5bUfrJDn5NzcbDAJffbmdvLO33VO2MtRFscsBR4bJCa9C2kIMjJwzt/grTCie+9P5
         Hy3aR7vEY65PvdZ5oDMYxmcdfEVRA13wXpl8qeFdMXLOWRjkZIHRx9IRRHE1L5CRGz3H
         KWBN8mkzMYqtwLcf8tFtkbG5mUDj5zGW8jlAmVaVVk2XhbKIVGN+N5S1pF9adAVLTYnC
         CsgfBWSUHBhMKNgGSgvIrcWFFwJ6plbeslriWv2mVhNlWI0uDIGOrTIuUcIkL/0PZnD6
         8S4w==
X-Gm-Message-State: AKGB3mIrmcgh7uCMlq2SPQ7LUiLlFhHADV4eJMqd6QRblwQGyKZ7LB4m
        oSk1vHrsl18nCgkl9+Wuenkfw7zB22seqFxaaFQ=
X-Google-Smtp-Source: ACJfBotK57c0gXIVbpDFyitXnXnFkek/0h/CabtyLs03DS2FyfEM1LNdcor+q8IfAWAsBElZ1I9dpgw/800AQuS1N68=
X-Received: by 10.176.92.40 with SMTP id q40mr43057421uaf.85.1514912763681;
 Tue, 02 Jan 2018 09:06:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.4.199 with HTTP; Tue, 2 Jan 2018 09:05:43 -0800 (PST)
In-Reply-To: <20180102150848.11314-7-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180102150848.11314-7-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 2 Jan 2018 18:05:43 +0100
X-Google-Sender-Auth: oPD-3gIgXWM6GFJYy2M89JpJwCw
Message-ID: <CA+7wUsyfrFcGevgfRb9S3T1bSGaFjN=y1gfg70D21vpw26YWzQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] MIPS: Setup boot_command_line before plat_mem_setup
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Tue, Jan 2, 2018 at 4:08 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>
> Platforms using DT will typically call __dt_setup_arch from
> plat_mem_setup. This in turn calls early_init_dt_scan. When
> CONFIG_CMDLINE is set, this leads to its value being copied into
> boot_command_line by early_init_dt_scan_chosen. If this happens before
> the code setting up boot_command_line in arch_mem_init runs, that code
> will go on to append CONFIG_CMDLINE (via builtin_cmdline) to
> boot_command_line again, duplicating it. For some command line
> parameters (eg. earlycon) this can be a problem. Set up
> boot_command_line before early_init_dt_scan_chosen gets called such that
> it will not write CONFIG_CMDLINE in this scenario & the arguments aren't
> duplicated.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>  arch/mips/kernel/setup.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
>  v2: New patch in this series
>  v3: No change
>  v4: No change
>  v5: No change

I would have used @mips email. Anyway:

Acked-by: Mathieu Malaterre <malat@debian.org>
