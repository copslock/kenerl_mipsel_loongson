Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 17:56:23 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34235 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026572AbbEHP4ViFyAE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 May 2015 17:56:21 +0200
Received: by pdbqa5 with SMTP id qa5so86503275pdb.1;
        Fri, 08 May 2015 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0mGmWafFsrWmiJoY/DqSSa0Xe4eSiDsxegWQUjJgiwE=;
        b=GVl9+Aw01d1Hm1JBPZEkL/fWUKcN7ffDZJ6qZ4454BGYFESmle7vK140X3jR1UVjxj
         1sxYWiGI1hoBbAAAbL0wPenL1jPyx2hmi1vXBdzywvS2b2GFiT4a44bd+dGUbaFQJltf
         rfT1UZH2c7S+t39HxIi0Jqld7XmzWHdyBdospi5j58hI4AEevKLDNe0Rp0lSeC3gvcuv
         kTs/NalmDtX275/PiWCFB1MYExalprTGImn5cssct0lIIabqoJ9CLnm3MPtUtCCHd4Lh
         1b1n82r1zFTNsP9HJHfvZq5nM+YEsaeIy6vvP9WlwtzUMJqN7/F8sRRmZjL5C1w27qrJ
         RHdQ==
X-Received: by 10.69.1.3 with SMTP id bc3mr7648803pbd.36.1431100513458;
        Fri, 08 May 2015 08:55:13 -0700 (PDT)
Received: from [192.168.0.106] ([59.12.167.210])
        by mx.google.com with ESMTPSA id al13sm5616152pac.23.2015.05.08.08.55.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 May 2015 08:55:12 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 1/2] MIPS: BMIPS: dts: remove unsupported entry for bcm7362
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CAJiQ=7CQshXhGJ7ftWQSu_UxgKVaRprZPEPXWNP6ci_1bLrJrw@mail.gmail.com>
Date:   Sat, 9 May 2015 00:55:07 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BABEE235-D7C4-4897-B3ED-778A5FB7F538@gmail.com>
References: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com> <1431089958-2626-2-git-send-email-jaedon.shin@gmail.com> <CAJiQ=7CQshXhGJ7ftWQSu_UxgKVaRprZPEPXWNP6ci_1bLrJrw@mail.gmail.com>
To:     Kevin Cernekee <cernekee@gmail.com>
X-Mailer: Apple Mail (2.2098)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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


> On May 8, 2015, at 11:40 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> 
> On Fri, May 8, 2015 at 5:59 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> Remove unsupported memory entry for the bcm7362 platform. The BMIPS4380
>> processor only supports ZONE_NORMAL is not available for HIGHMEM.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> arch/mips/boot/dts/brcm/bcm97362svmb.dts | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> index b7b88e5dc9e7..ab8b01fa7dcf 100644
>> --- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> +++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> @@ -8,7 +8,7 @@
>> 
>>        memory@0 {
>>                device_type = "memory";
>> -               reg = <0x00000000 0x10000000>, <0x20000000 0x30000000>;
>> +               reg = <0x00000000 0x10000000>;
> 
> Hmm, this is more of a kernel limitation than a hardware limitation,
> though.  The board physically has 1GB of memory, right?  It is best if
> the DT entry reflects the actual hardware configuration.
> 
> The Broadcom kernels enable the CPU's special "XKS01" feature to put
> 1GB of memory in ZONE_NORMAL:
> 
> https://github.com/Broadcom/stblinux-3.3/tree/master/linux
> 
> Maybe this would be worth adding to mainline.

Yes, It is right to have 1GB of memory.

In order to add XKS01 ioremap, keg, tlb, dma, etc. change is required.
However, there is no assurance they'll take those changes to the mainline.

Anyway, I also hope it added.
From cernekee@gmail.com Fri May  8 18:40:28 2015
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 18:40:29 +0200 (CEST)
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36640 "EHLO
        mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026561AbbEHQk1zjMAV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 18:40:27 +0200
Received: by qgeb100 with SMTP id b100so39099240qge.3;
        Fri, 08 May 2015 09:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lE+jkO2ubQAlbacuUw+yzVOcDmZeUpCKbEf2Po9OOAU=;
        b=VKpMsHSbsUTWKWmd/7SWonYKiOpbgKx2MNWD93bDN2c1n+TERGw8dcaNFpZSLeEGjR
         8hJyDzxZW/wU2J4xc7r4nJ4t4mdujxHbUMs38zlnd0GYnzbq+snszqGDo93PAczb9M2L
         d2W2pZyuhfPRe3iSBRoSNOX4VFGdsuwAsaviNSQTtbgfbWHQO6mqxcWp32J3bri3qjE4
         LDFwotWd9rB0SbKSejADS85RulIhBUFPHWLztyQZTynoe7dCs7l7NxufKqXGlKFTj1Pf
         Q1JzJw8u5s9ihp04e6MdLzIGdr0o6CqbVh66Wd2Hkkvf7qrnEwgExjoJjUOT0gzE4ZxF
         flng==
X-Received: by 10.140.22.147 with SMTP id 19mr6028464qgn.52.1431103224304;
 Fri, 08 May 2015 09:40:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.94.117 with HTTP; Fri, 8 May 2015 09:40:03 -0700 (PDT)
In-Reply-To: <10776752.kPn2ooXz5Z@wuerfel>
References: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com>
 <1431089958-2626-2-git-send-email-jaedon.shin@gmail.com> <CAJiQ=7CQshXhGJ7ftWQSu_UxgKVaRprZPEPXWNP6ci_1bLrJrw@mail.gmail.com>
 <10776752.kPn2ooXz5Z@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Fri, 8 May 2015 09:40:03 -0700
Message-ID: <CAJiQ=7Ajkae60eKfzr=mjPDov=bzoq7jBVDdQhGO37G8GGKK3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: BMIPS: dts: remove unsupported entry for bcm7362
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47290
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
Content-Length: 1894
Lines: 43

On Fri, May 8, 2015 at 8:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 08 May 2015 07:40:44 Kevin Cernekee wrote:
>> On Fri, May 8, 2015 at 5:59 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> > Remove unsupported memory entry for the bcm7362 platform. The BMIPS4380
>> > processor only supports ZONE_NORMAL is not available for HIGHMEM.
>> >
>> > Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> > ---
>> >  arch/mips/boot/dts/brcm/bcm97362svmb.dts | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> > index b7b88e5dc9e7..ab8b01fa7dcf 100644
>> > --- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> > +++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
>> > @@ -8,7 +8,7 @@
>> >
>> >         memory@0 {
>> >                 device_type = "memory";
>> > -               reg = <0x00000000 0x10000000>, <0x20000000 0x30000000>;
>> > +               reg = <0x00000000 0x10000000>;
>>
>> Hmm, this is more of a kernel limitation than a hardware limitation,
>> though.  The board physically has 1GB of memory, right?  It is best if
>> the DT entry reflects the actual hardware configuration.
>>
>> The Broadcom kernels enable the CPU's special "XKS01" feature to put
>> 1GB of memory in ZONE_NORMAL:
>>
>> https://github.com/Broadcom/stblinux-3.3/tree/master/linux
>>
>
> What exactly is the kernel limitation here?

If we can't enable HIGHMEM, e.g. because the MIPS CPU has D$ aliases,
then Linux is supposed to ignore any RAM above the highmem/lowmem
boundary.

There is code in paging_init() that tries to do this.  Several years
ago it used to work, but the last time I tried it (~Oct 2014) it was
broken due to some other changes in MIPS early memory init, so Linux
hangs on boot unless you take the excess RAM out of DT.  Jaedon may be
running into the same issue.
