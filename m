Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 15:55:22 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:35423 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491074Ab1A0OzT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jan 2011 15:55:19 +0100
Received: by qwj9 with SMTP id 9so2155546qwj.36
        for <linux-mips@linux-mips.org>; Thu, 27 Jan 2011 06:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rWpc4bltdel3X3LgTfNXcghtQaVRrC9jZsWWp1q4vgg=;
        b=mfzjCQKCqOs6l6Z45vQGj1eJfjLZCUQjdfhMKWlkKmOgD0n1z/xCSfKOVr4gOWjn/6
         V8Ierq9qcz87trWRGOUeskuFAce7FJTuVOQfIigytp7G93Y5BKwLXNkxdoYnsBzUfPtd
         pihr6dYzlGve5tynpfAlmRCKvMS9wENG0+jBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gE1Aamb4wnEPa1W+zJ07nWrqE8645e2Ubapnym24IzyHA4GFoXSsVxVWypXmVPCiNz
         dR2eXnmecWIkGCsSwr+9wvKQWGzFRJssFOPwkN12/WS7jIz+rcnWtN4TGcoqqRhPxSl2
         veRWc7jhgNisV4o22qgeW8F52uaG5r/CTMCxw=
MIME-Version: 1.0
Received: by 10.229.232.85 with SMTP id jt21mr1613252qcb.164.1296140112850;
 Thu, 27 Jan 2011 06:55:12 -0800 (PST)
Received: by 10.229.51.130 with HTTP; Thu, 27 Jan 2011 06:55:12 -0800 (PST)
In-Reply-To: <4D3DCB5A.6060107@caviumnetworks.com>
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
        <4D3DCB5A.6060107@caviumnetworks.com>
Date:   Thu, 27 Jan 2011 20:25:12 +0530
Message-ID: <AANLkTi=mbof+GbRuS-0hezDpj+XmA+jL7mE+kdjKJzd5@mail.gmail.com>
Subject: Re: page size change on MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, kernelnewbies@nl.linux.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi David,

thanks for your response.

I check and found that kernel is booting with 16KB page size with
ramdisk booting. But when I change to 64KB it give me

: applet not found
                  Kernel panic - not syncing: Attempted to kill init!
so I check and found that it is not able to execute well the system
call in kernel_execve function.
I am using codesourcercy toolchain(4.3.1). So is there a way to debug
this problem or how to debug below function.

int kernel_execve(const char *filename, char *const argv[], char *const envp[])
{
	register unsigned long __a0 asm("$4") = (unsigned long) filename;
	register unsigned long __a1 asm("$5") = (unsigned long) argv;
	register unsigned long __a2 asm("$6") = (unsigned long) envp;
	register unsigned long __a3 asm("$7");
	unsigned long __v0;
	__asm__ volatile ("					\n"
	"	.set	noreorder				\n"
	"	li	$2, %5		# __NR_execve		\n"
	"	syscall						\n"
	"	move	%0, $2					\n"
	"	.set	reorder					\n"
	: "=&r" (__v0), "=r" (__a3)
	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_execve)
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24",
	  "memory");
	

	if (__a3 == 0)			
		return __v0;
	return -__v0;
}


On Tue, Jan 25, 2011 at 12:26 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 01/24/2011 07:02 AM, naveen yadav wrote:
>>
>> Hi All,
>>
>>
>> we are using mips32r2  so I want to know which all pages size it can
>> support?
>> When I modify arch/mips/Kconfig.  it boot sucessfully on 16KB page
>> size. but hang/not boot crash when change page size to 8KB,32KB and 64
>> KB.
>
> I don't think 8KB and 32KB work on most mips32r2 processors.  You would have
> to check the processor manual to be sure.
>
>
>>
>> We are using 2.6.30 kernel.
>>
>> At Page Size 8KB and 32KB  it hang in unpack_to_rootfs() function of
>> init/initramfs.c
>>
>> 64KB it hangs when execute init  Kernel panic - not syncing: Attempted
>> to kill init!
>
> I regularly run 4K, 16K, and 64K page sizes with a Debian rootfs.  If you
> run with a broken uClibc toolchain that doesn't support larger pages, it
> will of course fail.  In this case the problem is with your toolchain, not
> the kernel.
>
> David Daney
>
>
>>
>> config PAGE_SIZE_4KB
>>         bool "4kB"
>>         help
>>          This option select the standard 4kB Linux page size.  On some
>>          R3000-family processors this is the only available page size.
>>  Using
>>          4kB page size will minimize memory consumption and is therefore
>>          recommended for low memory systems.
>>
>> config PAGE_SIZE_8KB
>>         bool "8kB"
>>        depends on (EXPERIMENTAL&&  CPU_R8000) || CPU_CAVIUM_OCTEON
>>         help
>>           Using 8kB page size will result in higher performance kernel at
>>           the price of higher memory consumption.  This option is
>> available
>>           only on R8000 and cnMIPS processors.  Note that you will need a
>>           suitable Linux distribution to support this.
>>
>> config PAGE_SIZE_16KB
>>         bool "16kB"
>>        depends on !CPU_R3000&&  !CPU_TX39XX
>>         help
>>           Using 16kB page size will result in higher performance kernel at
>>           the price of higher memory consumption.  This option is
>> available on
>>           all non-R3000 family processors.  Note that you will need a
>> suitable
>>           Linux distribution to support this.
>>
>> config PAGE_SIZE_32KB
>>         bool "32kB"
>>         help
>>           Using 32kB page size will result in higher performance kernel at
>>           the price of higher memory consumption.  This option is
>> available
>>           only on cnMIPS cores.  Note that you will need a suitable Linux
>>           distribution to support this.
>>
>> config PAGE_SIZE_64KB
>>         bool "64kB"
>>        depends on EXPERIMENTAL&&  !CPU_R3000&&  !CPU_TX39XX
>>         help
>>           Using 64kB page size will result in higher performance kernel at
>>           the price of higher memory consumption.  This option is
>> available on
>>           all non-R3000 family processor.  Not that at the time of this
>>           writing this option is still high experimental.
>>
>>
>
>
