Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5CJC1u02966
	for linux-mips-outgoing; Tue, 12 Jun 2001 12:12:01 -0700
Received: from dea.waldorf-gmbh.de (u-238-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.238])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5CJBwV02963
	for <linux-mips@oss.sgi.com>; Tue, 12 Jun 2001 12:11:59 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5CJBpw28194;
	Tue, 12 Jun 2001 21:11:51 +0200
Date: Tue, 12 Jun 2001 21:11:51 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
Message-ID: <20010612211151.A27552@bacchus.dhis.org>
References: <20010611210311.A8768@lucon.org> <20010612133925.B5106@bacchus.dhis.org> <20010612094055.B20012@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010612094055.B20012@lucon.org>; from hjl@lucon.org on Tue, Jun 12, 2001 at 09:40:55AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 12, 2001 at 09:40:55AM -0700, H . J . Lu wrote:

> FYI, my glibc includes
> 
>         * sysdeps/mips/dl-machine.h (MAP_BASE_ADDR): Commented out.

That means elf/dl-load.c will assume zero for the load address.  That will
crash static programs which expect a value of 0x5ffe0000 and are trying to
dlopen a shared library which uses a different value.  Most popular
example is rpm.  So we need to keep ``#define MAP_BASE_ADDR(l) 0x5ffe0000''
in there until we've got a real fix, unfortunately.

ABI requires us to properly support DT_MIPS_BASE_ADDRESS, so that needs
to fixed for real anyway ...

>         * sysdeps/mips/rtld-ldscript.in: Removed.
>         * sysdeps/mips/rtld-parms: Likewise.
>         * sysdeps/mips/mips64/rtld-parms: Likewise.
>         * sysdeps/mips/mipsel/rtld-parms: Likewise.
> 
> As I mentioned before, the resulting glibc works fine with the IRIX ABI
> executables. But I have no ideas about DSOs.

This rtld stuff was an IRIX-ism which made it into Linux without the necessary
reflection; nothing bad should happen if we remove it.

  Ralf
