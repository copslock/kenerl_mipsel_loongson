Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 23:34:24 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:48167 "EHLO
        mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491810Ab0E0VeU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 23:34:20 +0200
Received: by pzk3 with SMTP id 3so177329pzk.24
        for <linux-mips@linux-mips.org>; Thu, 27 May 2010 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=x5wiHaTVPJsowRHwsWWpNk6egJmDMj7yw3FHw6g4hyE=;
        b=g9UV7Mghyf2vKAH5qUpbv9D2/kw06a6b5D7V2IOu+R9Wp7grHkAzgXWeSqhexLh3KP
         bI58mIOXqOk4sh2cBJMp99wl16FHJIk2DNpDGY5zLHUMWZzVMJuVU53N4hAK5C0G5Owf
         PkA53AzXYGT6KnlKiOPRWddlTeV11+nq+aI3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pAGkUBoHldc7ydO0uw3I6EPDSnzM9PJLDmuMms/CaYHpDTgKWjxNfQzQzzbniaZPQB
         KJNVNmXa88LRj/ivgcZaYOx696bWLbt2zwoo3xKFROAxorY0RpzEhZSoDktb7I7mMFs3
         waD9h8aDVFDkuQsheyWQygtxy22SDKS3rDX6I=
Received: by 10.142.55.4 with SMTP id d4mr7326283wfa.309.1274996052228;
        Thu, 27 May 2010 14:34:12 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id e40sm921376wfj.11.2010.05.27.14.34.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 14:34:11 -0700 (PDT)
Message-ID: <4BFEE551.8000306@gmail.com>
Date:   Thu, 27 May 2010 14:34:09 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     octane indice <octane@alinto.com>
CC:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
References: <1274711094.4bfa8c3675983@www.inmano.com>  <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>  <20100525131341.GA26500@linux-mips.org>  <1274795905.4bfbd781a17fa@www.inmano.com>  <20100525144400.GA30900@linux-mips.org>  <1274879482.4bfd1dfa91e70@www.inmano.com> <AANLkTikbZmTWh8X4KOKLAUaJxKS5-PO39hmiTVICB5Zm@mail.gmail.com> <1274977788.4bfe9dfc7680f@www.inmano.com>
In-Reply-To: <1274977788.4bfe9dfc7680f@www.inmano.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 09:29 AM, octane indice wrote:
> Response to Dmitri Vorobiev<dmitri.vorobiev@gmail.com>  :
>> Just checked that the following steps result in a successful
>> build of a vanilla 2.6.34 vmlinux:
>>
> Thanks for taking the time to do it.
>
>> http://ftp.gnu.org/gnu/gcc/gcc-4.4.4/gcc-core-4.4.4.tar.bz2
>> tar jxf gcc-core-4.4.4.tar.bz2
>> cd ../build
>> ../src/gcc-4.4.4/configure --target=mips64-unknown-linux-gnu
>> --prefix=/work/tmp/zoo --disable-threads --disable-shared
>> --disable-multilib --disable-libgcc --disable-libmudflap
>> --disable-libssp --disable-libgomp
>> make
>
> It fails here with something related to stdc++. With adding a
> --enable-language=c it works. So the configure line I used is:
> ../gcc-4.4.4/configure --target=mips64-unknown-linux-gnu
> --prefix=/var/samba/mips --disable-threads --disable-shared
> --disable-multilib --disable-libgcc --disable-libmudflap --disable-libssp
> --disable-libgomp --enable-languages=c
>
>> make ARCH=mips cavium-octeon_defconfig
>> make ARCH=mips
>> CROSS_COMPILE=/work/tmp/zoo/bin/mips64-unknown-linux-gnu- vmlinux
>>
>> Hope that helps.
>>
> It helped me a lot, thank you. The kernel compiles fine.
> The kernel is very huge: 39MBytes (!).
> After a mips64-unknown-linux-gnu-strip, it downsized to 3.3MBytes.
> But that kernel doesn't boot.
>
> The system in the board I have uses in U-boot:
> ext2load ide 0 4000000 vmlinux
> bootoctlinux 4000000 (other args..)
>
> But when I replace the vmlinux file with mine called 'mips', it says:
> RSEC-K1# ext2load ide 0 4000000 mips
>
> 3362840 bytes read
> WARNING: Data loaded outside of the reserved load area, memory corruption
> may occur.
> WARNING: Please refer to the bootloader memory map documentation for more
> information.
> RSEC-K1# bootoctlinux 4000000
> ELF file is 64 bit
> Attempting to allocate memory for ELF segment: addr: 0xffffffff81100000
> (adjusted to: 0x0000000001100000), size 0x355c00
> Allocated memory for ELF segment: addr: 0xffffffff81100000, size 0x355c00
> Attempting to allocate memory for ELF segment: addr: 0xffffffff81343da0
> (adjusted to: 0x0000000001343da0), size 0x24
> Error allocating memory for elf image!
> ## ERROR loading File!
> RSEC-K1#
>

Early Octeon bootloaders cannot handle PT_NOTE program headers, I think 
that is what is biting you here.

If you can upgrade to an SDK-1.9 or later bootloader, I would recommend 
that.  Otherwise remove the PT_NOTE from your kernel image (the 
technique for doing this is left as an excise for the reader, but I have 
found that emacs hexl mode works well).

David Daney
