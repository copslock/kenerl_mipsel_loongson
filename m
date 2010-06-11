Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2010 17:18:56 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:51824 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492146Ab0FKOcD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Jun 2010 16:32:03 +0200
Received: by iwn34 with SMTP id 34so1415456iwn.36
        for <multiple recipients>; Fri, 11 Jun 2010 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6p61P/1iRVDOurgFYBaPJ+gsvg+EixmgoMhkOa7sTyk=;
        b=fgRJL75mPjtgaA9Zj6LRyyW2pjGHjMcadAImIHRsxe4AHkO6JgPUEWnezC2ZZhRtXn
         HRNjjrPkSsbqff29NYNMnBywep+QZPWopOZrxMLAajZHbt42KNxiHIiDxVILbnybLZvQ
         /LuLZZRAvMyf+iXKsPQGjyW7yKj5cU4Z4pJgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bKc6I/CvEjNL9hEk2nzqQ25pxHFngxR3wm6SiYWnpoeFbo6pzb+7fSDrKdFF9TdbZm
         n+Cacyp1xi2Wb+fxCE3EPuGqp0lJ5/bujmlQlix9vdkPsG5lryXWPB9EduguFm1fnfEP
         IOi5W9VePoDZ38n0UF1z8P4cc6ZV912jgb6Ys=
MIME-Version: 1.0
Received: by 10.231.124.227 with SMTP id v35mr1928471ibr.185.1276266720335; 
        Fri, 11 Jun 2010 07:32:00 -0700 (PDT)
Received: by 10.231.183.74 with HTTP; Fri, 11 Jun 2010 07:32:00 -0700 (PDT)
In-Reply-To: <BE430C874DBA6841A75E65151DCC6E1C0407668F@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
References: <BE430C874DBA6841A75E65151DCC6E1C0407668F@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Date:   Fri, 11 Jun 2010 16:32:00 +0200
Message-ID: <AANLkTimHTt3jCTPrlIDAkdDc8WheBf7bdEThk3JO8yNO@mail.gmail.com>
Subject: Re:
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Jabir M <Jabir_M@pmc-sierra.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 27120
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8113

Hi,

On Fri, Jun 11, 2010 at 4:06 PM, Jabir M <Jabir_M@pmc-sierra.com> wrote:
>    I am working on a FPU-less 34k MIPS platform with linux-2.6.24
> kernel. After running a Darwin media streaming server on the board
> for a while, my oprofile results shows high utilization on
> fpu_emulator_cop1Handler() & r4k_wait().
>
> wiki page http://www.linux-mips.org/wiki/Floating_point says gcc will
> use hard float as default and soft float is best suited model for a
> fpu less processor.  Could anyone kindly help me in understanding use
> of -msoft-float .
> Whether I need to compile
>
> 1. kernel with -msoft-float ? or
> 2. Glibc ? or
> 3. Application ? or
> 4. All the above ?

I have fought with this in the past; what you need to do is:
- build gcc with softfloat support (mipsel-softfloat-linux-gnu triplet
for example),
- build a libc with this new compiler,
- then rebuild all libraries and apps with you new softfloat toolchain.

<plug>
I have a working softfloat environment for MIPS32 here at [1], it includes a
complete c/c++ toolchain with gcc-4.4.3.   It's built for mips32r1, no idea if
it is supposed to work with 34k cores.
</plug>

Best regards,
        Manuel Lauss

[1]  http://mlau.at/files/mips32-linux/
