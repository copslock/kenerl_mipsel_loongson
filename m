Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jul 2016 14:53:01 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:58756 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992483AbcGQMwyx9Nm0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jul 2016 14:52:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 4D960B91970;
        Sun, 17 Jul 2016 14:52:54 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 765ADB91945;
        Sun, 17 Jul 2016 14:52:26 +0200 (CEST)
Received: by mail-vk0-f42.google.com with SMTP id j126so155020884vkg.3;
        Sun, 17 Jul 2016 05:52:26 -0700 (PDT)
X-Gm-Message-State: ALyK8tJZ5rxvMOmfv56v2HjrKXirxLnnhdyoTYLvbW7JY1aJz8KGPykSSOwGlu3/ZGVkAOXPkMf2QKti/VkUNw==
X-Received: by 10.31.74.199 with SMTP id x190mr15199115vka.42.1468759945196;
 Sun, 17 Jul 2016 05:52:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.64.101 with HTTP; Sun, 17 Jul 2016 05:52:05 -0700 (PDT)
In-Reply-To: <1468758512.6100.10.camel@chimera>
References: <1466414857-30456-1-git-send-email-jogo@openwrt.org>
 <1466414857-30456-3-git-send-email-jogo@openwrt.org> <1468758512.6100.10.camel@chimera>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 17 Jul 2016 14:52:05 +0200
X-Gmail-Original-Message-ID: <CAOiHx==dcJMTaHggOW1skRcAfL7Zu3rOXGytvbz0rMi8O=zBcA@mail.gmail.com>
Message-ID: <CAOiHx==dcJMTaHggOW1skRcAfL7Zu3rOXGytvbz0rMi8O=zBcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MIPS: store the appended dtb address in a variable
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Antony Pavlov <antonynpavlov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On 17 July 2016 at 14:28, Daniel Gimpelevich
<daniel@gimpelevich.san-francisco.ca.us> wrote:
> On Mon, 2016-06-20 at 11:27 +0200, Jonas Gorski wrote:
>> Instead of rewriting the arguments to match the UHI spec, store the
>> address of a appended or UHI supplied dtb in fw_supplied_dtb.
>>
>> That way the original bootloader arugments are kept intact while still
>> making the use of an appended dtb invisible for mach code.
>>
>> Mach code can still find out if it is an appended dtb by comparing
>> fw_arg1 with fw_supplied_dtb.
>>
>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>> ---
>> v1 -> v2:
>>  * no changes
>>
>>  arch/mips/ath79/setup.c          |  4 ++--
>>  arch/mips/bmips/setup.c          |  4 ++--
>>  arch/mips/include/asm/bootinfo.h |  4 ++++
>>  arch/mips/kernel/head.S          | 21 ++++++++++++++-------
>>  arch/mips/kernel/setup.c         |  4 ++++
>>  arch/mips/lantiq/prom.c          |  4 ++--
>>  arch/mips/pic32/pic32mzda/init.c |  4 ++--
>>  7 files changed, 30 insertions(+), 15 deletions(-)
> [snip]
>> -       else if (fw_arg0 == -2) /* UHI interface */
>> -               dtb = (void *)fw_arg1;
>> +       else if (fw_passed_dtb) /* UHI interface */
>> +               dtb = (void *)fw_passed_dtb;
>
> I just now realized that this is also incorrect, on each platform. The
> check for fw_passed_dtb should be in addition (prior) to checking for
> UHI via fw_arg0 == -2, not instead of it.

No it isn't, the code in head.S already does this, so there is no need
to check fw_arg0 again, unless you need to know if this was an
appended dtb or a UHI passed one. The whole point of using
fw_passed_dtb is that you *don't* need to check individually for UHI
and appended dtb.


Jonas
