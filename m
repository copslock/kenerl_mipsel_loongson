Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 19:19:03 +0100 (CET)
Received: from zeniv.linux.org.uk ([195.92.253.2]:60510 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994680AbeCRSSyOu1Ph (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 19:18:54 +0100
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1exctM-000830-BM; Sun, 18 Mar 2018 18:18:48 +0000
Date:   Sun, 18 Mar 2018 18:18:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jslaby@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Message-ID: <20180318181848.GU30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <viro@ftp.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viro@ZenIV.linux.org.uk
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

On Sun, Mar 18, 2018 at 11:06:42AM -0700, Linus Torvalds wrote:

> and then we can do
> 
>   COMPAT_SYSCALL_DEFINE5(readahead, int, fd,
> COMPAT_ARG_64BIT_ODD(off), compat_size_t, count)
>   {
>       return do_readahead(fd, off_lo + ((u64)off_hi << 64), count);
>   }
> 
> which at least looks reasonably legible, and has *zero* ifdef's anywhere.

It's a bit more complicated, but...

> I do *not* want to see those disgusting __ARCH_WANT_LE_COMPAT_SYS
> things and crazy #ifdef's in code.

Absolutely.  Those piles of ifdefs are unreadable garbage.

> So either let the architectures do their own trivial wrappers
> entirely, or do something clean like the above. Do *not* do
> #ifdef'fery at the system call declaration time.
> 
> Also note that the "ODD" arguments may not be the ones that need
> padding. I could easily see a system call argument numbering scheme
> like
> 
>    r0 - system call number
>    r1 - first argument
>    r2 - second argument
>    ...
> 
> and then it's the *EVEN* 64-bit arguments that would need the padding
> (because they are actually odd in the register numbers). The above
> COMPAT_ARG_64BIT[_ODD]() model allows for that too.
> 
> Of course, if some architecture then has some other arbitrary rules (I
> could see register pairing rules that aren't the usual "even register"
> ones), then such an architecture would really have to have its own
> wrapper, but the above at least would handle the simple cases, and
> doesn't look disgusting to use.

I'd done some digging in that area, will find the notes and post.
Basically, we can even avoid the odd/even annotations and have
COMPAT_SYSCALL_DEFINE... sort it out.  It's a bit more hairy than
I would like at this stage in the cycle, though.  I'll see if it can
be done without too much PITA.

However, there still are genuinely speci^Wfucked in head cases - see
e.g. this sad story:
commit ab8a261ba5e2dd9206da640de5870cc31d568a7c
Author: Helge Deller <deller@gmx.de>
Date:   Thu Jul 10 18:07:17 2014 +0200

    parisc: fix fanotify_mark() syscall on 32bit compat kernel

Those certainly ought to stay in arch/*
