Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2018 03:51:44 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:35086
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992829AbeCOCvi1TVAF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2018 03:51:38 +0100
Received: by mail-it0-x243.google.com with SMTP id v194-v6so7289935itb.0;
        Wed, 14 Mar 2018 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6PsZsueiuYK6l9Dw0AfvU5YG1pNdqWBwlt22vBUHALc=;
        b=lH/NvflsJblDSRZWCJg2TKh1hnn+XUi6Im3KA/x2PcQ+4Uskztf+dN2/xVWPxArHF2
         7Eoxg4uFMnWdOHfFs1+fm/bdqcUfZauhYtEfPYJ6ccgP3o83cwXNEZBXrf51JpWHIuog
         7d7Ma+MivrfIVMWJ3nFl22HAb2Z5Scz4hPe4Zp0Jm1GHNI8LbjAk/2ZPb3fj92VCmBAh
         yxlDXBv3k3DnO6dcPlr5njmZnCd+4LQD9FuZRezY7lPzsacjM2FACpQXd29cBhdy3ZfI
         YMHFBUb0HMVIkuOiD9QxKFIecy3XINOEiaH9hGQgrZJ9ZiArKS4ciAsWNmBufWt4uRd0
         RlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6PsZsueiuYK6l9Dw0AfvU5YG1pNdqWBwlt22vBUHALc=;
        b=Zyj2nRlK9vTFKQGG662GxsN+KXlu00knf34gs869li4cw1Rea7rpFI/tkW7Im6uIKv
         WiGnsgm8I+KOM1pTo2HqXfe82xEA/7gN7TjVpN+vGiemOU/jxIVUGAyqxh2EKXEiN3Xi
         cFti46s5qR4JF2fF1NxAN5xIXfaST8UPbRI/D8pX9l9StSCnK3IynOcam0CWogSdQbqc
         fVMCa98uIdarMfKsztsP6WK5EVlXVvyYfEjffRB/y2hlTZcJ+tDEDX3L+iAvQ2nK74mH
         cxnc9E++3C5PvBnoIYFvqkFXEl4KGG0suIrDFegL9bncwRCu/EJQ9SLS6g9rknUhbBLi
         SLFQ==
X-Gm-Message-State: AElRT7FPO/3T7znHOHiCQfUy+vpgge92nIyKgL3NTfNqvnS4aYdfVT2W
        2QOaIgjhbJQufqhrSwXBJbT+qGCaYbvmC1eue3w=
X-Google-Smtp-Source: AG47ELsOk4zGt84Iv4l3pKsrBv6OJiHt8sgY+doYXZfldItEeYrwEBkWO/xlVTrzjWqkS5bOfi+sRd/uT2EvKRTwahQ=
X-Received: by 2002:a24:32c4:: with SMTP id j187-v6mr4508526ita.85.1521082292127;
 Wed, 14 Mar 2018 19:51:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 14 Mar 2018 19:51:31 -0700 (PDT)
In-Reply-To: <CAK8P3a1fxWAK94GH0cpzh6CHXgL4uJuDNCGpdJen5ib1HH1xoA@mail.gmail.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
 <201803132313.a4R8Y434%fengguang.wu@intel.com> <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
 <CAK8P3a1fxWAK94GH0cpzh6CHXgL4uJuDNCGpdJen5ib1HH1xoA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 14 Mar 2018 19:51:31 -0700
Message-ID: <CABeXuvpFfD+a6tSSOvni=v23DuJ-bWeZwmnzg4SU+TR=WHxs7Q@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v4 02/10] include: Move compat_timespec/ timeval
 to compat_time.h
To:     Arnd Bergmann <arnd@arndb.de>
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
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62988
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

On Wed, Mar 14, 2018 at 1:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Mar 14, 2018 at 4:50 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> The file arch/arm64/kernel/process.c needs asm/compat.h also to be
>> included directly since this is included conditionally from
>> include/compat.h. This does seem to be typical of arm64 as I was not
>> completely able to get rid of asm/compat.h includes for arm64 in this
>> series. My plan is to have separate patches to get rid of asm/compat.h
>> includes for the architectures that are not straight forward to keep
>> this series simple.
>> I will fix this and update the series.
>>
>
> I ran across the same thing in two more files during randconfig testing on
> arm64 now, adding this fixup on top for the moment, but maybe there
> is a better way:

I was looking at how Al tested his uaccess patches:
https://www.spinics.net/lists/linux-fsdevel/msg108752.html

He seems to be running the kbuild bot tests on his own git.
Is it possible to verify it this way on the 2038 tree? Or, I could
host a tree also.

Thanks,
Deepa
