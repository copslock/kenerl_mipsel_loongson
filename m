Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB58Js423828
	for linux-mips-outgoing; Wed, 5 Dec 2001 00:19:54 -0800
Received: from mangalore.zipworld.com.au (leeloo.zip.com.au [203.12.97.48])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB58Jko23825
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 00:19:46 -0800
Received: from zip.com.au (root@zipperii.zip.com.au [61.8.0.87])
	by mangalore.zipworld.com.au (8.9.3/8.9.3) with ESMTP id SAA04488;
	Wed, 5 Dec 2001 18:17:36 +1100
Message-ID: <3C0DCA07.AD302D7D@zip.com.au>
Date: Tue, 04 Dec 2001 23:17:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: todd_m_roy@vermontel.net
CC: bregor@anusf.anu.edu.au, Kenneth Albanowski <kjahds@kjahds.com>,
   Mat Hostetter <mat@lcs.mit.edu>,
   Andy Dougherty <doughera@lafcol.lafayette.edu>,
   Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
   Ron Guilmette <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   "Hazelwood; Galen" <galenh@micron.net>,
   Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
   Linas Vepstas <linas@linas.org>, Feher Janos <aries@hal2000.terra.vein.hu>,
   Leonard Zubkoff <lnz@dandelion.com>, "Steven J. Hill" <sjhill@cotw.com>,
   linux-gcc@vger.kernel.org, GNU C Library <libc-alpha@sourceware.cygnus.com>,
   gcc@gcc.gnu.org
Subject: Re: Problem with binutils 2.11.92.0.12 and ..12.3
References: <3C085FA1.CCDC7100@vermontel.net>,
		<3C085FA1.CCDC7100@vermontel.net>; from salteroy@vermontel.net on Fri, Nov 30, 2001 at 11:42:09PM -0500 <20011201094659.A9044@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:
> 
> On Fri, Nov 30, 2001 at 11:42:09PM -0500, Todd Roy, Wanda Salter and Alice Salter-Roy wrote:
> > Hi,
> >   I had a linux kernel linking problem with 2.11.92.0.12 and
> > 2.11.92.0.12.3
> ...
> >
> > I reverted to 2.11.92.0.10 and all is well again.
> >
> 
> I updated the release note for 2.11.92.0.12.3. Please read it carefully.
> 
> ...
> --- linux/arch/alpha/vmlinux.lds.in.discard     Thu Nov 22 00:30:16 2001
> +++ linux/arch/alpha/vmlinux.lds.in     Thu Nov 22 00:30:47 2001
> @@ -92,5 +92,5 @@ SECTIONS
>    .debug_typenames 0 : { *(.debug_typenames) }
>    .debug_varnames  0 : { *(.debug_varnames) }
> 
> -  /DISCARD/ : { *(.text.exit) *(.data.exit) }
> +  /DISCARD/ : { *(.text.exit) *(.data.exit) *(.exitcall.exit) }
>  }
> --- linux/drivers/char/serial.c.discard Thu Nov 22 00:37:14 2001
> +++ linux/drivers/char/serial.c Thu Nov 22 10:54:54 2001
> @@ -4887,7 +4887,9 @@ static char serial_pci_driver_name[] = "
>  static struct pci_driver serial_pci_driver = {
>         name:           serial_pci_driver_name,
>         probe:          serial_init_one,
> +#ifdef MODULE
>         remove:        serial_remove_one,
> +#endif
>         id_table:       serial_pci_tbl,
>  };
> 

This is not sufficient.  If CONFIG_HOTPLUG is defined,
__devinit sections are still included in vmlinux.  This
is because those functions are required for hot-unplugging.

This patch will cause hot-unplug for statically linked drivers
to not work correctly, because the ->remove() method isn't
available (it has a null pointer).

The ifdef needs to be:

#if defined(MODULE) || defined(CONFIG_HOTPLUG)

I've just send a patch, which alters 59 kernel files to
the kernel list.  It's for 2.4.17-pre2 and will hopefully
appear in 2.4.17-pre3.

The easiest fix for earlier kernels is to edit arch/i386/vmlinux.lds.in
and delete the entire /DISCARD/ section.
