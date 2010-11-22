Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 15:58:01 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:51085 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492018Ab0KVO5x convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Nov 2010 15:57:53 +0100
Received: by wwb31 with SMTP id 31so238375wwb.24
        for <linux-mips@linux-mips.org>; Mon, 22 Nov 2010 06:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mOwD1iujYtIouRxIuTjztCbUzd7dDwEpzM3An4DJKmA=;
        b=QhvHCs5OKJ3audrJkfueA6V+uXdE9DKuIIP3Mw/BFMBXzEoptTNKImpwaHTxlscdrQ
         DPh35dv1NVxyM5mQxgSTPf106PxxGek0KkHknnYWg912z4+UPy05eoC0CwMaQdxsHbUq
         Pif6J5zVAZnQr9T7aao/xFQO8F1UYjZEn/pFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t5b+lJ6zYvkvCsoQ0H7nIr8c9j+Jlbf96tSDyJvR3kyDEJHOi3ab/loBCwOPq0NN3i
         p4PpIR235Y1AIUE1MDdya3TKUcTDMJeP6IGPhGjL42U1lHNkrxzQgCAuItlBtXyJxb7i
         q6ReW/sjIfkWbo3E7Bm1nW2grNStwQ64pCV50=
MIME-Version: 1.0
Received: by 10.216.157.6 with SMTP id n6mr5230642wek.35.1290437860646; Mon,
 22 Nov 2010 06:57:40 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Mon, 22 Nov 2010 06:57:40 -0800 (PST)
In-Reply-To: <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
Date:   Mon, 22 Nov 2010 22:57:40 +0800
Message-ID: <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
Subject: Re: Build failure triggered by recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Arnaud Lacombe <lacombar@gmail.com>
Cc:     John Reiser <jreiseer@bitwagon.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

The cause should be the endian problem, I guess you were cross-compiling it?

If we compile the kernel for (32bit + big endian) target on an x86
machine(little endian) or reversely, then, it will fail.

Since the scripts/recordmcount is compiled with the local toolchain,
the data structs will be explained according to the local
configuration(endian...).

So, we may need to custom our own elf.h for recordmcount according to
the target type(endian here) of the kernel image:

At first, pass the target information to recordmcount(only a demo
here, we may need to clear it carefully):

diff --git a/scripts/Makefile b/scripts/Makefile
index 2e08810..151fe3e 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -11,6 +11,9 @@ hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
 hostprogs-$(CONFIG_LOGO)         += pnmtologo
 hostprogs-$(CONFIG_VT)           += conmakehash
 hostprogs-$(CONFIG_IKCONFIG)     += bin2c
+HOSTCFLAGS_recordmcount.o        += -DARCH=__$(ARCH)__ \
+       -DBIT=__$(if $(CONFIG_64BIT),64,32)__           \
+       -DENDIAN=__$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)__
 hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount

 always         := $(hostprogs-y) $(hostprogs-m)

Then, custom the related data struct(Elf...) for the specific
target(Perhaps we can steal some code from glibc...) and as a result,
no need to check the targets at run-time... just like what we have
done for the Perl version of recordmcount, but for the C version of
recordmcount, we only need to pass the information for one time.

Regard,
Wu Zhangjin

On Mon, Nov 22, 2010 at 7:42 PM, wu zhangjin <wuzhangjin@gmail.com> wrote:
> Hi, Arnaud
>
> This only happen at 32bit + big endian, so, perhaps, the symbol
> reltype of bitendian 32bit differs from little endian 32bit, I will
> check it later, thanks!
>
> Regards,
> Wu Zhangjin
>
> On Mon, Nov 22, 2010 at 11:04 AM, Arnaud Lacombe <lacombar@gmail.com> wrote:
>> Hi,
>>
>> The build of an `allyesconfig' configuration from v2.6.37-rc3 is
>> failing relatively soon on the following:
>>
>> [...]
>>  LD      init/mounts.o
>> /OpenWrt-SDK-ar71xx-for-Linux-i686/staging_dir/toolchain-mips_gcc4.1.2/bin/mips-linux-ld:
>> init/do_mounts.o: bad reloc symbol index (0x20200 >= 0x84) for offset
>> 0x0 in section `__mcount_loc'
>>
>> /OpenWrt-SDK-ar71xx-for-Linux-i686/staging_dir/toolchain-mips_gcc4.1.2/bin/mips-linux-ld
>> -v
>> GNU ld version 2.17
>>
>> The toolchain originated from OpenWRT Kamikaze and is available on their FTP[0].
>>
>> I've not been able to locate the exact point of failure.
>>
>>  - Arnaud
>>
>> [0]: http://downloads.openwrt.org/kamikaze/8.09.2/ar71xx/
>>
>>
>
