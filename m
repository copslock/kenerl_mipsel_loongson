Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 May 2013 20:30:20 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:34410 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825732Ab3EPS3wF4VNO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 May 2013 20:29:52 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 2BFA8644F;
        Thu, 16 May 2013 12:35:14 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 45A97E45FB;
        Thu, 16 May 2013 12:29:22 -0600 (MDT)
Message-ID: <5195257F.3060309@wwwdotorg.org>
Date:   Thu, 16 May 2013 12:29:19 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     linux-kernel@vger.kernel.org, ac100@lists.launchpad.net,
        Alan Stern <stern@rowland.harvard.edu>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Barry Song <baohua.song@csr.com>,
        Ben Dooks <ben-linux@fluff.org>, cpufreq@vger.kernel.org,
        Dan Williams <djbw@fb.com>, David Airlie <airlied@linux.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Deepak Saxena <dsaxena@plexity.net>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        Eduardo Valentin <eduardo.valentin@ti.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Felipe Balbi <balbi@ti.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Inki Dae <inki.dae@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Julian Andres Klode <jak@jak-linux.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Marc Dietrich <marvin24@gmx.de>,
        Mark Brown <broonie@kernel.org>,
        Matt Mackall <mpm@selenic.com>, netdev@vger.kernel.org,
        Paul Zimmerman <paulz@synopsys.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Ralf Baechle <ralf@linux-mips.org>, rtc-linux@googlegroups.com,
        Russell King <linux@arm.linux.org.uk>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        spi-devel-general@lists.sourceforge.net,
        Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Vinod Koul <vinod.koul@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 00/33] devm improvement series, part 1, take 2
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.97.7 at avon.wwwdotorg.org
X-Virus-Status: Clean
Return-Path: <swarren@wwwdotorg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 05/16/2013 05:15 AM, Wolfram Sang wrote:
> Lately, I have been experimenting how to improve the devm interface to make
> writing device drivers easier and less error prone while also getting rid of
> its subtle issues. I think it has more potential but still needs work and
> definately conistency, especiall in its usage.
...

The Tegra parts in patches 4, 5, 8, 15, 16, 17, 29 all,
Acked-by: Stephen Warren <swarren@nvidia.com>
