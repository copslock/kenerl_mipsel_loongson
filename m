Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 05:26:18 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:42202 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491753Ab0FBDGl convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 05:06:41 +0200
Received: by pwi2 with SMTP id 2so2510481pwi.36
        for <multiple recipients>; Tue, 01 Jun 2010 20:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7AlnwrCYNGFzbY7Ji2R28wDJFzeqs+AJp13lg4xeTRA=;
        b=WI1RAnqbI77xF4hVpXtSCN6sKh8FoD1p97rn93415YSiU3mhCQQ4AtDrlwW9Fz/Ftr
         g1i250nzHBi/tIhW5l6F5307R4p43p6ZYY4wQY/xnucGRsWbjqTQPtj/EcICItWcBCeQ
         TFQCWf+4cfS9IYA956mSpD4SbTkqaTdC2b+DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F4rcIsYxm+pi1+Qp48T+9LLL4Q3nGi8+LNlS/lmk92Jk9Ett4KqZeD/32Re7mY2WbI
         DNfVpPW9XZCG1qdLZPmocoNDgh1Bzd6wYl98SREBu6hoXpkUIrsB6CnV5LEVOEHNlRsh
         D1ZSHOcJWnG68TWtSxYn3Hl+gMFVh087PI4ps=
MIME-Version: 1.0
Received: by 10.141.90.18 with SMTP id s18mr5677312rvl.297.1275447993155; Tue, 
        01 Jun 2010 20:06:33 -0700 (PDT)
Received: by 10.142.179.7 with HTTP; Tue, 1 Jun 2010 20:06:33 -0700 (PDT)
In-Reply-To: <20100601152750.GA5131@merkur.ravnborg.org>
References: <616317d6d889537d03c3c0860231da9a2cce0b69.1275372093.git.wuzhangjin@gmail.com>
        <20100601152750.GA5131@merkur.ravnborg.org>
Date:   Wed, 2 Jun 2010 11:06:33 +0800
Message-ID: <AANLkTikR8qY2NwurQ76R1F-AQ4QcmmqXvoWtlOqCB5Ou@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 26981
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 948

Hi, Sam

On Tue, Jun 1, 2010 at 11:27 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
[...]
>
>> diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
>> index 4667a5f..f210b09 100644
>> --- a/arch/mips/boot/.gitignore
>> +++ b/arch/mips/boot/.gitignore
>> @@ -3,3 +3,4 @@ elf2ecoff
>>  vmlinux.*
>>  zImage
>>  zImage.tmp
>> +calc_vmlinuz_load_addr
>
> Does this do any good in this file?
> I had assumed this covered only the same dir as the .gitignore file
> is stored. But I may be wrong.

I have tried to add this to boot/compressed/.gitignore, but there was
no .gitignore there and found the vmlinux.* in boot/.gitignore, it
worked to hide the vmlinux.* under boot/compressed/, then I put the
calc_vmlinuz_load_addr to this .gitignore too ;) it really hided the
calc_vmlinuz_load_addr, that's it.

BTW: I just don't want to add a new file for one line if it is not necessary ;)

>
>> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
>> index 7204dfc..cd9ee04 100644
>> --- a/arch/mips/boot/compressed/Makefile
>> +++ b/arch/mips/boot/compressed/Makefile
>>
>> -LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
>> -vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/piggy.o
>> -     $(call cmd,ld)
>> +# Calculate the load address of the compressed kernel
>> +hostprogs-y := calc_vmlinuz_load_addr
>> +
>> +vmlinuzobjs-y += $(obj)/piggy.o
>> +
>> +quiet_cmd_zld = LD      $@
>> +      cmd_zld = $(LD) $(LDFLAGS) -Ttext $(shell $(obj)/calc_vmlinuz_load_addr $(objtree)/$(KBUILD_IMAGE) $(VMLINUX_LOAD_ADDRESS)) -T $< $(vmlinuzobjs-y) -o $@
>
> The line seriously fail the 80 char limit.
> Something like this:
>
> load_addr = $(shell $(obj)/calc_vmlinuz_load_addr \
>                    $(objtree)/$(KBUILD_IMAGE) $(VMLINUX_LOAD_ADDRESS)
> quiet_cmd_zld = LD      $@
>      cmd_zld = $(LD) $(LDFLAGS) -Ttext $(load-addr) -T $< $(vmlinuzobjs-y) -o $@
>
> Note: The load_addr local variable _must_ use "=" asignment

This is the _key_ stuff. I  tried to use VMLINUZ_LOAD_ADDR(like your
load_addr) as the load address, but failed all the time, seems I used
the ":=" assignment, now with "=", it works, thanks!

And could you please explain their differences?

>
>> +vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/calc_vmlinuz_load_addr
>> +     $(call cmd,zld)
>>       $(Q)$(OBJCOPY) $(OBJCOPYFLAGS) $@
>
> Does objcopy support equally named input and out files?
> If this is the case you could use:
> $(call cmd,objcopy) as the last line.

Just checked the ld.script, and found the .reginfo section have been
discarded, then it's time to remove this objcopy line(this objcopy
line only remove the .reginfo section).

[...]
>> +
>> +     /* Align with 65536 */
>> +     vmlinuz_load_addr += (65536 - vmlinux_size % 65536);
>
> You have plenty of rooms for a comment about why you do this.
> Would be good to use this possibility.
>

The address of "vmlinux_load_addr + vmlinux_size" may be not aligned
with the standard data type of MIPS, that's why we need the alignment,
but here 65536, 64k(about several pages), is really a little big, I
will use 16 bytes in the next revision and add more comments for it:

+       /*
+        * Align with 16 bytes: "greater than that used for any standard data
+        * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
+        */
+
+       vmlinuz_load_addr += (16 - vmlinux_size % 16);

Thanks & Regards,

-- 
Studying engineer. Wu Zhangjin
Lanzhou University      http://www.lzu.edu.cn
Distributed & Embedded System Lab      http://dslab.lzu.edu.cn
School of Information Science and Engeneering         http://xxxy.lzu.edu.cn
wuzhangjin@gmail.com         http://falcon.oss.lzu.edu.cn
Address:Tianshui South Road 222,Lanzhou,P.R.China    Zip Code:730000
Tel:+86-931-8912025
