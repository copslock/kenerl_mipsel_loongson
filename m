Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2012 21:51:09 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46789 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903609Ab2CLUvD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2012 21:51:03 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id AF2E28F61;
        Mon, 12 Mar 2012 21:51:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HWolDuQ-qkvJ; Mon, 12 Mar 2012 21:50:49 +0100 (CET)
Received: from [192.168.1.220] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id E9C4C8F60;
        Mon, 12 Mar 2012 21:50:48 +0100 (CET)
Message-ID: <4F5E61A8.20903@hauke-m.de>
Date:   Mon, 12 Mar 2012 21:50:48 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     gregkh@linuxfoundation.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org
Subject: Re: [PATCH 6/7] USB: OHCI: remove old SSB OHCI driver
References: <Pine.LNX.4.44L0.1203121023490.1216-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1203121023490.1216-100000@iolanthe.rowland.org>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/12/2012 03:28 PM, Alan Stern wrote:
> On Sun, 11 Mar 2012, Hauke Mehrtens wrote:
> 
>> This is now replaced by the new ssb USB driver, which also supports
>> devices with an EHCI controller.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  drivers/usb/host/Kconfig    |   13 --
>>  drivers/usb/host/ohci-hcd.c |   21 +----
>>  drivers/usb/host/ohci-ssb.c |  260 -------------------------------------------
>>  3 files changed, 1 insertions(+), 293 deletions(-)
>>  delete mode 100644 drivers/usb/host/ohci-ssb.c
>>
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index eab27d5..665fb89 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -360,19 +360,6 @@ config USB_OHCI_HCD_PCI
>>  	  Enables support for PCI-bus plug-in USB controller cards.
>>  	  If unsure, say Y.
>>  
>> -config USB_OHCI_HCD_SSB
>> -	bool "OHCI support for Broadcom SSB OHCI core"
>> -	depends on USB_OHCI_HCD && (SSB = y || SSB = USB_OHCI_HCD) && EXPERIMENTAL
>> -	default n
>> -	---help---
>> -	  Support for the Sonics Silicon Backplane (SSB) attached
>> -	  Broadcom USB OHCI core.
>> -
>> -	  This device is present in some embedded devices with
>> -	  Broadcom based SSB bus.
>> -
>> -	  If unsure, say N.
>> -
> 
> I don't like the idea of removing this section entirely.  It will leave 
> people wondering what happened to their driver.
> 
> Instead, for the next few kernel releases, how about leaving this
> section in place and causing it to select USB_OHCI_HCD_PLATFORM?  Maybe 
> also add a line to the help section explaining that from now on, this 
> driver has been replaced by the generic OHCI platform driver.
> 
> And likewise for the SSB EHCI driver, of course.

That sounds good, I will change that.

Hauke
