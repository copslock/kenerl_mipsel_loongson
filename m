Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 15:11:41 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:44133
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994806AbeCIOLerJRSM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 15:11:34 +0100
Received: by mail-qt0-x244.google.com with SMTP id g60so10742289qtd.11;
        Fri, 09 Mar 2018 06:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tF6zZXjW2bG3tvxAqVdgADG8UGDkuePshWcNRfG/vQw=;
        b=MVJ6Fg/Y0mmk9ErRwgCsKUl76iZH2bNTp+rtBFbumIES8A9UMiPC+OVy1bs+DcS3B6
         P/3B/Qd+M1DuG8ZOMCgitqnEe0mIL9B/DfsRbX3SX/vdjHWUvcbrN59SH/NALATISFt+
         P9auRfJrrNpjMU7bBnj7GmwqlAAkv9NLNLVVoZv0uiY3eq4MYM6KvDyHmGikgfc7LRVS
         FnQZl48EBm18gMX4/18DJhtrHXcrAdDA5PLjIxjgK7lYG2h/vpU1nwUZMMV6OMLVBHi4
         QL31J7B1Bic3A8vEjBlSKS/NgD/4bljJBSCM907QZ5Lv6VChZSQXPuz8EDFxozoqIUYc
         JllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tF6zZXjW2bG3tvxAqVdgADG8UGDkuePshWcNRfG/vQw=;
        b=jneA8L39xlYrRkbIqp8cmQ46FKYyz7wAtBSue15n0hTOqil3zBEyAT+udyfbYWkHz5
         R7Gglarn2A5LzKOjlH2aEySJHF1ZtPx0YMMyCauq0ewogz6batRl876XJE4vxnZIlMGt
         3mUZFYVY6WuplCg5zSa4YI0i5xJbh+6AepSf7HsaACGVRIceUdUeYfqtEUTKt7EcNQX7
         SSD+w6vJuZvM+0SzrkoGGvO9DsGZlgN1RSc2YHSBKzOk7BBPeAnt0sDH75n1oMAVt17d
         nLng3QHCjVZW6J8/WVZlezAcUyaRcocJNB2r/ySKD8OTejWkO3X5yH3o5Ug6Kr62OYqq
         PH0A==
X-Gm-Message-State: AElRT7HkNJdCpZDUptCrL4MUBjpIRN+lUi05GiybLcO9iQ05aZYBtB5b
        mycWCBC9ynpbpI9MSJfpHhuopxAyqyCcHIPeFXc=
X-Google-Smtp-Source: AG47ELudBm0ltbuv8sQtqqx0ftVoWeC0hnUtpTPI4t6MtguuOWtTS+YvP0xQ+JqV/69bFVsX6UyOUDDp6easiPV+HPA=
X-Received: by 10.237.56.234 with SMTP id k97mr46245460qte.35.1520604688254;
 Fri, 09 Mar 2018 06:11:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.185.46 with HTTP; Fri, 9 Mar 2018 06:11:27 -0800 (PST)
In-Reply-To: <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com> <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Mar 2018 15:11:27 +0100
X-Google-Sender-Auth: W3i2gvxkZWph6HnLGbwzULFKbgE
Message-ID: <CAK8P3a0NZfxoxeJbrebBmZDqQhD9s12xpUwMoM-rZzH8aezuYA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] arch: add untagged_addr definition for other arches
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62872
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

On Fri, Mar 9, 2018 at 3:02 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> To allow arm64 syscalls accept tagged pointers from userspace, we must
> untag them when they are passed to the kernel. Since untagging is done in
> generic parts of the kernel (like the mm subsystem), the untagged_addr
> macro should be defined for all architectures.
>
> Define it as a noop for all other architectures besides arm64.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/alpha/include/asm/uaccess.h      | 2 ++
>  arch/arc/include/asm/uaccess.h        | 1 +
>  arch/arm/include/asm/uaccess.h        | 2 ++
>  arch/blackfin/include/asm/uaccess.h   | 2 ++
>  arch/c6x/include/asm/uaccess.h        | 2 ++
>  arch/cris/include/asm/uaccess.h       | 2 ++
>  arch/frv/include/asm/uaccess.h        | 2 ++
>  arch/ia64/include/asm/uaccess.h       | 2 ++
>  arch/m32r/include/asm/uaccess.h       | 2 ++
>  arch/m68k/include/asm/uaccess.h       | 2 ++
>  arch/metag/include/asm/uaccess.h      | 2 ++
>  arch/microblaze/include/asm/uaccess.h | 2 ++
>  arch/mips/include/asm/uaccess.h       | 2 ++
>  arch/mn10300/include/asm/uaccess.h    | 2 ++
>  arch/nios2/include/asm/uaccess.h      | 2 ++
>  arch/openrisc/include/asm/uaccess.h   | 2 ++
>  arch/parisc/include/asm/uaccess.h     | 2 ++
>  arch/powerpc/include/asm/uaccess.h    | 2 ++
>  arch/riscv/include/asm/uaccess.h      | 2 ++
>  arch/score/include/asm/uaccess.h      | 2 ++
>  arch/sh/include/asm/uaccess.h         | 2 ++
>  arch/sparc/include/asm/uaccess.h      | 2 ++
>  arch/tile/include/asm/uaccess.h       | 2 ++
>  arch/x86/include/asm/uaccess.h        | 2 ++
>  arch/xtensa/include/asm/uaccess.h     | 2 ++
>  include/asm-generic/uaccess.h         | 2 ++
>  26 files changed, 51 insertions(+)

I have patches to remove the blackfin, cris, frv, m32r, metag, mn10300,
score, tile and unicore32 architectures from the kernel, these should be
part of linux-next in the next few days. It's not a big issue, but if you keep
patching them, this will cause a merge conflict.

It might be easier to drop them from your patch as well.

    Arnd
