Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2003 08:50:34 +0000 (GMT)
Received: from webmail27.rediffmail.com ([IPv6:::ffff:203.199.83.37]:6313 "HELO
	rediffmail.com") by linux-mips.org with SMTP id <S8225193AbTCLIud>;
	Wed, 12 Mar 2003 08:50:33 +0000
Received: (qmail 7399 invoked by uid 510); 12 Mar 2003 08:49:46 -0000
Date: 12 Mar 2003 08:49:46 -0000
Message-ID: <20030312084946.7398.qmail@webmail27.rediffmail.com>
Received: from unknown (194.175.117.86) by rediffmail.com via HTTP; 12 mar 2003 08:49:46 -0000
MIME-Version: 1.0
From: "Santosh " <ipv6_san@rediffmail.com>
Reply-To: "Santosh " <ipv6_san@rediffmail.com>
To: "KUNITAKE Koichi" <kunitake@linux-ipv6.org>
Cc: linux-mips@linux-mips.org, usagi-users@linux-ipv6.org
Subject: Re: Re: (usagi-users 02263) Usagi kernel for MIPS target
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <ipv6_san@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ipv6_san@rediffmail.com
Precedence: bulk
X-list: linux-mips

i tried compiling this way

# make ARCH=mips xconfig
i get
ERROR - Attempting to write value for unconfigured variable 
(CONFIG_VTAG_ICACHE)
ERROR - Attempting to write value for unconfigured variable 
(CONFIG_BINFMT_ELF32)
ERROR - Attempting to write value for unconfigured variable 
(CONFIG_SERIAL)
ERROR - Attempting to write value for unconfigured variable 
(CONFIG_RTC)

Don't know what's wrong.
I have configured for MIPS Malta (Experimental) board

then i did # make ARCH=mips dep

finally # make ARCH=mips CROSS_COMPILE=mipsel-linux-

Now i get
binfmt_elf.c: In function 'load_elf_interp':
binfmt_elf.c:278: 'EF_MIPS_ABI2' undeclared
binfmt_elf.c:278: 'EF_MIPS_ABI' undeclared
make[2]:Leaving directory '/home/user/usagi/kernel/linux24/fs'
make:***[_dir_fs]Error 2

Is Usagi stable on MIPS Malta board ??
Pls tell me what's wrong.

-Santosh
------------------------------------------


On Wed, 12 Mar 2003 KUNITAKE Koichi wrote :
>   Hello,
>
>On 12 Mar 2003 07:08:17 -0000
>"Santosh " <ipv6_san@rediffmail.com> wrote:
>
> >Can someone tell me what changes i have to make to compile 
>the
> >sources successfully for MIPS target ???
>
>   I have never compiled USAGI for MIPS target, but I think you
>should edit linux24/Makefile as following.
>
>
>--- Makefile.orig       2003-03-12 16:55:06.000000000 +0900
>+++ Makefile    2003-03-12 16:55:32.000000000 +0900
>@@ -5,7 +5,8 @@
>
>  
>KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
>
>-ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e 
>s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
>+#ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e 
>s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
>+ARCH := mips
>  KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e 
>"s/-//g")
>
>  CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; 
>\
>@@ -19,7 +20,7 @@
>  HOSTCC         = gcc
>  HOSTCFLAGS     = -Wall -Wstrict-prototypes -O2 
>-fomit-frame-pointer
>
>-CROSS_COMPILE  =
>+CROSS_COMPILE  = mips-linux-
>
>  #
>  # Include the make variables (CC, etc...)
>
>
>   Did this fail?
>
>Best regards,
>

__________________________________________________________
Great Travel Deals, Airfares, Hotels on
http://www.journeymart.com/rediff/travel.asp
