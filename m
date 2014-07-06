Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jul 2014 07:58:58 +0200 (CEST)
Received: from mail-ve0-f180.google.com ([209.85.128.180]:54949 "EHLO
        mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859462AbaGFF6uU7VCX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Jul 2014 07:58:50 +0200
Received: by mail-ve0-f180.google.com with SMTP id jw12so2814678veb.25
        for <multiple recipients>; Sat, 05 Jul 2014 22:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wPoEDCqOih5IsNV1wBN5FHF1ywHTn+/qtQp//Au/KIY=;
        b=Oj2vkpJQYoIpRtPZreD2S1c1wQFHvx4r0TCQAthjRkKK5ZHlNZXSahjcYHTYBH7/9P
         A0+H4Km26JojS4yRQSiM2gNyUnsvunIXKelsL/bNIiKv/CR8KbfRAy/V3Q2ouv53fmrS
         dlcuMzHik4dNtslPDZwINFQ6MngA36Yd4lrA0it15Gl24m7BdU3/a+X6NToFaPIJOWme
         NSNzmwXsJCZLfw/3nL3PmkhcScKVGsUTbXE6v681HMlzYy1kpIOZ80pqIqRXoeUQEpuZ
         etzawWE1yWBnKWz07UAbewPQr/PkQfnfvxxbXwhd1H5nPo9ijrbFDfZTcnFxGRz3/wpN
         HiZA==
MIME-Version: 1.0
X-Received: by 10.58.150.1 with SMTP id ue1mr19260509veb.11.1404626323824;
 Sat, 05 Jul 2014 22:58:43 -0700 (PDT)
Received: by 10.221.53.5 with HTTP; Sat, 5 Jul 2014 22:58:43 -0700 (PDT)
In-Reply-To: <53B80EFC.6020504@infradead.org>
References: <1404528619-3715-1-git-send-email-xerofoify@gmail.com>
        <53B80EFC.6020504@infradead.org>
Date:   Sun, 6 Jul 2014 01:58:43 -0400
Message-ID: <CAPDOMVid83VWT4n93MjvxoWdcq2KPYren0o5ubGi+9HHY6a7EQ@mail.gmail.com>
Subject: Re: [PATCH] mips: Add #ifdef in file bridge.h
From:   Nick Krause <xerofoify@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     ralf@linux-mips.org, jchandra@broadcom.com, blogic@openwrt.org,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

No I didn't I finally learned how to cross compile the kernel it's not
hard just have to find the docs for it :).
Cheers Nick

On Sat, Jul 5, 2014 at 10:43 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 07/04/2014 07:50 PM, Nicholas Krause wrote:
>> This patch addes a #ifdef __ASSEMBLY__ in order to check if this part
>> of the file is configured to fix this #ifdef block in bridge.h for mips.
>>
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> ---
>>  arch/mips/include/asm/netlogic/xlp-hal/bridge.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
>> index 3067f98..4f315c3 100644
>> --- a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
>> +++ b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
>> @@ -143,7 +143,7 @@
>>  #define BRIDGE_GIO_WEIGHT            0x2cb
>>  #define BRIDGE_FLASH_WEIGHT          0x2cc
>>
>> -/* FIXME verify */
>> +#ifdef __ASSEMBLY__
>>  #define BRIDGE_9XX_FLASH_BAR(i)              (0x11 + (i))
>>  #define BRIDGE_9XX_FLASH_BAR_LIMIT(i)        (0x15 + (i))
>>
>>
>
> Hi,
>
> Where is the corresponding #endif ?
> The #endif at line 185 goes with the #ifndef __ASSEMBLY__ at line 176.
>
> I think that this patch will cause a build error (or at least a warning).
> Did you test it?
>
>
> --
> ~Randy
