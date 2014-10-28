Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 10:37:41 +0100 (CET)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:42604 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011543AbaJ1Jhjc9KM5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 10:37:39 +0100
Received: by mail-ig0-f169.google.com with SMTP id a13so2126069igq.2
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 02:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5Y0EE501pKoRW7fKIhoYu6FsfHRR9naqTr6Ah4nK90c=;
        b=ewQL65E1iMRVZ3beJwF5Tiyo8eYoEBs2rK4iUZcFvVXRl+NXQzOvJwwRRkQx/k5GWh
         PkkTz7gyiRSoC2lmVAzEt4KdvHJ2bmlFwWBqgGQ5hJH077K6vpN8W0PN7Tq2k/QXWyzK
         OQjwf52TNMnOOb4OI28oRish6XPPTB21R7mC2KcoJ6rVWUcSsso+0eaoplQiblY0U3xR
         oG1rxRfk8dvgJpP9S0oZ5L+cZrd9C456TIWEJWzqKAotrctBJrwCHrRTw4zuuFvGXRfy
         wNXn4RKxfRnjlngSSmpV+gSRmXHg1bNgORIjvezP1qFB3Bx5gp9nwapiOPmHPaBAxA8L
         p+Gw==
X-Gm-Message-State: ALoCoQkQpL/d6iDUuzEDhQMRCdnx4MU5cTLr7yXnkjjokF0cyDzBvdsCRLsSodDprYxI5qLmYUww
MIME-Version: 1.0
X-Received: by 10.51.16.99 with SMTP id fv3mr28668952igd.31.1414489053606;
 Tue, 28 Oct 2014 02:37:33 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Tue, 28 Oct 2014 02:37:33 -0700 (PDT)
In-Reply-To: <1412972930-16777-3-git-send-email-blogic@openwrt.org>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
        <1412972930-16777-3-git-send-email-blogic@openwrt.org>
Date:   Tue, 28 Oct 2014 10:37:33 +0100
Message-ID: <CACRpkdZtpMY7pLjZ_nUrVSUVxBuQe496cs_JFCV-zEojDokK4Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] DT: Add documentation for gpio-mt7621
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Fri, Oct 10, 2014 at 10:28 PM, John Crispin <blogic@openwrt.org> wrote:

> Describe gpio-mt7621 binding.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org

These bindings look fine.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
