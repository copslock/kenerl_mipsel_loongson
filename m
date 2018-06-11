Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 10:28:31 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:42682
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeFKI2XhjMHb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 10:28:23 +0200
Received: by mail-lf0-x244.google.com with SMTP id v135-v6so29192016lfa.9
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2018 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z5kDMISGDwNmmBG1v1w0sDEx4H9HSISZRPZZhi/5sk0=;
        b=dUHyN4KzlPWuHC73x76wfAizljn3PQ4OBWvSFV+2D4YSKg+eFXxRmtxAswexsM0GM3
         RCqP30gukuQLskBTk3yKI8ZbYNYQ4UGyBQXTnYwQIWgk7OLmNM0eKy5pROlXUj69Yf88
         ju1KUw1x8vWwxjGspch4uDAH+0jOF5Ft/Ld0jrEv2m152t2odBN4LYVofiYFApXeSq66
         I8mAC4+AaFXclpBh+YS5w1b8541HSc4N0tQI4pB66Ezaezu++IKqB1GaBndw57eBBAyb
         5iBKQvDERDuhU+ckEO2bdSySZTJsfJ7cJEqfxsemltzrJ+Z0LsQZLRVcWpWWYCEW9jI0
         1NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z5kDMISGDwNmmBG1v1w0sDEx4H9HSISZRPZZhi/5sk0=;
        b=sh0ooQ9jZjlWGXeTqxTCdWrRUlQIR7TL1m/9RUDJrlnooGGppInyKHUmuEbu02MtgO
         j/ec1+CiC+FnQVez77l95msTH9ytuIs7nnaFqdhHtMCBmrblN0GRCDFNiUGDpI8ZFQKE
         Ue2h/CKy0Cp6XMVnCkOk5++adp9KB8aX2YU2BAeUP2eKituYSaCa/LpS/l3uGQWe20kB
         K63sFp+s7qcSI/rqn6a7y66BkFVCnK8VRgWFTlUsUIic098tLeI85VF/sLICJpMBGa5G
         uLkME0pAd5daxbu/GuK34lD7TKU0FjyPxFydpdjB9nPUre1VCEc7iZD3J4Oa9SMFaNzF
         zqtA==
X-Gm-Message-State: APt69E2KwsDQNmvg/48li+YMOaVNStORDhQUgA8BUQSWG+iZoBFvPJkd
        P62kbKm8X9wsD8ty5KtFF5D/KmZYid40eZlE46SYrj2cL10=
X-Google-Smtp-Source: ADUXVKL/LeIG5ZjGJcEQkwTB6nCFsnnkTMQP+6fMubg1w7m4n3f5w9+OtbGbOBel2mYsY3LWWlqjkpjxHya9/SH1wEU=
X-Received: by 2002:a19:dd0b:: with SMTP id u11-v6mr10129609lfg.100.1528705697836;
 Mon, 11 Jun 2018 01:28:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:eb04:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:28:16
 -0700 (PDT)
X-Originating-IP: [172.247.34.138]
In-Reply-To: <20180611013821.21422-1-r@hev.cc>
References: <20180611013821.21422-1-r@hev.cc>
From:   Heiher <r@hev.cc>
Date:   Mon, 11 Jun 2018 16:28:16 +0800
Message-ID: <CAHirt9jr8PC6iCjMgcZTSZVEZ2mKtaWZMG3mugO4AFGDFAdG6g@mail.gmail.com>
Subject: Re: [PATCH v4] MIPS: Fix ejtag handler on SMP
To:     linux-mips@linux-mips.org, paul.burton@mips.com
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, Heiher <r@hev.cc>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <r@hev.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r@hev.cc
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

Unfortunately, I remember that sdbbp instruction can be executed in
user mode. so, $gp may not always point to thread info.

On Mon, Jun 11, 2018 at 9:38 AM,  <r@hev.cc> wrote:
> From: Heiher <r@hev.cc>
>
> On SMP systems, the shared ejtag debug buffer may be overwritten by
> other cores, because every cores can generate ejtag exception at
> same time.
>
> Unfortunately, in that context, it's difficult to relax more registers
> to access per cpu buffers. so use ll/sc to serialize the access.
>
> Signed-off-by: Heiher <r@hev.cc>
> ---
>  arch/mips/kernel/genex.S | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 37b9383eacd3..fec6256bac1e 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -354,16 +354,54 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
>         sll     k0, k0, 30      # Check for SDBBP.
>         bgez    k0, ejtag_return
>
> +#ifdef CONFIG_SMP
> +1:     PTR_LA  k0, ejtag_debug_buffer_spinlock
> +       ll      k0, 0(k0)
> +       bnez    k0, 1b
> +       PTR_LA  k0, ejtag_debug_buffer_spinlock
> +       sc      k0, 0(k0)
> +       beqz    k0, 1b
> +# ifdef CONFIG_WEAK_REORDERING_BEYOND_LLSC
> +       sync
> +# endif
> +
> +       PTR_LA  k0, ejtag_debug_buffer
> +       LONG_S  k1, 0(k0)
> +
> +       lw      k1, TI_CPU(gp)
> +       PTR_SLL k1, LONGLOG
> +       PTR_LA  k0, ejtag_debug_buffer_per_cpu
> +       PTR_ADDU k0, k1
> +
> +       PTR_LA  k1, ejtag_debug_buffer
> +       LONG_L  k1, 0(k1)
> +       LONG_S  k1, 0(k0)
> +
> +       PTR_LA  k0, ejtag_debug_buffer_spinlock
> +       sw      zero, 0(k0)
> +#else
>         PTR_LA  k0, ejtag_debug_buffer
>         LONG_S  k1, 0(k0)
> +#endif
> +
>         SAVE_ALL
>         move    a0, sp
>         jal     ejtag_exception_handler
>         RESTORE_ALL
> +
> +#ifdef CONFIG_SMP
> +       lw      k1, TI_CPU(gp)
> +       PTR_SLL k1, LONGLOG
> +       PTR_LA  k0, ejtag_debug_buffer_per_cpu
> +       PTR_ADDU k0, k1
> +       LONG_L  k1, 0(k0)
> +#else
>         PTR_LA  k0, ejtag_debug_buffer
>         LONG_L  k1, 0(k0)
> +#endif
>
>  ejtag_return:
> +       back_to_back_c0_hazard
>         MFC0    k0, CP0_DESAVE
>         .set    mips32
>         deret
> @@ -377,6 +415,12 @@ ejtag_return:
>         .data
>  EXPORT(ejtag_debug_buffer)
>         .fill   LONGSIZE
> +#ifdef CONFIG_SMP
> +EXPORT(ejtag_debug_buffer_spinlock)
> +       .fill   LONGSIZE
> +EXPORT(ejtag_debug_buffer_per_cpu)
> +       .fill   LONGSIZE * NR_CPUS
> +#endif
>         .previous
>
>         __INIT
> --
> 2.17.1
>



-- 
Best regards!
Hev
https://hev.cc
