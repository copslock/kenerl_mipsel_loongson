Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9E6xZX29153
	for linux-mips-outgoing; Sat, 13 Oct 2001 23:59:35 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9E6xRD29149
	for <linux-mips@oss.sgi.com>; Sat, 13 Oct 2001 23:59:28 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 91DEF125C0; Sat, 13 Oct 2001 23:59:24 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 826B6EBA5; Sat, 13 Oct 2001 23:59:24 -0700 (PDT)
Date: Sat, 13 Oct 2001 23:59:24 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: binutils@sourceware.cygnus.com, gcc@gcc.gnu.org,
   GNU C Library <libc-alpha@sourceware.cygnus.com>,
   Kenneth Albanowski <kjahds@kjahds.com>, Mat Hostetter <mat@lcs.mit.edu>,
   Andy Dougherty <doughera@lafcol.lafayette.edu>,
   Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
   Ron Guilmette <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   "Hazelwood; Galen" <galenh@micron.net>,
   Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
   Linas Vepstas <linas@linas.org>, Feher Janos <aries@hal2000.terra.vein.hu>,
   "Steven J. Hill" <sjhill@cotw.com>, linux-gcc@vger.kernel.org,
   amodra@bigpond.net.au
Subject: Re: binutils 2.11.92.0.6 (Re: binutils 2.11.92.0.5 is broken)
Message-ID: <20011013235924.C15807@lucon.org>
References: <200110131452.f9DEq7Q0032358@dandelion.com> <20011013190034.A27019@lucon.org> <20011013235621.A15807@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011013235621.A15807@lucon.org>; from hjl@lucon.org on Sat, Oct 13, 2001 at 11:56:21PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Oct 13, 2001 at 11:56:21PM -0700, H . J . Lu wrote:
> On Sat, Oct 13, 2001 at 07:00:34PM -0700, H . J . Lu wrote:
> > On Sat, Oct 13, 2001 at 07:52:07AM -0700, Leonard Zubkoff wrote:
> > > HJ,
> > > 
> > > In recompiling my whole system with your latest binutils-2.11.92.0.5, I
> > > received the following error while linking telnetd from the netkit-telnet-0.17
> > > package:
> > > 
> > > gcc  telnetd.o state.o termstat.o slc.o sys_term.o utility.o global.o setproctitle.o -lutil -lutil -o telnetd
> > > /usr/bin/ld: BFD internal error, aborting at elf32-i386.c line 646 in elf_i386_copy_indirect_symbol
> > > 
> > > /usr/bin/ld: Please report this bug.
> > > 
> > > collect2: ld returned 1 exit status
> > > 
> > > Thought you'd want to know...
> > > 
> > 
> > Hi Alan,
> > 
> > This patch
> > 
> > http://sources.redhat.com/ml/binutils/2001-10/msg00035.html
> > 
> > is incomplete. You cannot do any backend processing when
> > 
> > if (dir == ind->weakdef)
> > 
> > I will double check all backend xxx_hash_copy_indirect.
> > 
> > I am planning to make binutils 2.11.92.0.6 within a week.
> > 
> > Sorry for that.
> > 
> > 
> 
> Here is a proposed patch for binutils 2.11.92.0.6. I will run more
> tests before releasing it. Please test it as much as you can.
> 
> Thanks.
> 
> 
> H.J.
> ---

Ooops. Here is the complete changelog against 2.11.92.0.5.


H.J.
----
2001-10-13  H.J. Lu <hjl@gnu.org>

	* elf32-hppa.c (elf32_hppa_copy_indirect_symbol): Don't abort
	if this is a weakdef.
	* elf32-i386.c (elf_i386_copy_indirect_symbol): Likewise.
	* elf64-ppc.c (ppc64_elf_copy_indirect_symbol): Likewise.

	* elf32-ppc.c (ppc_elf_adjust_dynamic_symbol): Set plt.offset
	to -1 and clear the ELF_LINK_HASH_NEEDS_PLT bit if the symbol
	is not a function.
	* elf32-hppa.c (elf32_hppa_adjust_dynamic_symbol): Likewise.
	* elf32-s390.c (elf_s390_adjust_dynamic_symbol): Likewise.
	* elf64-s390.c (elf_s390_adjust_dynamic_symbol): Likewise.
	* elf64-x86-64.c (elf64_x86_64_adjust_dynamic_symbol):
	Likewise.

2001-10-11  H.J. Lu  <hjl@gnu.org>

	* elf32-mips.c (mips_elf_calculate_relocation): Don't create
	dynamic relocation for symbols defined in regular objects when
	creating executables.

2001-10-11  H.J. Lu  <hjl@gnu.org>

	* elflink.h (elf_merge_symbol): Revert the change made on
	2001-10-03.
