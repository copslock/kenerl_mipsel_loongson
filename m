Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Feb 2013 12:44:01 +0100 (CET)
Received: from mga03.intel.com ([143.182.124.21]:35174 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823126Ab3BNLoAToZdr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Feb 2013 12:44:00 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 14 Feb 2013 03:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,665,1355126400"; 
   d="scan'208";a="202309498"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.164])
  by AZSMGA002.ch.intel.com with ESMTP; 14 Feb 2013 03:43:49 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Svetoslav Neykov <svetoslav@neykov.name>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: Re: [PATCH 3/5] usb: chipidea: Don't access OTG related registers
In-Reply-To: <1360791538-6332-4-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name> <1360791538-6332-4-git-send-email-svetoslav@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Feb 2013 13:45:26 +0200
Message-ID: <874nhfazl5.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.shishkin@linux.intel.com
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

Svetoslav Neykov <svetoslav@neykov.name> writes:

> According to the datasheet the chipidea controller in AR933x doesn't expose OTG and TEST registers.
> If no OTG support is detected don't call functions which access those registers.
>
> Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
> ---
>  drivers/usb/chipidea/udc.c |   24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 78ac5e5..9fda4d8 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1395,7 +1395,10 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
>  		if (is_active) {
>  			pm_runtime_get_sync(&_gadget->dev);
>  			hw_device_reset(ci, USBMODE_CM_DC);
> -			hw_enable_vbus_intr(ci);
> +
> +			if (ci->is_otg)
> +				hw_enable_vbus_intr(ci);

It might be easier on the eyes if you move the "if (ci->is_otg)" check
inside hw_enable_vbus_intr(). But otherwise looks sensible.

Regards,
--
Alex
