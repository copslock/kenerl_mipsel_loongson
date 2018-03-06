Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 13:46:44 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:34948
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994684AbeCFMqgxEeG- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2018 13:46:36 +0100
Received: by mail-qt0-x243.google.com with SMTP id z14so24359514qti.2;
        Tue, 06 Mar 2018 04:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/Ielnr86jGrUQlnBR/122CDpc3athB20kKhhVr6fYKo=;
        b=eFOHlHttRAGLuYv45Vsck5VAp9Xbtzcm+I6w73l9ParfoTL2DK+D0WVdtgzwAIlyOz
         1p/4D9NyjC/DHGOMBS+zEHdi2zulz4Ealx0X4lOfAWbSdF0TzI2y9VZ7uSE/QXbjspI3
         zB1/wkW9MjXy/Yk8Hm6BeHJbiUby8Rq69DEdxyMBAbcjjTHWRtVDyWxkcNLVWzezCl0b
         Yv4J3ulk6hcOLXCOFk7RzLZgrzR7kTNKvyRI6DsGuFIaDtp6ZDrfqQ5XaPypov+JGNxK
         KkLK4RrBKq/Kr14Suk1jIRRqcePQoSE0yHT7pdg+3JrVdtWQ6nqBExJja6EOuvXSB1Ws
         Mfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/Ielnr86jGrUQlnBR/122CDpc3athB20kKhhVr6fYKo=;
        b=GFiBLIasKMhemgafBeknve0JCBJinal3Z73ljfbXP7EDXXiWa/kzugp0aQRV9BdpQ+
         rhJyuoGyG0xn6yJdG26XCHz6eH9aXCrQYwgp5i7bZPT60fQz6lXWWHwm+173OZ17gflX
         q7/Wq+0f3ZV7UwfHFHJXBGM1KA/Cf0d7NYhwcbzUiK2j64SK8VWwzx7e816y7GFKCX+Z
         z+ZN9uczZ/36uv6pI9br48UfKchdMYdqIM1iumxKKhiMxDsJKuYW2d0rsfKcJvqWLDkE
         GgLWGPY3raRB903MbmrtcdCl+hvw4g9L9L7p2BPv/Z9iDlCkZQkNuxzuhIA2Szh1QR/y
         XKQA==
X-Gm-Message-State: AElRT7HIEEtaKyV9zOASaK7a2YW5FEfDhHv7ftvJ+WCKHR3Lwdi91kGw
        F67vbo+ImIhc9V2mthDSeddCEIqFaLKtAlw4+uo=
X-Google-Smtp-Source: AG47ELubcUMV/+p/AxAmTMPOWF9PblRAuLVhHE+k8ZdW1lB3Qhh5h6OFTi2hSjDKV9ynu+IUnH/10AD6Di9PnFGMwqU=
X-Received: by 10.200.36.233 with SMTP id t38mr28285144qtt.141.1520340390600;
 Tue, 06 Mar 2018 04:46:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.185.46 with HTTP; Tue, 6 Mar 2018 04:46:30 -0800 (PST)
In-Reply-To: <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com> <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Mar 2018 13:46:30 +0100
X-Google-Sender-Auth: Di7AbiJq9u7xkF2XLlEyCPy3GA0
Message-ID: <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to compat_time.h
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
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
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Mar 5, 2018 at 10:30 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
>> All the current architecture specific defines for these
>> are the same. Refactor these common defines to a common
>> header file.
>>
>> The new common linux/compat_time.h is also useful as it
>> will eventually be used to hold all the defines that
>> are needed for compat time types that support non y2038
>> safe types. New architectures need not have to define these
>> new types as they will only use new y2038 safe syscalls.
>> This file can be deleted after y2038 when we stop supporting
>> non y2038 safe syscalls.
>
> You are now include a <linux/*.h> from several asm files
> (
>  arch/arm64/include/asm/stat.h
>  arch/s390/include/asm/elf.h
>  arch/x86/include/asm/ftrace.h
>  arch/x86/include/asm/sys_ia32.h
> )
> It works, and it is done in many places, but it looks somewhat weird.
> Would it make sense to have an asm-generic/compate-time.h instead? Asking for
> opinions here.

I don't think we have such a rule. If a header file is common to all
architectures (i.e. no architecture uses a different implementation),
it should be in include/linux rather than include/asm-generic, regardless
of whether it can be used by assembler files or not.

>> --- a/drivers/s390/net/qeth_core_main.c
>> +++ b/drivers/s390/net/qeth_core_main.c
>> @@ -32,7 +32,7 @@
>>  #include <asm/chpid.h>
>>  #include <asm/io.h>
>>  #include <asm/sysinfo.h>
>> -#include <asm/compat.h>
>> +#include <linux/compat.h>
>>  #include <asm/diag.h>
>>  #include <asm/cio.h>
>>  #include <asm/ccwdev.h>
>
> Can you move that into the other includes (where all the other <linux/*> includes are.

Good catch, this is definitely a rule we have ;-)

       Arnd
