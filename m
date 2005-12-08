Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2005 16:52:39 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:13640 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133900AbVLHQwT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Dec 2005 16:52:19 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB8Gpot26925;
	Thu, 8 Dec 2005 20:51:51 +0400
Message-ID: <439864A6.9070104@ru.mvista.com>
Date:	Thu, 08 Dec 2005 19:51:50 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Peter Popov <ppopov@embeddedalley.com>,
	David Brownell <david-b@pacbell.net>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Philips PNX8550 USB Host driver compile fix
References: <20051206193522.2582.qmail@web411.biz.mail.mud.yahoo.com>
In-Reply-To: <20051206193522.2582.qmail@web411.biz.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello Ralf, David,

Could you please advise.
What is the right solution in the situation when USB PCI and on-chip USB 
used in the situation when we want ohci-hcd to be a module?

Vladimir

Peter Popov wrote:

>I suppose the right solution is to be able to use the
>on-chip usb controller as well as an external pci
>controller. I don't think anyone will do that though.
>I have one board with an external USB controller but
>that was done in order to add usb 2.0 support, so the
>on-chip usb controller is not used. So the simple fix
>below works fine for me, but Ralf and David B. may
>have higher standards ;)
>
>Pete
>
>--- "Vladimir A. Barinov" <vbarinov@ru.mvista.com>
>wrote:
>
>  
>
>>Hello, Ralf, Pete,
>>
>>The current ohci-hcd driver is a little defective.
>>It's unable to use usb-ohci as modules in the case
>>when PCI and on-chip 
>>USB are enabled.
>>It just will not be compiled since there are two
>>calls if module_init in 
>>ohci-hcd.
>>
>>Please look at the patch attached.
>>I 'm not sure is this patch well for this situation.
>>Any suggestions are very appreciated.
>>
>>TIA,
>>Vladimir
>>
>>
>>    
>>
>>>--- linux-2.6.10.orig/drivers/usb/host/ohci-hcd.c
>>>      
>>>
>>2005-12-02 16:37:59.000000000 +0300
>>+++ linux-2.6.10/drivers/usb/host/ohci-hcd.c
>>2005-12-02 19:34:21.000000000 +0300
>>@@ -906,8 +906,12 @@ MODULE_LICENSE ("GPL");
>> #endif
>> 
>> #ifdef CONFIG_PNX8550
>>+#if defined(CONFIG_PCI) &&
>>defined(CONFIG_USB_OHCI_HCD_MODULE)
>>+#error "unable to compile PNX8550 USB and PCI USB
>>as modules simultaneously until usb hcd stack is
>>rewritten"
>>+#else
>> #include "ohci-pnx8550.c"
>> #endif
>>+#endif
>> 
>> #ifdef CONFIG_USB_OHCI_HCD_PPC_SOC
>> #include "ohci-ppc-soc.c"
>>@@ -919,6 +923,7 @@ MODULE_LICENSE ("GPL");
>>       || defined (CONFIG_ARCH_LH7A404) \
>>       || defined (CONFIG_PXA27x) \
>>       || defined (CONFIG_SOC_AU1X00) \
>>+      || defined (CONFIG_PNX8550) \
>>       || defined (CONFIG_USB_OHCI_HCD_PPC_SOC) \
>> 	)
>> #error "missing bus glue for ohci-hcd"
>>
>>    
>>
>
>
>  
>
