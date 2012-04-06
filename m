Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2012 20:13:21 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:37691 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904086Ab2DFSNP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2012 20:13:15 +0200
Received: by bkcjk13 with SMTP id jk13so2949669bkc.36
        for <linux-mips@linux-mips.org>; Fri, 06 Apr 2012 11:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=rg4SKF/yt8zjjBHfj/VYrFfi1lEVWnJtwd10m9otpVA=;
        b=BM6gLW5DjHup7SdU7aQ309CxzoICxWKbZruEca/bsmkZZB1Z+g2dn73YuYgjNSSvXq
         5yzkRrojbtJeXTxPBM0BN7MQXAUSvSFtl8xzaa/kE6zWKEHQ7nOUrhBtnpR49Wnd5sA5
         6oiU8/ozfHbVE6NlV6/dvFE3evjeNiSGsMA/8hi8v5O22KVJOgqrvWUxEWcTCw96+twB
         7xhQmflLA7cNhrfUUamvgAfnqH1EhrG4H91tSkiNmOZDBEIp1o2L13t1rsH0pqHCSp8h
         KwVqIVXXAtvw0M30ZmE312U8sF0fgu9RKGEHhrJmQxbe+DUS1tGyihy5+eOzy/DfJGWs
         6/RA==
Received: by 10.204.128.152 with SMTP id k24mr3129290bks.127.1333735990114;
        Fri, 06 Apr 2012 11:13:10 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id iv11sm11325196bkc.16.2012.04.06.11.13.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 11:13:09 -0700 (PDT)
Message-ID: <4F7F31F9.7030706@mvista.com>
Date:   Fri, 06 Apr 2012 22:12:09 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        sjhill@realitydiluted.com
Subject: Re: [PATCH 4/5] MIPS: Malta PCI changes for PCI 2.1 compatibility
 and conflicts.
References: <1333735183-15796-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1333735183-15796-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnpUAjp+QnNrqD3nECH4TGPyk6H9SPtYYRTLgiRyg/HZSvqLJwEisnogOG8tR971JLsOOLn
X-archive-position: 32873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 04/06/2012 09:59 PM, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> Turns on PCI 2.1 compatibility for the Malta platform for the
> PIIX4 controller. Change start address to avoid conflicts with
> the ACPI and SMB devices.

> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
[...]
> diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
> index b7f37d4..5f7d113 100644
> --- a/arch/mips/mti-malta/malta-setup.c
> +++ b/arch/mips/mti-malta/malta-setup.c
> @@ -222,3 +222,14 @@ void __init plat_mem_setup(void)
>   	board_be_init = malta_be_init;
>   	board_be_handler = malta_be_handler;
>   }
> +/* Enable PCI 2.1 compatibility in PIIX4 */
> +static void __init quirk_dlcsetup(struct pci_dev *dev)
> +{
> +	u8 odlc, ndlc;

    You don't need two variables. And please add an empty line after declaration 
block.

> +	(void) pci_read_config_byte(dev, 0x82,&odlc);
> +	/* Enable passive releases and delayed transaction */
> +	ndlc = odlc | 7;
> +	(void) pci_write_config_byte(dev, 0x82, ndlc);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
> +		quirk_dlcsetup);

WBR, Sergei
