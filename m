Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 18:26:50 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:39276 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012618AbbKER0s0Bmkl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Nov 2015 18:26:48 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 194BF28A98D;
        Thu,  5 Nov 2015 18:24:53 +0100 (CET)
Received: from Dicker-Alter.lan (p548C9511.dip0.t-ipconnect.de [84.140.149.17])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu,  5 Nov 2015 18:24:53 +0100 (CET)
Subject: Re: [PATCH V2 4/9] arch: mips: ralink: add tty detection
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1446692398-44153-1-git-send-email-blogic@openwrt.org>
 <563B62AC.9000407@cogentembedded.com> <563B6735.2080505@phrozen.org>
 <563B902B.3060702@cogentembedded.com>
Cc:     linux-mips@linux-mips.org
From:   John Crispin <blogic@openwrt.org>
Message-ID: <563B9152.3050906@openwrt.org>
Date:   Thu, 5 Nov 2015 18:26:42 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <563B902B.3060702@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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



On 05/11/2015 18:21, Sergei Shtylyov wrote:
> On 11/05/2015 05:27 PM, John Crispin wrote:
> 
>>>> MT7688 has several uarts that can be used for console. There are
>>>> several
>>>> boards in the wild, that use ttyS1 or ttyS2. This patch applies a
>>>> simply
>>>> autodetection routine to figure out which ttyS the bootloader used as
>>>> console. The uarts come up in 6 bit mode by default. The bootloader
>>>> will
>>>> have set 8 bit mode on the console. Find that 8bit tty and use it.
>>>>
>>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>>> ---
>>>> Changes in V2:
>>>> * remove superflous inline definition
>>>>
>>>>    arch/mips/ralink/early_printk.c |   26 ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/arch/mips/ralink/early_printk.c
>>>> b/arch/mips/ralink/early_printk.c
>>>> index 255d695..3c59ffe 100644
>>>> --- a/arch/mips/ralink/early_printk.c
>>>> +++ b/arch/mips/ralink/early_printk.c
>>> [...]
>>>> @@ -47,8 +49,32 @@ static inline int soc_is_mt7628(void)
>>>>            (__raw_readl(chipid_membase) == MT7628_CHIP_NAME1);
>>>>    }
>>>>
>>>> +static void find_uart_base(void)
>>>> +{
>>>> +    int i;
>>>> +
>>>> +    if (!soc_is_mt7628())
>>>> +        return;
>>>> +
>>>> +    for (i = 0; i < 3; i++) {
>>>> +        u32 reg = uart_r32(UART_REG_LCR + (0x100 * i));
>>>
>>>     Inner parens not needed, the operator precedence is natural.
>>>
>>
>> "not needed" means "should be removed" or "not needed".
> 
>    That's completely up to you.
> 
>> checkpatch.pl certainly did not complain and a quick look around
>> instantly yielded lots of places in the kernel where this is done. imho
>> the brackets make it more readable
> 
>    Do you really always write 2 + (3 * 4) when you e.g. use scientific
> calculator?

no that would be silly. when using a calculator i know what i am typing.
unless there is someone looking over my shoulder i am the only one that
needs to understand.

when i write software that others are supposed to read which has
"register + (bank * bank offset)" constructs in it then i tend to add
brackets.

	John

> 
> [...]
> 
> MBR, Sergei
