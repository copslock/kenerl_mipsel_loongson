Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 06:21:02 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:61144 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491063Ab0KWFUz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 06:20:55 +0100
Received: by wyf22 with SMTP id 22so8042369wyf.36
        for <linux-mips@linux-mips.org>; Mon, 22 Nov 2010 21:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K9YB+Bnm76Yq9/OSteyQ+oCmNErk/nVlswFass1VxCg=;
        b=unIp3YyUdriIz6gR1/4WQvi1W1sE3BHUTyHShZZM4UEex60N9rXaIpZk/RrPZYeunW
         xW1K01hKQ+4eMEy8y1xAqo1KJbc1Lx4b33ZwCAQ5nH3WGj0eblP0I06HbNoBp9CwVOG2
         aodRg2b4Bg52J3TW304hI6AjyVmRqN4DguDHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gJp2rJghul6JLfB8wxlR+Mn6y3upIb6V77ff6WMLojHb6xjlBjCpjvo7ocnaP6HnOB
         fzXk8RVEAMBHxdAgKe6jNlvKdSHyUV2udV3h03pnAd0mseRPl0ry1xp6zJRzk+S6O56D
         iAa6crbzwQiStX2BUCeRmm927w08SvQ2p+gJA=
MIME-Version: 1.0
Received: by 10.216.30.65 with SMTP id j43mr6074841wea.20.1290489648999; Mon,
 22 Nov 2010 21:20:48 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Mon, 22 Nov 2010 21:20:28 -0800 (PST)
In-Reply-To: <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
        <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
        <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
Date:   Tue, 23 Nov 2010 13:20:28 +0800
Message-ID: <AANLkTingc9-=HmL-GZ7vZ7JtZs+hKVsw88AFUfHwsbvS@mail.gmail.com>
Subject: Re: Build failure triggered by recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Arnaud Lacombe <lacombar@gmail.com>
Cc:     John Reiser <jreiser@bitwagon.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2010 at 2:46 AM, Arnaud Lacombe <lacombar@gmail.com> wrote:
> Hi,
>
> On Mon, Nov 22, 2010 at 9:57 AM, wu zhangjin <wuzhangjin@gmail.com> wrote:
>> Hi,
>>
>> The cause should be the endian problem, I guess you were cross-compiling it?
>>
> yes.
>
>> If we compile the kernel for (32bit + big endian) target on an x86
>> machine(little endian) or reversely, then, it will fail.
>>
>> Since the scripts/recordmcount is compiled with the local toolchain,
>> the data structs will be explained according to the local
>> configuration(endian...).
>>
> will it ? recordmcount.c does not switch endianness based on the host,
> but based on format of the object file, see the switch
> (ehdr->e_ident[EI_DATA]) { ... } in do_file(), the result does also
> depend a runtime endianness check.

Yes ;-)

>
>> So, we may need to custom our own elf.h for recordmcount according to
>> the target type(endian here) of the kernel image:
>>
>> At first, pass the target information to recordmcount(only a demo
>> here, we may need to clear it carefully):
>>
>> diff --git a/scripts/Makefile b/scripts/Makefile
>> index 2e08810..151fe3e 100644
>> --- a/scripts/Makefile
>> +++ b/scripts/Makefile
>> @@ -11,6 +11,9 @@ hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
>>  hostprogs-$(CONFIG_LOGO)         += pnmtologo
>>  hostprogs-$(CONFIG_VT)           += conmakehash
>>  hostprogs-$(CONFIG_IKCONFIG)     += bin2c
>> +HOSTCFLAGS_recordmcount.o        += -DARCH=__$(ARCH)__ \
>> +       -DBIT=__$(if $(CONFIG_64BIT),64,32)__           \
>> +       -DENDIAN=__$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)__
>>  hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
>>
>>  always         := $(hostprogs-y) $(hostprogs-m)
>>
> hum,
>
> % grep "BIT\|ENDIAN" scripts/recordmcount.*
> scripts/recordmcount.h: mcsec.sh_type = w(SHT_PROGBITS);
> scripts/recordmcount.h: if (SHT_PROGBITS != w(txthdr->sh_type) ||
>
> so none these macro are not checked explicitly, and headers included
> should not either.

John have already abstracted w, w2, w8 to handle the endianess
problem, I just forgot looking to them, sorry ;-)

BTW,

1. But check the endianess and ARCH before compiling the
scripts/recordmcount.c may speedup it a lot for after issuing "make
ARCH=XXX", everything including the endianess and ARCH of the object
files are definite, so, we may don't need to check them at runtime. of
course, check them at runtime can avoid compiling it for different
ARCHs but who will use this for different ARCHs at the same time ;-)
2. In the long run, we may be possible to add a new option(with -pg)
to gcc and ask it to create a __mcount_loc section for us, then, we
will be able to use it in kernel directly. I think gcc will be easier
to put the _mcount calling sites into a section because it adds them
and therefore knows 'more'(where, endianess, type... are definite)
about them, but in kernel, we need extra/complex search, check and
relocation...

Thanks & Regards,
Wu Zhangjin
