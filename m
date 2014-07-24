Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 10:29:38 +0200 (CEST)
Received: from mail-oa0-f44.google.com ([209.85.219.44]:40893 "EHLO
        mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842383AbaGXI32w6pHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2014 10:29:28 +0200
Received: by mail-oa0-f44.google.com with SMTP id eb12so3255861oac.31
        for <linux-mips@linux-mips.org>; Thu, 24 Jul 2014 01:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1NC3ZbyGjuZZvRpXhJplqKG8zUXgjtsOTCWQltj5q8U=;
        b=dohJghLH5w1E8f/yOXIqomw4YrwE3IgoRDJzIRsBuSlUu5CTa2FNgavizuYLHnNo6V
         K9XbqkBNswqvBHYZSlcIL3FfO3SwsylXbqUHn4yKkhLPDgHxK+lQd97EoiPs+UQePeBl
         pEcai6RBSTF351LYOUIoM4KzO43C9p7TTH+TMt/NgqIo1iNley75yTmsMV3Sw/ndHHEs
         Y9HtwkKTxt2urDWt4HrYrK5Vu7qFRqCCGaMuR4qLy0dE8s4bJ3WUROl7tpdrJXdTH1EX
         DwKBd27Ekn4O5Axf8olJgzaTKkxFnv9/bRyAZgxA9pBxWdQABMxJdpdIgJoqiXBjtS6a
         0V8A==
X-Gm-Message-State: ALoCoQn/IXV8FDOcEsO+/HvfUG66Z3akra4ZSnCyhnKoOJUx5CBerijqKmt52KQdiKB1NpJ9ez1j
MIME-Version: 1.0
X-Received: by 10.182.29.234 with SMTP id n10mr10363467obh.67.1406190562767;
 Thu, 24 Jul 2014 01:29:22 -0700 (PDT)
Received: by 10.182.33.100 with HTTP; Thu, 24 Jul 2014 01:29:22 -0700 (PDT)
In-Reply-To: <20140722151125.GS17528@sirena.org.uk>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
        <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
        <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
        <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
        <20140722151125.GS17528@sirena.org.uk>
Date:   Thu, 24 Jul 2014 10:29:22 +0200
Message-ID: <CACRpkdaEF14cB+=SjTHgwGH0z88v82Q_UNPvjzDAbpOb_2ec5Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of gpio_remove retval in driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     abdoulaye berthe <berthe.ab@gmail.com>,
        "arm@kernel.org" <arm@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <cooloney@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Michael Buesch <m@bues.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
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
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41557
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

On Tue, Jul 22, 2014 at 5:11 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 22, 2014 at 05:08:13PM +0200, Linus Walleij wrote:
>
>> Heads up. Requesting ACKs for this patch or I'm atleast warning that it will be
>> applied. We're getting rid of the return value from gpiochip_remove().
>
> Can someone send the patch please?  Splitting it up per-subsystem would
> probably be easier...

OK Abdoulaye maybe we can do it a piece at a time?

I have removed the __must_check attribute from gpiochip_remove()
in the gpiolib, so the compiler won't complain about this being missing
anymore as of kernel v3.17. I also dropped the check in the GPIO
and pin control subsystem, and other subsystems can start
dropping the checks too if they are OK with the build warnings
from the kautobuild until the __must_check removal has propagated
upstream.

Yours,
Linus Walleij
