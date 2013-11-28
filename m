Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2013 13:45:25 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:39548 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819765Ab3K1MpWeE4u2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Nov 2013 13:45:22 +0100
Received: by mail-ob0-f169.google.com with SMTP id wm4so8878019obc.0
        for <multiple recipients>; Thu, 28 Nov 2013 04:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1C1rzR7b0Po5RVuB9WTocRiDXpz8dClHtL7FCMskSqk=;
        b=FmHCxy1LdJSE+SPPcUYqAmDv6+3zEF1b4B7A1sCrv58B9Zhlw0j4Tp8hiy1/4ZlFDk
         1BLYpsxMRY+3T30shGwhWdMDFZXBwTW6Sjnv5RQ+AcSTgotrxu969U6DnxCpauf+TfbY
         h+U4vpgd8ILB5vRmZFbxsByqMDrFJUDmVWJGHUcwHCcuOvaXXn+9I38zDFf9k0Cvk7OW
         1mwegRhOnvMx+qtyYEjxju153YCkZhCkXPBfyC+1K8G5LfntbhWxraJGpa+bqM1x25DG
         HZQnPes4iFZTJgVR+SgdHmCDqrUKF1lOh8RqEoVAuJWEKTg5ttaK3m0PyWLWMmANERsE
         L+Ew==
MIME-Version: 1.0
X-Received: by 10.182.22.18 with SMTP id z18mr19221156obe.42.1385642716076;
 Thu, 28 Nov 2013 04:45:16 -0800 (PST)
Received: by 10.76.73.8 with HTTP; Thu, 28 Nov 2013 04:45:16 -0800 (PST)
In-Reply-To: <5297353B.1000007@hauke-m.de>
References: <1385634758-22723-1-git-send-email-zajec5@gmail.com>
        <5297353B.1000007@hauke-m.de>
Date:   Thu, 28 Nov 2013 13:45:16 +0100
Message-ID: <CACna6rxYZmBxtA9x5eTKUUXTCbGpLjKtSRCGmsMPeq9SdcnSrg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Prepare support for GPIO buttons
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

2013/11/28 Hauke Mehrtens <hauke@hauke-m.de>:
> On 11/28/2013 11:32 AM, Rafał Miłecki wrote:
>> So far this adds support for one Netgear model only, but it's designed
>> and ready to add many more device. We could hopefully import database
>> from OpenWrt.
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>> This should apply cleanly on top of (still not pushed):
>> MIPS: BCM47XX: Prepare support for LEDs
>> ---
>
> It would be nice if include/linux/gpio_keys.h is used for that, but I
> know the generic gpio system does not provide enough functionality to do
> so with this gpio controller.
>
> Have you tried to extend the gpio system to make this possible?

I tried that, but I hit few issues:

1) Different IRQ flags:
genirq: Flags mismatch irq 2. 00000080 (serial) vs. 00000083 (gpio_keys)
(that could be workarounded with some way of passing flags to the
serial of gpio_keys).

2) gpio_keys generic interrupt handler
It was only scheduling work that didn't start until releasing the
button. By then GPIO value was back to "normal" and keypress wasn't
detected at all.

3) interrupt polarity
(It's related to the 2nd). We need to adjust IRQ polarity to stop HW
from generating IRQs all the time and to get a next IRQ on button
release.

Do you have any other ideas for above?


> As far as I read your comment your are getting an interrupt till you
> change the polarity?

Yes. But I change polarity immediately and as the result I get only 1
IRQ for key press and 1 IRQ for key release.
Works perfectly, as expected.
