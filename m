Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 23:03:45 +0100 (CET)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60618 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825710AbaABWDm6meqc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Jan 2014 23:03:42 +0100
Received: by mail-pd0-f170.google.com with SMTP id g10so14670417pdj.29
        for <linux-mips@linux-mips.org>; Thu, 02 Jan 2014 14:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codyps.com; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=gfUeKKLcnmXQNSrYExz2D4q4/MOvtUIboOafCmTn/1Y=;
        b=CldvRa0/WMK/wt6FGxTtcCziI1B7DLL0HWTdBIEEbPqekuZM3jT3JrP4t93AZt7/2v
         FEmqC0G2w/1Ws51xLuX09jcWOU7u4SV7zX0gBqZWb77FgL5kTmmuh6Mc9lpU3UTtAQOp
         TAHaAzBIHcSdOnDUHnOEpQXydzrDSkPuWR+qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gfUeKKLcnmXQNSrYExz2D4q4/MOvtUIboOafCmTn/1Y=;
        b=aNH+rmbU8n0H7y1mslD8h1qG71FHsuxYkZfPTtnCiFRJQG0yLOYUhL/sHT9HMwf3Ee
         ZCTEhg8oJlLy6/Ky5upW1HEEIgz1YDH+QlYe2ASyGijUpF5qL56rqvi9H2vmsRBTjmlv
         LtPnX09GyUyWOx1ZyjHQt/dF5IGtIMq9nAWaIS7i7dQ4fF9gaPkltsA3uGV7In4U5ifG
         yX1g+yvzFK7span9nOOSZlmSPk6kwb7jkwI0xExtSGC9E/4Vj+KwyD7EuJu4D7nlwLn3
         cGBE8W87clhn0y9vyINOGfyr6NW1/Iingi68CCcdz+NJpdniiCehZwFliZYLng6WNOd8
         ViLw==
X-Gm-Message-State: ALoCoQlWT/IiUa70AQ0nNzyZYGGnzCYSTts+G8QfRyIfqAebmFwUyoeY9SE1WzuZGdyHBKmFnpJc
MIME-Version: 1.0
X-Received: by 10.68.170.225 with SMTP id ap1mr90784723pbc.117.1388700215460;
 Thu, 02 Jan 2014 14:03:35 -0800 (PST)
Received: by 10.66.48.42 with HTTP; Thu, 2 Jan 2014 14:03:35 -0800 (PST)
X-Originating-IP: [74.90.190.240]
In-Reply-To: <CACna6rw1_QXXk0g9tpWVsx5G1zbNQdun5edHkSzkabVfLuxL4A@mail.gmail.com>
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
        <CACna6rw1_QXXk0g9tpWVsx5G1zbNQdun5edHkSzkabVfLuxL4A@mail.gmail.com>
Date:   Thu, 2 Jan 2014 14:03:35 -0800
X-Google-Sender-Auth: smF5Raf5LFNZcx4k_mORzeaxZl8
Message-ID: <CAPoQQ-35pFjDq7j_nLPQdCrKnibcaQCha9a5XbVJxv9UQvsW_w@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: BCM47XX: add Belkin F7Dxxxx board detection
From:   Cody P Schafer <devel@codyps.com>
To:     =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <dev@codyps.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: devel@codyps.com
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

On Thu, Jan 2, 2014 at 1:35 PM, Rafał Miłecki <zajec5@gmail.com> wrote:
> 2014/1/2 Hauke Mehrtens <hauke@hauke-m.de>:
>> From: Cody P Schafer <devel@codyps.com>
>>
>> Add a few Belkin F7Dxxxx entries, with F7D4401 sourced from online
>> documentation and the "F7D7302" being observed. F7D3301, F7D3302, and
>> F7D4302 are reasonable guesses which are unlikely to cause
>> mis-detection.
>>
>> It also appears that at least the F7D3302, F7D3301, F7D7301, and F7D7302
>> have a shared boardtype and boardrev, so use that as a fallback to a
>> "generic" F7Dxxxx board.
>
> Cody, Hauke: I'm starring at this patch for 10 minutes now and it's
> still unclear for me.
>
> You say 3301, 3302, 7301 and 7302 have the same board_* entries
> stating they can be treated with a generic ID entry.

I included the generic BCM47XX_BOARD_BELKIN_F7DXXXX entry to catch
those boards that we don't yet have specific entries for. It allows us
to get the leds and buttons working mostly correctly.

The specific names are included so that one can determine a more exact
board. The stock CFE requires different images for different boards
even though they are very similar. Hardware variations are simply
gigabit vs 100MB switches, usb port population, led population, and
5Ghz radio population (none of which truly require the greater detail
in board type).

> At the same time
> you define BELKIN_F7D3301 and BELKIN_F7D3302... so they are not
> identical after all?

[rehash of above] They have the same boardtype & boardrev, but
(unfortunately) have different image requirements from the stock CFE.

> Finally what about 4302? I can see it's untested,
> but for some reason you assign it to the separated enum entry. Is this
> not going to share config with the generic ones?

Sorry, I've had this patch go though a couple revisions (adding more
boards), and not all of them made it into the patch description. (4302
is just another variation on the generic f7dxxxx board).

> Sorry, but it looks really messy to me.

We can thank Belkin for that (see CFE issues mentioned above that
cause us to want these more specific BCM47XX_BOARD_* macros).


As an alternate to exposing the specific board names via this
interface, we (openwrt) could use the nvram userspace tool to look for
the specific type (the kernel really only needs the generic one,
unless we want to give a more accurate picture of which LEDs are
populated). Hauke - thoughts?
