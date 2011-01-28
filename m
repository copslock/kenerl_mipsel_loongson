Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2011 19:49:12 +0100 (CET)
Received: from [12.108.191.235] ([12.108.191.235]:14157 "EHLO
        mail3.caviumnetworks.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491120Ab1A1StJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jan 2011 19:49:09 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d430fd20000>; Fri, 28 Jan 2011 10:49:54 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 28 Jan 2011 10:49:04 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 28 Jan 2011 10:49:04 -0800
Message-ID: <4D430F9A.7040905@caviumnetworks.com>
Date:   Fri, 28 Jan 2011 10:48:58 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     naveen yadav <yad.naveen@gmail.com>
CC:     adnan iqbal <adnan.iqbal@seecs.edu.pk>, linux-mips@linux-mips.org,
        kernelnewbies@nl.linux.org
Subject: Re: page size change on MIPS
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>      <4D3DCB5A.6060107@caviumnetworks.com>   <AANLkTi=mbof+GbRuS-0hezDpj+XmA+jL7mE+kdjKJzd5@mail.gmail.com>  <AANLkTimbLenZ0+0NxN+EckjuJO6ezGimdw0FaqycFRRi@mail.gmail.com>  <4D41AEFC.5030609@caviumnetworks.com> <AANLkTin-D8KW2uDYkSbEsCuS2rPSetw23CLxkAqw7OYd@mail.gmail.com>
In-Reply-To: <AANLkTin-D8KW2uDYkSbEsCuS2rPSetw23CLxkAqw7OYd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2011 18:49:04.0158 (UTC) FILETIME=[09062BE0:01CBBF1C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/28/2011 01:18 AM, naveen yadav wrote:
> Hi all
>
> I try changing the kernel_execve() function as suggested, but it fails,
> I am using code sourcery toolchain 4.4.1 but it still fails. I am
> using 2.6.30.9 kernel and this function is part of it.
>
>

Quit trying to change kernel_execve().  It is perfect as it is.

The problem is elsewhere.


>
> Kind regards
>

Thank you.

>
> On Thu, Jan 27, 2011 at 11:14 PM, David Daney<ddaney@caviumnetworks.com>  wrote:
>> On 01/27/2011 07:18 AM, adnan iqbal wrote:
>>>
>>> Please try this. One line of code is added ( move    %1, $7).
>>>
>>>
>>> int kernel_execve(const char *filename, char *const argv[], char *const
>>> envp[])
>>> {
>>>         register unsigned long __a0 asm("$4") = (unsigned long) filename;
>>>         register unsigned long __a1 asm("$5") = (unsigned long) argv;
>>>         register unsigned long __a2 asm("$6") = (unsigned long) envp;
>>>         register unsigned long __a3 asm("$7");
>>>         unsigned long __v0;
>>>         __asm__ volatile ("                                     \n"
>>>         "       .set    noreorder                               \n"
>>>         "       li      $2, %5          # __NR_execve           \n"
>>>         "       syscall                                         \n"
>>>         "       move    %0, $2                                  \n"
>>>      "      move    %1, $7                    \n"
>>>         "       .set    reorder                                 \n"
>>>         : "=&r" (__v0), "=r" (__a3)
>>>         : "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_execve)
>>>         : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15",
>>> "$24",
>>>           "memory");
>>>
>>>
>>>         if (__a3 == 0)
>>>                 return __v0;
>>>         return -__v0;
>>> }
>>>
>>
>> I don't know where you got that code.  But really you should do what glibc
>> does.  glibc gets it correct.
>>
>> At a minimum you are missing "hi" and "lo" clobbers.

Ignore that ^^^^^ advice.

>>
>> If the code works with 16K pages, and not 64K pages, then this snippet is
>> not the problem.  Likely your problem is the layout of the PHDRs in the
>> executable is not compatible with the page size.
>>

Instead look at this issue.

>> David Daney
>>
>>
>>>
>>> On Thu, Jan 27, 2011 at 7:55 PM, naveen yadav<yad.naveen@gmail.com>
>>>   wrote:
>>>
>>>> Hi David,
>>>>
>>>> thanks for your response.
>>>>
>>>> I check and found that kernel is booting with 16KB page size with
>>>> ramdisk booting. But when I change to 64KB it give me
>>>>
>>>> : applet not found
>>>>                   Kernel panic - not syncing: Attempted to kill init!
>>>> so I check and found that it is not able to execute well the system
>>>> call in kernel_execve function.
>>>> I am using codesourcercy toolchain(4.3.1). So is there a way to debug
>>>> this problem or how to debug below function.
>>>>
>>>> int kernel_execve(const char *filename, char *const argv[], char *const
>>>> envp[])
>>>> {
>>>>         register unsigned long __a0 asm("$4") = (unsigned long) filename;
>>>>         register unsigned long __a1 asm("$5") = (unsigned long) argv;
>>>>         register unsigned long __a2 asm("$6") = (unsigned long) envp;
>>>>         register unsigned long __a3 asm("$7");
>>>>         unsigned long __v0;
>>>>         __asm__ volatile ("                                     \n"
>>>>         "       .set    noreorder                               \n"
>>>>         "       li      $2, %5          # __NR_execve           \n"
>>>>         "       syscall                                         \n"
>>>>         "       move    %0, $2                                  \n"
>>>>         "       .set    reorder                                 \n"
>>>>         : "=&r" (__v0), "=r" (__a3)
>>>>         : "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_execve)
>>>>         : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15",
>>>> "$24",
>>>>           "memory");
>>>>
>>>>
>>>>         if (__a3 == 0)
>>>>                 return __v0;
>>>>         return -__v0;
>>>> }
>>>>
>>>>
>>>> On Tue, Jan 25, 2011 at 12:26 AM, David Daney<ddaney@caviumnetworks.com>
>>>> wrote:
>>>>>
>>>>> On 01/24/2011 07:02 AM, naveen yadav wrote:
>>>>>>
>>>>>> Hi All,
>>>>>>
>>>>>>
>>>>>> we are using mips32r2  so I want to know which all pages size it can
>>>>>> support?
>>>>>> When I modify arch/mips/Kconfig.  it boot sucessfully on 16KB page
>>>>>> size. but hang/not boot crash when change page size to 8KB,32KB and 64
>>>>>> KB.
>>>>>
>>>>> I don't think 8KB and 32KB work on most mips32r2 processors.  You would
>>>>
>>>> have
>>>>>
>>>>> to check the processor manual to be sure.
>>>>>
>>>>>
>>>>>>
>>>>>> We are using 2.6.30 kernel.
>>>>>>
>>>>>> At Page Size 8KB and 32KB  it hang in unpack_to_rootfs() function of
>>>>>> init/initramfs.c
>>>>>>
>>>>>> 64KB it hangs when execute init  Kernel panic - not syncing: Attempted
>>>>>> to kill init!
>>>>>
>>>>> I regularly run 4K, 16K, and 64K page sizes with a Debian rootfs.  If
>>>>> you
>>>>> run with a broken uClibc toolchain that doesn't support larger pages, it
>>>>> will of course fail.  In this case the problem is with your toolchain,
>>>>
>>>> not
>>>>>
>>>>> the kernel.
>>>>>
>>>>> David Daney
>>>>>
>>>>>
>>>>>>
>>>>>> config PAGE_SIZE_4KB
>>>>>>          bool "4kB"
>>>>>>          help
>>>>>>           This option select the standard 4kB Linux page size.  On some
>>>>>>           R3000-family processors this is the only available page size.
>>>>>>   Using
>>>>>>           4kB page size will minimize memory consumption and is
>>>>>> therefore
>>>>>>           recommended for low memory systems.
>>>>>>
>>>>>> config PAGE_SIZE_8KB
>>>>>>          bool "8kB"
>>>>>>         depends on (EXPERIMENTAL&&     CPU_R8000) || CPU_CAVIUM_OCTEON
>>>>>>          help
>>>>>>            Using 8kB page size will result in higher performance kernel
>>>>
>>>> at
>>>>>>
>>>>>>            the price of higher memory consumption.  This option is
>>>>>> available
>>>>>>            only on R8000 and cnMIPS processors.  Note that you will need
>>>>
>>>> a
>>>>>>
>>>>>>            suitable Linux distribution to support this.
>>>>>>
>>>>>> config PAGE_SIZE_16KB
>>>>>>          bool "16kB"
>>>>>>         depends on !CPU_R3000&&     !CPU_TX39XX
>>>>>>          help
>>>>>>            Using 16kB page size will result in higher performance kernel
>>>>
>>>> at
>>>>>>
>>>>>>            the price of higher memory consumption.  This option is
>>>>>> available on
>>>>>>            all non-R3000 family processors.  Note that you will need a
>>>>>> suitable
>>>>>>            Linux distribution to support this.
>>>>>>
>>>>>> config PAGE_SIZE_32KB
>>>>>>          bool "32kB"
>>>>>>          help
>>>>>>            Using 32kB page size will result in higher performance kernel
>>>>
>>>> at
>>>>>>
>>>>>>            the price of higher memory consumption.  This option is
>>>>>> available
>>>>>>            only on cnMIPS cores.  Note that you will need a suitable
>>>>
>>>> Linux
>>>>>>
>>>>>>            distribution to support this.
>>>>>>
>>>>>> config PAGE_SIZE_64KB
>>>>>>          bool "64kB"
>>>>>>         depends on EXPERIMENTAL&&     !CPU_R3000&&     !CPU_TX39XX
>>>>>>          help
>>>>>>            Using 64kB page size will result in higher performance kernel
>>>>
>>>> at
>>>>>>
>>>>>>            the price of higher memory consumption.  This option is
>>>>>> available on
>>>>>>            all non-R3000 family processor.  Not that at the time of this
>>>>>>            writing this option is still high experimental.
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>
>>
>
