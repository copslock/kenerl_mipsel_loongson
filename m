Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2012 16:05:34 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1186 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870486Ab2JHOF0sY08x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Oct 2012 16:05:26 +0200
Received: from [10.9.200.131] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 08 Oct 2012 07:02:20 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 8 Oct 2012 07:05:07 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 91D6040FEF; Mon, 8
 Oct 2012 07:05:04 -0700 (PDT)
Date:   Mon, 8 Oct 2012 19:36:42 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Florian Fainelli" <florian@openwrt.org>
cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/32 v4] MIPS: Netlogic: use ehci-platform driver
Message-ID: <20121008140641.GC30932@jayachandranc.netlogicmicro.com>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org>
 <1349701906-16481-6-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
In-Reply-To: <1349701906-16481-6-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7C6C03663PS2978763-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 34657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Mon, Oct 08, 2012 at 03:11:19PM +0200, Florian Fainelli wrote:
> The EHCI platform driver is suitable for use by the Netlogic XLR platform
> since there is nothing specific that the EHCI XLR platform driver does.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Changes in v4:
> - rebased against greg's latest usb-next
> No changes in v3
> 
> Changes in v2:
> - really change driver name to "ehci-platform"
> - slightly reworded commit message
> 
>  arch/mips/netlogic/xlr/platform.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
> index 71b44d8..144c5c6 100644
> --- a/arch/mips/netlogic/xlr/platform.c
> +++ b/arch/mips/netlogic/xlr/platform.c
> @@ -15,6 +15,7 @@
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>
>  #include <linux/i2c.h>
> +#include <linux/usb/ehci_pdriver.h>
>  
>  #include <asm/netlogic/haldefs.h>
>  #include <asm/netlogic/xlr/iomap.h>
> @@ -123,8 +124,12 @@ static u64 xls_usb_dmamask = ~(u32)0;
>  		},							\
>  	}
>  
> +static struct usb_ehci_pdata xls_usb_ehci_pdata = {
> +	.caps_offset	= 0,
> +};
> +

Do we need to initilaize static data to 0?

JC.
