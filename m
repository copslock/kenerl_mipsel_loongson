Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2010 17:09:33 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:60905 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492513Ab0AJQJ3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2010 17:09:29 +0100
Received: by pwj1 with SMTP id 1so969168pwj.24
        for <multiple recipients>; Sun, 10 Jan 2010 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n8tJ2xkrAaZpKgInTecKh5NCNTv3sNZcnBd+Ef6nrDU=;
        b=UOntVQyaO1uqhj2Z5F3pMmohOEIgVOroxb9pbuvtNo2XN242tqLEbMCfA9Rc/SwWCB
         QkMhrinpWuNk0+BNBnYo/QDwViuY0JVptQYO5otlm9ZEf+m0CqoTCMiqfAmx5oD2IwjJ
         PoLDDVcKRngXlPxWe8UeoC8AQOTnzx/3eUB+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hXSER/xcJc61mfDZ60z2b8qRwG+51AgAQD+Vtjp4+lXff6u/loN7ypMo7swkA6DV6h
         35n3FTOtFiK/B4QZOxw5JWqx53MBsWriHd3fx5I6q8U65qZTR7PYpwuE8nRoZ1/RU3IM
         z5oUzFNaZPLgLtRFeSeZ+TEZAMRaYvGj8gqxE=
MIME-Version: 1.0
Received: by 10.143.26.36 with SMTP id d36mr4799686wfj.280.1263139762879; Sun, 
        10 Jan 2010 08:09:22 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001061244330.13474@eddie.linux-mips.org>
References: <3a665c761001052313v36bfeb89v37ada6b76e91c271@mail.gmail.com>
         <alpine.LFD.2.00.1001061244330.13474@eddie.linux-mips.org>
Date:   Mon, 11 Jan 2010 00:09:22 +0800
Message-ID: <3a665c761001100809g1400db9er5cc3a6228467934a@mail.gmail.com>
Subject: Re: some question about Extended Asm
From:   loody <miloody@gmail.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6566

Hi:
Thanks for your help.

2010/1/6 Maciej W. Rozycki <macro@linux-mips.org>:
> On Wed, 6 Jan 2010, loody wrote:
>
>> I try to
>>   "or %0, count\n", where count is $a1.
>> so I write %1 as count and write
>>   "or %0, %1\n" and assign %1 as count in input section.
>>
>> But the result is not what I expect.
>> the result is "   or      v1,v1,v0"
>> Did I miss something or the only way to meet what I need is directly write
>>  "or %0, $a1\n"?
>
>  As you can figure out from the semantics:
>
>        or      v1, v0
>
> is a shorthand for:
>
>        or      v1, v1, v0
>There is no two-argument register OR instruction in the standard MIPS
>instruction set (nor there is a need for one).
I have some question about extended assembly in mips
1. is mips assembly in AT&T syntax?
    from the document I google from the web, they emphasize that the
GNU C compiler use AT&T syntax, and they list some example about intel
instructions.
But when I write the extended assembly in mips, I find it seem not AT&T syntax.
The order of input and output is still the same as original mips instructions.
Does that mean GNU compiler for mips doesn't use AT&T syntax?

2. how do we know which parameter is for %0,%1,etc?

suppose my src is as below
 asm(
                "add %0, %1, %2\n"
                "sub %0,%2, %1\n"
                :"=r" (count)
                :"r" (temp), "r" (count)
        );
how do I know which parameter is %0, %1 and %2?
there 2 variable, count and temp above, but in assembly it use 3 parameters.
how to match them?

appreciate your kind help,
miloody
