Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f72ClgK15524
	for linux-mips-outgoing; Thu, 2 Aug 2001 05:47:42 -0700
Received: from dea.waldorf-gmbh.de (u-206-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.206])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f72ClcV15513
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 05:47:38 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f72BsuT24679;
	Thu, 2 Aug 2001 13:54:56 +0200
Date: Thu, 2 Aug 2001 13:54:56 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "John D. Davis" <johnd@Stanford.EDU>
Cc: Carsten Langgaard <carstenl@mips.com>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: r4600 flag
Message-ID: <20010802135456.F24305@bacchus.dhis.org>
References: <3B66B4E6.70B80D21@mips.com> <Pine.GSO.4.31.0107310824430.28499-100000@epic8.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0107310824430.28499-100000@epic8.Stanford.EDU>; from johnd@Stanford.EDU on Tue, Jul 31, 2001 at 08:29:12AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 31, 2001 at 08:29:12AM -0700, John D. Davis wrote:

> Looking at the system map from the generic build of 2.4.3, it looks like
> the code is 64 bit.  The upper 32 bits are "f" instead of 0.

No.  Sign extended, that is bit 31 is copied into bits 32 to 63.

> I built it > using the R4600 flag.  This differs from the system map for
> 2.4.0-test9 where the upper 32 bits are 0.

No.  Different binutils.  Older binutils did zero extend 32-bit addresses
to 64-bit addresses in the objdump output which is wrong.

> For the indy, do I specify mips2 to generate 32 bit code?

-mips2 :-)

For the kernel we use a few 64-bit instructions on the Indy though.  These
are carefully chosen such that nothing go wrong like exceptions corrupting
the upper 32-bit of a register.

> objdump says it is ELF32, but it doesn't look like that.  I would like to
> generate 32bit.

ELF is an object format.  Nothing prevents you from putting 64-bit code into
a 32-bit ELF file and vice versa.  You just need to be careful.

  Ralf
