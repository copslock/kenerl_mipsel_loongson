Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 09:57:09 +0100 (CET)
Received: from isilmar-4.linta.de ([136.243.71.142]:54996 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992615AbeCTI5CTVIJs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2018 09:57:02 +0100
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id AA3962008FF;
        Tue, 20 Mar 2018 08:56:59 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 85DF620B3D; Tue, 20 Mar 2018 09:56:32 +0100 (CET)
Date:   Tue, 20 Mar 2018 09:56:32 +0100
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
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Message-ID: <20180320085632.GB30383@light.dominikbrodowski.net>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
 <20180319232342.GX30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319232342.GX30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <linux@dominikbrodowski.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63074
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

On Mon, Mar 19, 2018 at 11:23:42PM +0000, Al Viro wrote:
> static inline long C_S_moron(int, loff_t, size_t);
> long compat_SyS_moron(long a0, long a1, long a2, long a3, long a4, long a5, long a6)
> {
> 	return C_S_moron((__force int)a0,
> 		  (__force loff_t)(((u64)a2 << 32)|a1),
> 		  (__force size_t)a3);
> }
> static inline long C_S_moron(int fd, loff_t offset, size_t count)
> {
> 	whatever body you had for it
> }
> 
> That - from
> COMPAT_SYSCALL_DEFINE3(moron, int, fd, loff_t, offset, size_t, count)
> {
> 	whatever body you had for it
> }
> 
> We can use similar machinery for SYSCALL_DEFINE itself, so that
> SyS_moron() would be defined with (long, long, long, long, long, long)
> as arguments and not (long, long long, long) as we have now.

That would be great, as it would allow to use a struct pt_regs * based
syscall calling convention on i386 as well, and not only on x86-64, right?

> It's not impossible to do.  It won't be pretty, but that use of local
> enums allows to avoid unbearably long expansions.
> 
> Benefits:
> 	* all SyS... wrappers (i.e. the thing that really ought to
> go into syscall tables) have the same type.
> 	* we could have SYSCALL_DEFINE produce a trivial compat
> wrapper, have explicit COMPAT_SYSCALL_DEFINE discard that thing
> and populate the compat syscall table *entirely* with compat_SyS_...,
> letting the linker sort it out.  That way we don't need to keep
> track of what can use native and what needs compat in each compat
> table on biarch.
> 	* s390 compat wrappers would disappear with that approach.
> 	* we could even stop generating sys_... aliases - if
> syscall table is generated by slapping SyS_... or compat_SyS_...
> on the name given there, we don't need to _have_ those sys_...
> things at all.  All SyS_... would have the same type, so the pile
> in syscalls.h would not be needed - we could generate the externs
> at the same time we generate the syscall table.
> 
> And yes, it's a high-squick approach.  I know and I'm not saying
> it's a good idea.  OTOH, to quote the motto of philosophers and
> shell game operators, "there's something in it"...

... and getting rid of all in-kernel calls to sys_*() is needed as
groundwork for that. So I'll continue to do that "mindless" conversion
first. On top of that, three things (which are mostly orthogonal to each
other) can be done:

1) ptregs system call conversion for x86-64

   Original implementation by Linus exists; needs a bit of tweaking
   but should be doable soon. Need to double-check it does the right
   thing for IA32_EMULATION, though.

2) re-work initramfs etc. code to not use in-kernel equivalents of
   syscalls, but operate on the VFS level instead.

3) re-work SYSCALL_DEFINEx() / COMPAT_SYSCALL_DEFINEx() based on
   your suggestions.

Does that sound sensible?

Thanks,
	Dominik
