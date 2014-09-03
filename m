Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 23:13:21 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:46680 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007452AbaICVNUP0GwT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Sep 2014 23:13:20 +0200
Received: by mail-ie0-f180.google.com with SMTP id rl12so10587818iec.11
        for <linux-mips@linux-mips.org>; Wed, 03 Sep 2014 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DFSI5SZuDQibsi3Qredoe9yozM9w/GHsaPgJE53LseA=;
        b=galuTsqPpOzs+8Yg1EcfdBLGyWRzTPDQnifPaVVStTOj3+8y7XmBsedcrJWk59NeH/
         +HZKGf3NPFOiM0BWcScXVKsnU4TzCibtl0rAhwah0JvD9kDEwkNdrXTYTq89XNi8qRaW
         vJjLSrGAydL/lZzh2Gu4cpbtDCrtjobdBBm8GbpBy1DBvqb7Sr+N9z+v+XfOfjYzB3kv
         gmKx31jyXqLcSzRbd3nXGR1ZB1uvyV/NRc6LDV8gSn3zucMKiTMgDrf+y9AtueYxxdoX
         fvCkBZs9n7uyCYzJ8Uos+Yw1eln8JpVdI5A/9R/2m9XXn9qDi2yFFZOMW1HYPVS6k92i
         T3Cw==
MIME-Version: 1.0
X-Received: by 10.51.17.2 with SMTP id ga2mr225010igd.2.1409778793913; Wed, 03
 Sep 2014 14:13:13 -0700 (PDT)
Received: by 10.107.10.133 with HTTP; Wed, 3 Sep 2014 14:13:13 -0700 (PDT)
In-Reply-To: <54077671.7000204@hauke-m.de>
References: <1409764481-20997-1-git-send-email-zajec5@gmail.com>
        <54077671.7000204@hauke-m.de>
Date:   Wed, 3 Sep 2014 23:13:13 +0200
Message-ID: <CACna6rz6oTPSsWP_AGALZPLuZ8CHM3hAFXB7op3Q4OzO18qg3A@mail.gmail.com>
Subject: Re: [PATCH][RFC] MIPS: BCM47XX: Use mtd as an alternative way/API to
 get NVRAM content
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42385
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

On 3 September 2014 22:13, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 09/03/2014 07:14 PM, Rafał Miłecki wrote:
>> NVRAM can be read using magic memory offset, but after all it's just a
>> flash partition. On platforms where NVRAM isn't needed early we can get
>> it using mtd subsystem.
>
> Where would this work?
>
> Do you plan the following initialization order in bcma on arm and mips?
>
> 1. bcma SoC version
> 2. bcma bus scan
> 3. flash driver registration
> 4. nvram read
> 5. sprom generation from nvram and attaching to bcma
> 6. registration of the other bcam cores (wifi, ...)
>
> The nvram is memory mapped on every SoC, just on devices with nand flash
> booting we would need something to check for bad blocks.

The order you noted is probably quite accurate.

Indeed, I want to use "mtd" subsystem because of NAND. Mapping NAND
flash content to the memory is nice, but it's reliable for few first
sections/blocks only. The rest of flash may contain bad blocks and we
should read it being aware of that.
