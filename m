Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 18:31:58 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34394 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010699AbbDGQb4gCe-f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 18:31:56 +0200
Received: by lboc7 with SMTP id c7so46856745lbo.1;
        Tue, 07 Apr 2015 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VfvxMD/MExSCgG1vqOywJXNpfxtQyUs++J12OaCxIlY=;
        b=zbIxpLmm8S00KXFVUFrMr19QDiWdOVZSey4brEJd6WqkwkCBaqs4mN9qvy9YSFrNrG
         j1NepenrPmwKM0Z10P2by5Yj1hLVsAW0iU4YWjamHhWRHFzs6RvlxlqQUn87w2/iLHbn
         /dDagFmj9sIFlJQvp0WF5qZxSrDAzmeqeWa581cI125RgtsYZyqFBqCPg8sPTaSbMkBq
         gKe2eqtD5DRlYJg4FUQwYssBPhJQMYtvNTDf8obZAmT6Y5nVb1jGeK/zuX3cT2NsulR4
         APi1vUSFe3vHTe9Pi3A8FTXIQhdcji3hp/ak58UgV7lmqHo9/4oNJ9pqQkOB8SUyEPvK
         7pqg==
MIME-Version: 1.0
X-Received: by 10.152.2.232 with SMTP id 8mr19117027lax.8.1428424312361; Tue,
 07 Apr 2015 09:31:52 -0700 (PDT)
Received: by 10.25.23.157 with HTTP; Tue, 7 Apr 2015 09:31:52 -0700 (PDT)
In-Reply-To: <5523FC32.3080904@biot.com>
References: <1428285076-14269-1-git-send-email-bert@biot.com>
        <20150407065217.GC3461@x1>
        <5523FC32.3080904@biot.com>
Date:   Tue, 7 Apr 2015 19:31:52 +0300
Message-ID: <CAHp75VfYcUFoTtiFmrd7JFB70A1Wg-gg2ZETcqGNZ9a34jKy0Q@mail.gmail.com>
Subject: Re: [PATCH] mfd: Add support for CPLD chip on Mikrotik RB4xx boards
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Tue, Apr 7, 2015 at 6:48 PM, Bert Vermeulen <bert@biot.com> wrote:
> On 07/04/15 08:52, Lee Jones wrote:
>> On Mon, 06 Apr 2015, Bert Vermeulen wrote:
>>
>>> The SPI-connected CPLD chip controls access to the main NAND flash
>>> chip and five LEDs.
>>>
>>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>>> ---
>>>   arch/mips/include/asm/mach-ath79/rb4xx_cpld.h |  49 +++++
>>>   drivers/mfd/Kconfig                           |   7 +
>>>   drivers/mfd/Makefile                          |   1 +
>>>   drivers/mfd/rb4xx-cpld.c                      | 279 ++++++++++++++++++++++++++
>>>   4 files changed, 336 insertions(+)
>>>   create mode 100644 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
>>>   create mode 100644 drivers/mfd/rb4xx-cpld.c
>>
>> This device doesn't look like an MFD, it rather looks like a CPLD
>> driver.  We had a recent submission like this [1], perhaps this will
>> provide another argument for drivers/programmables or something.
>>
>> [1] https://lkml.org/lkml/2015/2/17/42
>
> Yup, got bounced into drivers/mfd after initially submitting it as an SPI
> protocol driver (where it lives in openwrt). Indeed it's not a great fit
> anywhere -- not even programmables: this thing has its firmware on board,
> nothing ever feeds it on startup.
>
> Drivers for CPLDs don't necessarily have anything in common -- these are
> customized chips basically. In this case it's a NAND controller and GPIO/LED
> expander rolled into one.

Then perhaps drivers/misc ?


-- 
With Best Regards,
Andy Shevchenko
