Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 15:29:34 +0200 (CEST)
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60405 "EHLO
        mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822681Ab3I3N3cZEQHx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 15:29:32 +0200
Received: by mail-pb0-f48.google.com with SMTP id ma3so5526322pbc.7
        for <multiple recipients>; Mon, 30 Sep 2013 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BDOqQ0phJ6qFNTDSr9xclifv3at79osrzY+bHu8Zhic=;
        b=r5SMWYjVm0fmADIQN5I/NyuH8BgpgyH0e5F9tb17xtMjHbAmFqj6uZAp3SfOY0f2zL
         FjWgWLxzKg0DOCddhB/UvMbLs3vxvj4zGW+QwNRME93ojjTBiBvSgajOFBFbEvWe0DjH
         OSvC9FjBZvZ95KiPab1DkaFAFeND8vZIjPbgkJwTRGcE8MAIw97/bt5WpPs5Mqw5wDSc
         yGjJmxyYYP1sPSIqZwVuMk9rc2+1w0XGNMsxsliBkeT9cgTDkwD+A1bsi6kyOvJWXV4c
         c4PrD0tvwllEvsCJbJOPSVUpzNhTLLlHLIItnTeoEpH9q2zw7S0LaCG03bBTU1OHU9yB
         x5fA==
X-Received: by 10.68.251.133 with SMTP id zk5mr23545704pbc.69.1380547765104;
 Mon, 30 Sep 2013 06:29:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.38.99 with HTTP; Mon, 30 Sep 2013 06:28:45 -0700 (PDT)
In-Reply-To: <1380472330-9247-1-git-send-email-antonynpavlov@gmail.com>
References: <1380472330-9247-1-git-send-email-antonynpavlov@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Mon, 30 Sep 2013 14:28:45 +0100
Message-ID: <CAGVrzcZ2DoL6M9O9bFOWYaVQMawiJrdoL7HC1UUfbhxb3Mrvew@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: ZBOOT: gather string functions into string.c
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/9/29 Antony Pavlov <antonynpavlov@gmail.com>:
> In the worst case this adds less then 128 bytes of code
> but on the other hand this makes code organization more clear.
>
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>

Just one minor comment below, but not a big problem.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

[snip]

> +/*
> + * arch/mips/boot/compressed/string.c
> + *
> + * Very small subset of simple string routines
> + */
> +
> +#include <linux/string.h>

Nitpick: only linux/types.h is actually required for size_t, but this
is not a big deal.

> +
> +void *memcpy(void *dest, const void *src, size_t n)
> +{
> +       int i;
> +       const char *s = src;
> +       char *d = dest;
> +
> +       for (i = 0; i < n; i++)
> +               d[i] = s[i];
> +       return dest;
> +}
> +
> +void *memset(void *s, int c, size_t n)
> +{
> +       int i;
> +       char *ss = s;
> +
> +       for (i = 0; i < n; i++)
> +               ss[i] = c;
> +       return s;
> +}
> --
> 1.8.4.rc3
>



-- 
Florian
