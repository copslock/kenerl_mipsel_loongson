Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 17:02:09 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:38947 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006715AbaHYPCHJ6kdu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 17:02:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id EF97D28088F
        for <linux-mips@linux-mips.org>; Mon, 25 Aug 2014 17:01:50 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com [209.85.216.178])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 507DA28AD6F
        for <linux-mips@linux-mips.org>; Mon, 25 Aug 2014 17:01:38 +0200 (CEST)
Received: by mail-qc0-f178.google.com with SMTP id x3so14126843qcv.9
        for <linux-mips@linux-mips.org>; Mon, 25 Aug 2014 08:01:47 -0700 (PDT)
X-Received: by 10.140.83.242 with SMTP id j105mr33890304qgd.38.1408978907631;
 Mon, 25 Aug 2014 08:01:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.244 with HTTP; Mon, 25 Aug 2014 08:01:27 -0700 (PDT)
In-Reply-To: <8344390.rjnOcYBCET@wuerfel>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
 <1408915485-8078-5-git-send-email-hauke@hauke-m.de> <8344390.rjnOcYBCET@wuerfel>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 25 Aug 2014 17:01:27 +0200
Message-ID: <CAOiHx=kcnZqkUxTc64oWWnyet2wXZe+3A1Lt2C5kvjgVjgwcVw@mail.gmail.com>
Subject: Re: [RFC 3/7] bcm47xx-sprom: add Broadcom sprom parser driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Mon, Aug 25, 2014 at 9:52 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 24 August 2014 23:24:41 Hauke Mehrtens wrote:
>> This driver needs an nvram driver and fetches the sprom values from the
>> nvram and provides it to any other driver. The calibration data for the
>> wifi chip the mac address and some more board description data is
>> stores in the sprom.
>>
>> This is based on a copy of arch/mips/bcm47xx/sprom.c and my plan is to
>> make the bcm47xx MIPS SoCs also use this driver some time later.
>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/misc/bcm47xx-sprom.txt     |  16 +
>
> I'd prefer not to list the binding in a 'misc' category. Maybe we can
> have a new category and move the misc/sram.txt into the same?
>
>>  drivers/misc/Kconfig                               |  14 +
>>  drivers/misc/Makefile                              |   1 +
>>  drivers/misc/bcm47xx-sprom.c                       | 690 +++++++++++++++++++++
>
> On a similar note, putting the driver into drivers/misc seems
> suboptimal: misc drivers should by definition be something that
> is for some odd hardware with no external dependencies on it,
> whereas your driver seems to be used by multiple other drivers.
>
> Would it make sense to put it into drivers/bcma when that is the
> only bus it is used on?

If the driver will be used for bcm47xx/mips, it will be used for two
busses, bcma and ssb, so it will need to be at a common
location.


Jonas
