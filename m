Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 13:21:49 +0200 (CEST)
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36569 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012536AbbELLVrTcfnN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 13:21:47 +0200
Received: by oift201 with SMTP id t201so2912866oif.3
        for <linux-mips@linux-mips.org>; Tue, 12 May 2015 04:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fd0QdtaYIueBoURvtM4bRDJEDGrw2w1F7Wrmiqvn6OE=;
        b=UTUzMVoKjIyKKdsSvu4Ok8LkisRmdZmVk8RvdKFco+pBdDzJwfprtvikScQjw6+dsI
         T26JxbVr3dXpQa5msvVzzj+O6T/bkEcVe8XxHdWZeg7NUHj1Vu+zuEdeiGVyFnU9jHz1
         9os7Lzi+a3Wu0TOTCrX1zqe7ohbNMxAwlTY/lGoD709UXk5B+BcsG3Afol4TFFJ7oFwM
         xOZ60RMf6BNyuGJO00yomUUEkfNm+paZN04P+OwBoiLQCgoEoAOrRxrQbEyqdVKNdjXa
         dKlhmysmlurk+AHq/l5pWRd3IegA+qVfzpntGxrDuphrzsZ82iuaCmnBSdHni8i7a3Dv
         85gw==
X-Gm-Message-State: ALoCoQkZej8biKDoHtX13QINGE0Pe9xM+f+GeUXptEsaJ1dsa3J5LITzOwWl/X95wArgQf2FLIUZ
MIME-Version: 1.0
X-Received: by 10.182.65.194 with SMTP id z2mr11502526obs.30.1431429703652;
 Tue, 12 May 2015 04:21:43 -0700 (PDT)
Received: by 10.182.204.41 with HTTP; Tue, 12 May 2015 04:21:43 -0700 (PDT)
In-Reply-To: <1430942343-27201-1-git-send-email-abrestic@chromium.org>
References: <1430942343-27201-1-git-send-email-abrestic@chromium.org>
Date:   Tue, 12 May 2015 13:21:43 +0200
Message-ID: <CACRpkda9gP45BUyh2bCYCvUM1MM+ZbUtbiyqsQ-ZrGde7cEGrg@mail.gmail.com>
Subject: Re: [PATCH V5] pinctrl: Add Pistachio SoC pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47342
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

On Wed, May 6, 2015 at 9:59 PM, Andrew Bresticker <abrestic@chromium.org> wrote:

> Add a driver for the pin controller present on the IMG Pistachio SoC.
> This driver provides pinmux and pinconfig operations as well as GPIO
> and IRQ chips for the GPIO banks.
>
> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: James Hartley <james.hartley@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> ---
> Changes from v4:
>  - Switched to using gpiochip_add_pin_range().
>  - Fixed up Kconfig entry.

This version applied. Awesome job with this driver, thanks!

Yours,
Linus Walleij
