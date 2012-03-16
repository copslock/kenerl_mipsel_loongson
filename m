Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2012 10:06:09 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2275 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901172Ab2CPJGB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Mar 2012 10:06:01 +0100
Received: from [10.9.200.133] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 16 Mar 2012 02:14:58 -0700
X-Server-Uuid: B730DE51-FC43-4C83-941F-F1F78A914BDD
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 16 Mar 2012 02:05:09 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 30524BC395; Fri, 16 Mar 2012 02:05:46 -0700 (PDT)
Received: from [10.0.2.15] (unknown [10.176.68.152]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 92186207C0; Fri, 16
 Mar 2012 02:05:44 -0700 (PDT)
Message-ID: <4F630267.5050909@broadcom.com>
Date:   Fri, 16 Mar 2012 10:05:43 +0100
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216
 Thunderbird/10.0.2
MIME-Version: 1.0
To:     "Hauke Mehrtens" <hauke@hauke-m.de>
cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "m@bues.ch" <m@bues.ch>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "zajec5@gmail.com" <zajec5@gmail.com>
Subject: Re: [PATCH v5 4/4] USB: OHCI: remove old SSB OHCI driver
References: <1331851799-5968-1-git-send-email-hauke@hauke-m.de>
 <1331851799-5968-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1331851799-5968-5-git-send-email-hauke@hauke-m.de>
X-WSS-ID: 637DDB183E05310984-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/15/2012 11:49 PM, Hauke Mehrtens wrote:
> This is now replaced by the new ssb USB driver, which also supports
> devices with an EHCI controller.
>
> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
> ---
>   drivers/usb/host/Kconfig    |    7 +-
>   drivers/usb/host/ohci-hcd.c |   21 +----
>   drivers/usb/host/ohci-ssb.c |  260 -------------------------------------------
>   3 files changed, 7 insertions(+), 281 deletions(-)
>   delete mode 100644 drivers/usb/host/ohci-ssb.c
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 2fc5637..00b6fc8 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -373,10 +373,15 @@ config USB_OHCI_HCD_PCI
>   	  If unsure, say Y.
>
>   config USB_OHCI_HCD_SSB
> -	bool "OHCI support for Broadcom SSB OHCI core"
> +	bool "OHCI support for Broadcom SSB OHCI core (DEPRECATED)"
>   	depends on USB_OHCI_HCD&&  (SSB = y || SSB = USB_OHCI_HCD)&&  EXPERIMENTAL
> +	select USB_HCD_SSB
> +	select USB_OHCI_HCD_PLATFORM
>   	default n
>   	---help---
> +	  This option is deprecated now and the driver was removed, use
> +	  USB_HCD_SSB and USB_OHCI_HCD_PLATFORM instead.
> +
>   	  Support for the Sonics Silicon Backplane (SSB) attached
>   	  Broadcom USB OHCI core.

Looks fine as it helps transitioning old .config files. Should the 
select statements be mentioned in the help section, ie. 'using' iso 'use'.

Gr. AvS
