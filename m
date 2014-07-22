Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 21:19:33 +0200 (CEST)
Received: from mailout2.w2.samsung.com ([211.189.100.12]:40174 "EHLO
        usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860206AbaGVTRrdhSB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 21:17:47 +0200
Received: from uscpsbgm2.samsung.com
 (u115.gpu85.samsung.co.kr [203.254.195.115]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N9400FS9O9FSP80@mailout2.w2.samsung.com>; Tue,
 22 Jul 2014 15:17:40 -0400 (EDT)
X-AuditID: cbfec373-b7fd56d0000060dc-5d-53ceb8d325b6
Received: from ussync4.samsung.com ( [203.254.195.84])
        by uscpsbgm2.samsung.com (USCPMTA) with SMTP id 90.E9.24796.3D8BEC35; Tue,
 22 Jul 2014 15:17:39 -0400 (EDT)
Received: from recife.lan ([105.144.134.243])
 by ussync4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0N94009CBO95ZL60@ussync4.samsung.com>; Tue,
 22 Jul 2014 15:17:39 -0400 (EDT)
Date:   Tue, 22 Jul 2014 16:17:28 -0300
From:   Mauro Carvalho Chehab <m.chehab@samsung.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     abdoulaye berthe <berthe.ab@gmail.com>,
        "arm@kernel.org" <arm@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <cooloney@gmail.com>,
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
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of gpio_remove retval in
 driver
Message-id: <20140722161728.712d961e.m.chehab@samsung.com>
In-reply-to: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.22; x86_64-redhat-linux-gnu)
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/hEN3LO84FG3z8amZx5eIhJotjX7aw
        WXxoamW22NPay2Yx9eETNoujOycyWRxe9ILR4tyrRywWzYvXs1nsnrOYxeL+16OMFt+udDBZ
        TPmznMniRN8HVovN8/8wWtz89I3V4vKuOWwWPRu2slpMmDqJ3eLM4l52izl/pjBbrJr7hNXi
        4ycbi0t7VCxOd7NarJ9/i81izclUB2mPDZ+b2DxmH3/E5rFz1l12j543Lawem1Z1snncubaH
        zePoyrVMHvNOBnrsn7uG3WPhlWYmjzMLjrB7HL+xncnj8ya5AN4oLpuU1JzMstQifbsEroyu
        PftZC7ZxVRyb+Zq1gXEBRxcjJ4eEgInEvbNH2SBsMYkL99YD2VwcQgJLGCV6v09khHCamSSW
        PXrMCFLFIqAq8XftZnYQm03ASOJVYwsriC0ioCPRve0nK0gDs8BiTom+qTvBioQFwiWWHe0E
        a+YVsJJ4ebuFGcTmFAiWaOn/xQ6xoZdJYsr9RywQdzhL/Jw5CapBUOLH5HtgcWYBLYnN25pY
        IWx5ic1r3jJPYBSYhaRsFpKyWUjKFjAyr2IULS1OLihOSs810itOzC0uzUvXS87P3cQIifzi
        HYwvNlgdYhTgYFTi4dVYfjZYiDWxrLgy9xCjBAezkghvdOu5YCHelMTKqtSi/Pii0pzU4kOM
        TBycUg2Mk+cu58hiWWC/MO7u5LL3u1N8+ffMeZTk4h58teV2N//dVqbJJ/T5NIT8n3LKlvFq
        TCsM62Y8pcPhzrrn3aLHz1cLO73pDZtZ3bhuot3WabUn1797+8B4wQXdCsuU0sK7KgmBkrcb
        vnb9Dcr87vfU7ETc6gkZOx1UzX7ym2dIv7hlsnDyaysNJZbijERDLeai4kQAutiGzdoCAAA=
Return-Path: <m.chehab@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.chehab@samsung.com
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

Em Tue, 22 Jul 2014 17:08:13 +0200
Linus Walleij <linus.walleij@linaro.org> escreveu:

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
> 
...
> >  drivers/media/dvb-frontends/cxd2820r_core.c    | 10 +++-------
> 
> Mauro can you ACK this?

Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
> 
> (Hm that looks weird. Mental note to look closer at this.)

What's weird there?

Regards,
Mauro
