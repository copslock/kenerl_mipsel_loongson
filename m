Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 19:13:25 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36118 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014690AbcAGSNYIqTTe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 19:13:24 +0100
Received: by mail-pa0-f49.google.com with SMTP id yy13so171844972pab.3
        for <linux-mips@linux-mips.org>; Thu, 07 Jan 2016 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zpT+akx+GRSK4Ho+ijom43wtyheq2jDiL/E62Dx5s5s=;
        b=mSQ8juTFXguZW0zIPJG6esFWmIop+0J3Vl+mnhB9ooA2H2q7N+2OEqrsXLGIEx8l6h
         Ty6ckJbw9e8ZKR4bxI90IGpG0UTcm8L8qXwvR8VDGDKuPGLi5ohVfP/c3HxGoCmDf4vQ
         v4/2/Lj///3V1MD4dia2Q0XKROuN1pg/WYh+sqiiekJDhZ1YQ5OzbB0v9RXy1eyItBHK
         aIDBIRV9dIEmHnzW8CLlRSWUTsWAmfMHcFjPtWuLJFxgBybETRB5A67cIbDbkYkLCBrb
         x0jGPCFQnO4w6OEQSNgw94h4jaIrJFW1dxeq9vmfY9AdCPybX5Zk8+kTvEK5jfDFAbwV
         wb1g==
X-Received: by 10.66.158.193 with SMTP id ww1mr152357678pab.21.1452190397448;
        Thu, 07 Jan 2016 10:13:17 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id dg12sm119333854pac.47.2016.01.07.10.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2016 10:13:16 -0800 (PST)
Message-ID: <568EAA99.1020603@gmail.com>
Date:   Thu, 07 Jan 2016 10:12:41 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     linux-gpio@vger.kernel.org, 
 open list:MIPS <linux-mips@linux-mips.org>,
 jaedon.shin@gmail.com, Linus Walleij <linus.walleij@linaro.org>, 
 Alexandre Courbot <gnurou@gmail.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, 
 Jim Quinlan <jim2101024@gmail.com>
Subject: Re: [PATCH 1/3] gpio: brcmstb: have driver register during subsys_initcall()
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com> <1452106523-11556-2-git-send-email-f.fainelli@gmail.com> <CADtm3G7_pGdgM8EJgRzRf8j1JAJKivxzd85ie5haWP8ivZvwSg@mail.gmail.com>
In-Reply-To: <CADtm3G7_pGdgM8EJgRzRf8j1JAJKivxzd85ie5haWP8ivZvwSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50964
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

On 06/01/16 22:05, Gregory Fong wrote:
> Hello Florian and Jim,
> 
> On Wed, Jan 6, 2016 at 10:55 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> From: Jim Quinlan <jim2101024@gmail.com>
>>
>> Because regulators are started with subsys_initcall(), and gpio references may
>> be contained in the regulators, it makes sense to start the brcmstb-gpio's with
>> a subsys_initcall(). The order within the drivers/Makefile ensures that the
>> gpio initialization happens prior to the regulator's initialization.
>>
>> We need to unroll module_platform_driver() now to allow this and have custom
>> exit and init module functions to control the initialization level.
> 
> If gpio pins are needed for a regulator to come up, wouldn't it be
> better to handle this using deferred probe instead of initcall-based
> initialization?  Deferred probe has its problems, but I was under the
> impression that it's the encouraged way to resolve these sort of
> initialization order issues.

To give you some more context associated with this change, we now have
some boards which have GPIO-connected regulators to turn on/off PCIe
endpoint devices. In the downstream kernel, and with lack of a better
solution for now, we ended-up having the PCIE Root Complex driver to
claim these regulator, and flip them on shortly before attempting a bus
scan.

If we used deferred probing, I am assuming the sequence of events could
go like this:

- PCIe driver gets initialized, looks for regulators, cannot get a
handle on them, gets EPROBE_DEFER (arch_initcall right now)
- regulator subsystem gets initialized, does not have a valid GPIO
provider driver yet, returns EPROBE_DEFER (subsys_initcall)
- GPIO provider (gpio-brcmstb) finally gets probed and registered,
regulator get registered and available, PCIe RC driver can now use them
and power on the PCIE end point (module_initcall)

I suppose this might be working actually, let me go back to the white
board and look at this with Jim.
-- 
Florian
