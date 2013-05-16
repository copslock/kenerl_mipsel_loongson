Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 May 2013 18:12:41 +0200 (CEST)
Received: from sauhun.de ([89.238.76.85]:50316 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825725Ab3EPQMjgLcRu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 May 2013 18:12:39 +0200
Received: from p5b387862.dip0.t-ipconnect.de ([91.56.120.98]:44333 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <wolfram@the-dreams.de>)
        id 1Ud0n5-0007Qc-Kv; Thu, 16 May 2013 18:12:28 +0200
Date:   Thu, 16 May 2013 18:13:58 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
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
Subject: Re: [PATCH 00/33] devm improvement series, part 1, take 2
Message-ID: <20130516161355.GA3032@katana>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
 <1368705452.15764.217.camel@sauron.fi.intel.com>
 <CAKohpokUy7QfvKkzGH025Zs5VkUhr8zRLeo3caG3LAnLfptzww@mail.gmail.com>
 <1368709862.15764.224.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368709862.15764.224.camel@sauron.fi.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <wolfram@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


> I need a defconfig which would have this driver enabled. 

My wish would be a minimal config. Right now, I try to build the driver
with the current config and when that fails I grep through the
(uncompressed) defconfigs for the symbol needed. Gives me 45/57 success
rate on this series. Not perfect, but the best I could come up with
without writing a .config-generator myself.
