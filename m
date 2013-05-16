Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 May 2013 13:55:16 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:10254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823124Ab3EPLzLPwqJQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 May 2013 13:55:11 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP; 16 May 2013 04:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,683,1363158000"; 
   d="scan'208";a="335050358"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2013 04:55:02 -0700
Received: from [10.237.72.52] (sauron.fi.intel.com [10.237.72.52])
        by linux.intel.com (Postfix) with ESMTP id E89F46A408D;
        Thu, 16 May 2013 04:54:36 -0700 (PDT)
Message-ID: <1368705452.15764.217.camel@sauron.fi.intel.com>
Subject: Re: [PATCH 00/33] devm improvement series, part 1, take 2
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
Date:   Thu, 16 May 2013 14:57:32 +0300
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.6.4 (3.6.4-3.fc18) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
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

On Thu, 2013-05-16 at 13:15 +0200, Wolfram Sang wrote:
> Despite various architectures and platform dependencies, I managed to
> compile
> test 45 out of 57 modified files locally using heuristics and
> defconfigs.
> If somebody knows how to create a minimal .config with a certain
> kconfig symbol
> (and its dependencies) set, I'd love to hear about it.

If you find this out, please, share!

-- 
Best Regards,
Artem Bityutskiy
