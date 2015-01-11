Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 13:45:15 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:43692 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010140AbbAKMpNptNDZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 13:45:13 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 204031538A; Sun, 11 Jan 2015 12:45:08 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart handler
References: <1420914550-18335-1-git-send-email-lars@metafoo.de>
        <yw1xh9vyflfw.fsf@unicorn.mansr.com> <54B1CF9B.3060606@roeck-us.net>
        <yw1xd26lfr93.fsf@unicorn.mansr.com> <54B26BB4.50707@metafoo.de>
        <yw1x8uh9fqj1.fsf@unicorn.mansr.com> <54B26F5C.8050202@metafoo.de>
Date:   Sun, 11 Jan 2015 12:45:08 +0000
In-Reply-To: <54B26F5C.8050202@metafoo.de> (Lars-Peter Clausen's message of
        "Sun, 11 Jan 2015 13:41:00 +0100")
Message-ID: <yw1x4mrxfpuz.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Lars-Peter Clausen <lars@metafoo.de> writes:

> On 01/11/2015 01:30 PM, M�ns Rullg�rd wrote:
>> Lars-Peter Clausen <lars@metafoo.de> writes:
>>
>>> On 01/11/2015 01:15 PM, M�ns Rullg�rd wrote:
>>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>>
>>>>> On 01/10/2015 12:08 PM, M�ns Rullg�rd wrote:
>>>>>> Lars-Peter Clausen <lars@metafoo.de> writes:
>>>>>>
>>>>>>> Use the recently introduced do_kernel_restart() function as the default restart
>>>>>>> handler if the platform did not explicitly provide a restart handler. This
>>>>>>> allows use restart handler that have been registered by device drivers to
>>>>>>> restart the machine.
>>>>>>>
>>>>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>>>>> ---
>>>>>>>     arch/mips/kernel/reset.c |    2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
>>>>>>> index 07fc524..36cd80c 100644
>>>>>>> --- a/arch/mips/kernel/reset.c
>>>>>>> +++ b/arch/mips/kernel/reset.c
>>>>>>> @@ -19,7 +19,7 @@
>>>>>>>      * So handle all using function pointers to machine specific
>>>>>>>      * functions.
>>>>>>>      */
>>>>>>> -void (*_machine_restart)(char *command);
>>>>>>> +void (*_machine_restart)(char *command) = do_kernel_restart;
>>>>>>>     void (*_machine_halt)(void);
>>>>>>>     void (*pm_power_off)(void);
>>>>>>
>>>>>> There is already a similar patch posted by Kevin Cernekee:
>>>>>> http://www.linux-mips.org/archives/linux-mips/2014-12/msg00410.html
>>>>>>
>>>>> Personally I prefer the earlier patch, though I guess that is personal
>>>>> preference.
>>>>
>>>> They both achieve the same thing, though Kevin's is more in line with
>>>> what ARM does.  Missing from both is a fallback while(1) loop in case no
>>>> restart handlers are registered.  With the restart moved to the watchdog
>>>> driver, there's a possibility that this might happen.
>>>>
>>>
>>> In my opinion if such a fallback is needed it should be put into the
>>> kernel core reboot implementation and not into individual restart
>>> handler implementations.
>>>
>>> My first version of this patch was do_kernel_restart() followed by a
>>> machine_halt() (so it goes to sleep instead of busy looping) as a
>>> fallback. But I couldn't find a good reason why that should be done at
>>> the individual restart handler level, so I dropped it.
>>
>> ARM does it its arch machine_restart() function.  MIPS should probably
>> follow suit.
>>
>
> That's just cargo culting...

True.

> Either it is required, then it should probably be moved into the core
> kernel, or it is not required in which case it can be removed from the
> ARM machine_restart() implementation.

The quickest way to find out is probably to send a patch adding such
code to the end of kernel_restart().

-- 
M�ns Rullg�rd
mans@mansr.com
