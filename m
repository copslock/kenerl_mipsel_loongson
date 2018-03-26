Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2018 08:25:17 +0200 (CEST)
Received: from isilmar-4.linta.de ([136.243.71.142]:33158 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991307AbeCZGZKJKO9p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2018 08:25:10 +0200
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 49196200882;
        Mon, 26 Mar 2018 06:25:07 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id B594A2042B; Mon, 26 Mar 2018 08:24:49 +0200 (CEST)
Date:   Mon, 26 Mar 2018 08:24:49 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
Message-ID: <20180326062449.GA27503@light.dominikbrodowski.net>
References: <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
 <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk>
 <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326034750.GN30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <linux@dominikbrodowski.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@dominikbrodowski.net
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

On Mon, Mar 26, 2018 at 04:47:50AM +0100, Al Viro wrote:
> 	* mips n32 and x86 x32 can become an extra source of headache.
> That actually applies to any plans of passing struct pt_regs *.  As it
> is, e.g. syscall 515 on amd64 is compat_sys_readv().  Dispatched via
> this:
>         /*
>          * NB: Native and x32 syscalls are dispatched from the same
>          * table.  The only functional difference is the x32 bit in
>          * regs->orig_ax, which changes the behavior of some syscalls.
>          */
>         if (likely((nr & __SYSCALL_MASK) < NR_syscalls)) {
>                 nr = array_index_nospec(nr & __SYSCALL_MASK, NR_syscalls);
>                 regs->ax = sys_call_table[nr](
>                         regs->di, regs->si, regs->dx,
>                         regs->r10, regs->r8, regs->r9);
>         }
> Now, syscall 145 via 32bit call is *also* compat_sys_readv(), dispatched
> via
>                 nr = array_index_nospec(nr, IA32_NR_syscalls);
>                 /*
>                  * It's possible that a 32-bit syscall implementation
>                  * takes a 64-bit parameter but nonetheless assumes that
>                  * the high bits are zero.  Make sure we zero-extend all
>                  * of the args.
>                  */
>                 regs->ax = ia32_sys_call_table[nr](
>                         (unsigned int)regs->bx, (unsigned int)regs->cx,
>                         (unsigned int)regs->dx, (unsigned int)regs->si,
>                         (unsigned int)regs->di, (unsigned int)regs->bp);
> Right now it works - we call the same function, passing it arguments picked
> from different set of registers (di/si/dx in x32 case, bx/cx/dx in i386 one).
> But if we switch to passing struct pt_regs * and have the wrapper fetch
> regs->{bx,cx,dx}, we have a problem.  It won't work for both entry points.
> 
> IMO it's a good reason to have dispatcher(s) handle extraction from pt_regs
> and let the wrapper deal with the resulting 6 u64 or 6 u32, normalizing
> them and arranging them into arguments expected by syscall body.
> 
> Linus, Dominik - how do you plan dealing with that fun?  Regardless of the
> way we generate the glue, the issue remains.  We can't get the same
> struct pt_regs *-taking function for both; we either need to produce
> a separate chunk of glue for each compat_sys_... involved (either making
> COMPAT_SYSCALL_DEFINE generate both, or having duplicate X32_SYSCALL_DEFINE
> for each of those COMPAT_SYSCALL_DEFINE - with identical body, at that)
> or we need to have the registers-to-slots mapping done in dispatcher...

Nice catch. A similar thing is needed already for non-compat syscalls like
sys_close(), which takes pt_regs->bx on IA32_EMULATION and pt_regs->di on
native x86-64. Therefore, I propose to generate all the stubs we need within
SYSCALL_DEFINEx() and COMPAT_SYSCALL_DEFINEx() (actually, within the
arch-provided version of these macros). See

	https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git	syscalls-WIP

for details on my current plans.

Thanks,
	Dominik
