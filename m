Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 15:57:11 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53006 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831315Ab3HPN5HT8QNE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 15:57:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 05E67260AE8;
        Fri, 16 Aug 2013 15:57:01 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YWkxsScUW9gu; Fri, 16 Aug 2013 15:57:00 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id A6157260A99;
        Fri, 16 Aug 2013 15:57:00 +0200 (CEST)
Message-ID: <520E2FC9.1040603@openwrt.org>
Date:   Fri, 16 Aug 2013 15:57:29 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@gmail.com>
CC:     Jonas Gorski <jogo@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ath79: Avoid using unitialized 'reg' variable
References: <1376384478-27424-1-git-send-email-markos.chandras@imgtec.com> <CAOiHx==9E9m5Ds0trutySyaxM0VLJfh1+LKcxYfWFWFt-8dx1A@mail.gmail.com> <CAG2jQ8iUWU83xWqfYF=ev9Gfxsx6ocBK-0wLaQs8QE=d2+5NmA@mail.gmail.com> <CAG2jQ8gkQgGYcsz4x7wgnhq18EzyK5qe64CLR3+iefqb8hGEvQ@mail.gmail.com>
In-Reply-To: <CAG2jQ8gkQgGYcsz4x7wgnhq18EzyK5qe64CLR3+iefqb8hGEvQ@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

Hi Markos,
> On 15 August 2013 14:42, Markos Chandras <markos.chandras@gmail.com> wrote:
>> On 14 August 2013 12:12, Jonas Gorski <jogo@openwrt.org> wrote:
>>> Hi,
>>>
>>> On Tue, Aug 13, 2013 at 11:01 AM, Markos Chandras
>>> <markos.chandras@imgtec.com> wrote:
>>>> Fixes the following build error:
>>>> arch/mips/include/asm/mach-ath79/ath79.h:139:20: error: 'reg' may be used
>>>> uninitialized in this function [-Werror=maybe-uninitialized]
>>>> arch/mips/ath79/common.c:62:6: note: 'reg' was declared here
>>>> In file included from arch/mips/ath79/common.c:20:0:
>>>> arch/mips/ath79/common.c: In function 'ath79_device_reset_clear':
>>>> arch/mips/include/asm/mach-ath79/ath79.h:139:20:
>>>> error: 'reg' may be used uninitialized in this function
>>>> [-Werror=maybe-uninitialized]
>>>> arch/mips/ath79/common.c:90:6: note: 'reg' was declared here
>>>>
>>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>>> ---

<snip>

>>>> +       } else {
>>>>                 BUG();
>>>> +               panic("Unknown SOC!");
>>>
>>> Both BUG() and panic() seems to be a bit overkill, especially since
>>> the panic won't be reached unless BUG is disabled - just the panic()
>>> should be enough.
>>>
>>> Also the panic message isn't very helpful, maybe print the raw id of
>>> the SoC here?
>>>
>>>
>>
>> Hi Jonas,
>>
>> Thank you for the review. I will submit a new patch.
>>
>> --
>> Regards,
>> Markos Chandras
> 
> Hi Jonas,
> 
> I had a look at the code again and it seems that reporting the 'id' is
> not needed since an unknown SOC will cause a panic
> earlier in the boot process. Look at arch/mips/ath79/setup.c, in the
> plat_mem_setup function.
> This one calls ath79_detect_sys_type which causes the following panic
> if an unknown SOC is detected.
> 
> panic("ath79: unknown SoC, id:0x%08x", id);
> 
> This makes me think that ath79_device_reset_set and
> ath79_device_reset_clear should not care about an unknown SOC at all.
> 

The BUG() call helps to ensure that the ath79_device_reset{clear,set} functions
will be modified when someone adds support for a new SoC. So I prefer to have a
panic() or at least a WARN()+return here. However, instead of the 'Unknown SoC!'
message, a 'reset register is not defined for the SoC' text would be more
meaningful given the actual context.

-Gabor
