Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2003 09:04:01 +0000 (GMT)
Received: from [IPv6:::ffff:62.116.167.108] ([IPv6:::ffff:62.116.167.108]:18853
	"EHLO oricom4.internetx.de") by linux-mips.org with ESMTP
	id <S8225193AbTCLJEA>; Wed, 12 Mar 2003 09:04:00 +0000
Received: from mycable.de (p5086B0E2.dip.t-dialin.net [80.134.176.226])
	(authenticated bits=0)
	by oricom4.internetx.de (8.12.8/8.12.8) with ESMTP id h2C90kH7012453;
	Wed, 12 Mar 2003 10:00:46 +0100
Message-ID: <3E6EF89A.6050207@mycable.de>
Date: Wed, 12 Mar 2003 10:06:34 +0100
From: Tiemo Krueger - mycable GmbH <tk@mycable.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Santosh <ipv6_san@rediffmail.com>
CC: linux-mips@linux-mips.org
Subject: Re: (usagi-users 02263) Usagi kernel for MIPS target
References: <20030312084946.7398.qmail@webmail27.rediffmail.com>
In-Reply-To: <20030312084946.7398.qmail@webmail27.rediffmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tk@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tk@mycable.de
Precedence: bulk
X-list: linux-mips

I had some time ago some trouble with xconfig, it seems that some
dependencies between configuration topics are not setup properly for MIPS
try the normal 'config' instead.
I remember that RTC was one of the appearing problems

Tiemo

Santosh wrote:

> i tried compiling this way
>
> # make ARCH=mips xconfig
> i get
> ERROR - Attempting to write value for unconfigured variable 
> (CONFIG_VTAG_ICACHE)
> ERROR - Attempting to write value for unconfigured variable 
> (CONFIG_BINFMT_ELF32)
> ERROR - Attempting to write value for unconfigured variable 
> (CONFIG_SERIAL)
> ERROR - Attempting to write value for unconfigured variable (CONFIG_RTC)
>
> Don't know what's wrong.
> I have configured for MIPS Malta (Experimental) board
>
> then i did # make ARCH=mips dep
>
> finally # make ARCH=mips CROSS_COMPILE=mipsel-linux-
>
> Now i get
> binfmt_elf.c: In function 'load_elf_interp':
> binfmt_elf.c:278: 'EF_MIPS_ABI2' undeclared
> binfmt_elf.c:278: 'EF_MIPS_ABI' undeclared
> make[2]:Leaving directory '/home/user/usagi/kernel/linux24/fs'
> make:***[_dir_fs]Error 2
>
> Is Usagi stable on MIPS Malta board ??
> Pls tell me what's wrong.
>
> -Santosh
> ------------------------------------------
>
>
> On Wed, 12 Mar 2003 KUNITAKE Koichi wrote :
>
>>   Hello,
>>
>> On 12 Mar 2003 07:08:17 -0000
>> "Santosh " <ipv6_san@rediffmail.com> wrote:
>>
>> >Can someone tell me what changes i have to make to compile the
>> >sources successfully for MIPS target ???
>>
>>   I have never compiled USAGI for MIPS target, but I think you
>> should edit linux24/Makefile as following.
>>
>>
>> --- Makefile.orig       2003-03-12 16:55:06.000000000 +0900
>> +++ Makefile    2003-03-12 16:55:32.000000000 +0900
>> @@ -5,7 +5,8 @@
>>
>>  
>> KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
>>
>> -ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ 
>> -e s/arm.*/arm/ -e s/sa110/arm/)
>> +#ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ 
>> -e s/arm.*/arm/ -e s/sa110/arm/)
>> +ARCH := mips
>>  KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")
>>
>>  CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
>> @@ -19,7 +20,7 @@
>>  HOSTCC         = gcc
>>  HOSTCFLAGS     = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
>>
>> -CROSS_COMPILE  =
>> +CROSS_COMPILE  = mips-linux-
>>
>>  #
>>  # Include the make variables (CC, etc...)
>>
>>
>>   Did this fail?
>>
>> Best regards,
>>
>
> __________________________________________________________
> Great Travel Deals, Airfares, Hotels on
> http://www.journeymart.com/rediff/travel.asp
>
>
>


-- 
-------------------------------------------------------
Tiemo Krueger       Tel:  +49 48 73 90 19 86
mycable GmbH        Fax: +49 48 73 90 19 76
Boeker Stieg 43
D-24613 Aukrug      eMail: tk@mycable.de

Public Kryptographic Key is available on request
-------------------------------------------------------
