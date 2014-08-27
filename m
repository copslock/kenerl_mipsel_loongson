Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 20:21:22 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:47420 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007087AbaH0SVV034AM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 20:21:21 +0200
Received: by mail-oa0-f53.google.com with SMTP id m19so114413oag.12
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=h1ML/i9g9R8qeSboMcnXdsAO3NRn5eHJ4Ukx9xt4zf0=;
        b=g/EAhJhv+IjUd0oFcjkR3PjZQkLNMUNmNrrxSC+nyEikjgb2xaiRvqpK2Je1HaWIp2
         wW1BchKLh10Kw2EM9K+EJKUzoHcywEgimshRFkCbPi8mADvlQkAyWM/SXUVx+hjMM+W8
         BkleMdccW+3pMFqbnQ7w/QZg+EHPx8686QBPrEWb6ohJKr4E5yJUbzv5r6ndS1ehyDsp
         DroqAlQcGYr4PCPI35tcydhbuBTedlbaB8QrPVSXm9r0Fb0bedBkV/fA/VcheLmLEX7J
         0qiqMeHrRWAUvjke5S2Zs0SqhBer99bpKPkn2DuEbUgMi2sSqKZoWIPErTDtm7Drfbkx
         GGng==
X-Received: by 10.60.98.105 with SMTP id eh9mr3650304oeb.56.1409163675128;
        Wed, 27 Aug 2014 11:21:15 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id fg2sm1273656obb.16.2014.08.27.11.21.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Aug 2014 11:21:14 -0700 (PDT)
Message-ID: <53FE217B.7000401@gmail.com>
Date:   Wed, 27 Aug 2014 11:20:43 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
CC:     devicetree@vger.kernel.org,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [RFC 2/7] bcm47xx-nvram: add new broadcom nvram driver with dt
 support
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de> <1408915485-8078-4-git-send-email-hauke@hauke-m.de> <CACna6rwJBDpg9VS4h5hfP4wtGRVwAdRUq5mELeA0OFWWzH9jsA@mail.gmail.com>
In-Reply-To: <CACna6rwJBDpg9VS4h5hfP4wtGRVwAdRUq5mELeA0OFWWzH9jsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42282
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

On 08/26/2014 10:54 PM, Rafał Miłecki wrote:
> On 24 August 2014 23:24, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> +On NorthStar ARM SoCs the NAND flash is available at 0x1c000000 and the
>> +NOR flash is at 0x1e000000
>> +
>> +Example:
>> +
>> +nvram0: nvram@0 {
>> +       compatible = "brcm,bcm47xx-nvram";
>> +       reg = <0x1c000000 0x01000000>;
>> +};
> 
> Could we avoid that? Type of flash can easily be checked in the code.
> All we need to do is to read BCMA_IOST register of BCMA_CORE_NS_ROM
> core.

So there is a boot status register you can read to tell what type of
flash you booted from, but does that also give you the resource ranges
for these type of flashes? Presumably they will be mapped into different
addresses (at least bcm63xx is like that), that information needs to be
listed somewhere.
--
Florian
