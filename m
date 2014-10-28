Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 17:13:17 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33878 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011105AbaJ1QNQ0ZiRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 17:13:16 +0100
Received: by mail-ie0-f176.google.com with SMTP id rd18so1009601iec.35
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 09:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=eksZIjj4UxNrFB5zskGgxalFyBdhxukkw8OLMcAT4Qs=;
        b=ciCW+iUr2KTaI4ePRpqe8H/oACCw/YZrzMdg2T14B8NSrdar1gaJhl+Lih9317zXsg
         bO1jzH70E4GJVfrZ6Xz2AqDzLwnpPI6Dy9XBas0pNUuWtdKGO9tjPhNanj0KUmFvlpP2
         izvIbZe0PXbVf1xGrijKUmrKFCVVjmfUi8mCJt9ccp26gxeaZ54OTOzKz4blSqjdAd6H
         qgb9HkqmETjlR1377VJWdkldPPdtQySkHX5EFYL++wWxcCMIrPILgRMmfjR4T2XIYHqD
         XsEWHRu67o/Vrc/HTCQqwQjQ6vrgvrI2DRBNdPayXTfJRZRzbX673sJcKhwRnhhh8VY5
         24/A==
X-Gm-Message-State: ALoCoQlrRvPGZu7F2YNVgjcna8qG1WeWAWHZ39/vjmxKx9V+1sjr2obOxLCM8ro2+h+PxNJbDB0e
MIME-Version: 1.0
X-Received: by 10.107.168.201 with SMTP id e70mr3161551ioj.89.1414512765061;
 Tue, 28 Oct 2014 09:12:45 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Tue, 28 Oct 2014 09:12:44 -0700 (PDT)
In-Reply-To: <CAHNKnsThQb8zstGhRJjFFJx6eKtFd-NZuK9wND-Puex2OCY=Hw@mail.gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
        <1410723213-22440-10-git-send-email-ryazanov.s.a@gmail.com>
        <CACRpkda3Cq+d47DMm018nAC7ThcHAOv-tOqEbNsUY1mOSnKyoA@mail.gmail.com>
        <CAHNKnsSj-=0aFHD574yRW9BpH1ONhy7K0NA8xri2ez6ab_MPMA@mail.gmail.com>
        <CACRpkda7XffyCvsG7CAMwF0qDW9bJ_m+xxFhhMAqd_r=O4B8+g@mail.gmail.com>
        <CAHNKnsThQb8zstGhRJjFFJx6eKtFd-NZuK9wND-Puex2OCY=Hw@mail.gmail.com>
Date:   Tue, 28 Oct 2014 17:12:44 +0100
Message-ID: <CACRpkdbBLTOxjszvqj=Br9wqLU_6X_cC_7DOpFcT_+=QrapZrA@mail.gmail.com>
Subject: Re: [RFC 09/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43645
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

On Tue, Oct 21, 2014 at 10:59 AM, Sergey Ryazanov
<ryazanov.s.a@gmail.com> wrote:

> BTW, the use of the irq_domain framework is required or I could
> opencode some stuff?

Whatever makes sense. If you write something that looks very
convoluted compared to doing it with irqdomain, you're doing
something wrong.

But shouldn't this driver be using GPIOLIB_IRQCHIP by the way?
That includes irqdomain handling.

Yours,
Linus Walleij
