Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2011 10:18:49 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:59572 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491094Ab1A1JSp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jan 2011 10:18:45 +0100
Received: by qwj9 with SMTP id 9so2991257qwj.36
        for <linux-mips@linux-mips.org>; Fri, 28 Jan 2011 01:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=okgSuuChzLbE78iKy6YAqNddafEDrlkMVUzTuNJuihs=;
        b=r7F1eM/BeAcZHk6myMeAepTbeb9uowIcQrxgx6pnFWKmizsQ9M5MQJdCYTlC+67IIB
         w1l3dXDc2QwI2FV3baxt2C/unWQuPMd/bJQydRD8T2HkSWhdJMAIidRzbN6VBr/Sez5/
         uQsxjUCmx4s2+YWhLU6CdMToqIXnxdgdulV0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cn0oh0tty4n27drEfSwJMYZQpSvpt+47n+4boFCsiBLpSSXH5FfdA8xY3Nb6d+0Hua
         g2phGv+wD2dyiZ16So0s6VGxkfecX+yjEY0pmOz0qT8YW2FxjYrcbZwY6e6xD+TSfnDS
         jWK6K8bqj4oV6QW0qZe+TienV0KSGjeX9NN40=
MIME-Version: 1.0
Received: by 10.229.224.201 with SMTP id ip9mr735563qcb.202.1296206317893;
 Fri, 28 Jan 2011 01:18:37 -0800 (PST)
Received: by 10.229.51.130 with HTTP; Fri, 28 Jan 2011 01:18:37 -0800 (PST)
In-Reply-To: <4D41AEFC.5030609@caviumnetworks.com>
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
        <4D3DCB5A.6060107@caviumnetworks.com>
        <AANLkTi=mbof+GbRuS-0hezDpj+XmA+jL7mE+kdjKJzd5@mail.gmail.com>
        <AANLkTimbLenZ0+0NxN+EckjuJO6ezGimdw0FaqycFRRi@mail.gmail.com>
        <4D41AEFC.5030609@caviumnetworks.com>
Date:   Fri, 28 Jan 2011 14:48:37 +0530
Message-ID: <AANLkTin-D8KW2uDYkSbEsCuS2rPSetw23CLxkAqw7OYd@mail.gmail.com>
Subject: Re: page size change on MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     adnan iqbal <adnan.iqbal@seecs.edu.pk>, linux-mips@linux-mips.org,
        kernelnewbies@nl.linux.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all

I try changing the kernel_execve() function as suggested, but it fails,
I am using code sourcery toolchain 4.4.1 but it still fails. I am
using 2.6.30.9 kernel and this function is part of it.



Kind regards


