Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 13:25:30 +0100 (CET)
Received: from smtp-out-127.synserver.de ([212.40.185.127]:1039 "EHLO
        smtp-out-127.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010895AbbAKMZ2QBKmS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 13:25:28 +0100
Received: (qmail 6493 invoked by uid 0); 11 Jan 2015 12:25:25 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 6427
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO ?192.168.178.23?) [88.217.3.222]
  by 217.119.54.87 with AES128-SHA encrypted SMTP; 11 Jan 2015 12:25:25 -0000
Message-ID: <54B26BB4.50707@metafoo.de>
Date:   Sun, 11 Jan 2015 13:25:24 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
MIME-Version: 1.0
To:     =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart
 handler
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <yw1xh9vyflfw.fsf@unicorn.mansr.com> <54B1CF9B.3060606@roeck-us.net> <yw1xd26lfr93.fsf@unicorn.mansr.com>
In-Reply-To: <yw1xd26lfr93.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 01/11/2015 01:15 PM, Måns Rullgård wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>
>> On 01/10/2015 12:08 PM, Måns Rullgård wrote:
>>> Lars-Peter Clausen <lars@metafoo.de> writes:
>>>
>>>> Use the recently introduced do_kernel_restart() function as the default restart
>>>> handler if the platform did not explicitly provide a restart handler. This
>>>> allows use restart handler that have been registered by device drivers to
>>>> restart the machine.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> ---
>>>>    arch/mips/kernel/reset.c |    2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
>>>> index 07fc524..36cd80c 100644
>>>> --- a/arch/mips/kernel/reset.c
>>>> +++ b/arch/mips/kernel/reset.c
>>>> @@ -19,7 +19,7 @@
>>>>     * So handle all using function pointers to machine specific
>>>>     * functions.
>>>>     */
>>>> -void (*_machine_restart)(char *command);
>>>> +void (*_machine_restart)(char *command) = do_kernel_restart;
>>>>    void (*_machine_halt)(void);
>>>>    void (*pm_power_off)(void);
>>>
>>> There is already a similar patch posted by Kevin Cernekee:
>>> http://www.linux-mips.org/archives/linux-mips/2014-12/msg00410.html
>>>
>> Personally I prefer the earlier patch, though I guess that is personal
>> preference.
>
> They both achieve the same thing, though Kevin's is more in line with
> what ARM does.  Missing from both is a fallback while(1) loop in case no
> restart handlers are registered.  With the restart moved to the watchdog
> driver, there's a possibility that this might happen.
>

In my opinion if such a fallback is needed it should be put into the kernel 
core reboot implementation and not into individual restart handler 
implementations.

My first version of this patch was do_kernel_restart() followed by a 
machine_halt() (so it goes to sleep instead of busy looping) as a fallback. 
But I couldn't find a good reason why that should be done at the individual 
restart handler level, so I dropped it.

- Lars
