Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 00:19:26 +0100 (CET)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33328 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012971AbcBRXTY734py (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2016 00:19:24 +0100
Received: by mail-oi0-f47.google.com with SMTP id j125so873527oih.0
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 15:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0Ffm5HiJjE0HuAKApoKgNZ19Zl/LPh01R72Rpd2r8Qc=;
        b=Ca5GIGcEhU1jTUsYGZnTzSMhi+BW3RUPuy/7T9xSgUaHgeSP6zrKN55wsbI+f50FDW
         Y4era5gfnRYy0DvMKpz3L0TuqLwN2qj1Od1gQ6KLq9THNbWy+TnJQTx3kVTrWKLdf4m9
         xX0bcbZg+8hE3AZ5723KqOP0+TWO3sBb+FZXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0Ffm5HiJjE0HuAKApoKgNZ19Zl/LPh01R72Rpd2r8Qc=;
        b=NCs4rDIUbKzpIn+gSZSnRPWf5xbaaWY66gC0jehBHP0sb/eUSTmfnmiia3ia0xLAQ9
         nhwr2wFDJxSyhLg2vZ3xZyX8UH+86El4SFDrCJdsPaGctEl9JIBJYDg9WcHjP1Zxld7p
         RjpJ41Kd8+zKteEmAwGKZjk0HDSyg39EAT32TQES6vPzgZSu7UWyNrApTIkQNR0NG5CG
         AhqlHuq/4N2v6m1t/1wsJ0S7trVoX4SD29+NZDo1uNNkfe3ij4Fs4GX+PdDrgfWSYlBC
         vvXgDHt+yYd3PrKfhwoErJa7HW94pRkU2kixGxMGhEDshxL8Q4tdL7q37mMLY7XT9VTS
         f9qw==
X-Gm-Message-State: AG10YOQOZc/0wKbS4SboJlw9esgGv+1Ve6lyYw41QqWcXUdkacs8JGNdIXYS44tvs5lm2wv2SMFiE16cROj5De2v
MIME-Version: 1.0
X-Received: by 10.202.180.137 with SMTP id d131mr8487574oif.135.1455837559069;
 Thu, 18 Feb 2016 15:19:19 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Thu, 18 Feb 2016 15:19:18 -0800 (PST)
In-Reply-To: <20160216160609.GA15268@linux-mips.org>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-1-git-send-email-arnd@arndb.de>
        <20160216160609.GA15268@linux-mips.org>
Date:   Fri, 19 Feb 2016 00:19:18 +0100
Message-ID: <CACRpkda=TFuUWzV_pLKoVhCZp1zWbEjoGmCey_w87bsuQZZ=jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] MIPS: jz4740: remove broken irq_to_gpio() call
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "# v4 . 3+" <stable@vger.kernel.org>, Alban Bedel <albeu@free.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52123
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

On Tue, Feb 16, 2016 at 5:06 PM, Ralf Baechle <ralf@linux-mips.org> wrote:

>> -#define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
>> +#define IRQ_TO_BIT(irq) BIT((irq - JZ4740_IRQ_GPIO(0)) & 0x1f)
>>
>>  static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
>>  {
>
> I've already committed an identical fix locally.
>
>   Ralf

I took that fix out of linux-next and applied to the GPIO tree so I can apply
the rest of the patches without build problems. If you keep it
around without changing it, git should cope I guess.

Yours,
Linus Walleij
