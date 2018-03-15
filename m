Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2018 09:04:17 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:34272
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbeCOIELV8P1x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2018 09:04:11 +0100
Received: by mail-it0-x241.google.com with SMTP id z7-v6so6075620iti.1;
        Thu, 15 Mar 2018 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yCw36mdZungrJO7C0NyYFRbIv/19kkLti6Ob7KL/5Ak=;
        b=kYJNoC0qKslc5/EEiuKSgt3IkqcKQOqpEmlL4Aq0VZ+Nbf1B8eacluvjopZMXxaRTY
         1sO3bHY6xE4b3rj6SQTN+W69GOsqUz6Fi1L2noaysmdmcogGnnE5Nti/Sx/faexWSUZJ
         S0BV4nXQ7EQJl/9Lfd+qCPTaFtmrKUGrg1EUd53vqYqouSOrfu53yYgaLBfeKjDP/sLD
         gf7K08I8ZWBW0SI2bmFSbTrHh/GmxgfcEAeFT1lld7shmNRM+PTZxbQ5RYACgACFwm3n
         Im8FdgGkBOeVjUrg3YI5RD61Ejj4F4oA/ecgn4pWAHvcJfcqWwia+o7zk7E1ACaJfHoB
         tOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yCw36mdZungrJO7C0NyYFRbIv/19kkLti6Ob7KL/5Ak=;
        b=bW1QAgdMe9WSIxkDDUSYRz+XKhaKKKmXj/Crxb6/gVozSKMCjWPY++JdEcvozXLWLb
         8aqW7uJbBwziJLpes7CaB9ZNPn/BErUyRW57+Q8xBVxSZvJrSW2kAan5aQscY9JaVwEO
         eyKn1v/RJMIBJK1KktHdZGLoWUAu+kWnT3j2/LDBpRR6aJMqvJwhD5NOFHyuq01kbhV8
         3p8QvfgtrhDiPrjO+sNoV/Q76bm97Hvu4usrGmEAIF9HwHny5xrGFr/92XXJIf9qOirp
         yKgqJ6yMFO+r8nB7v38kQY021rD8d+NjLbEchaA5IPTSHcBWgLIGPt3jTr6r14KljO0+
         d3uw==
X-Gm-Message-State: AElRT7EIKhcIVhTUrHVxuZJctFKTPrKgCDT/DwLLUjoDQ/RBePlv4CTb
        yrLsIa2aLexc7ROUP6w33LY+FBS8L0P4xLrtz/A=
X-Google-Smtp-Source: AG47ELu2KsG5YAS8v1axJ+bea6sWBzMOC1G3sgAnbtr6TXZSsx4LVt+HAC+0zPUXzJU6b9xl5mDxGVhRf0QILPVcfDI=
X-Received: by 10.36.134.2 with SMTP id u2mr4931172itd.28.1521101044927; Thu,
 15 Mar 2018 01:04:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.71 with HTTP; Thu, 15 Mar 2018 01:04:04 -0700 (PDT)
In-Reply-To: <CABeXuvpFfD+a6tSSOvni=v23DuJ-bWeZwmnzg4SU+TR=WHxs7Q@mail.gmail.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
 <201803132313.a4R8Y434%fengguang.wu@intel.com> <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
 <CAK8P3a1fxWAK94GH0cpzh6CHXgL4uJuDNCGpdJen5ib1HH1xoA@mail.gmail.com> <CABeXuvpFfD+a6tSSOvni=v23DuJ-bWeZwmnzg4SU+TR=WHxs7Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Mar 2018 09:04:04 +0100
X-Google-Sender-Auth: Map4-y8FQdzdO88VOrGUpjWD7R4
Message-ID: <CAK8P3a1p1PruO_KsiE-sGAZdmoAVi2E3zZ+SXMzU=AZsb-RY-A@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v4 02/10] include: Move compat_timespec/ timeval
 to compat_time.h
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        sebott@linux.vnet.ibm.com,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        Robert Richter <rric@kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gerald.schaefer@de.ibm.com,
        Parisc List <linux-parisc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, kbuild-all@01.org,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62989
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

On Thu, Mar 15, 2018 at 3:51 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Wed, Mar 14, 2018 at 1:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Mar 14, 2018 at 4:50 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>> The file arch/arm64/kernel/process.c needs asm/compat.h also to be
>>> included directly since this is included conditionally from
>>> include/compat.h. This does seem to be typical of arm64 as I was not
>>> completely able to get rid of asm/compat.h includes for arm64 in this
>>> series. My plan is to have separate patches to get rid of asm/compat.h
>>> includes for the architectures that are not straight forward to keep
>>> this series simple.
>>> I will fix this and update the series.
>>>
>>
>> I ran across the same thing in two more files during randconfig testing on
>> arm64 now, adding this fixup on top for the moment, but maybe there
>> is a better way:
>
> I was looking at how Al tested his uaccess patches:
> https://www.spinics.net/lists/linux-fsdevel/msg108752.html
>
> He seems to be running the kbuild bot tests on his own git.
> Is it possible to verify it this way on the 2038 tree? Or, I could
> host a tree also.

The kbuild bot should generally pick up any branch on git.kernel.org,
and the patches sent to the mailing list. It tests a lot of things
configurations, but I tend to find some things that it doesn't find
by doing lots of randconfig builds on fewer target architectures
(I only build arm, arm64 and x86 regularly).

I remember that there was some discussion about a method
to get the bot to test other branches (besides asking Fengguang
to add it manually), but I don't remember what came out of that.

        Arnd
