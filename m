Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2011 19:28:01 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:61391 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491202Ab1GUR16 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jul 2011 19:27:58 +0200
Received: by gya1 with SMTP id 1so837308gya.36
        for <multiple recipients>; Thu, 21 Jul 2011 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9ZVYsA70l+uoYlzseiUCADoLuduVm/y2Qm8bKGCdVWk=;
        b=SwHqbexKaiVAuIvXORllJJV+181Se4MOOkvLr4FPukZLxxgJ5lLIDvc6hKBtv2k2Fc
         F3jQi7+92HnkVKWkF9uFofzNRFm2U2Y0j6ErW+AFFsjXn7jhMtV8vYMDizBjkwnlZCsV
         QQ2a707zecd19lnTLR4jUPI36MYU63QoH6Stk=
MIME-Version: 1.0
Received: by 10.236.190.68 with SMTP id d44mr809119yhn.393.1311269271876; Thu,
 21 Jul 2011 10:27:51 -0700 (PDT)
Received: by 10.236.95.168 with HTTP; Thu, 21 Jul 2011 10:27:51 -0700 (PDT)
In-Reply-To: <s5hmxg78st2.wl%tiwai@suse.de>
References: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
        <s5hmxg78st2.wl%tiwai@suse.de>
Date:   Thu, 21 Jul 2011 19:27:51 +0200
Message-ID: <CAOLZvyEaKdSwC9ZU_FrYYAqmTkHfCsztftip_sY0Vfe9wDN7Og@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 0/2] ALSA: ASoC for Au1000/1500/1100
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15298

On Thu, Jul 21, 2011 at 7:08 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 21 Jul 2011 18:34:08 +0200,
> Manuel Lauss wrote:
>>
>> Hello,
>>
>> These 2 patches implement ASoC drivers for the AC97 and I2S
>> controllers found on early Alchemy chips.  They are largely
>> based on the old mips/au1x00.c driver which they replace.
>
> In general, dropping an old driver happens a bit later after the new
> driver comes in.  You can make the old one as deprecated at first.

Makes sense, just ignore patch 2 then ;)

Thanks,
        Manuel Lauss
