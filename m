Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 11:07:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4811 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007224AbcDAJHjVGO-5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2016 11:07:39 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 9DC59B21F38D;
        Fri,  1 Apr 2016 10:07:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 1 Apr 2016 10:07:33 +0100
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 1 Apr
 2016 10:07:32 +0100
Subject: Re: [PATCH v2 11/11] MIPS: KASLR: Print relocation Information on
 boot
To:     Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
 <1459415142-3412-12-git-send-email-matt.redfearn@imgtec.com>
 <56FD1A32.10204@cogentembedded.com> <20160401084403.GA28123@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kernel-hardening@lists.openwall.com>,
        "Aaro Koskinen" <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <56FE3A54.4020102@imgtec.com>
Date:   Fri, 1 Apr 2016 10:07:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160401084403.GA28123@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 01/04/16 09:44, Ralf Baechle wrote:
> On Thu, Mar 31, 2016 at 03:38:10PM +0300, Sergei Shtylyov wrote:
>
>>> When debugging a relocated kernel, the addresses of the relocated
>>> symbols and the offset applied is essential information. If the kernel
>>> is compiled with debugging information, then print this information
>>> during bootup using the same function as the panic notifer.
>>     Notifier.
> Fixed when merging.
>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>> ---
>>>
>>> Changes in v2: None
>>>
>>>   arch/mips/kernel/setup.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>> index d8376d7b3345..ae71f8d9b555 100644
>>> --- a/arch/mips/kernel/setup.c
>>> +++ b/arch/mips/kernel/setup.c
>>> @@ -477,9 +477,18 @@ static void __init bootmem_init(void)
>>>   	 */
>>>   	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
>>>   		unsigned long offset;
>>> +		extern void show_kernel_relocation(const char *level);
>>>
>>>   		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
>>>   		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
>>> +
>>> +#if (defined CONFIG_DEBUG_KERNEL) && (defined CONFIG_DEBUG_INFO)
>>     Not #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)?
>>
>> [...]
> CPP syntax is not what most people seem to believe that is the parenthesis
> around the argument of defined are not required so above line is unusual
> but perfectly ok.  However following boring standards is good so I changed
> this, too.
>
>    Ralf

Great, thanks Ralf.

Matt
