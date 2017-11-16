Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 00:42:49 +0100 (CET)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:39451
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992188AbdKPXmmJ-m5K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 00:42:42 +0100
Received: by mail-oi0-x242.google.com with SMTP id r190so522613oie.6;
        Thu, 16 Nov 2017 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hpNeYm30ruNAfIduvbbbXwpbFZQ35hFiqhNPvDxd8Fc=;
        b=G2weztNxVFEquGfqXw0UM5OdKUgm2OiPtW+NVYo0ih8gHfY/tc3vGYB/dRNNZdfzjc
         bZIz46PbZ/wp1mILzFaXSellaI3KGHSqZTAIBkcWEbpLLzV7Os7GlUc3nKNz3vIIorfv
         w9wiEUGi70gQ13LIPS2dGYifqD6SHHnV4qphihP0Rj54cRcpTBYusAfwpCwHHIXG8RuZ
         T5W1QdtiK/21U7kguyGtTFVxN+etUxOtMRgywAKTTMc3fbVcunGIpB3nW6a6vTkXA5FS
         rDciz7+w23vPWhKA84nVL5YU4BSHm8P501HHIqAQy+BqLoDxDvrBsi6Sc5xAOh20RPvM
         GhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hpNeYm30ruNAfIduvbbbXwpbFZQ35hFiqhNPvDxd8Fc=;
        b=UKFCXy0PUPOhnw0P+CAfjc/TQQ1JXxWp0n+PrdnO8HBiv9dNkXm4QeX9pU+6kaxyJb
         EmgJURi1kZ19fqQ16kobmbRzCOEjCULAbug/HHagoNZJe+HgAtgk7saZil0wB967J0in
         ppxedqRV+28Yu9vg4xbR6FM2+xQL6tcZCe0BSEFcDxTE7OGdRQRbPSL45uHRG+eY6AUX
         2POtU1TFkLcn5GDueBVn28ZqhmZIrOFZLb7X4gtHVZkPgsgxPDRDcYjXyAJykkgZ8hRM
         A9nSPYXn0rj9W3eEo681x7Ac/xSnY13+GWGM3uHUuA/+jo02kFC0s8J0VidMMOQ9X+ST
         wAuQ==
X-Gm-Message-State: AJaThX7qZRiiFWYes/8se3r6Ku+y++ehtvZ3vl9dB+rIRfohFOpTbCQ3
        W70W+7NKtcSynclo4QF31oktaNR51VQtjnBinUc=
X-Google-Smtp-Source: AGs4zMZkyQRu8YBDwgn63Lg+eb+8ZDXJ/v8MsMSM5NzSD9FS1ORMjmNK24rtvqPTwUY95ivcMpONmq0mHekbhYHEBTM=
X-Received: by 10.202.229.65 with SMTP id c62mr13789oih.128.1510875755767;
 Thu, 16 Nov 2017 15:42:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.43.3 with HTTP; Thu, 16 Nov 2017 15:42:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1711160958430.2191@nanos>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
 <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
 <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com> <alpine.DEB.2.20.1711160958430.2191@nanos>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Nov 2017 00:42:35 +0100
X-Google-Sender-Auth: qV6qBbRCPsm0bRHmCYki0BT0dCM
Message-ID: <CAK8P3a0wxs59T1zW4ahbJXeW6QjStm0mbCFoL_RQexAa6dzh_w@mail.gmail.com>
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
X-archive-position: 60977
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

On Thu, Nov 16, 2017 at 10:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 15 Nov 2017, Deepa Dinamani wrote:
>> > I had on concern about x32, maybe we should check
>> > for "COMPAT_USE_64BIT_TIME" before zeroing out the tv_nsec
>> > bits.
>>
>> Thanks, I think you are right. I had the check conditional on
>> CONFIG_64BIT_TIME and then removed as I forgot why I added it. :)
>>
>> > Regarding CONFIG_COMPAT_TIME/CONFIG_64BIT_TIME, would
>> > it help to just leave out that part for now and unconditionally
>> > define '__kernel_timespec' as 'timespec' until we are ready to
>> > convert the architectures?
>>
>> Another approach would be to use separate configs:
>>
>> 1. To indicate 64 bit time_t syscall support. This will be dependent
>> on architectures as CONFIG_64BIT_TIME.
>> We can delete this once all architectures have provided support for this.
>>
>> 2. Another config (maybe COMPAT_32BIT_TIME?) to be introduced later,
>> which will compile out all syscalls/ features that use 32 bit time_t.
>> This can help build a y2038 safe kernel later.
>>
>> Would this work for everyone?
>
> Having extra config switches which are selectable by architectures and
> removed when everything is converted is definitely the right way to go.
>
> That allows you to gradually convert stuff w/o inflicting wreckage all over
> the place.

The CONFIG_64BIT_TIME would do that nicely for the new stuff like
the conditional definition of __kernel_timespec, this one would get
removed after we convert all architectures.

A second issue is how to control the compilation of the compat syscalls.
CONFIG_COMPAT_32BIT_TIME handles that and could be defined
in Kconfig as 'def_bool (!64BIT && CONFIG_64BIT_TIME) || COMPAT',
this is then just a more readable way of expressing exactly when the
functions should be built.

For completeness, there may be a third category, depending on how
we handle things like sys_nanosleep(): Here, we want the native
sys_nanosleep on 64-bit architectures, and compat_sys_nanosleep()
to handle the 32-bit time_t variant on both 32-bit and 64-bit targets,
but our plan is to not have a native 32-bit sys_nanosleep on 32-bit
architectures any more, as new glibc should call clock_nanosleep()
with a new syscall number instead. Should we then enclose
sys_nanosleep in "#if !defined(CONFIG_64BIT_TIME) ||
defined(CONFIG_64BIT)", or should we try to come up with another
Kconfig symbol name that expresses this better?

       Arnd
