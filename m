Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 22:02:34 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:36265 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903703Ab2ENUCb convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 22:02:31 +0200
Received: by yhjj52 with SMTP id j52so5466295yhj.36
        for <linux-mips@linux-mips.org>; Mon, 14 May 2012 13:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=Zfc9pRu1WWd7BxDoGiwnoOkuJCrImMEaaBQhiKDQpRU=;
        b=lQLfKVDE8wTgWtkbIYkmpSWgX+PrfixS3NnNUG2t5ePOc0PRcXqlig7UvjhjyMAQA7
         ikvZi99XU/HOw736/AnlkIY4pUZXJVJ5rEq5orEi7L1Q9piNQPTAJm7RCrMlVuTcyXYz
         kyEFOWcCFAlDoy9t0mJFYYirq8h45xvtkLaVK2JeyzGv/1TUlUI9zRmoE5tBcG7Eh+Yc
         DytAZybKP+iUW+kmM0jEc48F1vApdVr2jZn3ftoRzGJtVVgbOlGz5hf4pN+7YrvHqD91
         F4iBDV5IkTEpI7oUj+mXeLdAp20UAaALindrsaL0t8kQfuX2xjNaeGti8o9q75sQIKC0
         D1cg==
MIME-Version: 1.0
Received: by 10.236.165.71 with SMTP id d47mr9314155yhl.107.1337025744603;
 Mon, 14 May 2012 13:02:24 -0700 (PDT)
Received: by 10.147.137.4 with HTTP; Mon, 14 May 2012 13:02:24 -0700 (PDT)
In-Reply-To: <1336772086-17248-2-git-send-email-ddaney.cavm@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
        <1336772086-17248-2-git-send-email-ddaney.cavm@gmail.com>
Date:   Mon, 14 May 2012 22:02:24 +0200
Message-ID: <CACRpkdaXgcYTxb4qHPkzsrU+x6=zg8mQGVxmgCV59R1s2eqn+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: OCTEON: Add register definitions for SPI host hardware.
From:   Linus Walleij <linus.walleij@linaro.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Gm-Message-State: ALoCoQlJPrrOg86hFhNbLd+1RzULR1AA9MxyxS2j/NsqhjUKA2bmwSAbIBfOwP9Yyu6ZHK3svOei
X-archive-position: 33315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, May 11, 2012 at 11:34 PM, David Daney <ddaney.cavm@gmail.com> wrote:

> From: David Daney <david.daney@cavium.com>
>
> Needed by SPI driver.

That's not very verbose, plese tell atleast tell which SPI driver it's for.

> +union cvmx_mpi_cfg {
> +       uint64_t u64;

The kernel already has a type (in <linux/kernel.h>) used in many places in the
kernel, called "u64" so this gets very confusing.

Can you call it something else?

BTW: you could then s/uint64_t/u64 and use that u64.
(Some don't like the three-letter types so no big deal.)

> +       struct cvmx_mpi_cfg_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +               uint64_t reserved_29_63:35;
> +               uint64_t clkdiv:13;
> +               uint64_t csena3:1;
> +               uint64_t csena2:1;
> +               uint64_t csena1:1;
> +               uint64_t csena0:1;
> +               uint64_t cslate:1;
> +               uint64_t tritx:1;
> +               uint64_t idleclks:2;
> +               uint64_t cshi:1;
> +               uint64_t csena:1;
> +               uint64_t int_ena:1;
> +               uint64_t lsbfirst:1;
> +               uint64_t wireor:1;
> +               uint64_t clk_cont:1;
> +               uint64_t idlelo:1;
> +               uint64_t enable:1;
> +#else
> +               uint64_t enable:1;
> +               uint64_t idlelo:1;
> +               uint64_t clk_cont:1;
> +               uint64_t wireor:1;
> +               uint64_t lsbfirst:1;
> +               uint64_t int_ena:1;
> +               uint64_t csena:1;
> +               uint64_t cshi:1;
> +               uint64_t idleclks:2;
> +               uint64_t tritx:1;
> +               uint64_t cslate:1;
> +               uint64_t csena0:1;
> +               uint64_t csena1:1;
> +               uint64_t csena2:1;
> +               uint64_t csena3:1;
> +               uint64_t clkdiv:13;
> +               uint64_t reserved_29_63:35;
> +#endif

This boggles my mind, but I see there are many drivers doing this,
but using uint64_t looks overly scary.

Can't you break it apart using a set of u32's like in
drivers/net/ethernet/micrel/ksz884x.c?

Yours,
Linus Walleij
