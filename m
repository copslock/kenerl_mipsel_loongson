Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Dec 2017 14:45:46 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbdLWNpjll3PY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Dec 2017 14:45:39 +0100
Received: from localhost (LFbn-1-12262-44.w90-92.abo.wanadoo.fr [90.92.75.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2FAA5927;
        Sat, 23 Dec 2017 13:45:31 +0000 (UTC)
Date:   Sat, 23 Dec 2017 14:45:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yisheng Xie <xieyisheng1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ulf.hansson@linaro.org, jakub.kicinski@netronome.com,
        airlied@linux.ie, linux-wireless@vger.kernel.org,
        linus.walleij@linaro.org, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-mtd@lists.infradead.org, daniel.vetter@intel.com,
        dan.j.williams@intel.com, jason@lakedaemon.net,
        linux-rtc@vger.kernel.org, boris.brezillon@free-electrons.com,
        mchehab@kernel.org, dmaengine@vger.kernel.org,
        vinod.koul@intel.com, richard@nod.at, marek.vasut@gmail.com,
        industrypack-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org, dvhart@infradead.org,
        linux@roeck-us.net, linux-media@vger.kernel.org,
        seanpaul@chromium.org, devel@driverdev.osuosl.org,
        linux-watchdog@vger.kernel.org, arnd@arndb.de,
        b.zolnierkie@samsung.com, marc.zyngier@arm.com, jslaby@suse.com,
        jani.nikula@linux.intel.com, linux-can@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org, mkl@pengutronix.de,
        linux-fbdev@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        bhelgaas@google.com, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, kvalo@codeaurora.org,
        a.zummo@towertech.it, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, lgirdwood@gmail.com,
        ralf@linux-mips.org, linux-spi@vger.kernel.org, ysxie@foxmail.com,
        wg@grandegger.com, cyrille.pitchen@wedev4u.fr, tj@kernel.org,
        alexandre.belloni@free-electrons.com, davem@davemloft.net,
        andy@infradead.org
Subject: Re: [PATCH v3 27/27] devres: kill devm_ioremap_nocache
Message-ID: <20171223134532.GA10103@kroah.com>
References: <1514026979-33838-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514026979-33838-1-git-send-email-xieyisheng1@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Sat, Dec 23, 2017 at 07:02:59PM +0800, Yisheng Xie wrote:
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -44,35 +44,6 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  EXPORT_SYMBOL(devm_ioremap);
>  
>  /**
> - * devm_ioremap_nocache - Managed ioremap_nocache()
> - * @dev: Generic device to remap IO address for
> - * @offset: Resource address to map
> - * @size: Size of map
> - *
> - * Managed ioremap_nocache().  Map is automatically unmapped on driver
> - * detach.
> - */
> -void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
> -				   resource_size_t size)
> -{
> -	void __iomem **ptr, *addr;
> -
> -	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> -
> -	addr = ioremap_nocache(offset, size);

Wait, devm_ioremap() calls ioremap(), not ioremap_nocache(), are you
_SURE_ that these are all identical?  For all arches?  If so, then
ioremap_nocache() can also be removed, right?

In my quick glance, I don't think you can do this series at all :(

greg k-h
