Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PFPXRw010481
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 08:25:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PFPXrP010480
	for linux-mips-outgoing; Thu, 25 Jul 2002 08:25:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PFPBRw010469
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 08:25:12 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020725152612.EIC24728.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Thu, 25 Jul 2002 15:26:12 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 81313125DA; Thu, 25 Jul 2002 08:26:10 -0700 (PDT)
Date: Thu, 25 Jul 2002 08:26:10 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com, binutils@sources.redhat.com
Subject: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux: RFC: elf_check_arch() rework)
Message-ID: <20020725082610.A21614@lucon.org>
References: <Pine.GSO.3.96.1020725125830.27463H-100000@delta.ds2.pg.gda.pl> <3D3FFD21.8DA26337@mips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D3FFD21.8DA26337@mips.com>; from carstenl@mips.com on Thu, Jul 25, 2002 at 03:29:12PM +0200
X-Spam-Status: No, hits=-4.3 required=5.0 tests=IN_REP_TO,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'd like to fix binutils ASAP. Here is a patch.


On Thu, Jul 25, 2002 at 03:29:12PM +0200, Carsten Langgaard wrote:
> "Maciej W. Rozycki" wrote:
> 
> > On Wed, 24 Jul 2002, Carsten Langgaard wrote:
> >
> > > We at MIPS are in the process of making an ABI spec for all this, which
> > > is the intention that should be used by the tool-vendors.  So please
> > > don't change the ELF header defines.
> >
> >  It'd be better the spec matched the real world...
> 
> Shouldn't it be the other way around, the real world should follow the spec
> ;-)
> The whole ELF header definition is just one big mess, because we are lacking
> a proper ABI spec.
> That's what has motivated us, to begin making this ABI spec.
> 
> We have defined the e_flags this way:
> 
> /* ELF header e_flags defines. MIPS architecture level. */
> #define EF_MIPS_ARCH_1      0x00000000  /* -mips1 code.  */
> #define EF_MIPS_ARCH_2      0x10000000  /* -mips2 code.  */
> #define EF_MIPS_ARCH_3      0x20000000  /* -mips3 code.  */
> #define EF_MIPS_ARCH_4      0x30000000  /* -mips4 code.  */
> #define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
> #define EF_MIPS_ARCH_32     0x60000000  /* MIPS32 code.  */
> #define EF_MIPS_ARCH_64     0x70000000  /* MIPS64 code.  */
> #define EF_MIPS_ARCH_32R2   0x80000000  /* MIPS32 code.  */
> #define EF_MIPS_ARCH_64R2   0x90000000  /* MIPS64 code.  */
> 
> The missing value 0x50000000, is because IRIX has defined a EF_MIPS_ARCH_6
> and Algorithmics has a E_MIPS_ARCH_ALGOR_32, which has this value.
> If you look at the elf.h file in glibc, the you will see, it has the same
> values as the kernel.
> 
> So I would prefer we fix that in binutils, I guess it not a problem as long
> as you don't have a toolchain that can generate MIPS32 or MIPS64 code.
> 
> 
> >
> > > I don't see that is wrong with checking the ISA level, I rather have an
> > > error telling me that I can't execute a certain ISA level than
> > > eventually getting a reserved instruction or something worse like
> > > something unpredictable.
> >
> >  Well, -ENOEXEC in not any more useful than SIGILL -- with the latter you
> > have at least an idea what happened.  The ISA check is not implemented for
> > any Linux port, so there no suitable hook in binfmt_*.c files.  You might
> > propose an implementation if that's particularly important for you.
> >
> 
> I would like a message telling me that I can't run this ISA level on the
> system.
> Imagined what would happen, if you execute mips3 code and execute ld/sd
> instructions on a mips32 kernel (but on a 64-bit processor), the kernel only
> save half the register and then everything could happen.
> 
> 
> >
> > > You are obviously right about the elf_check_arch in the 64-bit part of
> > > the kernel is broken.  It's probably just be copied from the 32-bit part
> > > without changes, like a lot of the code in the 64-bit kernel is.
> >
> >  Possibly, but it still makes me wonder why it wasn't adjusted at the time
> > binfmt_elf32.c was created...
> >
> >   Maciej
> >
> > --
> > +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> > +--------------------------------------------------------------+
> > +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
> 
> 
> 

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="elf-mips.patch"

2002-07-25  H.J. Lu <hjl@gnu.org>

	* mips.h (E_MIPS_ARCH_6): New.
	(E_MIPS_ARCH_ALGOR_32): New.
	(E_MIPS_ARCH_32): Changed.
	(E_MIPS_ARCH_64): Changed.
	(E_MIPS_ARCH_32R2): New.
	(E_MIPS_ARCH_64R2): New.

--- include/elf/mips.h.mips	Fri Sep  7 15:43:58 2001
+++ include/elf/mips.h	Thu Jul 25 08:21:10 2002
@@ -139,11 +139,23 @@ END_RELOC_NUMBERS (R_MIPS_maxext)
 /* -mips5 code.  */
 #define E_MIPS_ARCH_5           0x40000000
 
+/* Used by IRIX.  */
+#define E_MIPS_ARCH_6           0x50000000
+
+/* Used by Algorithmics.  */
+#define E_MIPS_ARCH_ALGOR_32    0x50000000
+
 /* -mips32 code.  */
-#define E_MIPS_ARCH_32          0x50000000
+#define E_MIPS_ARCH_32          0x60000000
 
 /* -mips64 code.  */
-#define E_MIPS_ARCH_64          0x60000000
+#define E_MIPS_ARCH_64          0x70000000
+
+/* MIPS32 code.  */
+#define E_MIPS_ARCH_32R2        0x80000000
+
+/* MIPS64 code.  */
+#define E_MIPS_ARCH_64R2        0x90000000
 
 /* The ABI of the file.  Also see EF_MIPS_ABI2 above. */
 #define EF_MIPS_ABI		0x0000F000

--u3/rZRmxL6MmkK24--
