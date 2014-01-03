Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 07:41:04 +0100 (CET)
Received: from mail-oa0-f54.google.com ([209.85.219.54]:59784 "EHLO
        mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825694AbaACGlBsGXea convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Jan 2014 07:41:01 +0100
Received: by mail-oa0-f54.google.com with SMTP id h16so15803008oag.13
        for <multiple recipients>; Thu, 02 Jan 2014 22:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/YS2B2YEqzRMMuwdBP/XGIV4XfEsAxmIBNekU4zjTx8=;
        b=zVVNqnWdO/bIyGKVUZlv+lMkDGkxug4/VqVdRzXoQ98Czqkgl+QPJCUZMW1HB7mjHp
         xDCs1Z1TOfqBr4erO/Mm3u64yxN/X0l9b669Bva4TIX1IPETkqYFN/tPQOWC3MAKOeek
         aH6ghps4UH6itcRbqnNdY8b+7Vsg+q2QxNpJJHRyeqEvDbN7SG95s19srBXZJ2V3UC4Y
         CvOCc9jZUzmw2ItaEAnKSJC4sAGIxo4FJH+9WyaQcVcwbNL2xOqFzqt2qRUbT82OkxeT
         PRhPQAk+m42/oekG/vTAeyx2kKNupJ/WUosyg3Zde0tGdSsefYmRl6pht9HhDZu4gbzl
         vSrw==
MIME-Version: 1.0
X-Received: by 10.182.227.136 with SMTP id sa8mr58250933obc.39.1388731254533;
 Thu, 02 Jan 2014 22:40:54 -0800 (PST)
Received: by 10.76.69.7 with HTTP; Thu, 2 Jan 2014 22:40:54 -0800 (PST)
In-Reply-To: <CAPoQQ-35pFjDq7j_nLPQdCrKnibcaQCha9a5XbVJxv9UQvsW_w@mail.gmail.com>
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
        <CACna6rw1_QXXk0g9tpWVsx5G1zbNQdun5edHkSzkabVfLuxL4A@mail.gmail.com>
        <CAPoQQ-35pFjDq7j_nLPQdCrKnibcaQCha9a5XbVJxv9UQvsW_w@mail.gmail.com>
Date:   Fri, 3 Jan 2014 07:40:54 +0100
Message-ID: <CACna6rw5ywazz-Nssd-yXC3cYzoWEg3Wkx2sgq2bK1V=MZOgQw@mail.gmail.com>
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
X-archive-position: 38856
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

2014/1/2 Cody P Schafer <devel@codyps.com>:
> On Thu, Jan 2, 2014 at 1:35 PM, Rafał Miłecki <zajec5@gmail.com> wrote:
>> 2014/1/2 Hauke Mehrtens <hauke@hauke-m.de>:
>>> From: Cody P Schafer <devel@codyps.com>
>>>
>>> Add a few Belkin F7Dxxxx entries, with F7D4401 sourced from online
>>> documentation and the "F7D7302" being observed. F7D3301, F7D3302, and
>>> F7D4302 are reasonable guesses which are unlikely to cause
>>> mis-detection.
>>>
>>> It also appears that at least the F7D3302, F7D3301, F7D7301, and F7D7302
>>> have a shared boardtype and boardrev, so use that as a fallback to a
>>> "generic" F7Dxxxx board.
>>
>> Cody, Hauke: I'm starring at this patch for 10 minutes now and it's
>> still unclear for me.
>>
>> You say 3301, 3302, 7301 and 7302 have the same board_* entries
>> stating they can be treated with a generic ID entry.
>
> I included the generic BCM47XX_BOARD_BELKIN_F7DXXXX entry to catch
> those boards that we don't yet have specific entries for. It allows us
> to get the leds and buttons working mostly correctly.
>
> The specific names are included so that one can determine a more exact
> board. The stock CFE requires different images for different boards
> even though they are very similar. Hardware variations are simply
> gigabit vs 100MB switches, usb port population, led population, and
> 5Ghz radio population (none of which truly require the greater detail
> in board type).

OK, maybe this is sth I'm missing... Why we should care about CFE in
kernel? We don't talk with CFE, do we? So we don't have to know which
device's CFE is that.

-- 
Rafał
