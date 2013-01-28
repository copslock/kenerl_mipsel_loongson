Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:57:04 +0100 (CET)
Received: from mail-bk0-f48.google.com ([209.85.214.48]:60116 "EHLO
        mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833259Ab3A1T5DYRPts (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 20:57:03 +0100
Received: by mail-bk0-f48.google.com with SMTP id jf20so918630bkc.21
        for <multiple recipients>; Mon, 28 Jan 2013 11:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=oF6WfYqIVLU3JscQaRj44ZQ8Ce1/tWOUfmTd2rns/w0=;
        b=SZTV3e6WxbbgsKWA94JRP0qn07M3GvAPkUqNqcb9WWIHH4NnF35t4DaAvvEkoPp5fV
         1yHPT2cKaN5LXOk47FDxKy6RmeOXyYcuZ0LBAVYV9QhQ7ZUAmoLBRDUDZprovU+dMGDP
         joAB7n8ppgWWC7wz1Ra4WdA8Jq7EUHXjLsfLYGPXPexwoBTN6gVZpdRgMO2v3ioKjfML
         NIckSzIQ1l7kOsiqoll96a+/l0bz9542YzFgmEAMvwauuPXpWCC8N6TaxsuOoM3eDEVq
         eAhvlSP7rVYWK68kzQUroBzQmauXVngJW5uP2JqQ7/XCo9LAnFfRwBzZjcUuGTO71Xcm
         0eqA==
X-Received: by 10.204.3.211 with SMTP id 19mr4264344bko.99.1359403017910;
        Mon, 28 Jan 2013 11:56:57 -0800 (PST)
Received: from ?IPv6:2a01:e35:2f70:4010:b9ce:7b43:9b76:2dfe? ([2a01:e35:2f70:4010:b9ce:7b43:9b76:2dfe])
        by mx.google.com with ESMTPS id gm14sm2394248bkc.7.2013.01.28.11.56.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 11:56:57 -0800 (PST)
Message-ID: <5106D80C.7050508@openwrt.org>
Date:   Mon, 28 Jan 2013 20:57:00 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        blogic@openwrt.org
Subject: Re: [PATCH 08/13] MIPS: BCM63XX: introduce BCM63XX_EHCI configuration
 symbol
References: <1359399991-2236-1-git-send-email-florian@openwrt.org> <1359399991-2236-9-git-send-email-florian@openwrt.org> <5106D187.80600@gmail.com>
In-Reply-To: <5106D187.80600@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Le 28/01/2013 20:29, David Daney a écrit :
> On 01/28/2013 11:06 AM, Florian Fainelli wrote:
>> This configuration symbol can be used by CPUs supporting the on-chip
>> EHCI controller, and ensures that all relevant EHCI-related
>> configuration options are selected. So far BCM6328, BCM6358 and BCM6368
>> have an EHCI controller and do select this symbol. Update
>> drivers/usb/host/Kconfig with BCM63XX to update direct unmet
>> dependencies.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
>>   arch/mips/bcm63xx/Kconfig |    9 +++++++++
>>   drivers/usb/host/Kconfig  |    5 +++--
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
>> index 23b1ffd..b899359 100644
>> --- a/arch/mips/bcm63xx/Kconfig
>> +++ b/arch/mips/bcm63xx/Kconfig
>> @@ -7,10 +7,17 @@ config BCM63XX_OHCI
>>       select USB_OHCI_BIG_ENDIAN_DESC if USB_OHCI_HCD
>>       select USB_OHCI_BIG_ENDIAN_MMIO if USB_OHCI_HCD
>>
>> +config BCM63XX_EHCI
>> +    bool
>> +    select USB_ARCH_HAS_EHCI
>> +    select USB_EHCI_BIG_ENDIAN_DESC if USB_EHCI_HCD
>> +    select USB_EHCI_BIG_ENDIAN_MMIO if USB_EHCI_HCD
>> +
>>   config BCM63XX_CPU_6328
>>       bool "support 6328 CPU"
>>       select HW_HAS_PCI
>>       select BCM63XX_OHCI
>> +    select BCM63XX_EHCI
> [...]
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index d6bb128..e16b2cb 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -115,14 +115,15 @@ config USB_EHCI_BIG_ENDIAN_MMIO
>>       depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || \
>>                       ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
>>                       PPC_MPC512x || CPU_CAVIUM_OCTEON || \
>> -                    PMC_MSP || SPARC_LEON || MIPS_SEAD3)
>> +                    PMC_MSP || SPARC_LEON || MIPS_SEAD3 || \
>> +                    BCM63XX)
>>       default y
>
> This is a complete mess.
>
> Can we get rid of the 'default y' and all those things after the '&&',
> and select USB_EHCI_BIG_ENDIAN_MMIO in the board Kconfig files?

Yes, pretty much like what exists for OHCI, scales much better.

>
> I am as guilty as anyone here (see || CPU_CAVIUM_OCTEON above).  But
> this doesn't seem sustainable.  We should be trying to keep the
> configuration information for all this in one spot.
>
> Now you have it spread across two files.  One to enable it, and the
> other to select it.  But do you really need to select it if it defaults
> to 'y'

I do agree with you, but I don't want this patchset to be blocked by the 
removal of the depends on (FOO && BAR && ...), but I can send a 
preliminary patch for this and get it merged with Greg's tree first.

>
>
>>
>>   config USB_EHCI_BIG_ENDIAN_DESC
>>       bool
>>       depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX ||
>> XPS_USB_HCD_XILINX || \
>>                       PPC_MPC512x || PMC_MSP || SPARC_LEON || \
>> -                    MIPS_SEAD3)
>> +                    MIPS_SEAD3 || BCM63XX)
>>       default y
>>
>
>
> Same here.
>
> Thanks,
> David (on a mission against Kconfig insanity) Daney
>
>
