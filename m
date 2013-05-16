Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 May 2013 14:55:49 +0200 (CEST)
Received: from mail-oa0-f48.google.com ([209.85.219.48]:58651 "EHLO
        mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825660Ab3EPMzsZq4u1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 May 2013 14:55:48 +0200
Received: by mail-oa0-f48.google.com with SMTP id i4so3648373oah.21
        for <linux-mips@linux-mips.org>; Thu, 16 May 2013 05:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=f3J7yM0YvzRjqCO3qQLyOGON0vhG88JXdgWnx9+IkGg=;
        b=ceFWvGk2JrtlMWoWeyECpi0oTtt0ADQjJoONLMDDvQoxkm+yMUmDB1sMR9xd8Q94Rc
         90jGHaVtR97oTre+4RXoVwTX+RhIp2dmgdtH72kT+UMcwQQwnTT2fnUlakFBmUbJKNLK
         EsjAPLlkpPDTyjAkoDvkqQKze0U+44MIWWE+Cl2zThZdMDIbcBWNKLBfO4jMf9qdzydV
         VcXpKAh7N9H/tGpiCGt8H54IgHgib+Wsj7CdbHVFqm8ZNDj0QZF2GnmOXQIIJQdrULoR
         r5lV3RnnAqvoyYLuoowAA6lcwFPtuQTrJY/PrJcVj9X80wQvSR0X3EAxQ1zGbibWJpM0
         tPjg==
MIME-Version: 1.0
X-Received: by 10.60.58.99 with SMTP id p3mr21592352oeq.23.1368708942194; Thu,
 16 May 2013 05:55:42 -0700 (PDT)
Received: by 10.182.180.16 with HTTP; Thu, 16 May 2013 05:55:42 -0700 (PDT)
In-Reply-To: <1368705452.15764.217.camel@sauron.fi.intel.com>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
        <1368705452.15764.217.camel@sauron.fi.intel.com>
Date:   Thu, 16 May 2013 18:25:42 +0530
Message-ID: <CAKohpokUy7QfvKkzGH025Zs5VkUhr8zRLeo3caG3LAnLfptzww@mail.gmail.com>
Subject: Re: [PATCH 00/33] devm improvement series, part 1, take 2
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     dedekind1@gmail.com
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Mackall <mpm@selenic.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>,
        linux-ide@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-i2c@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Wan ZongShun <mcuos.com@gmail.com>, ac100@lists.launchpad.net,
        devel@driverdev.osuosl.org, Kukjin Kim <kgene.kim@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Marc Dietrich <marvin24@gmx.de>,
        Stephen Warren <swarren@wwwdotorg.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org,
        Eduardo Valentin <eduardo.valentin@ti.com>,
        David Airlie <airlied@linux.ie>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Grant Likely <grant.likely@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Deepak Saxena <dsaxena@plexity.net>,
        linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org, Julian Andres Klode <jak@jak-linux.org>,
        Inki Dae <inki.dae@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org,
        rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        spi-devel-general@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Felipe Balbi <balbi@ti.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Vinod Koul <vinod.koul@intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Dan Williams <djbw@fb.com>, Tejun Heo <tj@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Zimmerman <paulz@synopsys.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQlxiwFE5lYPkfKIZJDTLzLGk9qdvRGIWx9ojIpBlxMOTp3IIAJUj+I/RlmsnNdXAIF6gz+8
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 16 May 2013 17:27, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Thu, 2013-05-16 at 13:15 +0200, Wolfram Sang wrote:
>> Despite various architectures and platform dependencies, I managed to
>> compile
>> test 45 out of 57 modified files locally using heuristics and
>> defconfigs.
>> If somebody knows how to create a minimal .config with a certain
>> kconfig symbol
>> (and its dependencies) set, I'd love to hear about it.
>
> If you find this out, please, share!

Are you guys looking for "make savedefconfig" ??
