Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 19:19:50 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11973 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492654Ab0DZRTr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Apr 2010 19:19:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd5cb400000>; Mon, 26 Apr 2010 10:20:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 26 Apr 2010 10:19:10 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 26 Apr 2010 10:19:09 -0700
Message-ID: <4BD5CB08.7010907@caviumnetworks.com>
Date:   Mon, 26 Apr 2010 10:19:04 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     wuzhangjin@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>        <1271135034.25797.41.camel@falcon> <20100413073435.GA6371@alpha.franken.de>     <20100413171610.GA16578@linux-mips.org> <1271232185.25872.142.camel@falcon>
In-Reply-To: <1271232185.25872.142.camel@falcon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2010 17:19:09.0995 (UTC) FILETIME=[956D77B0:01CAE564]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/14/2010 01:03 AM, Wu Zhangjin wrote:
> On Tue, 2010-04-13 at 18:16 +0100, Ralf Baechle wrote:
>> On Tue, Apr 13, 2010 at 09:34:38AM +0200, Thomas Bogendoerfer wrote:
>>
>>> On Tue, Apr 13, 2010 at 01:03:54PM +0800, Wu Zhangjin wrote:
>>>> This patch have broken the support to the MIPS variants whose
>>>> cpu_has_mips_r2 is 0 for the CAC_BASE and CKSEG0 is completely different
>>>> in these MIPSs.
>>>
>>> I've checked R4k and R10k manulas and the exception base is at CKSEG0, so
>>> about CPU we are talking ? And wouldn't it make for senso to have
>>> an extra define for the exception base then ?
>>
>> C0_ebase's design was a short-sigthed only considering 32-bit processors.
>> So the exception base is in CKSEG0 on every 64-bit processor, be it R2 or
>> older.  So yes, there is a bug as I've verified by testing but the patch
>> is unfortunately incorrect.
>
> Just debugged it via PMON:
>
> loaded the kernel and used "g console=tty root=/dev/hda5 init=/bin/bash"
> to start the kernel, there was a bad address exception.
>
> the kernel stopped at:
>
> Exception Cause=address error on store, SR=0x24000002, PC=0x8020526c
> ...
> BADVADDR=0x97ffffff80000100, ENTHI=0xfffffe000
> ...
> ...
> __copy_user+0x48  ... sd  t0,0(a0)  # addr = 0x80000100 rt=0x401a8000
>
> Seems the a0 argument of __copy_user is _bad_.
>
> And tried to set a break pointer to trap_init() and per_cpu_trap_init(),
> and then cpu_cache_init() ... r4k_cache_init() and at last found that
> set_uncached_handler(0x100,&except_vec2_generic, 0x80);
>
> /*
>   * Install uncached CPU exception handler.
>   * This is suitable only for the cache error exception which is the only
>   * exception handler that is being run uncached.
>   */
> void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
>          unsigned long size)
> {
> #ifdef CONFIG_32BIT
>          unsigned long uncached_ebase = KSEG1ADDR(ebase);
> #endif
> #ifdef CONFIG_64BIT
>          unsigned long uncached_ebase = TO_UNCAC(ebase);
> #endif
>
>          if (!addr)
>                  panic(panic_null_cerr);
>
>          memcpy((void *)(uncached_ebase + offset), addr, size);
> }
>
> memcpy() called __copy_user... and the a0 is uncached_ebase + offset,
> and uncached_ebase is defined by TO_UNCAC:
>
> #define TO_UNCAC(x)             (UNCAC_BASE | ((x)&  TO_PHYS_MASK))
> #define TO_PHYS_MASK _CONST64_(0x07ffffffffffffff)
> #define UNCAC_BASE _AC(0x9000000000000000, UL)
>
> If using CKSEG0 as the ebase, CKSEG0 is defined as 0xffffffff80000000,
> then we get the address: 0x97ffffff80000100, is this address ok?

I don't think so.  We should fix TO_UNCAC() so that it works with CKSEG0 
addresses.  It should be at physical address 0.  So 
TO_UNCAC(0xffffffff80000000), should yield 0x9000000000000000


#define TO_UNCAC(x) ({ \
	u64 a = (u64)(x);     \
	if (a & 0xffffffffc000000 == 0xffffffff80000000) \
		a = UNCAC_BASE | (a & 0x30000000); \
	else \
		a = UNCAC_BASE | (a & TO_PHYS_MASK) \
	a; \
})

David Daney


>
> And before, we have used the CAC_BASE as the ebase, the CAC_BASE is
> defined as following:
>
> #ifndef CAC_BASE
> #ifdef CONFIG_DMA_NONCOHERENT
> #define CAC_BASE                _AC(0x9800000000000000, UL)
> #else
> #define CAC_BASE                _AC(0xa800000000000000, UL)
> #endif
> #endif
>
> So, before, the uncached_base is 0x9000000000000000.
>
> Regards,
> 	Wu Zhangjin
>
>
