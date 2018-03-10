Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 23:17:57 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:35424
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992781AbeCJWRuiQwKY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Mar 2018 23:17:50 +0100
Received: by mail-pg0-x241.google.com with SMTP id l131so4967797pga.2
        for <linux-mips@linux-mips.org>; Sat, 10 Mar 2018 14:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tUA9HTZiga8RqE3KzUsBv6o262BDwwmS2eRJtNES/Pg=;
        b=AQwqdzv1uJoPq8ZxRygiiq1z3MfznaLb2zhbAlhXyHmyVc7h6dOPC6mvU5OYLpgBZh
         We/4gaOqPPa4vQZzx14zw3pafKTHJWvOcgVVDyptvQhWdnwNzffZCMId8kG8RtF1nHJs
         z5b7H5Gs1aCSo5qk9ExPX3aw8zqWx2Rfkf1qGBHfZ9LP4m37arpZZ0OU9u9L3y3ywfAa
         aZRgjb3yzBevIGq+q5b0iMykybrMGzUxMmjjtrvT4wtCHN7/lYAYYwzZJuOnQjhjro8O
         A3LU8Jdpc/CrC7YtNVoaKmqEjyb8vyfEjRJMJZCcPQTgQFzBAGKUV2jA5z+BaWyNE4Lh
         E3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tUA9HTZiga8RqE3KzUsBv6o262BDwwmS2eRJtNES/Pg=;
        b=L+9/UfvUb/5B0dKV3uZFPWSWqVfGEmMF3UI/f1KGcVZEDrvQBi42GuMeEb8axkZm9Y
         0Tw4K1wKEH0wdtLRE8JZ53lK+klgpyKnLRUoCxWJnAkX1jRiqE0pb6DaNMeKNWOrJqVe
         SqCmgRjsu7RBr83LIvAHDBtZGMGX1fkuK4NTSftp8v5pocGkREBPT8U5vJUVf1eE2VFs
         oW5Mteux8k0vpVH2E6hXtWFljDDqkeYRLAAoDBF1Ki8aG2AUPZVoDYlqh9Ggyx3RgisO
         3XUnL8uFHw+1iDtLRFCxJ60vWMWafRwy4S3ljcaIolOj7cPoxwd+zA7+5hcaNq+fOtbq
         r3/A==
X-Gm-Message-State: AElRT7H2sOg7hbDDBg9zKMiX9naMKaq/3JTIJEAkkmjqdnBj+jwOmxtO
        9NQVm7UE7ptSHTV7bl7X3NOess1RWHu2/l2Cp7/P/A==
X-Google-Smtp-Source: AG47ELsI9CIwhfMKjfneaDyd3HWphiUXyf6kVqqqr4mOMLJHP5R6agb/cAdzQuSXJj551i2U1rRRcI50JI81PeOntLA=
X-Received: by 10.98.200.131 with SMTP id i3mr3139102pfk.40.1520720263804;
 Sat, 10 Mar 2018 14:17:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.149.10 with HTTP; Sat, 10 Mar 2018 14:17:43 -0800 (PST)
In-Reply-To: <CA+7wUsxuavjaVOpoOEVJp4gSd+J_FQ37JuRE_N2BhEqOx7G1yA@mail.gmail.com>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar> <CA+7wUsxuavjaVOpoOEVJp4gSd+J_FQ37JuRE_N2BhEqOx7G1yA@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 10 Mar 2018 19:17:43 -0300
Message-ID: <CAAEAJfDmQBShUVXupVMdcPSiu5t2i7VdF_1LM9Syu_Qiq6PsKg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Enable SD/MMC on JZ4780 SoCs
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

Hi Mathieu,

On 10 March 2018 at 14:02, Mathieu Malaterre <malat@debian.org> wrote:
> On Fri, Mar 9, 2018 at 4:12 PM, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>> This patchset adds support for SD/MMC on JZ4780 based
>> platforms, such as the MIPS Creator CI20 board.
>>
>> Most of the work has been done by Alex, Paul and Zubair,
>> while I've only prepared the upstream submission, cleaned
>> some patches, and written some commit logs where needed.
>>
>> All praises should go to them, all rants to me.
>>
>> The series is based on v4.16-rc4.
>>
>> Alex Smith (3):
>>   mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
>>   mmc: jz4740: Add support for the JZ4780
>>   mmc: jz4740: Fix race condition in IRQ mask update
>>
>> Ezequiel Garcia (9):
>>   mmc: jz4780: Order headers alphabetically
>>   mmc: jz4740: Use dev_get_platdata
>>   mmc: jz4740: Introduce devicetree probe
>>   mmc: dt-bindings: add MMC support to JZ4740 SoC
>>   mmc: jz4740: Use dma_request_chan()
>>   MIPS: dts: jz4780: Add DMA controller node to the devicetree
>>   MIPS: dts: jz4780: Add MMC controller node to the devicetree
>>   MIPS: dts: ci20: Enable DMA and MMC in the devicetree
>>   MIPS: configs: ci20: Enable DMA and MMC support
>>
>> Paul Cercueil (1):
>>   mmc: jz4740: Fix error exit path in driver's probe
>>
>> Zubair Lutfullah Kakakhel (1):
>>   mmc: jz4740: Reset the device requesting the interrupt
>
> Nice work. Entire series works just fine on my MIPS Creator CI20 (v1).
>

Cool. This means a Tested-by for the entire series?

> Nitpick: could you update the email addresses:
>
> s/imgtec/mips/
>

You sure that is appropriate? First of all, the work has done
under Imagination Technologies umbrella (even if now the
developers work for MIPS).

And second, I'd feel better if such request would come
from the authors, or at least acked by them.

Thanks for testing!
-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar
