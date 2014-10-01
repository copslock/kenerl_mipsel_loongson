Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2014 16:42:05 +0200 (CEST)
Received: from mail-yk0-f170.google.com ([209.85.160.170]:45015 "EHLO
        mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010261AbaJAOmAuDOfc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Oct 2014 16:42:00 +0200
Received: by mail-yk0-f170.google.com with SMTP id 20so161851yks.29
        for <multiple recipients>; Wed, 01 Oct 2014 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pjTpGITFMkDLs0Jac7hwXGB9aylC59nKxd9+GCuDx+8=;
        b=izC5C3llpZxdQZU6CqZvOg9jSBjepLFJPWVJ6ujmtNr/q/5nbMGsS/GC0vLWvIRSD7
         zd8ssXE8pTgqUYNWDdSQ7rc4k2vkR39zTF5QLq350Y67Lmy+TakxZ9M2i1JbXc3b5vzs
         ny1NCPpX93FByHQdjYy0CfDL2f2VCL0jF8deDTmvGpRMzgZdhgCsJrOP4LLb3S0/D9GN
         Ev6r4lpUEv2Wry3qbERbMiDVIsQasJ8BcL8MY3TskRVlborpw9KFPTdqKk/QXfddJ7YC
         74NHD3Qot72cZJrkAEiGXvon72Oqfhdj5uI0NlCMDWKlABd5JTThskV3YVeL3mmVwdwP
         AdSw==
X-Received: by 10.236.70.99 with SMTP id o63mr26263919yhd.98.1412174514654;
 Wed, 01 Oct 2014 07:41:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.135 with HTTP; Wed, 1 Oct 2014 07:41:34 -0700 (PDT)
In-Reply-To: <20140930172044.GE11919@tuxdriver.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
 <1411929195-23775-16-git-send-email-ryazanov.s.a@gmail.com> <20140930172044.GE11919@tuxdriver.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 1 Oct 2014 18:41:34 +0400
Message-ID: <CAHNKnsSNO3-mzcKcGdnxEndbq6y_Pr0Gqrv2dMVCZZssgqMnWA@mail.gmail.com>
Subject: Re: [PATCH 15/16] ath5k: update dependencies
To:     "John W. Linville" <linville@tuxdriver.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath5k-devel@venema.h4ckr.net
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-09-30 21:20 GMT+04:00 John W. Linville <linville@tuxdriver.com>:
> This patch does not seem to apply to wireless-next.  What tree is it
> based upon?
>
> John
>
Its based on linux-mips. I thought that ath5k was not changed in
recent time and did not  rebase patch on top of wireless-next.

John, could you delay patch merging? There is an idea to rename ar231x
in ath25, to be consistent with ath79 for AR71xx/AR9xxx.

> On Sun, Sep 28, 2014 at 10:33:14PM +0400, Sergey Ryazanov wrote:
>> - Use config symbol defined in the driver instead of arch specific one for
>>   conditional compilation.
>> - Rename the ATHEROS_AR231X config symbol to AR231X.
>> - Some of AR231x SoCs (e.g. AR2315) have PCI bus support, so remove !PCI
>>   dependency, which block AHB support build.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> Cc: Jiri Slaby <jirislaby@gmail.com>
>> Cc: Nick Kossifidis <mickflemm@gmail.com>
>> Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: ath5k-devel@lists.ath5k.org
>> ---
>>
>> Changes since RFC:
>>   - merge together patches that update ath5k dependencies
>>
>>  drivers/net/wireless/ath/ath5k/Kconfig | 10 +++++-----
>>  drivers/net/wireless/ath/ath5k/ath5k.h |  2 +-
>>  drivers/net/wireless/ath/ath5k/base.c  |  4 ++--
>>  drivers/net/wireless/ath/ath5k/led.c   |  4 ++--
>>  4 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath5k/Kconfig b/drivers/net/wireless/ath/ath5k/Kconfig
>> index c9f81a3..2b2a399 100644
>> --- a/drivers/net/wireless/ath/ath5k/Kconfig
>> +++ b/drivers/net/wireless/ath/ath5k/Kconfig
>> @@ -1,13 +1,13 @@
>>  config ATH5K
>>       tristate "Atheros 5xxx wireless cards support"
>> -     depends on (PCI || ATHEROS_AR231X) && MAC80211
>> +     depends on (PCI || AR231X) && MAC80211
>>       select ATH_COMMON
>>       select MAC80211_LEDS
>>       select LEDS_CLASS
>>       select NEW_LEDS
>>       select AVERAGE
>> -     select ATH5K_AHB if (ATHEROS_AR231X && !PCI)
>> -     select ATH5K_PCI if (!ATHEROS_AR231X && PCI)
>> +     select ATH5K_AHB if AR231X
>> +     select ATH5K_PCI if !AR231X
>>       ---help---
>>         This module adds support for wireless adapters based on
>>         Atheros 5xxx chipset.
>> @@ -54,14 +54,14 @@ config ATH5K_TRACER
>>
>>  config ATH5K_AHB
>>       bool "Atheros 5xxx AHB bus support"
>> -     depends on (ATHEROS_AR231X && !PCI)
>> +     depends on AR231X
>>       ---help---
>>         This adds support for WiSoC type chipsets of the 5xxx Atheros
>>         family.
>>
>>  config ATH5K_PCI
>>       bool "Atheros 5xxx PCI bus support"
>> -     depends on (!ATHEROS_AR231X && PCI)
>> +     depends on (!AR231X && PCI)
>>       ---help---
>>         This adds support for PCI type chipsets of the 5xxx Atheros
>>         family.
>> diff --git a/drivers/net/wireless/ath/ath5k/ath5k.h b/drivers/net/wireless/ath/ath5k/ath5k.h
>> index 85316bb..1ed7a88 100644
>> --- a/drivers/net/wireless/ath/ath5k/ath5k.h
>> +++ b/drivers/net/wireless/ath/ath5k/ath5k.h
>> @@ -1647,7 +1647,7 @@ static inline struct ath_regulatory *ath5k_hw_regulatory(struct ath5k_hw *ah)
>>       return &(ath5k_hw_common(ah)->regulatory);
>>  }
>>
>> -#ifdef CONFIG_ATHEROS_AR231X
>> +#ifdef CONFIG_ATH5K_AHB
>>  #define AR5K_AR2315_PCI_BASE ((void __iomem *)0xb0100000)
>>
>>  static inline void __iomem *ath5k_ahb_reg(struct ath5k_hw *ah, u16 reg)
>> diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
>> index 8ad2550..dd42487 100644
>> --- a/drivers/net/wireless/ath/ath5k/base.c
>> +++ b/drivers/net/wireless/ath/ath5k/base.c
>> @@ -99,7 +99,7 @@ static int ath5k_reset(struct ath5k_hw *ah, struct ieee80211_channel *chan,
>>
>>  /* Known SREVs */
>>  static const struct ath5k_srev_name srev_names[] = {
>> -#ifdef CONFIG_ATHEROS_AR231X
>> +#ifdef CONFIG_ATH5K_AHB
>>       { "5312",       AR5K_VERSION_MAC,       AR5K_SREV_AR5312_R2 },
>>       { "5312",       AR5K_VERSION_MAC,       AR5K_SREV_AR5312_R7 },
>>       { "2313",       AR5K_VERSION_MAC,       AR5K_SREV_AR2313_R8 },
>> @@ -142,7 +142,7 @@ static const struct ath5k_srev_name srev_names[] = {
>>       { "5413",       AR5K_VERSION_RAD,       AR5K_SREV_RAD_5413 },
>>       { "5424",       AR5K_VERSION_RAD,       AR5K_SREV_RAD_5424 },
>>       { "5133",       AR5K_VERSION_RAD,       AR5K_SREV_RAD_5133 },
>> -#ifdef CONFIG_ATHEROS_AR231X
>> +#ifdef CONFIG_ATH5K_AHB
>>       { "2316",       AR5K_VERSION_RAD,       AR5K_SREV_RAD_2316 },
>>       { "2317",       AR5K_VERSION_RAD,       AR5K_SREV_RAD_2317 },
>>  #endif
>> diff --git a/drivers/net/wireless/ath/ath5k/led.c b/drivers/net/wireless/ath/ath5k/led.c
>> index 48a6a69b..c730677 100644
>> --- a/drivers/net/wireless/ath/ath5k/led.c
>> +++ b/drivers/net/wireless/ath/ath5k/led.c
>> @@ -162,7 +162,7 @@ int ath5k_init_leds(struct ath5k_hw *ah)
>>  {
>>       int ret = 0;
>>       struct ieee80211_hw *hw = ah->hw;
>> -#ifndef CONFIG_ATHEROS_AR231X
>> +#ifndef CONFIG_ATH5K_AHB
>>       struct pci_dev *pdev = ah->pdev;
>>  #endif
>>       char name[ATH5K_LED_MAX_NAME_LEN + 1];
>> @@ -171,7 +171,7 @@ int ath5k_init_leds(struct ath5k_hw *ah)
>>       if (!ah->pdev)
>>               return 0;
>>
>> -#ifdef CONFIG_ATHEROS_AR231X
>> +#ifdef CONFIG_ATH5K_AHB
>>       match = NULL;
>>  #else
>>       match = pci_match_id(&ath5k_led_devices[0], pdev);
>> --
>> 1.8.5.5
>>

-- 
BR,
Sergey

С наилучшими пожеланиями
Рязанов Сергей
