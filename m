Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 11:46:53 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:43151
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbdKQKqofesxu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 11:46:44 +0100
Received: by mail-ot0-x244.google.com with SMTP id 105so1654937oth.10;
        Fri, 17 Nov 2017 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1vyNq+EHBC8NnFMSNPJ+YwxKo11zW+jQbDUJcx5jxUE=;
        b=tyqQquwgD3qIpku4gJnoTL31dQhnDKSAO+Y8udRuEjBTtWyGbhAVIOwThrRexrZ5ZX
         kNC6Geow3tgPjGYCmKhYKk2H//iCPjrylwXy0hzQIns4xQLTSTKcqNB+YRgOBaHLXZQL
         9nWiI+jBhzcpTUZpMFWg4r307iJEB8Pgitovm6jEfcTToL9VKjVwCjtQmW4cWz4TJoRA
         T2UT3Vc6NH+YNWD+f9cqCMXTPLrw1kx0SiZ1X33ecr06TXuh5zVq0cDWxASyxRlytfdj
         mZAOOwj3M2N/TbFo2bxBEKIH7ADymHC1A4ZaNGqFVNEsb/lRTRzIQ6YUANz/wUTTFnNT
         leUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1vyNq+EHBC8NnFMSNPJ+YwxKo11zW+jQbDUJcx5jxUE=;
        b=YBOP9MfIwutmiLd5lQgC+P/2IGGnNzeVC0Q1WNN3tx6QmZSQqb+/tpn9ovjSfx/oAd
         J7pPrWsWeGqRc3ne2Onu2EY6IxoO4LALI0ituEN7VEgcaec4qEl1jlq+RceIKlU1rc++
         ATKNPbozZrULI9fEZmufIrPZ9FvkbqMSQWUSxcz7y2g33/l3lrALKng2PelmKPVj6g64
         QTrWaoMnthhVSDsWswlyu1Jo7WgxnE/ns7dvJl3MTcsWvNSRlHHT/G8pFaMxg8LQxBET
         P6v+o18w4UfivozfH0N02HkhzRP6DU39+7W75K0LfU24EdhVkcpdVXcxp8rotSmUaa5X
         oM+Q==
X-Gm-Message-State: AJaThX7D8pfjx84FRuuv5M+Zxj9HrFhx/meGU9ur5c3vPM94f6JAb9OS
        OHXunKCoq0icPGszno4akYFyVjv4/0tlBv08MOo=
X-Google-Smtp-Source: AGs4zMaDssPJEJIEa9z3OGN90NRx74HGthjVhzbrPEujNz5kQnW9O0HC2gM4W9z+Y0M1xg1WoGbfKmnLEtI1lt/4DNE=
X-Received: by 10.157.34.20 with SMTP id o20mr906100ota.104.1510915598244;
 Fri, 17 Nov 2017 02:46:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.43.3 with HTTP; Fri, 17 Nov 2017 02:46:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1711171138510.7700@nanos>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
 <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
 <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
 <alpine.DEB.2.20.1711160958430.2191@nanos> <CAK8P3a0wxs59T1zW4ahbJXeW6QjStm0mbCFoL_RQexAa6dzh_w@mail.gmail.com>
 <alpine.DEB.2.20.1711170954000.1709@nanos> <CAK8P3a3fcVKTwoqN0CxYchzcFqUZPBeko=oYsA9eNxu4bQoYyw@mail.gmail.com>
 <alpine.DEB.2.20.1711171049180.1709@nanos> <CAK8P3a10N42rBO8XBrZWYOCwVB8jayjgZu2oa8FSpHTzszQacQ@mail.gmail.com>
 <alpine.DEB.2.20.1711171138510.7700@nanos>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Nov 2017 11:46:37 +0100
X-Google-Sender-Auth: PIetoqAfyFJkmB7GALjYAUP603A
Message-ID: <CAK8P3a1J0C5A+SzVWDz52ZkawG1HZYj2cR6oc=DL=QrXgYaiHg@mail.gmail.com>
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t conversion
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com,
        David Miller <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60994
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

On Fri, Nov 17, 2017 at 11:40 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 17 Nov 2017, Arnd Bergmann wrote:
>> On Fri, Nov 17, 2017 at 10:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Fri, 17 Nov 2017, Arnd Bergmann wrote:
>> >> On Fri, Nov 17, 2017 at 9:58 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >>
>> >> No, syscall that existing 32-bit user space enters would be handled by
>> >> compat_sys_nanosleep() on both 32-bit and 64-bit kernels at that
>> >> point. The idea here is to make the code path more uniform between
>> >> 32-bit and 64-bit kernels.
>> >
>> > So on a 32bit system compat_sys_nanosleep() would be the legacy
>> > sys_nanosleep() with the existing syscall number, but you don't want to
>> > introduce a new sys_nanosleep64() for 32bit. That makes a lot of sense.
>> >
>> > So back to your original question whether to use #if (MAGIC logic) or a
>> > separate config symbol. Please use the latter, these magic logic constructs
>> > are harder to read and prone to get wrong at some point. Having the
>> > decision logic in one place is always the right thing to do.
>>
>> How about this:
>>
>> config LEGACY_TIME_SYSCALLS
>>       def_bool 64BIT || !64BIT_TIME
>>       help
>>         This controls the compilation of the following system calls:
>> time, stime,
>>         gettimeofday, settimeofday, adjtimex, nanosleep, alarm, getitimer,
>>         setitimer, select, utime, utimes, futimesat, and
>> {old,new}{l,f,}stat{,64}.
>>         These all pass 32-bit time_t arguments on 32-bit architectures and
>>         are replaced by other interfaces (e.g. posix timers and clocks, statx).
>>         C libraries implementing 64-bit time_t in 32-bit architectures have to
>>         implement the handles by wrapping around the newer interfaces.
>
> s/handles/handling/ ????

I meant "handlers".

>>         New architectures should not explicitly disable this.
>
> New architectures should never enable this, right?

Right, I got an extra "not". I guess if Deepa incorporates the new option,
she can also improve my English ;-)

         Arnd
