Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jul 2016 15:48:21 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:59042 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992544AbcGQNsOphO9K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jul 2016 15:48:14 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 0AEBAB911EB;
        Sun, 17 Jul 2016 15:48:14 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.0.2] (dslb-088-073-002-213.088.073.pools.vodafone-ip.de [88.73.2.213])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5339DB911E2;
        Sun, 17 Jul 2016 15:48:04 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] MIPS: store the appended dtb address in a variable
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
References: <1466414857-30456-1-git-send-email-jogo@openwrt.org>
 <1466414857-30456-3-git-send-email-jogo@openwrt.org>
 <1468758512.6100.10.camel@chimera>
 <CAOiHx==dcJMTaHggOW1skRcAfL7Zu3rOXGytvbz0rMi8O=zBcA@mail.gmail.com>
 <1468760611.6100.20.camel@chimera>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Antony Pavlov <antonynpavlov@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Message-ID: <b01cce22-7e1f-05e0-74b4-87a84d26df64@openwrt.org>
Date:   Sun, 17 Jul 2016 15:48:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1468760611.6100.20.camel@chimera>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54344
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

On 17.07.2016 15:03, Daniel Gimpelevich wrote:
> On Sun, 2016-07-17 at 14:52 +0200, Jonas Gorski wrote:
>> On 17 July 2016 at 14:28, Daniel Gimpelevich
>> <daniel@gimpelevich.san-francisco.ca.us> wrote:
>>> On Mon, 2016-06-20 at 11:27 +0200, Jonas Gorski wrote:
>>>> Instead of rewriting the arguments to match the UHI spec, store the
>>>> address of a appended or UHI supplied dtb in fw_supplied_dtb.
>>>>
>>>> That way the original bootloader arugments are kept intact while still
>>>> making the use of an appended dtb invisible for mach code.
>>>>
>>>> Mach code can still find out if it is an appended dtb by comparing
>>>> fw_arg1 with fw_supplied_dtb.
>>>>
>>>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>>>> ---
>>>> v1 -> v2:
>>>>  * no changes
>>>>
>>>>  arch/mips/ath79/setup.c          |  4 ++--
>>>>  arch/mips/bmips/setup.c          |  4 ++--
>>>>  arch/mips/include/asm/bootinfo.h |  4 ++++
>>>>  arch/mips/kernel/head.S          | 21 ++++++++++++++-------
>>>>  arch/mips/kernel/setup.c         |  4 ++++
>>>>  arch/mips/lantiq/prom.c          |  4 ++--
>>>>  arch/mips/pic32/pic32mzda/init.c |  4 ++--
>>>>  7 files changed, 30 insertions(+), 15 deletions(-)
>>> [snip]
>>>> -       else if (fw_arg0 == -2) /* UHI interface */
>>>> -               dtb = (void *)fw_arg1;
>>>> +       else if (fw_passed_dtb) /* UHI interface */
>>>> +               dtb = (void *)fw_passed_dtb;
>>>
>>> I just now realized that this is also incorrect, on each platform. The
>>> check for fw_passed_dtb should be in addition (prior) to checking for
>>> UHI via fw_arg0 == -2, not instead of it.
>>
>> No it isn't, the code in head.S already does this, so there is no need
>> to check fw_arg0 again, unless you need to know if this was an
>> appended dtb or a UHI passed one. The whole point of using
>> fw_passed_dtb is that you *don't* need to check individually for UHI
>> and appended dtb.
>>
>>
>> Jonas
> 
> Not quite. The idea behind the old code was to mimic UHI bootloaders so
> that the kernel would not distinguish between them and a passed DTB.
> With fw_passed_dtb separate, the case of a real UHI bootloader is
> unhandled unless fw_arg0 is checked separately after it. It cannot
> presently be known for certain which platforms will have UHI available,
> and it does not hurt the kernel to conform to an overall MIPS spec even
> when unused, so removing the check for fw_arg0 even in the presence of a
> check for fw_passed_dtb at this point is feature removal, which there is
> no need to do.

Did you even read the code or what I wrote?

> On Sun, 2016-07-17 at 14:52 +0200, Jonas Gorski wrote:
>> No it isn't, the code in head.S already does this
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

in simplified pseudo c-code:

if (IS_ENABLED(APPENDED_DTB) && *__appended_dtb == FDT_MAGIC)
	fw_passed_dtb = __appended_dtb;
else if (fw_arg0 == -2) <- UHI interface
	fw_passed_dtb = fw_arg1;
else
	fw_passed_dtb = 0;

So if the the bootloader uses UHI, then fw_passed_dtb *will* be populated.
There is no need to check for it again from arch code.


Jonas
