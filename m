Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 16:57:14 +0100 (CET)
Received: from mail-io0-f182.google.com ([209.85.223.182]:36826 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008987AbcCNP5MvRV81 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Mar 2016 16:57:12 +0100
Received: by mail-io0-f182.google.com with SMTP id z76so227713210iof.3;
        Mon, 14 Mar 2016 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=fCZ2oLHrgSO9Oo9oH9+/78dTxUULcN25afxllo3s11c=;
        b=wJWwb3EJ19Z7XR3JV9dv/P+YovBwJpmcUa/3T3xTJ5QxZLodSmRzJedW0KVPxbRe/H
         /iDv4MYh/0E25AsVJB9CBHhaJAxnTZvHSfwhND8dFuT/yMnGabs/0dxNvI5LKrNh1z27
         jYCC8HSvTdLSQVcsNZ9GddF6ArrhZbL0BbWlykW+CCCNhzTBcMRimeqNhdTLd6l2MC8y
         fNB6REh3KQDqRgxg84P11IgOYMuhv4gm214UxQ3tWOdEo6M2Zc0b1fTzLOf5wDW4WG56
         po3YUUy7a3DVtihRbiJY3hBayYZ7KC2H8xFCWJCvowFHg9kEdnnbLKG+RxP4IGvLs+lj
         OLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=fCZ2oLHrgSO9Oo9oH9+/78dTxUULcN25afxllo3s11c=;
        b=jFGuAgsM08WhMN7QJP0OTJ0/ysVqVgapJt0Yreppm/ooAF785AdgQ3sV14Di/8xRMJ
         4IOLvDBpAJfkeVp7aaJF9lESAQggtFx+pvNYFER5WgVeySkBL8uA2ZFVZu3UgpZlbmLP
         xOpmp060rxWmQVIs0V7lUAMPqAek7PfASMFHrf/sRvJsuWnKm1qbPI0i5XUWNL+e+p/U
         gnGXDU4xU9L13eqZfCC7dBP7cW5ZtW7akQ99cZ2addujfA4woyuUfiTDwzxKt/tAGUb7
         B4x4PN405L/OuXMnoWELYP8GmWEdOHcxt+v/VtaH/+qxNGaxpXtg+hvd7hDkqz5RQzNH
         3bYg==
X-Gm-Message-State: AD7BkJICFiglqPBMi/G7329Rn5vAscOXlFl8TCtc/wuWdK+3AJfV0dj0Ar0/hKRL5R0r1F0fTray9uRelNhdJA==
MIME-Version: 1.0
X-Received: by 10.107.135.96 with SMTP id j93mr24561402iod.96.1457971026911;
 Mon, 14 Mar 2016 08:57:06 -0700 (PDT)
Received: by 10.107.159.142 with HTTP; Mon, 14 Mar 2016 08:57:06 -0700 (PDT)
In-Reply-To: <4928549.J7iBRWWaDH@wuerfel>
References: <1457965305-3258441-1-git-send-email-arnd@arndb.de>
        <CACna6rwx4Lna-PXNaHFwqn8xWitN=5ReUsAGPsK75YC2SLpDNg@mail.gmail.com>
        <4928549.J7iBRWWaDH@wuerfel>
Date:   Mon, 14 Mar 2016 16:57:06 +0100
Message-ID: <CACna6rzds0_+qxzp_MkFyiJijMyODK6VkxWvXuiEBKYHj-dwEQ@mail.gmail.com>
Subject: Re: [PATCH] Firmware: broadcom sprom: clarifiy SSB dependency
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul@pwsan.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52583
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

On 14 March 2016 at 16:34, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 14 March 2016 15:37:18 Rafał Miłecki wrote:
>> On 14 March 2016 at 15:21, Arnd Bergmann <arnd@arndb.de> wrote:
>> > The broadcom firmware drvier calls into the ssb SPROM code if that
>> > is enabled, but it fails if the SSB code is in a loadable module
>> > because the bcm47xx firmware is always built-in:
>> >
>> > drivers/firmware/built-in.o: In function `bcm47xx_sprom_register_fallbacks':
>> > bcm47xx_sprom.c:(.text+0x11c4): undefined reference to `ssb_arch_register_fallback_sprom'
>> >
>> > This adds a Kconfig dependency to ensure that we cannot turn on the
>> > generic sprom support if the ssb sprom is in a module.
>>
>> Can you attach your config that triggered this build error? I modified
>> condition to the:
>> #if IS_BUILTIN(CONFIG_SSB) && IS_ENABLED(CONFIG_SSB_SPROM)
>> which I believe should be enough.
>
> From inspection, I think your solution is sufficient to avoid the error.
> I found the bug while travelling and I'm only now catching up on the submissions,
> so I must have missed the fact that it was fixed. I looked at the code
> to see if additional patches had been applied on top, but I did not
> realize that you had modified the driver in place.

I sent a separated patch for this:
https://patchwork.linux-mips.org/patch/12836/
and it was folded/squashed by Ralf.

-- 
Rafał
