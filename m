Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 19:36:56 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:37884 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6863013AbaGVQCNLG8Ua (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 18:02:13 +0200
Received: by mail-ie0-f181.google.com with SMTP id rp18so8214118iec.40
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 09:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tk2ukiMSPG14A93KcdrDbEhowXSLWbFKWQR84Z+Ap0U=;
        b=gfRER/tEZoGCqlKq6dYVq0U9E9FKPAs4OxnIktLXyZa0dfdFN8l/Ys+TiQvN3SV6fZ
         yAM7G7Cf7673An7b4Qr7QtgPqzNHui1sg/U0dfbtNNJbwO0CztlFTOWpcRU42cFgAtKR
         NFTyzfUwUWaZ4W872iQGLo9vGHzl6gF00EEq19TPOSFqt+sipZmG3/OemzkwhEgItf+0
         k7JL2bJfNDJquh2cDKaIW/s6ha/ymS215pkwdJZLMeuRCFixWuxmye1jgPAofo2XA69H
         Jg+h3RSLdwRkLGkV6djq8hmvY030d8z4Quq10PneRkX7KAmnbzfuozW7/LlP2WfQnznG
         babQ==
X-Gm-Message-State: ALoCoQkyvdGzqTtsHoqbYOkC6kk4f57JQB6DuJ10+RUWiTUhNdyGnLmAAUgi6KCLbGPl69dEPSxm
X-Received: by 10.50.112.1 with SMTP id im1mr17723651igb.33.1406044927053;
        Tue, 22 Jul 2014 09:02:07 -0700 (PDT)
Received: from lee--X1 (host109-148-232-149.range109-148.btcentralplus.com. [109.148.232.149])
        by mx.google.com with ESMTPSA id y11sm50248856igp.14.2014.07.22.09.02.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Jul 2014 09:02:06 -0700 (PDT)
Date:   Tue, 22 Jul 2014 17:01:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     abdoulaye berthe <berthe.ab@gmail.com>,
        "arm@kernel.org" <arm@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <cooloney@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Michael Buesch <m@bues.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of gpio_remove retval
 in driver
Message-ID: <20140722160158.GE23210@lee--X1>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Tue, 22 Jul 2014, Linus Walleij wrote:

> On Sat, Jul 12, 2014 at 10:30 PM, abdoulaye berthe <berthe.ab@gmail.com> wrote:
> 
> Heads up. Requesting ACKs for this patch or I'm atleast warning that it will be
> applied. We're getting rid of the return value from gpiochip_remove().
> 
> > this remove all reference to gpio_remove retval in all driver
> > except pinctrl and gpio. the same thing is done for gpio and
> > pinctrl in two different patches.
> >
> > Signed-off-by: abdoulaye berthe <berthe.ab@gmail.com>
> (...)
> 
> I think this patch probably needs to be broken down per-subsystem as it
> hits all over the map. But let's start requesting ACKs for the
> individual pieces.
> Actually I think it will be OK to merge because there is likely not much churn
> around these code sites.
> 
> I'm a bit torn between just wanting a big patch for this hitting drivers/gpio
> and smaller patches hitting one subsystem at a time. We should be able
> to hammer this in one switch strike.

It would be better if you could devise a plan to make the switch a
subsystem at a time.

[...]

> >  drivers/mfd/asic3.c                            |  3 ++-
> >  drivers/mfd/htc-i2cpld.c                       |  8 +-------
> >  drivers/mfd/sm501.c                            | 17 +++--------------
> >  drivers/mfd/tc6393xb.c                         | 13 ++++---------
> >  drivers/mfd/ucb1x00-core.c                     |  8 ++------
> 
> Lee/Sam can either of you ACK this?

I don't see any code?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
