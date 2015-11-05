Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 15:27:05 +0100 (CET)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:44849
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011195AbbKEO1DMHmYe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2015 15:27:03 +0100
Subject: Re: [PATCH V2 4/9] arch: mips: ralink: add tty detection
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1446692398-44153-1-git-send-email-blogic@openwrt.org>
 <563B62AC.9000407@cogentembedded.com>
Cc:     linux-mips@linux-mips.org
From:   John Crispin <john@phrozen.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <563B6735.2080505@phrozen.org>
Date:   Thu, 5 Nov 2015 15:27:01 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <563B62AC.9000407@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi,

On 05/11/2015 15:07, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/5/2015 5:59 AM, John Crispin wrote:
> 
>> MT7688 has several uarts that can be used for console. There are several
>> boards in the wild, that use ttyS1 or ttyS2. This patch applies a simply
>> autodetection routine to figure out which ttyS the bootloader used as
>> console. The uarts come up in 6 bit mode by default. The bootloader will
>> have set 8 bit mode on the console. Find that 8bit tty and use it.
>>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> ---
>> Changes in V2:
>> * remove superflous inline definition
>>
>>   arch/mips/ralink/early_printk.c |   26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/mips/ralink/early_printk.c
>> b/arch/mips/ralink/early_printk.c
>> index 255d695..3c59ffe 100644
>> --- a/arch/mips/ralink/early_printk.c
>> +++ b/arch/mips/ralink/early_printk.c
> [...]
>> @@ -47,8 +49,32 @@ static inline int soc_is_mt7628(void)
>>           (__raw_readl(chipid_membase) == MT7628_CHIP_NAME1);
>>   }
>>
>> +static void find_uart_base(void)
>> +{
>> +    int i;
>> +
>> +    if (!soc_is_mt7628())
>> +        return;
>> +
>> +    for (i = 0; i < 3; i++) {
>> +        u32 reg = uart_r32(UART_REG_LCR + (0x100 * i));
> 
>    Inner parens not needed, the operator precedence is natural.
> 

"not needed" means "should be removed" or "not needed".

checkpatch.pl certainly did not complain and a quick look around
instantly yielded lots of places in the kernel where this is done. imho
the brackets make it more readable

	John

>> +
>> +        if (!reg)
>> +            continue;
>> +
>> +        uart_membase = (__iomem void *) KSEG1ADDR(EARLY_UART_BASE +
>> +                              (0x100 * i));
> 
>    Likewise.
>    Sorry for not noticing this before.
> 
> MBR, Sergei
> 
> 
