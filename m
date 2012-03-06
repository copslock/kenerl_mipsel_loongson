Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 14:28:13 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1978 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903668Ab2CFN2G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2012 14:28:06 +0100
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 06 Mar 2012 05:37:10 -0800
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 6 Mar 2012 05:27:33 -0800
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 F3B92BC394; Tue, 6 Mar 2012 05:27:32 -0800 (PST)
Received: from [10.0.2.15] (unknown [10.176.68.152]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 1585C207C0; Tue, 6
 Mar 2012 05:27:30 -0800 (PST)
Message-ID: <4F5610C2.3030101@broadcom.com>
Date:   Tue, 6 Mar 2012 14:27:30 +0100
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216
 Thunderbird/10.0.2
MIME-Version: 1.0
To:     "Hauke Mehrtens" <hauke@hauke-m.de>
cc:     "linville@tuxdriver.com" <linville@tuxdriver.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "m@bues.ch" <m@bues.ch>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH v2 07/11] bcma: add support for sprom not found on
 the device
References: <1330386974-4056-1-git-send-email-hauke@hauke-m.de>
 <1330386974-4056-8-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1330386974-4056-8-git-send-email-hauke@hauke-m.de>
X-WSS-ID: 6348CC8C4GW1029987-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/28/2012 12:56 AM, Hauke Mehrtens wrote:
>   	if (!bus->drv_cc.core)
>   		return -EOPNOTSUPP;
>
> -	if (!(bus->drv_cc.capabilities&  BCMA_CC_CAP_SPROM))
> -		return -ENOENT;
> -
> -	if (bus->drv_cc.core->id.rev>= 32) {
> -		sromctrl = bcma_read32(bus->drv_cc.core, BCMA_CC_SROM_CONTROL);
> -		if (!(sromctrl&  BCMA_CC_SROM_CONTROL_PRESENT))
> -			return -ENOENT;
> +	if (!bcma_is_sprom_available(bus)) {
> +		/*
> +		 * Maybe there is no SPROM on the device?
> +		 * Now we ask the arch code if there is some sprom
> +		 * available for this device in some other storage.
> +		 */
> +		err = bcma_fill_sprom_with_fallback(bus,&bus->sprom);
> +		if (err) {
> +			pr_warn("Using fallback SPROM failed (err %d)\n", err);

Hi Hauke,

I just noticed in this patch that the code continues when sprom fallback 
fails. Does that make sense? I have corrected it in my OTP patch. So if 
you agree or disagree you can comment on that patch.

> +		} else {
> +			pr_debug("Using SPROM revision %d provided by"
> +				 " platform.\n", bus->sprom.revision);
> +			return 0;
> +		}
>   	}
>
>   	sprom = kcalloc(SSB_SPROMSIZE_WORDS_R4, sizeof(u16),

Gr. AvS
