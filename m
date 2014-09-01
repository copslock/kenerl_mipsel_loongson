Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2014 09:48:55 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63960 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007766AbaIAHsyn-pvo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Sep 2014 09:48:54 +0200
Received: by mail-ie0-f177.google.com with SMTP id tp5so5690888ieb.22
        for <linux-mips@linux-mips.org>; Mon, 01 Sep 2014 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HzuuQZQmWh0lYHJUsPC97wg//HjN9Sa5Eh34AdVPGk4=;
        b=F3s4/zzJu6n/moxIko43UT7aP+hQo3N/fSALUKTQPn4xSpeaPRNxJbGS7HvNYrsjKM
         HZCVdR47z6ijhoWKg3z2sxHM2KrWXnqjNeQNUabGqB4caHNM9IJg9lRnx5vHgoNqvoVv
         wcGfWShsMa6Wx3qvjWK8uyjRxZx66q3vw25FoCJ9NahtgGsqFYUc25FF9ceOqecbfYd/
         hLzqhXBsttAN9nZLbIV+FDf6z9zh6+mMl4cbIAdMNkW56Ql6EAJ8OHJCa9Whi/roiFJs
         BohapM+xWFsDLOGcijLnEBmBVMtFil8oHEBx+OWSuv/9GtvjGqZUIZBOcA5YkzCrK7bH
         q2Wg==
MIME-Version: 1.0
X-Received: by 10.42.107.145 with SMTP id d17mr707595icp.61.1409557728548;
 Mon, 01 Sep 2014 00:48:48 -0700 (PDT)
Received: by 10.107.10.133 with HTTP; Mon, 1 Sep 2014 00:48:48 -0700 (PDT)
In-Reply-To: <CACna6rwmNtS1JSi=VHXWHu6mOM72Y8sBrr5EqCRbpYUHFrMnCg@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
        <53FF9D9B.30106@hauke-m.de>
        <CACna6rzaXHww2UXoP4Fi-zA3uNve4NQ48DeChF8zoBS-_-mtyw@mail.gmail.com>
        <5882203.GXbhhcHqjK@wuerfel>
        <CACna6rwmNtS1JSi=VHXWHu6mOM72Y8sBrr5EqCRbpYUHFrMnCg@mail.gmail.com>
Date:   Mon, 1 Sep 2014 09:48:48 +0200
Message-ID: <CACna6rwMovK133ZoFYsLcsnH39umU7=UAoyG6jmgM8ZVq0AYRA@mail.gmail.com>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42354
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

On 31 August 2014 11:20, Rafał Miłecki <zajec5@gmail.com> wrote:
> On 29 August 2014 22:04, Arnd Bergmann <arnd@arndb.de> wrote:
>> You mentioned that the 'boot_device' variable in your code snippet
>> comes from a hardware register that can be accessed easily, right?
>> A possible way to handle it would then be to have two DT entries
>> like
>>
>>         nvram@1c000000 {
>>                 compatible = "bcm,bcm4710-nvram";
>>                 reg = <0x1c000000 0x1000000>;
>>                 bcm,boot-device = BCMA_BOOT_DEV_NAND;
>>         };
>>
>>         nvram@1c000000 {
>>                 compatible = "bcm,bcm4710-nvram";
>>                 reg = <0x1e000000 0x1000000>;
>>                 bcm,boot-device = BCMA_BOOT_DEV_SERIAL;
>>         };
>
> This sounds like a nice consensus for me! Actually it seems to be
> similar to what we already do for other hardware parts.
>
> E.g. in bcm4708.dtsi Hauke put registers location of 4 Ethernet cores
> (gmac@0, gmac@1, gmac@2, gmac@3). I believe this board is ready for 4
> Ethernet cores so DT matches hardware capabilities. Then most vendors
> use/activate only one (maybe up to 2?) Ethernet cores. It's up to the
> driver to detect if core is activated/used.
>
> AFAIU having two flash mappings (as suggested above) would follow this
> logic. It would match hardware capabilities. And then it would be up
> to driver to detect which one mapping is really in use for this
> particular board.
>
> Does it make sense?

I've just realized something. When Broadcom's code reads NVRAM content
it uses "hndnand_checkbadb" to skip bad blocks. It seems NVRAM doesn't
lay in 100% reliable flash sectors.

Above function comes from shared/ which (the directory) provides tons
of low level stuff without using any kernel API. OFC it won't be
acceptable for us to implement low level NAND stuff in the nvram
driver (this would mean duplicating NAND driver code). It seems we
won't be able to use NAND flash mapping to the memory (this magic
0x1c000000) at all...

So I think we'll need to change our vision of flash access in
bcm74xx_nvram driver. I guess we will have to:
1) Register NAND core early
2) Initialize NAND driver
3) Use mtd/nand API in bcm47xx_nvram

-- 
Rafał
