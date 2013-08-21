Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 17:45:45 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:2672 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6839078Ab3HUPpjRtd6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 17:45:39 +0200
Message-ID: <5214E05E.7000303@imgtec.com>
Date:   Wed, 21 Aug 2013 16:44:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: add uImage build target
References: <1377096947-3959-1-git-send-email-james.hogan@imgtec.com> <CAGVrzcZ8FVv9p00R6yDaqRMQARi64P+zVzNRsyeGpiL4UZL3Vg@mail.gmail.com>
In-Reply-To: <CAGVrzcZ8FVv9p00R6yDaqRMQARi64P+zVzNRsyeGpiL4UZL3Vg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_21_16_45_34
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Florian,

On 21/08/13 16:08, Florian Fainelli wrote:
> 2013/8/21 James Hogan <james.hogan@imgtec.com>:
>> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
>> index b2be6b8..c4f339e 100644
>> --- a/arch/mips/Makefile
>> +++ b/arch/mips/Makefile
>> @@ -284,7 +284,7 @@ vmlinux.64: vmlinux
>>  all:   $(all-y)
>>
>>  # boot
>> -vmlinux.bin vmlinux.ecoff vmlinux.srec: $(vmlinux-32) FORCE
>> +vmlinux.bin vmlinux.ecoff vmlinux.srec uImage: $(vmlinux-32) FORCE
>>         $(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) arch/mips/boot/$@
>>
>>  # boot/compressed
>> @@ -327,6 +327,7 @@ define archhelp
>>         echo '  vmlinuz.ecoff        - ECOFF zboot image'
>>         echo '  vmlinuz.bin          - Raw binary zboot image'
>>         echo '  vmlinuz.srec         - SREC zboot image'
>> +       echo '  uImage               - U-Boot image (gzip)'
> 
> This is not quite accurate, since you introduce two new uImage
> targets, this should be:
> 
> +       echo '  uImage               - U-Boot image'
> +       echo '  uImage.gz               - U-Boot image (gzip)'

Only uImage is passed through to arch/mips/boot/Makefile, but yes, they
probably both should be.

> 
>>         echo
>>         echo '  These will be default as appropriate for a configured platform.'
>>  endef
>> diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
>> index f210b09..a73d6e2 100644
>> --- a/arch/mips/boot/.gitignore
>> +++ b/arch/mips/boot/.gitignore
>> @@ -4,3 +4,4 @@ vmlinux.*
>>  zImage
>>  zImage.tmp
>>  calc_vmlinuz_load_addr
>> +uImage
>> diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
>> index 851261e..8169d42 100644
>> --- a/arch/mips/boot/Makefile
>> +++ b/arch/mips/boot/Makefile
>> @@ -40,3 +40,18 @@ quiet_cmd_srec = OBJCOPY $@
>>        cmd_srec = $(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $@
>>  $(obj)/vmlinux.srec: $(VMLINUX) FORCE
>>         $(call if_changed,srec)
>> +
>> +UIMAGE_LOADADDR  = $(shell $(NM) $(VMLINUX) | grep "\b_text\b"        | cut -f1 -d\ )
> 
> Is not VMLINUX_LOAD_ADDRESS suitable here?

It's only passed through to arch/mips/boot/compressed. It can always be
made to pass it to arch/mips/boot too though.

> 
>> +UIMAGE_ENTRYADDR = $(shell $(NM) $(VMLINUX) | grep '\bkernel_entry\b' | cut -f1 -d\ )
> 
> This logic already exists in arch/mips/boot/compressed/Makefile, so we
> might want to move this to arch/mips/Makefile? This could be a
> preliminary or subsequent patch, your call.

Thanks for the feedback. I'll refactor it a bit to avoid duplication.

Cheers
James
