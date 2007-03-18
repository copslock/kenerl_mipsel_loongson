Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2007 21:38:13 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([63.240.77.82]:8676 "EHLO
	sccrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022842AbXCRViL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Mar 2007 21:38:11 +0000
Received: from [192.168.1.4] (c-68-34-70-207.hsd1.md.comcast.net[68.34.70.207])
          by comcast.net (sccrmhc12) with ESMTP
          id <20070318213728012008jte7e>; Sun, 18 Mar 2007 21:37:28 +0000
Message-ID: <45FDB118.4050208@gentoo.org>
Date:	Sun, 18 Mar 2007 17:37:28 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	post@pfrst.de
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
References: <45D8B070.7070405@gentoo.org> <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com> <45FC3923.2080207@gentoo.org> <Pine.LNX.4.58.0703181006450.396@Indigo2.Peter> <45FDAE77.1040800@gentoo.org>
In-Reply-To: <45FDAE77.1040800@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> peter fuerst wrote:
>>
>> Hi!
>>
>> Did you try to use PHYS_OFFSET > 0 ?  __pa() ist still (as of
>> d3fbd83ff545e49e2a0a5ca0f00dda4eedaf8be7) defined as (casts omitted):
>>
>> #define __pa(x) (x - (x < CKSEG0 ? PAGE_OFFSET:CKSEG0) + PHYS_OFFSET)
>>
>> This gives __pa(CKSEG0) == PHYS_OFFSET, which will never work for
>> PHYS_OFFSET > 0. A quick fix (assuming this was the cause for failure)
>> could be:
>>
>> ========================================================================
>> --- 
>> d3fbd83ff545e49e2a0a5ca0f00dda4eedaf8be7/include/asm-mips/page.h    
>> Sat Mar 10 08:43:17 2007
>> +++ quickfix/include/asm-mips/page.h    Sun Mar 18 10:24:34 2007
>> @@ -150,7 +150,7 @@ typedef struct { unsigned long pgprot; }
>>   * __pa()/__va() should be used only during mem init.
>>   */
>>  #if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
>> -#define __pa_page_offset(x)    ((unsigned long)(x) < CKSEG0 ? 
>> PAGE_OFFSET : CKSEG0)
>> +#define __pa_page_offset(x)    ((unsigned long)(x) < CKSEG0 ? 
>> PAGE_OFFSET : CKSEG0+PHYS_OFFSET)
>>  #else
>>  #define __pa_page_offset(x)    PAGE_OFFSET
>>  #endif
>>
>>
>> Signed-off-by: peter fuerst <post@pfrst.de>
>>
>> ========================================================================
>>
>> Of course, "#define PAGE_OFFSET (CAC_BASE + PHYS_OFFSET)" is also needed.
>>
>> kind regards
>>
>> peter
> 
> Hmm, I can't find where PHYS_OFFSET is defined for mips.  A grep shows 
> it mostly existing for the arm arch.  Is there an alternative macro 
> available, or is this something that needs porting over?
> 
> 
> --Kumba

Ah, duh.  PHYS_OFFSET was introduced post-2.6.20, so I won't be able to leverage 
this w/o backporting.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
