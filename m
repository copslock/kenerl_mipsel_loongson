Received:  by oss.sgi.com id <S554002AbRAYTca>;
	Thu, 25 Jan 2001 11:32:30 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:34820 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S553994AbRAYTcI>; Thu, 25 Jan 2001 11:32:08 -0800
Received: from redhat.com (IDENT:joe@dhcp-4.wirespeed.com [172.16.17.4])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id NAA02948;
	Thu, 25 Jan 2001 13:27:13 -0600
Message-ID: <3A707FFB.60802@redhat.com>
Date:   Thu, 25 Jan 2001 13:35:23 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     Joe deBlaquiere <jadb@redhat.com>
CC:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org> <3A70705C.5020600@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

that didn't make sense, did it... ;o)

what I meant to say is that it works like

sysmips(MIPS_ATOMIC_SET,ptr,val)
{
	 *ptr = val ;
	val 0 ;
}

but it is an atomic operation

if this correct in a pseudo-code sense?

Joe deBlaquiere wrote:

> I'm trying to implement MIPS_ATOMIC_SET for the Vr4181, which has no ll, 
> sc operations. It looks to me like the function does something like
> 
> sysmips(MIPS_ATOMIC_SET,ptr,val)
> {
> 
> }
> 
> Florian Lohoff wrote:
> 
>> On Wed, Jan 24, 2001 at 04:59:19PM +0100, Florian Lohoff wrote:
>> 
>>> Decoded this is:
>>> 
>>> Unable to handle kernel paging request at virtual address 00000000, 
>>> epc == 00000000, ra == 00000000
>>> $0 : 00000000 1004fc00 fffffff2 00000001
>>> $4 : fffffff2 00000000 00000001 00000000
>>> $8 : 00000000 2abf3a94 8800f4a0 00000004
>>> $12: 8ec09f10 7ffffaf8 8ec09f18 8ec09f18
>>> $16: 8801acf8 00000000 10011510 00000002
>>> $20: 10011510 7ffffdd8 7ffffdcc 00000002
>>> $24: 00000000 2abf3a80
>>> $28: 8ec08000 8ec09ef8 7ffffd10 00000000
>>> epc   : 00000000
>>> Using defaults from ksymoops -t elf32-bigmips -a mips:3000
>>> Status: 1004fc03
>>> Cause : 30000008
>> 
>> 
>> 
>> Ok - another one (sorry to spam you)
>> 
>>>  From "handle_sys" i see that system call address and no of
>> 
>> args are in t2 and t3 which are 0x8800f4a0 and 4 with the register
>> dump above.
>> 
>> 8800f4a0 is sys_sysmips which i also saw in the find strace.
>> 
>>>  From the strace i find
>> 
>> 
>> sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
>> 
>> all the time - 0x7d1 is "MIPS_ATOMIC_SET" - Ok from the trace
>> i see the call comes from handle_sys which itself would end with
>> o32_ret_from_sys_call.
>> 
>> sysmips(MIPS_ATOMIC_SET, ...)
>> would itself return with "ret_from_sys_call".
>> 
>> If i now apply
>> 
>> Index: arch/mips/kernel/sysmips.c
>> ===================================================================
>> RCS file: /cvs/linux/arch/mips/kernel/sysmips.c,v
>> retrieving revision 1.15
>> diff -u -r1.15 sysmips.c
>> --- arch/mips/kernel/sysmips.c    2000/11/18 01:19:35    1.15
>> +++ arch/mips/kernel/sysmips.c    2001/01/25 15:48:44
>> @@ -111,7 +111,7 @@
>>  
>>          __asm__ __volatile__(
>>              "move\t$29, %0\n\t"
>> -            "j\tret_from_sys_call"
>> +            "j\to32_ret_from_sys_call"
>>              : /* No outputs */
>>              : "r" (&cmd));
>>          /* Unreached */
>> 
>> The machine now at least doesnt crash anymore - Others have to decide
>> if this is correct. (Nevertheless find doesnt return but this might
>> be a different problem)
>> 
>> Flo


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
