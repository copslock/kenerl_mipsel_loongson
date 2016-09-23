Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 15:10:56 +0200 (CEST)
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34904 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991932AbcIWNKqljcB1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 15:10:46 +0200
Received: by mail-oi0-f44.google.com with SMTP id w11so133517331oia.2
        for <linux-mips@linux-mips.org>; Fri, 23 Sep 2016 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hIyeDPsQ9Bu8WCGavnLp7AO3PHZiDmYnoOBMoEUZ/lM=;
        b=EhnTA48U+YwH+tv2TKoyhyjRQ1cwXRPgDNWOOltFaJH9xTWgaIi9y0XduQ9VPz+PLT
         uUdJL+u9XIMRxSjkcW+KkKswwSEE3qVTQzel57eZCvTNQ3wHhj/UC4QkJ2E5b2hTA4Io
         sUiL4sj8hw/W6M9cmPoLB5fye3BXoI5I7FPe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hIyeDPsQ9Bu8WCGavnLp7AO3PHZiDmYnoOBMoEUZ/lM=;
        b=C9LthUMP8Ihm/DohiHBSilxr9Gr+KEJOnF05C7OhJa1mSsSULO1AZY0+bqW5T++IlP
         ABX8rXIB96ZKvGDLnyunm15k4jI/3Bflba02z5nSs6iozRVmGQkQr7bf3RyRTcddNvCY
         uvM9zrtkosa+vxNwyey+KHcFjyKJGSBPp8YLLZ1guijfpXfONAwqxwyuzapYrVQ2dXwM
         Vzqm7nU6Z8/U7IITD2z78WjB1tLnWYKFjgVFx9oneL2X3cebnGo0roWEWaucxMN3OTc9
         HKM6LoBJpHPQzPj2XzyXfAh+fFs0UJxbwwWdFBK7j5RDpBPP2YJlxQjWULMCte74wSDc
         f5hQ==
X-Gm-Message-State: AE9vXwOT+Mz3R0HEkVHvVNmvm3OffMNiThbbp4bjLCzmyVWDhGoMOuV9m2gojGMfxY81Ub6pxwEP+X+vFU5FuVEx
X-Received: by 10.202.106.143 with SMTP id f137mr9895783oic.165.1474636239257;
 Fri, 23 Sep 2016 06:10:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.146.7 with HTTP; Fri, 23 Sep 2016 06:10:38 -0700 (PDT)
In-Reply-To: <1474470459-2124-1-git-send-email-weiyj.lk@gmail.com>
References: <1474470459-2124-1-git-send-email-weiyj.lk@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Sep 2016 15:10:38 +0200
Message-ID: <CACRpkdZJ-=-gRy4+ERwxmwZrGgjbAVdE-itt6yZQd0U3QK0Nnw@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: loongson1: remove redundant return value
 check of platform_get_resource()
To:     Wei Yongjun <weiyj.lk@gmail.com>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55250
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

On Wed, Sep 21, 2016 at 5:07 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied.

Yours,
Linus Walleij
