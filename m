Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 10:31:49 +0100 (CET)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:38009
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbdKQJblw7jJw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 10:31:41 +0100
Received: by mail-oi0-x243.google.com with SMTP id b189so1240019oia.5;
        Fri, 17 Nov 2017 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/FWYvKlOvJyvOBQELQQ+EyMq7FdSRPi8XDHjUPM760I=;
        b=dte8MlQurVIRtLAhAxufYuxKNx8Og23H7XLiYfwgxB6uf6WiNmmfGZnOcGTYFazW+f
         6xrkBlnfIqp5lP2ALz1a0HEoUUCtlrZBU6BmaM/fFgZ575PjcIh85QPAkYYAw7PU2m10
         W1WrfhzF00eTFQ12RjUnQzUDr4zTiPBjFXHsihjjueEIiJ0mHjmok17blJ4yzlRzbfHG
         mXn+ygLm9KM337VBJzO+7tHuUk0UTwEQU4j49gmcIflhCO9fCtIXaXJYORgNQvdkWFnW
         fw+w9BMmQThFreZn+MhDVqVv/mmQhuJOe9V9A1//QaZR2mh1vuP9FXjxFjXevPBvbbOs
         g29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/FWYvKlOvJyvOBQELQQ+EyMq7FdSRPi8XDHjUPM760I=;
        b=LtcWtuUVqQDFQ8uVfCZfr6rzn/cr17464xHYiLVK5m6LSQ35jAbMvuYgzAnj5Pq5+5
         SX0Z9OGOO/gEbBY1CeWeys2gD/V7U2F4+nwX4zRngT8ItEh5onPoLcFjE+b1A2hfENT3
         rDXFrwlzcNVOur1oNhqgySk+VPTops2675qtOZz4jhHKI0blmA1CdwRA0RFZeD+qaMh7
         tjS4qU0qJquAOsG+pigI2Rk9nfS/XWA4V4G/ICyrln4ThTR8QOzj6NfNMsrhMKzNQNir
         ShUk9fdNnLI9wLmf5QgRZpgEgVa9p1BY8qwz7wepTV9p0QqaKvRAxtWPKHZBzWOTJ8yg
         Q5Yg==
X-Gm-Message-State: AJaThX4arbq5YiuElChEH4YGCpZM8ojIW7jw77/ObflmCXBOLDozNWjN
        8lSggl8fDQg9jhnTpslzbUak3rs5uAeQh7vUG38=
X-Google-Smtp-Source: AGs4zMZ8O8ZKsHxZOzWGLqmjAi6bTpOeOz9JRrKpAxVy9+goAPc8Ls2RIKP4ZQ2solSAjvh7wAfKcJ4rwbTwwih4jjg=
X-Received: by 10.202.62.198 with SMTP id l189mr756674oia.281.1510911095452;
 Fri, 17 Nov 2017 01:31:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.43.3 with HTTP; Fri, 17 Nov 2017 01:31:34 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1711170954000.1709@nanos>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
 <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
 <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com>
 <alpine.DEB.2.20.1711160958430.2191@nanos> <CAK8P3a0wxs59T1zW4ahbJXeW6QjStm0mbCFoL_RQexAa6dzh_w@mail.gmail.com>
 <alpine.DEB.2.20.1711170954000.1709@nanos>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Nov 2017 10:31:34 +0100
X-Google-Sender-Auth: 6a0viZRogiMxMrsAk-G1-FnYDUA
Message-ID: <CAK8P3a3fcVKTwoqN0CxYchzcFqUZPBeko=oYsA9eNxu4bQoYyw@mail.gmail.com>
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
X-archive-position: 60989
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

On Fri, Nov 17, 2017 at 9:58 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 17 Nov 2017, Arnd Bergmann wrote:
>> On Thu, Nov 16, 2017 at 10:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Wed, 15 Nov 2017, Deepa Dinamani wrote:
>> >> Would this work for everyone?
>> >
>> > Having extra config switches which are selectable by architectures and
>> > removed when everything is converted is definitely the right way to go.
>> >
>> > That allows you to gradually convert stuff w/o inflicting wreckage all over
>> > the place.
>>
>> The CONFIG_64BIT_TIME would do that nicely for the new stuff like
>> the conditional definition of __kernel_timespec, this one would get
>> removed after we convert all architectures.
>>
>> A second issue is how to control the compilation of the compat syscalls.
>> CONFIG_COMPAT_32BIT_TIME handles that and could be defined
>> in Kconfig as 'def_bool (!64BIT && CONFIG_64BIT_TIME) || COMPAT',
>> this is then just a more readable way of expressing exactly when the
>> functions should be built.
>>
>> For completeness, there may be a third category, depending on how
>> we handle things like sys_nanosleep(): Here, we want the native
>> sys_nanosleep on 64-bit architectures, and compat_sys_nanosleep()
>> to handle the 32-bit time_t variant on both 32-bit and 64-bit targets,
>> but our plan is to not have a native 32-bit sys_nanosleep on 32-bit
>> architectures any more, as new glibc should call clock_nanosleep()
>> with a new syscall number instead. Should we then enclose
>
> Isn't that going to break existing userspace?

No, syscall that existing 32-bit user space enters would be handled by
compat_sys_nanosleep() on both 32-bit and 64-bit kernels at that
point. The idea here is to make the code path more uniform between
32-bit and 64-bit kernels.

      Arnd
