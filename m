Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 23:47:59 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:49072 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825710AbaABWrY4sZ30 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 23:47:24 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C6D818F62;
        Thu,  2 Jan 2014 23:47:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TcGq5+487QTj; Thu,  2 Jan 2014 23:47:17 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:19e2:b924:c8e0:1c32] (unknown [IPv6:2001:470:1f0b:447:19e2:b924:c8e0:1c32])
        by hauke-m.de (Postfix) with ESMTPSA id 45AE5857F;
        Thu,  2 Jan 2014 23:47:17 +0100 (CET)
Message-ID: <52C5EC73.1090201@hauke-m.de>
Date:   Thu, 02 Jan 2014 23:47:15 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Cody P Schafer <devel@codyps.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/4] MIPS: BCM47XX: add Belkin F7Dxxxx board detection
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de> <CACna6rw1_QXXk0g9tpWVsx5G1zbNQdun5edHkSzkabVfLuxL4A@mail.gmail.com> <CAPoQQ-35pFjDq7j_nLPQdCrKnibcaQCha9a5XbVJxv9UQvsW_w@mail.gmail.com>
In-Reply-To: <CAPoQQ-35pFjDq7j_nLPQdCrKnibcaQCha9a5XbVJxv9UQvsW_w@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 01/02/2014 11:03 PM, Cody P Schafer wrote:
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
> 
>> At the same time
>> you define BELKIN_F7D3301 and BELKIN_F7D3302... so they are not
>> identical after all?
> 
> [rehash of above] They have the same boardtype & boardrev, but
> (unfortunately) have different image requirements from the stock CFE.
> 
>> Finally what about 4302? I can see it's untested,
>> but for some reason you assign it to the separated enum entry. Is this
>> not going to share config with the generic ones?
> 
> Sorry, I've had this patch go though a couple revisions (adding more
> boards), and not all of them made it into the patch description. (4302
> is just another variation on the generic f7dxxxx board).
> 
>> Sorry, but it looks really messy to me.
> 
> We can thank Belkin for that (see CFE issues mentioned above that
> cause us to want these more specific BCM47XX_BOARD_* macros).
> 
> 
> As an alternate to exposing the specific board names via this
> interface, we (openwrt) could use the nvram userspace tool to look for
> the specific type (the kernel really only needs the generic one,
> unless we want to give a more accurate picture of which LEDs are
> populated). Hauke - thoughts?
> 

If it is possible to detect the specific board I would go with that. At
least when the led configuration is different we have to do different
things for the different boards. In the current way it does not take a
lot of memory to add a new board to the detect code just some bytes  <
50 in init ram. I would remove the generic entry now and leave the
others in, if someone has a different board we can add it.

Hauke
