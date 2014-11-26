Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 17:08:15 +0100 (CET)
Received: from mail-qg0-f42.google.com ([209.85.192.42]:45158 "EHLO
        mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006967AbaKZQIOQBSPS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 17:08:14 +0100
Received: by mail-qg0-f42.google.com with SMTP id z107so2285587qgd.29
        for <linux-mips@linux-mips.org>; Wed, 26 Nov 2014 08:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NHzQ+VSCpDLz8n7r2izm9Az9XX69ZK3YKeBZ5p0xyWM=;
        b=whfeyiZXfzWedFzcpwHt54h4aHt+/c/NgickZBgLbZnM2OlET32VgyVPwWPQpAZcTD
         gUqnboWk5srObJ5h8SWTSRCt8MlFXNulrdtlin3tE5L0qwwOmBrzXezZXIEeFTlESTNP
         o9c5WoOLW98A/GRX8LRVsnfy2bHBXrjHAK2P8EvrRaH0xQw6iJl3wmgyy6TdhqLL2He2
         9gzQVG+HDuyDWwGMFunOiHd/DGu8jPNaiU0cDqifeHC697kGXNVHJ/IFscvdVHtRu0jf
         BXkfoqwTeBFWxpfIFv+ysiyULoRiADvSN9rHnqSDpVbbqzEXjxYoh3Q1e27Xe1qMMtyy
         XKoA==
X-Received: by 10.224.80.71 with SMTP id s7mr45171818qak.35.1417018083688;
 Wed, 26 Nov 2014 08:08:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 26 Nov 2014 08:07:43 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1411261013340.1322-100000@iolanthe.rowland.org>
References: <1416962994-27095-10-git-send-email-cernekee@gmail.com> <Pine.LNX.4.44L0.1411261013340.1322-100000@iolanthe.rowland.org>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 26 Nov 2014 08:07:43 -0800
Message-ID: <CAJiQ=7CuLA2vDpnkDysBU100R0uuUidB_ua3sZdV74vNPjV76w@mail.gmail.com>
Subject: Re: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian
 helper function
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux@prisktech.co.nz,
        Greg KH <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Grant Likely <grant.likely@linaro.org>, robh+dt@kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Marc C <marc.ceeeee@gmail.com>, linux-pm@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, Nov 26, 2014 at 7:14 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> index 43c1a4e..9505c31 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> @@ -12,6 +12,8 @@ Optional properties:
>>   - big-endian-regs : boolean, set this for hcds with big-endian registers
>>   - big-endian-desc : boolean, set this for hcds with big-endian descriptors
>>   - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
>> + - native-endian : boolean, enables big-endian-regs + big-endian-desc
>> +   iff the kernel was compiled for big endian
>
> Is this really a property of the hardware?  It appears to depend on the
> kernel configuration.  As such, is it appropriate for DT?

Yes, the peripheral registers automatically adjust their endianness to
match the CPU.  So if the CPU is running an LE kernel, the peripheral
needs to be accessed in LE mode; if the CPU is running a BE kernel,
the peripheral needs to be accessed in BE mode.
