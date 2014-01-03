Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 07:43:40 +0100 (CET)
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46603 "EHLO
        mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825694AbaACGni3S-gH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Jan 2014 07:43:38 +0100
Received: by mail-ob0-f170.google.com with SMTP id wp18so15384754obc.1
        for <multiple recipients>; Thu, 02 Jan 2014 22:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KUapxzlAKcIPdxIbBaDDgkl5y5e7CTMJkqzWANaKx+M=;
        b=XDXII2Oq4smnt5MENuXEri8uxDNvwiLF7W56eCHQ6YuwofO0uc4uRphXNwG6WRryc3
         IHL5C2qocYcMdgJoUnaUg3tSHwtW03cCHkU42HFX1LmR0FW88p+VnnJpLEf/G41zb1Zz
         Spt/8j2GCHV4OFJQghLpG3dpglugCSI9HApy8akSJ0Gjd0ydLOwKzpzSeePjGe84TpT4
         qkdQyM79lkD8E6srQN2M2KLq6KY5jGFi/SZlOrFRIAKttRjENhPFbKKkIczvejA1ZUt3
         h1sJQgLJGKmW+Y2ia1Nx/pLBPoEyWaeDT4833+JGmFk9u6mcGvx7TM80+pYWedMdMKuh
         IX3w==
MIME-Version: 1.0
X-Received: by 10.60.35.73 with SMTP id f9mr134696oej.50.1388731412380; Thu,
 02 Jan 2014 22:43:32 -0800 (PST)
Received: by 10.76.69.7 with HTTP; Thu, 2 Jan 2014 22:43:32 -0800 (PST)
In-Reply-To: <CACna6rw5ywazz-Nssd-yXC3cYzoWEg3Wkx2sgq2bK1V=MZOgQw@mail.gmail.com>
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
        <CACna6rw1_QXXk0g9tpWVsx5G1zbNQdun5edHkSzkabVfLuxL4A@mail.gmail.com>
        <CAPoQQ-35pFjDq7j_nLPQdCrKnibcaQCha9a5XbVJxv9UQvsW_w@mail.gmail.com>
        <CACna6rw5ywazz-Nssd-yXC3cYzoWEg3Wkx2sgq2bK1V=MZOgQw@mail.gmail.com>
Date:   Fri, 3 Jan 2014 07:43:32 +0100
Message-ID: <CACna6rzEzMxj_XoS-3cu8yCqfZTztJmtZhEaeeEpd5zqMayFww@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: BCM47XX: add Belkin F7Dxxxx board detection
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Cody P Schafer <devel@codyps.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38857
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

2014/1/3 Rafał Miłecki <zajec5@gmail.com>:
> 2014/1/2 Cody P Schafer <devel@codyps.com>:
>> On Thu, Jan 2, 2014 at 1:35 PM, Rafał Miłecki <zajec5@gmail.com> wrote:
>>> 2014/1/2 Hauke Mehrtens <hauke@hauke-m.de>:
>>>> From: Cody P Schafer <devel@codyps.com>
>>>>
>>>> Add a few Belkin F7Dxxxx entries, with F7D4401 sourced from online
>>>> documentation and the "F7D7302" being observed. F7D3301, F7D3302, and
>>>> F7D4302 are reasonable guesses which are unlikely to cause
>>>> mis-detection.
>>>>
>>>> It also appears that at least the F7D3302, F7D3301, F7D7301, and F7D7302
>>>> have a shared boardtype and boardrev, so use that as a fallback to a
>>>> "generic" F7Dxxxx board.
>>>
>>> Cody, Hauke: I'm starring at this patch for 10 minutes now and it's
>>> still unclear for me.
>>>
>>> You say 3301, 3302, 7301 and 7302 have the same board_* entries
>>> stating they can be treated with a generic ID entry.
>>
>> I included the generic BCM47XX_BOARD_BELKIN_F7DXXXX entry to catch
>> those boards that we don't yet have specific entries for. It allows us
>> to get the leds and buttons working mostly correctly.
>>
>> The specific names are included so that one can determine a more exact
>> board. The stock CFE requires different images for different boards
>> even though they are very similar. Hardware variations are simply
>> gigabit vs 100MB switches, usb port population, led population, and
>> 5Ghz radio population (none of which truly require the greater detail
>> in board type).
>
> OK, maybe this is sth I'm missing... Why we should care about CFE in
> kernel? We don't talk with CFE, do we? So we don't have to know which
> device's CFE is that.

Also: are the CFEs in 3302 and 7302 identical? Because you use
BCM47XX_BOARD_BELKIN_F7D3302 for both of them.

I'd prefer to see BCM47XX_BOARD_BELKIN_F7DX302, or maybe even better:
two separated entries that can be combined in leds.c and buttons.c.

-- 
Rafał
