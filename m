Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 21:58:20 +0100 (CET)
Received: from mail-bk0-f43.google.com ([209.85.214.43]:54884 "EHLO
        mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833256Ab3A1U6TzEY6d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 21:58:19 +0100
Received: by mail-bk0-f43.google.com with SMTP id jm19so1137718bkc.16
        for <multiple recipients>; Mon, 28 Jan 2013 12:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BXSjMTm+g7uLJ/lr7XYiXGLRLv7+R8Dug3cChW+Pf4o=;
        b=LyQuvCCrm4wNcSVNKYz3uU23gIXoR+W/eXMqmfbcxYqLc4+pvHWge0T/JMY7fXg1/q
         ylhEFvBzsbDi402XfHkgdqpyDG0QrnGWoJl+PJcmU0miyFGDo6cR9UBZ8Sgg/qc0+VgB
         V9l6sRSMBWtZ1mq3i8WNk5LEw1X/S/r1DhTgcjhtRdGmcf5i4viE2h1pJofEGOzImTuR
         dYwNC6+M/4KfiXbeiMmEGk5VowZCBB0v5sg04W07tEk+Re/FRPAgWVpuCPuscGFVGIEY
         RH9bu3FDsaAKsL7wQIugxhLCYZeWEZK90LrjX3REBIuJGFrSAgFzNFE4fJivAnBZ1WWw
         72+A==
X-Received: by 10.204.9.132 with SMTP id l4mr4463413bkl.6.1359406694353;
        Mon, 28 Jan 2013 12:58:14 -0800 (PST)
Received: from ?IPv6:2a01:e35:2f70:4010:b9ce:7b43:9b76:2dfe? ([2a01:e35:2f70:4010:b9ce:7b43:9b76:2dfe])
        by mx.google.com with ESMTPS id i20sm7553291bkw.5.2013.01.28.12.58.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 12:58:13 -0800 (PST)
Message-ID: <5106E665.7020105@openwrt.org>
Date:   Mon, 28 Jan 2013 21:58:13 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, jogo@openwrt.org,
        mbizon@freebox.fr, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, blogic@openwrt.org
Subject: Re: [PATCH 11/13] USB: EHCI: add ignore_oc flag to disable overcurrent
 checking
References: <Pine.LNX.4.44L0.1301281500530.1997-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1301281500530.1997-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35602
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

Le 28/01/2013 21:08, Alan Stern a écrit :
> On Mon, 28 Jan 2013, Florian Fainelli wrote:
>
>> This patch adds an ignore_oc flag which can be set by EHCI controller
>> not supporting or wanting to disable overcurrent checking. The EHCI
>> platform data in include/linux/usb/ehci_pdriver.h is also augmented to
>> take advantage of this new flag.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
>>   drivers/usb/host/ehci-hcd.c      |    2 +-
>>   drivers/usb/host/ehci-hub.c      |    4 ++--
>>   drivers/usb/host/ehci.h          |    1 +
>>   include/linux/usb/ehci_pdriver.h |    1 +
>>   4 files changed, 5 insertions(+), 3 deletions(-)
>
> You forgot to add
>
> 	ehci->ignore_oc = pdata->ignore_oc;
>
> to ehci_platform_reset().  This makes me wonder: Either the patches
> were not tested very well or else the new ignore_oc stuff isn't needed.

ignore_oc is not actually needed for all BCM63xx boards, and mine does 
not require it, but that is clearly an oversight, thanks for spotting this.

>
>> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
>> index c97503b..bd435ac 100644
>> --- a/drivers/usb/host/ehci-hcd.c
>> +++ b/drivers/usb/host/ehci-hcd.c
>> @@ -634,7 +634,7 @@ static int ehci_run (struct usb_hcd *hcd)
>>   		"USB %x.%x started, EHCI %x.%02x%s\n",
>>   		((ehci->sbrn & 0xf0)>>4), (ehci->sbrn & 0x0f),
>>   		temp >> 8, temp & 0xff,
>> -		ignore_oc ? ", overcurrent ignored" : "");
>> +		(ignore_oc || ehci->ignore_oc) ? ", overcurrent ignored" : "");
>
> You could simplify the code here and other places if you add
>
> 	ehci->ignore_oc ||= ignore_oc;
>
> to ehci_init().  Then you wouldn't need to test ignore_oc all the time.
>
> Alan Stern
>
>