On Thu, Jan 27, 2011 at 11:14 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 01/27/2011 07:18 AM, adnan iqbal wrote:
>>
>> Please try this. One line of code is added ( move    %1, $7).
>>
>>
>> int kernel_execve(const char *filename, char *const argv[], char *const
>> envp[])
>> {
>>        register unsigned long __a0 asm("$4") = (unsigned long) filename;
>>        register unsigned long __a1 asm("$5") = (unsigned long) argv;
>>        register unsigned long __a2 asm("$6") = (unsigned long) envp;
>>        register unsigned long __a3 asm("$7");
>>        unsigned long __v0;
>>        __asm__ volatile ("                                     \n"
>>        "       .set    noreorder                               \n"
>>        "       li      $2, %5          # __NR_execve           \n"
>>        "       syscall                                         \n"
>>        "       move    %0, $2                                  \n"
>>     "      move    %1, $7                    \n"
>>        "       .set    reorder                                 \n"
>>        : "=&r" (__v0), "=r" (__a3)
>>        : "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_execve)
>>        : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15",
>> "$24",
>>          "memory");
>>
>>
>>        if (__a3 == 0)
>>                return __v0;
>>        return -__v0;
>> }
>>
>
> I don't know where you got that code.  But really you should do what glibc
> does.  glibc gets it correct.
>
> At a minimum you are missing "hi" and "lo" clobbers.
>
> If the code works with 16K pages, and not 64K pages, then this snippet is
> not the problem.  Likely your problem is the layout of the PHDRs in the
> executable is not compatible with the page size.
>
> David Daney
>
>
>>
>> On Thu, Jan 27, 2011 at 7:55 PM, naveen yadav<yad.naveen@gmail.com>
>>  wrote:
>>
>>> Hi David,
>>>
>>> thanks for your response.
>>>
>>> I check and found that kernel is booting with 16KB page size with
>>> ramdisk booting. But when I change to 64KB it give me
>>>
>>> : applet not found
>>>                  Kernel panic - not syncing: Attempted to kill init!
>>> so I check and found that it is not able to execute well the system
>>> call in kernel_execve function.
>>> I am using codesourcercy toolchain(4.3.1). So is there a way to debug
>>> this problem or how to debug below function.
>>>
>>> int kernel_execve(const char *filename, char *const argv[], char *const
>>> envp[])
>>> {
>>>        register unsigned long __a0 asm("$4") = (unsigned long) filename;
>>>        register unsigned long __a1 asm("$5") = (unsigned long) argv;
>>>        register unsigned long __a2 asm("$6") = (unsigned long) envp;
>>>        register unsigned long __a3 asm("$7");
>>>        unsigned long __v0;
>>>        __asm__ volatile ("                                     \n"
>>>        "       .set    noreorder                               \n"
>>>        "       li      $2, %5          # __NR_execve           \n"
>>>        "       syscall                                         \n"
>>>        "       move    %0, $2                                  \n"
>>>        "       .set    reorder                                 \n"
>>>        : "=&r" (__v0), "=r" (__a3)
>>>        : "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_execve)
>>>        : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15",
>>> "$24",
>>>          "memory");
>>>
>>>
>>>        if (__a3 == 0)
>>>                return __v0;
>>>        return -__v0;
>>> }
>>>
>>>
>>> On Tue, Jan 25, 2011 at 12:26 AM, David Daney<ddaney@caviumnetworks.com>
>>> wrote:
>>>>
>>>> On 01/24/2011 07:02 AM, naveen yadav wrote:
>>>>>
>>>>> Hi All,
>>>>>
>>>>>
>>>>> we are using mips32r2  so I want to know which all pages size it can
>>>>> support?
>>>>> When I modify arch/mips/Kconfig.  it boot sucessfully on 16KB page
>>>>> size. but hang/not boot crash when change page size to 8KB,32KB and 64
>>>>> KB.
>>>>
>>>> I don't think 8KB and 32KB work on most mips32r2 processors.  You would
>>>
>>> have
>>>>
>>>> to check the processor manual to be sure.
>>>>
>>>>
>>>>>
>>>>> We are using 2.6.30 kernel.
>>>>>
>>>>> At Page Size 8KB and 32KB  it hang in unpack_to_rootfs() function of
>>>>> init/initramfs.c
>>>>>
>>>>> 64KB it hangs when execute init  Kernel panic - not syncing: Attempted
>>>>> to kill init!
>>>>
>>>> I regularly run 4K, 16K, and 64K page sizes with a Debian rootfs.  If
>>>> you
>>>> run with a broken uClibc toolchain that doesn't support larger pages, it
>>>> will of course fail.  In this case the problem is with your toolchain,
>>>
>>> not
>>>>
>>>> the kernel.
>>>>
>>>> David Daney
>>>>
>>>>
>>>>>
>>>>> config PAGE_SIZE_4KB
>>>>>         bool "4kB"
>>>>>         help
>>>>>          This option select the standard 4kB Linux page size.  On some
>>>>>          R3000-family processors this is the only available page size.
>>>>>  Using
>>>>>          4kB page size will minimize memory consumption and is
>>>>> therefore
>>>>>          recommended for low memory systems.
>>>>>
>>>>> config PAGE_SIZE_8KB
>>>>>         bool "8kB"
>>>>>        depends on (EXPERIMENTAL&&   CPU_R8000) || CPU_CAVIUM_OCTEON
>>>>>         help
>>>>>           Using 8kB page size will result in higher performance kernel
>>>
>>> at
>>>>>
>>>>>           the price of higher memory consumption.  This option is
>>>>> available
>>>>>           only on R8000 and cnMIPS processors.  Note that you will need
>>>
>>> a
>>>>>
>>>>>           suitable Linux distribution to support this.
>>>>>
>>>>> config PAGE_SIZE_16KB
>>>>>         bool "16kB"
>>>>>        depends on !CPU_R3000&&   !CPU_TX39XX
>>>>>         help
>>>>>           Using 16kB page size will result in higher performance kernel
>>>
>>> at
>>>>>
>>>>>           the price of higher memory consumption.  This option is
>>>>> available on
>>>>>           all non-R3000 family processors.  Note that you will need a
>>>>> suitable
>>>>>           Linux distribution to support this.
>>>>>
>>>>> config PAGE_SIZE_32KB
>>>>>         bool "32kB"
>>>>>         help
>>>>>           Using 32kB page size will result in higher performance kernel
>>>
>>> at
>>>>>
>>>>>           the price of higher memory consumption.  This option is
>>>>> available
>>>>>           only on cnMIPS cores.  Note that you will need a suitable
>>>
>>> Linux
>>>>>
>>>>>           distribution to support this.
>>>>>
>>>>> config PAGE_SIZE_64KB
>>>>>         bool "64kB"
>>>>>        depends on EXPERIMENTAL&&   !CPU_R3000&&   !CPU_TX39XX
>>>>>         help
>>>>>           Using 64kB page size will result in higher performance kernel
>>>
>>> at
>>>>>
>>>>>           the price of higher memory consumption.  This option is
>>>>> available on
>>>>>           all non-R3000 family processor.  Not that at the time of this
>>>>>           writing this option is still high experimental.
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>
>
>
