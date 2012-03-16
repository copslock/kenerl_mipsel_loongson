Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2012 16:36:03 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36672 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903689Ab2CPPgA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Mar 2012 16:36:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 577348F61;
        Fri, 16 Mar 2012 16:35:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zg7ploNB+Jy6; Fri, 16 Mar 2012 16:35:45 +0100 (CET)
Received: from [134.102.24.159] (eduroam-pool6-0159.wlan.uni-bremen.de [134.102.24.159])
        by hauke-m.de (Postfix) with ESMTPSA id BD59F8F60;
        Fri, 16 Mar 2012 16:35:44 +0100 (CET)
Message-ID: <4F635DCF.7060101@hauke-m.de>
Date:   Fri, 16 Mar 2012 16:35:43 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
MIME-Version: 1.0
To:     Arend van Spriel <arend@broadcom.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "m@bues.ch" <m@bues.ch>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "zajec5@gmail.com" <zajec5@gmail.com>
Subject: Re: [PATCH v5 4/4] USB: OHCI: remove old SSB OHCI driver
References: <1331851799-5968-1-git-send-email-hauke@hauke-m.de> <1331851799-5968-5-git-send-email-hauke@hauke-m.de> <4F630267.5050909@broadcom.com>
In-Reply-To: <4F630267.5050909@broadcom.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/16/2012 10:05 AM, Arend van Spriel wrote:
> On 03/15/2012 11:49 PM, Hauke Mehrtens wrote:
>> This is now replaced by the new ssb USB driver, which also supports
>> devices with an EHCI controller.
>>
>> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
>> ---
>>   drivers/usb/host/Kconfig    |    7 +-
>>   drivers/usb/host/ohci-hcd.c |   21 +----
>>   drivers/usb/host/ohci-ssb.c |  260
>> -------------------------------------------
>>   3 files changed, 7 insertions(+), 281 deletions(-)
>>   delete mode 100644 drivers/usb/host/ohci-ssb.c
>>
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 2fc5637..00b6fc8 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -373,10 +373,15 @@ config USB_OHCI_HCD_PCI
>>         If unsure, say Y.
>>
>>   config USB_OHCI_HCD_SSB
>> -    bool "OHCI support for Broadcom SSB OHCI core"
>> +    bool "OHCI support for Broadcom SSB OHCI core (DEPRECATED)"
>>       depends on USB_OHCI_HCD&&  (SSB = y || SSB = USB_OHCI_HCD)&& 
>> EXPERIMENTAL
>> +    select USB_HCD_SSB
>> +    select USB_OHCI_HCD_PLATFORM
>>       default n
>>       ---help---
>> +      This option is deprecated now and the driver was removed, use
>> +      USB_HCD_SSB and USB_OHCI_HCD_PLATFORM instead.
>> +
>>         Support for the Sonics Silicon Backplane (SSB) attached
>>         Broadcom USB OHCI core.
> 
> Looks fine as it helps transitioning old .config files. Should the
> select statements be mentioned in the help section, ie. 'using' iso 'use'.

I think "use" is better as USB_OHCI_HCD_SSB will be removed in some time
and it should not be used any more. If someone generated the config or a
base config with some other script it should be changed to USB_HCD_SSB
and USB_OHCI_HCD_PLATFORM.

Hauke

Hauke
