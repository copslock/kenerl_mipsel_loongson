Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 16:44:12 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:35304 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27042813AbcFQOoJeM9Qn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 16:44:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E5B7FB80461;
        Fri, 17 Jun 2016 16:44:08 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.0.2] (dslb-088-073-007-040.088.073.pools.vodafone-ip.de [88.73.7.40])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 4BD11B803F1;
        Fri, 17 Jun 2016 16:43:59 +0200 (CEST)
Subject: Re: [PATCH 1/2] MIPS: ZBOOT: copy appended dtb to the end of the
 kernel
To:     Antony Pavlov <antonynpavlov@gmail.com>
References: <1466165260-6897-1-git-send-email-jogo@openwrt.org>
 <1466165260-6897-2-git-send-email-jogo@openwrt.org>
 <20160617170141.faf0b14b26177f820f01d140@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
From:   Jonas Gorski <jogo@openwrt.org>
Message-ID: <b57eb27d-f7fe-b457-1915-75e995668a06@openwrt.org>
Date:   Fri, 17 Jun 2016 16:44:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160617170141.faf0b14b26177f820f01d140@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi Antony,

On 17.06.2016 16:01, Antony Pavlov wrote:
> On Fri, 17 Jun 2016 14:07:39 +0200
> Jonas Gorski <jogo@openwrt.org> wrote:
> 
>> Instead of rewriting the arguments, just move the appended dtb to where
>> the decompressed kernel expects it. This eliminates the need for special
>> casing vmlinuz.bin appended dtb files.
>>
>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>> ---
>>  arch/mips/Kconfig                      | 22 ++--------------------
>>  arch/mips/boot/compressed/Makefile     |  1 +
>>  arch/mips/boot/compressed/decompress.c | 21 +++++++++++++++++++++
>>  arch/mips/boot/compressed/head.S       | 16 ----------------
>>  4 files changed, 24 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index ac91939..0d0f71e 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -2885,10 +2885,10 @@ choice
>>  		  the documented boot protocol using a device tree.
>>  
>>  	config MIPS_RAW_APPENDED_DTB
>> -		bool "vmlinux.bin"
>> +		bool "vmlinux.bin or vmlinuz.bin"
>>  		help
>>  		  With this option, the boot code will look for a device tree binary
>> -		  DTB) appended to raw vmlinux.bin (without decompressor).
>> +		  DTB) appended to raw vmlinux.bin or vmlinuz.bin.
>>  		  (e.g. cat vmlinux.bin <filename>.dtb > vmlinux_w_dtb).
>>  
>>  		  This is meant as a backward compatibility convenience for those
>> @@ -2900,24 +2900,6 @@ choice
>>  		  look like a DTB header after a reboot if no actual DTB is appended
>>  		  to vmlinux.bin.  Do not leave this option active in a production kernel
>>  		  if you don't intend to always append a DTB.
>> -
>> -	config MIPS_ZBOOT_APPENDED_DTB
>> -		bool "vmlinuz.bin"
>> -		depends on SYS_SUPPORTS_ZBOOT
>> -		help
>> -		  With this option, the boot code will look for a device tree binary
>> -		  DTB) appended to raw vmlinuz.bin (with decompressor).
>> -		  (e.g. cat vmlinuz.bin <filename>.dtb > vmlinuz_w_dtb).
>> -
>> -		  This is meant as a backward compatibility convenience for those
>> -		  systems with a bootloader that can't be upgraded to accommodate
>> -		  the documented boot protocol using a device tree.
>> -
>> -		  Beware that there is very little in terms of protection against
>> -		  this option being confused by leftover garbage in memory that might
>> -		  look like a DTB header after a reboot if no actual DTB is appended
>> -		  to vmlinuz.bin.  Do not leave this option active in a production kernel
>> -		  if you don't intend to always append a DTB.
>>  endchoice
>>  
>>  choice
>> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
>> index 90aca95..f31ec89 100644
>> --- a/arch/mips/boot/compressed/Makefile
>> +++ b/arch/mips/boot/compressed/Makefile
>> @@ -29,6 +29,7 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>>  	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
>>  	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
>>  
>> +
> 
> Could you please remote this extra empty line?

Oops, that must have slipped through. Fixed locally.

>>  # decompressor objects (linked with vmlinuz)
>>  vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o
>>  
>> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
>> index 080cd53..e18ab3e 100644
>> --- a/arch/mips/boot/compressed/decompress.c
>> +++ b/arch/mips/boot/compressed/decompress.c
>> @@ -36,6 +36,12 @@ extern void puthex(unsigned long long val);
>>  #define puthex(val) do {} while (0)
>>  #endif
>>  
>> +#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
> 
> Do we really need this '#ifdef' here?

No we don't, I was under the assumption the __appended_dtb is
only available when appended dtb support is enabled, for for
the decompressor it is always defined. At least gcc doesn't
seem to complain about it being unused in a quick test
compile. Fixed locally.

> 
>> +#include <linux/libfdt.h>

And moved this one to the other #includes.

>> +
>> +extern char __appended_dtb[];
>> +#endif
>> +


Jonas
