Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6PH10a17484
	for linux-mips-outgoing; Wed, 25 Jul 2001 10:01:00 -0700
Received: from dea.waldorf-gmbh.de (u-46-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.46])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6PH0vO17481
	for <linux-mips@oss.sgi.com>; Wed, 25 Jul 2001 10:00:57 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6PH0kN01574;
	Wed, 25 Jul 2001 19:00:46 +0200
Date: Wed, 25 Jul 2001 19:00:46 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ian Soanes <ians@lineo.com>
Cc: Andre.Messerschmidt@infineon.com, linux-mips@oss.sgi.com
Subject: Re: AW: GCC and Modules
Message-ID: <20010725190046.A1391@bacchus.dhis.org>
References: <86048F07C015D311864100902760F1DDFF0016@dlfw003a.dus.infineon.com> <3B5ED17F.6D50331F@lineo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5ED17F.6D50331F@lineo.com>; from ians@lineo.com on Wed, Jul 25, 2001 at 03:02:39PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 25, 2001 at 03:02:39PM +0100, Ian Soanes wrote:

> This may be a little out of date, but compiling with the module with
> -mlong-calls worked for me when I had similar problems loading modules a
> while back. Relinking the module with 'ld -r -o new_mod.o orig_mod.o'
> was useful too ...it worked around some 'exceeds local_symtab_size'
> messages.

The local_symtab_size symtab is caused by the fine differences between
IRIX ELF and ABI ELF.  More recent binutils versions switched to ABI ELF
as the default.

Not using -mlong-calls results in ``Relocation overflow'' messages.  That's
not the case here, so this option probably was used.

Error messages about _gp_disp proof that the module contains PIC code that
is has not been built using -mno-abicalls -fno-pic.

  Ralf
