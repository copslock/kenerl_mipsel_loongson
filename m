Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 23:59:03 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:39623
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994696AbeCFW6vz1D2o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2018 23:58:51 +0100
Received: by mail-it0-x242.google.com with SMTP id l187so940421ith.4;
        Tue, 06 Mar 2018 14:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9BU1XIJejlcA5+ETQWzkzXQDr4aDP7Pwgh2JjLzXoqo=;
        b=gUraEbqPByk74uy0sAVecF7IxSjDEgzrTN6DWms8H076C945F6C6l+rwqIPv3wS4Q2
         KWSaYCRY2wUMN0BKBF5ZI7uU4pyZoDJd9x7BSIwZBZEVz6JovsGk+x2dUNBxPztrOlv3
         XEK1+QCDF/lPe06K5B2Jf/PqmKFkoeejS6yDn6pOM1dz8paq35EN7NKHpR6oQwhG0AC3
         GEL+6JIZz6nX79cT+4Nm/L9f263VPP9LA/+FynlTil6AIRPNe0j2tbQ7O85iAzz+y41h
         Jxh/ge3nZBd8FyRLvibSkn4W7/UiqVG80TIPNV+ab2apLzmhBAUxGLN3RkefYpiTQ0nj
         zwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9BU1XIJejlcA5+ETQWzkzXQDr4aDP7Pwgh2JjLzXoqo=;
        b=hSviqFSG+Vigq4LM7UKfyavlsi5N1RjVu6HivBX1hrD4hkM+0zpMSEovsgkzW6aCXZ
         lDd7grnOtnc34PtyU7gaJ7UkS0xxTex2+X9SwBGiEpN+AvFxUBibuK8zb9A/itF+rYvZ
         z0pBu/xf0IOvlVodsZzu6oQrbPP0z+vSqYXOgK6ILs9Kb6cCYkLqatOUn7OrpQKgtAhP
         X08FZQsQ+fpqKFLEiUVfbtR5aBWCvhL0/x6Cm5FjlksgcGAXBGkG6ckrFjwwFOAnwzas
         MNzkXb99J2j5Rpxvix9jS/lKM00FDB6Zx9KzHpZChTHdRBuyNx5cGaV9kiG9lADwizb3
         ZsOw==
X-Gm-Message-State: AElRT7EfxUyai3dK05BrxKXZ5FYw/avghpscKqz2Ui/GdFXM0+NT001n
        M1Ja3apACLXPdMtblBrllTnp75pMsFtxkvTbqyQ=
X-Google-Smtp-Source: AG47ELsmJN8yNz+BRsMefbs2x+SMW+reVHYxfQ7BxSZZVCKfWHNsSj5DcwWeXuw8MQFANCbTd4ex6/oC1+DGwK0bSt0=
X-Received: by 10.36.55.70 with SMTP id r67mr21242236itr.40.1520377125597;
 Tue, 06 Mar 2018 14:58:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.232.26 with HTTP; Tue, 6 Mar 2018 14:58:45 -0800 (PST)
In-Reply-To: <d8480da9-afe9-8a43-9c47-50919215a2de@de.ibm.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com> <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
 <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com> <d8480da9-afe9-8a43-9c47-50919215a2de@de.ibm.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 6 Mar 2018 14:58:45 -0800
Message-ID: <CABeXuvrdPV0q4ufuxEnqT6T3b8pCT5RLUfuAZ_cwXr0it8gj0Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to compat_time.h
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        sebott@linux.vnet.ibm.com,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robert Richter <rric@kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        gerald.schaefer@de.ibm.com,
        Parisc List <linux-parisc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>, cohuck@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

On Tue, Mar 6, 2018 at 4:48 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
> On 03/06/2018 01:46 PM, Arnd Bergmann wrote:
>> On Mon, Mar 5, 2018 at 10:30 AM, Christian Borntraeger
>> <borntraeger@de.ibm.com> wrote:
>>> On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
>>>> All the current architecture specific defines for these
>>>> are the same. Refactor these common defines to a common
>>>> header file.
>>>>
>>>> The new common linux/compat_time.h is also useful as it
>>>> will eventually be used to hold all the defines that
>>>> are needed for compat time types that support non y2038
>>>> safe types. New architectures need not have to define these
>>>> new types as they will only use new y2038 safe syscalls.
>>>> This file can be deleted after y2038 when we stop supporting
>>>> non y2038 safe syscalls.
>>>
>>> You are now include a <linux/*.h> from several asm files
>>> (
>>>  arch/arm64/include/asm/stat.h
>>>  arch/s390/include/asm/elf.h
>>>  arch/x86/include/asm/ftrace.h
>>>  arch/x86/include/asm/sys_ia32.h
>>> )
>>> It works, and it is done in many places, but it looks somewhat weird.
>>> Would it make sense to have an asm-generic/compate-time.h instead? Asking for
>>> opinions here.
>>
>> I don't think we have such a rule. If a header file is common to all
>> architectures (i.e. no architecture uses a different implementation),
>> it should be in include/linux rather than include/asm-generic, regardless
>> of whether it can be used by assembler files or not.
>>
>>>> --- a/drivers/s390/net/qeth_core_main.c
>>>> +++ b/drivers/s390/net/qeth_core_main.c
>>>> @@ -32,7 +32,7 @@
>>>>  #include <asm/chpid.h>
>>>>  #include <asm/io.h>
>>>>  #include <asm/sysinfo.h>
>>>> -#include <asm/compat.h>
>>>> +#include <linux/compat.h>
>>>>  #include <asm/diag.h>
>>>>  #include <asm/cio.h>
>>>>  #include <asm/ccwdev.h>
>>>
>>> Can you move that into the other includes (where all the other <linux/*> includes are.
>>
>> Good catch, this is definitely a rule we have ;-)
>
> FWIW, this was also broken for
> arch/x86/include/asm/sys_ia32.h

The reason that this was done this way is because of the sed script
mentioned in the commit text.
I was trying to make minimal change apart from the script so that we
don't have other changes like moving the lines to keep the patch
simpler.
I will fix this by hand since this is preferred.
I will post an update.

-Deepa
