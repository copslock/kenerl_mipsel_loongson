Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 16:10:31 +0100 (CET)
Received: from mail-qk0-x230.google.com ([IPv6:2607:f8b0:400d:c09::230]:33020
        "EHLO mail-qk0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdCFPKYaoSCh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 16:10:24 +0100
Received: by mail-qk0-x230.google.com with SMTP id y76so26877250qkb.0
        for <linux-mips@linux-mips.org>; Mon, 06 Mar 2017 07:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=systemhalted.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WWJmdPZ9NWttrCdNFQI1XbK+HgGRSgTz2XdblaMohlU=;
        b=FvnK+FdKN9EWyJsk4swpZCJq3DnDKeZlc+QWXRjwyuwpMJDHl9Sh53BLppRGVZEgZF
         9/uGCvL3/xxC8VeD1v3H402rA0TjD0MNqWwyvKoo70qaVi3gjbIwY+69/RqBDhx6W2in
         5xIxc8dsDCmmkgTyOluyvft8qBpNSO4azv7xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WWJmdPZ9NWttrCdNFQI1XbK+HgGRSgTz2XdblaMohlU=;
        b=a25ZaWdV15KQATwA+OOnXSDzmUW7asUsIZlNPH2/LULuUUCzW8IPlpLm+3yUrjW4Qc
         pC2b8MpCa9t3B1NnzQ9AwRGnIvbR3Xye/qzXi+u386OzeX4bP+VE3QwkOL+OoT2Sdpof
         hu2qP5TcdKHUm2kzSusS4OYQDVcPwRof+hc7IcHlCkvJoRCJTN2j+tMK0L8tyD7zuSX9
         nzcwYCU9jSpRQuzMZ7vHvpKFtcLz+hNJgKu7ohpXbjOpSxlEuSwQ4RxgHMNzw2wJNsEO
         EWw+n4+yVxlvo9AGjWbamVdYPfsGWDMCjIyeq+7wtKV/4q9Rs4FQGxG19WB+/7ty0ok7
         s3SA==
X-Gm-Message-State: AMke39no5GO1b5GjU+NO1VFoEFVMgCJ6spboWd5nePJ21H1xCSy0n1ULDh3/8KQgmtTkXkn3e92EzHv0ljQ6Iw==
X-Received: by 10.55.19.10 with SMTP id d10mr14843619qkh.312.1488813018688;
 Mon, 06 Mar 2017 07:10:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.61.167 with HTTP; Mon, 6 Mar 2017 07:10:18 -0800 (PST)
X-Originating-IP: [184.145.137.27]
In-Reply-To: <CAE2sS1i-xezJu2hHfzOxpCMZHc2J+dsturtqFPMRWHa6mm6ccQ@mail.gmail.com>
References: <20170226010156.GA28831@altlinux.org> <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
 <CAE2sS1h9QNV+31GMSv8aahJYOb9hFtFp5Aj-yVOfg7cjBHr_kg@mail.gmail.com>
 <20170302154845.GB3503@altlinux.org> <CAE2sS1i-xezJu2hHfzOxpCMZHc2J+dsturtqFPMRWHa6mm6ccQ@mail.gmail.com>
From:   "Carlos O'Donell" <carlos@systemhalted.org>
Date:   Mon, 6 Mar 2017 10:10:18 -0500
Message-ID: <CAE2sS1jTyENymA-fSAk4dt29rYgX50zYqubVYnGVGnFrH=-1nA@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix asm/signal.h userspace compilation errors
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <carlos@systemhalted.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carlos@systemhalted.org
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

On Fri, Mar 3, 2017 at 8:23 PM, Carlos O'Donell <carlos@systemhalted.org> wrote:
> On Thu, Mar 2, 2017 at 10:48 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> On Thu, Mar 02, 2017 at 10:22:18AM -0500, Carlos O'Donell wrote:
>>> On Wed, Mar 1, 2017 at 11:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> > On Sun, Feb 26, 2017 at 2:01 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>>> >> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
>>> >> userspace compilation errors like this:
>>> >>
>>> >> /usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
>>> >>   size_t ss_size;
>>> >>
>>> >> As no uapi header provides a definition of size_t, inclusion
>>> >> of <stddef.h> seems to be the most conservative fix available.
>> [...]
>>> > I'm not sure if this is the best fix. We generally should not include one
>>> > standard header from another standard header. Would it be possible
>>> > to use __kernel_size_t instead of size_t?
>>>
>>> In glibc we handle this with special use of __need_size_t with GCC's
>>> provided stddef.h.
>>>
>>> For example glibc's signal.h does this:
>>>
>>> # define __need_size_t
>>> # include <stddef.h>
>>
>> Just to make it clear, do you suggest this approach for asm/signal.h as well?

The best practice from the glibc community looks like this:

(a) Create a bits/types/*.h header for the type you need.

e.g.
./time/bits/types/struct_timeval.h
./time/bits/types/struct_itimerspec.h
./time/bits/types/time_t.h
./time/bits/types/struct_timespec.h
./time/bits/types/struct_tm.h
./time/bits/types/clockid_t.h
./time/bits/types/clock_t.h
./time/bits/types/timer_t.h

(b) If neccessary the bits/types/*.h header is a wrapper:
~~~
#define __need_size_t
#include <stddef.h>
~~~
to get access to the compiler provided type.

This way all of the code you need simplifies to includes for the types you need.

e.g.

time/sys/time.h:
...
#include <bits/types.h>
#include <bits/types/time_t.h>
#include <bits/types/struct_timeval.h>
...

This is what we've been doing in glibc starting last September as we
cleaned up all the convoluted conditional logic to get the types we
needed in the headers that needed them.

Cheers,
Carlos.
