Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 20:01:00 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50387 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6863268AbaGVRvha5N3V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 19:51:37 +0200
Received: by mail-pd0-f169.google.com with SMTP id y10so997pdj.14
        for <multiple recipients>; Tue, 22 Jul 2014 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=he+7o/W6/LmRR2eKo/moak+bACJUcV2sS2zwwQWexFM=;
        b=uP1axbuy1atyR0ebDL+qjkFL4MmWNaBkCWdiUXwGmBz4sF9RLv/JdSapJduWTosWND
         7Z5VluA7qh6t/X5hdP6yekUzQTsQhkt97TjHEo77T1CHQU/UmOE5LiNgvnEG5brkcN1k
         x83agX38bplgVk2UaordhWHs9Ro6/WZ8bAJF8pL1B5JCqglrGUq2PweQ+Q+xcwoPSEgb
         fHJ5G0brluUbsDVAJR9NuxeAu2njvMnMFO2nq7XtdLhelZy1nKJWsYufZg6+8uPDSN2c
         ZkJqX8FjT8a8PMD/p2MeBrWwDjjj2EMeE4s5WBh8AHm2T8QYUIjeewYq/7D89dmd1gaZ
         UcEA==
X-Received: by 10.69.2.35 with SMTP id bl3mr24916141pbd.83.1406051487846;
        Tue, 22 Jul 2014 10:51:27 -0700 (PDT)
Received: from mailhub.coreip.homeip.net (c-50-136-245-103.hsd1.ca.comcast.net. [50.136.245.103])
        by mx.google.com with ESMTPSA id q1sm1384529pdd.10.2014.07.22.10.51.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 22 Jul 2014 10:51:26 -0700 (PDT)
Date:   Tue, 22 Jul 2014 10:51:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     abdoulaye berthe <berthe.ab@gmail.com>,
        "arm@kernel.org" <arm@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Bryan Wu <cooloney@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
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
Message-ID: <20140722175121.GA5489@core.coreip.homeip.net>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Tue, Jul 22, 2014 at 05:08:13PM +0200, Linus Walleij wrote:
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

...

> 
> >  drivers/input/keyboard/adp5588-keys.c          |  4 +---
> >  drivers/input/keyboard/adp5589-keys.c          |  4 +---
> >  drivers/input/touchscreen/ad7879.c             | 10 +++-------
> 
> Dmitry can you ACK this?

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
