Received: (from mail@localhost)
	by linux-xfs.sgi.com (8.12.0.Beta5/8.12.0.Beta5) id f592kPBB013385
	for linux-mips-outgoing; Fri, 8 Jun 2001 19:46:25 -0700
X-Authentication-Warning: linux-xfs.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.waldorf-gmbh.de (u-160-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.160])
	by linux-xfs.sgi.com (8.12.0.Beta5/8.12.0.Beta5) with SMTP id f592kJ3D013369
	for <linux-mips@oss.sgi.com>; Fri, 8 Jun 2001 19:46:22 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f592jKl12272;
	Sat, 9 Jun 2001 04:45:20 +0200
Date: Sat, 9 Jun 2001 04:45:20 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: emulate_load_store_insn
Message-ID: <20010609044520.A12255@bacchus.dhis.org>
References: <200106090151.SAA11162@hubble.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106090151.SAA11162@hubble.mips.com>; from carstenl@mips.com on Fri, Jun 08, 2001 at 06:51:01PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jun 08, 2001 at 06:51:01PM -0700, Carsten Langgaard wrote:

> Can anyone please explain the whole deal with the emulate_load_store_insn 
> function in arch/mips/kernel/unaligned.c.

Some software does of unaligned accesses.  Typical userspace example is fdisk
and the network stack which generally tries hard to avoid unaligned loads
and stores may make unaligned stores at times though.

> Isn't there a potential hole there, where a user application makes an illegal 
> memory access to an unaligned address and then the kernel tries to emulate
> that and crashes.

The addresses are verified the same way as any other userspace address
passed to the kernel.

> It also look like the MF_FIXADE flag is set by default, why is that ?

Two reasons 1) other MIPS OSes such as Risc/OS and IRIX also do it 2) crappy
software doesn't know how to enable this feature ...

> Shouldn't one suppose to make a syscall setting this MF_FIXADE flag ?

Sysmips(2) allows to toggle this flag.

  Ralf
