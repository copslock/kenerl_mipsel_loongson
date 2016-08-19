Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 12:55:21 +0200 (CEST)
Received: from mail-io0-f196.google.com ([209.85.223.196]:33258 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991104AbcHSKzN1YOay (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 12:55:13 +0200
Received: by mail-io0-f196.google.com with SMTP id y195so4525389iod.0
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2016 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WZ8GJqR9qeZJLbeUJvMe+o7a/2IYs40YhthxRYFYSHo=;
        b=y2yFfZN4FbDQ4yD1qrvTItHOyOWdjXLdsn6NWw71JcF01ijQbfmzg56+xmi5tvdR2f
         jfRTfAIGWaZnffAul7zG93Jq2O8PjuoY6iExCnUrptz4q3gzj6/j+/tAYkbMDloBfxR2
         qk7nRn6XvSn7e/hCfAwQXp70HkHJ7dMbgvrF07K9u4H4r3P/nua/v2SphUt0eXB7uUct
         5IG7PPxAZkFPINQ+Tj1j41Gu1LIIrq9DRcHp9jqaJxZdS1w10oWhhF4+ca6Ztn4ps0Eq
         pZJODGw6YVg7aRGcmOdmL5E3bzjeFflzuCOInXM0aVRtnT09u8kj8fknQYfv4JYDPydA
         c/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=WZ8GJqR9qeZJLbeUJvMe+o7a/2IYs40YhthxRYFYSHo=;
        b=L2KIZ42kP0yFhS3/LLTBOadf81XTlNSrnW86ZV7iAUbqPpkzSGSa2LFWk7PonJRADk
         6gqVQQENdaWvDZ7kglU11RctV8CeFpttN44qTxwe/4GzPwf89hkjSakAE3MiiW3GL1+t
         LyS5oLsmom7jALrY/Gg5ebn+irWK1MIP5nTNEpy0vy8hyYp3ZHC4tyQLt2Y8OM3UOJCM
         oUizy5Xx6PrPD1uWtSVSfqVWc7aKIatk0fns8ZLKyV6wFyYeyf+9HCrd80kOHGZ1NOPR
         iR7hj1RIoUM5jh/xNq7zOxE+wNqEVpgbtf6IFKdkr1WFwDHyUaSxPozdgleD0UR3v3ZL
         LyzQ==
X-Gm-Message-State: AEkooutw7gS4kuD25XWhEwqVe5WmBIMtqumbj2JOF2ceNaxWwVrs3jS9uDvNe1nL5xOHOfm7gB+tBfHiPDOwjQ==
X-Received: by 10.107.36.5 with SMTP id k5mr9201452iok.104.1471604107436; Fri,
 19 Aug 2016 03:55:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.54.75 with HTTP; Fri, 19 Aug 2016 03:55:06 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 19 Aug 2016 06:55:06 -0400
Message-ID: <CAH8yC8ny62Vf63cjtL8bUgGoRr-0BVGvqazs20S4JreJq+OBcg@mail.gmail.com>
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <noloader@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noloader@gmail.com
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

On Wed, Aug 17, 2016 at 11:35 AM, PrasannaKumar Muralidharan
<prasannatsmkumar@gmail.com> wrote:
> This patch adds support for hardware random number generator present in
> JZ4780 SoC.
>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  ...
> +static int jz4780_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +       struct jz4780_rng *jz4780_rng = container_of(rng, struct jz4780_rng,
> +                                                       rng);
> +       u32 *data = buf;
> +       *data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
> +       return 4;
> +}

My bad, I should have spotted this earlier....

i686, x86_64 and some ARM will sometimes define a macro indicating
unaligned data access is allowed. For example, see
__ARM_FEATURE_UNALIGNED (cf.,
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0774f/chr1383660321827.html)
. MIPSEL does not define such a macro.

    # MIPS ci20 creator with GCC 4.6
    $ gcc -march=native -dM -E - </dev/null | grep -i align
    #define __BIGGEST_ALIGNMENT__ 8

If the MIPS CPU does not tolerate unaligned data access, then the
following could SIGBUS:

> +       u32 *data = buf;
> +       *data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);

If GCC emits code that uses the MIPS unaligned load and store
instructions, then there's probably going to be a performance penalty.

Regardless of what the CPU tolerates, I believe unaligned data access
is undefined behavior in C/C++. I believe you should memcpy the value
into the buffer.

Jeff
