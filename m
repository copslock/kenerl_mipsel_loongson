Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 05:38:54 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:56630 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491109Ab0BAEiu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 05:38:50 +0100
Received: by pxi11 with SMTP id 11so3691982pxi.22
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 20:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=odC0p4YoMigSNBR0oOC34kx5Qno9xVqDZSn2Aivg3cg=;
        b=c//+Iq6pZlR/J9+18rPpPpmL2kQcTVit/LIDJqAZtKJg7uwg3khXAyKZV4gLTli4qQ
         v+lMDxsmeOCYN4GtjqADE9REGg+5okFYI/PWUrDBdws0i1oLB1fxwnSxu7Jc+4lN29rT
         BYWflLhvZOsqwda442PnJJOnJkF2wKKi+oQqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=CLSQoYjvWFJZlAzuevCGFhzqkkLqD2eU/oJSRj4RTeqIoAbdqrBL6035mcTFRcEAGm
         Vtft1IABds4BkIj9+LtAh9qVeY6PzC3V9Q+X7w7UeVbnln5gStI8ZZImLAHypUx/yTM1
         giRMX2rI36SVp4VUDmpuFBj5DfsYWdUd1PkSw=
MIME-Version: 1.0
Received: by 10.140.82.42 with SMTP id f42mr2818896rvb.163.1264999122356; Sun, 
        31 Jan 2010 20:38:42 -0800 (PST)
In-Reply-To: <20100129155303.GB3376@woodpecker.gentoo.org>
References: <38dc7fce1001290227v746c0a3dp4b3d81a58e73cf83@mail.gmail.com>
         <20100129155303.GB3376@woodpecker.gentoo.org>
Date:   Mon, 1 Feb 2010 13:38:42 +0900
Message-ID: <38dc7fce1001312038n6238ce9bga92df61ba04317dd@mail.gmail.com>
Subject: Re: GCC 4.4.2(mips) with -mplt option
From:   YD <ydgoo9@gmail.com>
To:     YD <ydgoo9@gmail.com>, linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <ydgoo9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips

I saw the toolchain for MIPS from broadcom(GCC-4.2.0, uClibc-0.9.29)
does support -mplt option.

I assumed they patched some code for uClibc and GCC also.

I hope I could find some patch like it. but I did not find yet.


On Sat, Jan 30, 2010 at 12:53 AM, Zhang Le <r0bertz@gentoo.org> wrote:
> On 19:27 Fri 29 Jan     , YD wrote:
>> Hello,
>>
>> I have built the toolchain using the buildroot ( GCC 4.4.2 with
>> uClibc-0.9.30.1 )
>
> I think you need to check if uClibc supports this feature.
> -mplt need support from libc, specifically dynamic loader, ld.so.
>
>>
>> Everything works well but when I compiled with -mplt option, always it
>> fails with Segmentation fault.
>>
>> I read some articles that with -mplt option, preformance will be 10%
>> highter than without plt option.
>>
>> I don't know why this fails everytime. please help me...
>>
>> #include <stdio.h>
>> int main()
>> {
>>  printf("Hello world \n"); return 0;
>> }
>>
>> #mipsel-linux-gcc  -o a a.c
>>  Hello world
>> #mipsel-linux-gcc -mplt -o a a.c
>>  Segmentation fault
>> #mipsel-linux-gcc -mplt -no-shared -o a a.c
>>  Segmentation fault
>> #mipsel-linux-gcc -mplt -no-shared -mabicalls -o a a.c
>>  Segmentation fault
>
> And -no-shared is actually not needed
> http://gcc.gnu.org/ml/gcc/2008-12/msg00010.html
>
> You should be able to verify this by 'mipsel-linux-gcc -v'
>
> Zhang, Le
>
