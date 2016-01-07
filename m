Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 16:28:42 +0100 (CET)
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35081 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009505AbcAGP2kA2x0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 16:28:40 +0100
Received: by mail-oi0-f41.google.com with SMTP id l9so287793107oia.2
        for <linux-mips@linux-mips.org>; Thu, 07 Jan 2016 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KWtma6QyqzcSQ2/y4rsGThATVrqS8mHFHJ0JwtNPjjY=;
        b=N5oYQgF51jS6WqMN5nYZbLQmg/7l/mdJqX5axwdavd8xzw2OVXuHCvhAlK6bR2mSnm
         NYyc1pru7xT6MrKoYkrozGC5v1K6vcWfxE1+/AKtaoZgeNWxu0PpPXHAZXyATC4aipGN
         fXL1HrX23aasMcmi0Hc45THgncmBnnBXvLH6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KWtma6QyqzcSQ2/y4rsGThATVrqS8mHFHJ0JwtNPjjY=;
        b=Ik27z2C8isnaaUt/C5fzW2qu8xrvQkePIDPBxp9HU1+IvNLkcq/pfvIRZs3JP/IijX
         dhhExf0bbqLjq8yb1+3Mon6WEUipGaEW8Z4kcp4/aPbVy7qFR3HO2RRatJjfr8bvOYk9
         VnC/f+F0Y8KGzFQlnPu+/8fQmowBePLhOPe0TJ/VubWgMlSNbBpHBkrc7umZx46kOxzc
         zJR+VUDtspEAapmBt0y7EfK+Sr92Rc4m+GvIf9Yw3Izatvy8XFJ6uizhNUAnOv9bPUub
         wU3aAT8GkqLO+3DFPz7/5LBPcjeTHUNFPw0CeWgQ6KNZ75LYGAOHysYKg2j6x4iCNsjg
         m3tg==
X-Gm-Message-State: ALoCoQnVzlWLK/ZbKl3l/QabWeWOSMhLy+fziRMyLh8/MwKuq2OrO0HcWlkxLQJqpIL16y7rF5LM14Oka8XzBRULClBHHLzqGmOl0u6BC9zVxbwuSAJXFeA=
MIME-Version: 1.0
X-Received: by 10.202.102.102 with SMTP id a99mr74055614oic.113.1452180514491;
 Thu, 07 Jan 2016 07:28:34 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Thu, 7 Jan 2016 07:28:34 -0800 (PST)
In-Reply-To: <1452106523-11556-2-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
        <1452106523-11556-2-git-send-email-f.fainelli@gmail.com>
Date:   Thu, 7 Jan 2016 16:28:34 +0100
Message-ID: <CACRpkda7xndoR5M7Jfhys4m_ggPModW=gEhzRZUnG2vn_WYDMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: brcmstb: have driver register during subsys_initcall()
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Gregory Fong <gregory.0xf0@gmail.com>, jaedon.shin@gmail.com,
        Alexandre Courbot <gnurou@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50960
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

On Wed, Jan 6, 2016 at 7:55 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:

> From: Jim Quinlan <jim2101024@gmail.com>
>
> Because regulators are started with subsys_initcall(), and gpio references may
> be contained in the regulators, it makes sense to start the brcmstb-gpio's with
> a subsys_initcall(). The order within the drivers/Makefile ensures that the
> gpio initialization happens prior to the regulator's initialization.
>
> We need to unroll module_platform_driver() now to allow this and have custom
> exit and init module functions to control the initialization level.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I'm holding this back until the initcall ordering discussion is
resolved, the other two patches are applied.

Yours,
Linus Walleij
