Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LCC0l18091
	for linux-mips-outgoing; Sat, 21 Jul 2001 05:12:00 -0700
Received: from dea.waldorf-gmbh.de (u-103-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LCBqV18087
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 05:11:53 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6LCBKw25155;
	Sat, 21 Jul 2001 14:11:20 +0200
Date: Sat, 21 Jul 2001 14:11:20 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Greg Satz <satz@ayrnetworks.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: SHN_MIPS_SCOMMON
Message-ID: <20010721141119.A25053@bacchus.dhis.org>
References: <20010721033019.A22637@bacchus.dhis.org> <B77EA5E8.883E%satz@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B77EA5E8.883E%satz@ayrnetworks.com>; from satz@ayrnetworks.com on Sat, Jul 21, 2001 at 03:22:17AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 03:22:17AM -0600, Greg Satz wrote:

> Hi Ralf, maybe I am missing something but after downloading and some perusal
> I don't see where the newer (2.4.5) kernel addresses this problem. At the
> risk of being redundant, the issue, as I see it, is the use of SCOMMON
> symbols in ELF section SHN_MIPS_SCOMMON (0xff03). These symbols are
> overlooked when insmod relocates symbols in the SHN_COMMON ELF section. They
> end up in the kernel with a value of 4. Upon being referenced, the module
> gets a page fault opps.
> 
> The file obj/obj_reloc.c in the modutils package is where the SHN_COMMON
> symbol relocation work is performed. Using the gcc flag -fno-common forces
> all commons info bss thus preventing the problem. We do this as a
> work-around now.
> 
> The question is whether the gcc -fno-common flag is the real fix or is
> obj/obj_reloc.c deficient. I have a patch that appears to work for
> obj/obj_reloc.c
> 
> We create the problem situation by declaring variables in one file as extern
> and defining them in another.

You have common declarations that's declarations without static or extern
keywords and initalization.  Perfectly legal.

> The compiler puts these variables in the SCOMMON segment instead of the
> COMMON segment.

Only if you don't compile / assemble / link with -G 0.

.scommon shouldn't ever be in a kernel object.  It seems that ld started
to move .common objects to .scommon from a certain version on, so 2.4.5
now passes the right options.  .scommon is used in global pointer
optimizations which doesn't work under Linux anyway as we use $gp ($28)
for a different purpose.  So modutils should reject such a module right
away.

  Ralf
