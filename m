Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 12:12:58 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3272 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491030Ab1FGKMy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Jun 2011 12:12:54 +0200
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 07 Jun 2011 03:16:29 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 7 Jun 2011 03:12:32 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 87E8C74D04; Tue, 7 Jun 2011 03:12:31 -0700 (PDT)
Received: from [192.168.1.120] (unknown [10.176.68.21]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 85A8320501; Tue, 7
 Jun 2011 03:12:29 -0700 (PDT)
Message-ID: <4DEDF98C.6020905@broadcom.com>
Date:   Tue, 7 Jun 2011 12:12:28 +0200
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     "Arnd Bergmann" <arnd@arndb.de>
cc:     "Hauke Mehrtens" <hauke@hauke-m.de>,
        "George Kashperko" <george@znau.edu.ua>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "Greg KH" <greg@kroah.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
 <201106061503.14852.arnd@arndb.de> <4DED48EA.7070001@hauke-m.de>
 <201106062353.40470.arnd@arndb.de>
In-Reply-To: <201106062353.40470.arnd@arndb.de>
X-WSS-ID: 61F325F74NS17263055-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5389

On 06/06/2011 11:53 PM, Arnd Bergmann wrote:
> On Monday 06 June 2011 23:38:50 Hauke Mehrtens wrote:
>> Accessing chip common should be possible without scanning the hole bus
>> as it is at the first position and initializing most things just needs
>> chip common. For initializing the interrupts scanning is needed as we do
>> not know where the mips core is located.
>>
>> As we can not use kalloc on early boot we could use a function which
>> uses kalloc under normal conditions and when on early boot the
>> architecture code which starts the bcma code should also provide a
>> function which returns a pointer to some memory in its text segment to
>> use. We need space for 16 cores in the architecture code.
>>
>> In addition bcma_bus_register(struct bcma_bus *bus) has to be divided
>> into two parts. The first part will scan the bus and initialize chip
>> common and mips core. The second part will initialize pci core and
>> register the devices in the system. When using this under normal
>> conditions they will be called directly after each other.
> Just split out the minimal low-level function from the bcma_bus_scan
> then, to locate a single device based on some identifier. The
> bcma_bus_scan() function can then repeatedly allocate one device
> and pass it to the low-level function when doing the proper scan,
> while the arch code calls the low-level function directly with static
> data.

If going for this we should pass struct bcma_device_id as match 
parameter as that identifies the core appropriately although you 
probably only want to match manufacturer and core identifiers.

Gr. AvS

-- 
Almost nobody dances sober, unless they happen to be insane.
-- H.P. Lovecraft --
