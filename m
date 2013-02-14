Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Feb 2013 10:01:57 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37285 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823082Ab3BNJBzw5ix- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Feb 2013 10:01:55 +0100
Received: from ptx.hi.pengutronix.de ([2001:6f8:1178:2:5054:ff:fec0:8e10] ident=Debian-exim)
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <mgr@pengutronix.de>)
        id 1U5uhF-0007Xg-Nf; Thu, 14 Feb 2013 10:01:37 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.72)
        (envelope-from <mgr@pengutronix.de>)
        id 1U5uhC-0005wQ-9x; Thu, 14 Feb 2013 10:01:34 +0100
Date:   Thu, 14 Feb 2013 10:01:34 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Svetoslav Neykov <svetoslav@neykov.name>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/5] usb: chipidea: flags to force usb mode
 (host/device)
Message-ID: <20130214090134.GI21362@pengutronix.de>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
 <1360791538-6332-3-git-send-email-svetoslav@neykov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1360791538-6332-3-git-send-email-svetoslav@neykov.name>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:53:06 up 166 days, 17:27, 12 users,  load average: 0.09, 0.09,
 0.09
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:5054:ff:fec0:8e10
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 35748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mgr@pengutronix.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Svetoslav,

On Wed, Feb 13, 2013 at 11:38:55PM +0200, Svetoslav Neykov wrote:
> The chipidea controller in the AR933x SOC supports both host and device modes but not OTG.
> Which USB mode is used depends on a pin state (GIPO13) during boot - HIGH for host, LOW for device mode.
> Currently if both host and device modes are available, the code assumes OTG support. Add flags to allow
> the platform code for force a specific mode based on the pin state.
> 
> Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
> ---
>  drivers/usb/chipidea/core.c  |   22 +++++++++++++++++-----
>  include/linux/usb/chipidea.h |    2 ++
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 3cefb4c..85c72e5 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -398,6 +398,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  	struct resource	*res;
>  	void __iomem	*base;
>  	int		ret;
> +	bool force_host_mode;
> +	bool force_device_mode;
>  
>  	if (!dev->platform_data) {
>  		dev_err(dev, "platform data missing\n");
> @@ -459,21 +461,31 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  	if (ret)
>  		dev_info(dev, "doesn't support gadget\n");
>  
> -	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
> +	force_host_mode = ci->platdata->flags & CI13XXX_FORCE_HOST_MODE;
> +	force_device_mode = ci->platdata->flags & CI13XXX_FORCE_DEVICE_MODE;
> +	if ((!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) ||
> +			(force_host_mode && !ci->roles[CI_ROLE_HOST]) ||
> +			(force_device_mode && !ci->roles[CI_ROLE_GADGET])) {
>  		dev_err(dev, "no supported roles\n");
>  		ret = -ENODEV;
>  		goto rm_wq;
>  	}
>  
> -	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
> +	if (!force_host_mode && !force_device_mode &&
> +			ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
>  		ci->is_otg = true;
>  		/* ID pin needs 1ms debouce time, we delay 2ms for safe */
>  		mdelay(2);
>  		ci->role = ci_otg_role(ci);
>  	} else {
> -		ci->role = ci->roles[CI_ROLE_HOST]
> -			? CI_ROLE_HOST
> -			: CI_ROLE_GADGET;
> +		if (force_host_mode)
> +			ci->role = CI_ROLE_HOST;
> +		else if (force_device_mode)
> +			ci->role = CI_ROLE_GADGET;
> +		else
> +			ci->role = ci->roles[CI_ROLE_HOST]
> +				? CI_ROLE_HOST
> +				: CI_ROLE_GADGET;
>  	}
>  
>  	ret = ci_role_start(ci, ci->role);
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index 544825d..e6f44d2 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -19,6 +19,8 @@ struct ci13xxx_platform_data {
>  #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
>  #define CI13XXX_PULLUP_ON_VBUS		BIT(2)
>  #define CI13XXX_DISABLE_STREAMING	BIT(3)
> +#define CI13XXX_FORCE_HOST_MODE		BIT(5)
> +#define CI13XXX_FORCE_DEVICE_MODE	BIT(6)
>  
>  #define CI13XXX_CONTROLLER_RESET_EVENT		0
>  #define CI13XXX_CONTROLLER_STOPPED_EVENT	1

We already discuss such functionality:

https://patchwork-mail1.kernel.org/patch/2092051/

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
