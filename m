Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 18:34:31 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:37938 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013753AbaKNReaCH5lI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2014 18:34:30 +0100
Received: by mail-pd0-f172.google.com with SMTP id r10so17072838pdi.17
        for <linux-mips@linux-mips.org>; Fri, 14 Nov 2014 09:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bf5y9WHzqZBWqK+FfN4bJQa3KigFE1cMnzJ2TWSWsWk=;
        b=Xelvo/iLw82DDAooeReE602sPRY4c5bbggSJq3dxVz/K/FOEOoyFnT+iKXGq4dYUBc
         kzodsHWC2UkjCSFOFenos2ohjkYBhdhJC2wC096yA47BjYAQPwlubaDloG48IltCLHEX
         Av4IEabZopcNOGPk9ypKxPTLcxSZh+LNnwZ/pcPNO4JAG7dkPaD8/w2LFz86JC+wQyhs
         Uu2wCvdMDtEAL/lI940WJyF1qM8iL+F4D5iKRANpwbG8dcCp3XMkc2OlsfxJf1JpsgOB
         0GTiqU0SmdOlm8adOzpvObTYfZlVtmhC8Xk7dpF4qlk1SATpSXuYBykcwDcsx0n7kw0p
         Jhrg==
X-Received: by 10.66.218.42 with SMTP id pd10mr4109944pac.151.1415986464010;
        Fri, 14 Nov 2014 09:34:24 -0800 (PST)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ty8sm28219513pab.26.2014.11.14.09.34.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2014 09:34:23 -0800 (PST)
Message-ID: <54663D1A.8080305@gmail.com>
Date:   Fri, 14 Nov 2014 09:34:18 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
CC:     David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 3/3] USB: host: Introduce flag to enable use of 64-bit
 dma_mask for ehci-platform
References: <Pine.LNX.4.44L0.1411141020490.1043-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1411141020490.1043-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 11/14/2014 07:23 AM, Alan Stern wrote:
> On Fri, 14 Nov 2014, Andreas Herrmann wrote:
> 
>> On Thu, Nov 13, 2014 at 08:44:17PM -0800, Florian Fainelli wrote:
>>> 2014-11-13 13:36 GMT-08:00 Andreas Herrmann
>>> <andreas.herrmann@caviumnetworks.com>:
>>>> ehci-octeon driver used a 64-bit dma_mask. With removal of ehci-octeon
>>>> and usage of ehci-platform ehci dma_mask is now limited to 32 bits
>>>> (coerced in ehci_platform_probe).
>>>>
>>>> Provide a flag in ehci platform data to allow use of 64 bits for
>>>> dma_mask.
>>>
>>> Why not just allow enforcing an arbitrary DMA mask?
>>
>> I thought about that but as it's currently just 32 or 64 bits
>> a flag is sufficient. (At the moment I am not aware that
>> other ehci-platform devices would require something else.)
>>
>> I'll change the flag to a mask if desired.
>> Alan, what's your opinion about this?
> 
> I'm not aware of any devices that need a different DMA mask either.  
> 
> Florian, do you have any reason for thinking such a thing might come 
> along?  Like Andreas, I don't mind making it more general if there's a 
> good reason to do so.

I don't have a specific platform I am thinking about, just that while we
are there allowing a dma_mask to be specified, I would rather pass an
u64 that covers all possible cases.

Thanks!
--
Florian
