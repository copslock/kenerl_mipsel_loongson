Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 13:41:00 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:39911 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8226777AbVGPMkm>; Sat, 16 Jul 2005 13:40:42 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1Dtlza-0007lr-00
	for <linux-mips@linux-mips.org>; Sat, 16 Jul 2005 14:42:06 +0200
Date:	Sat, 16 Jul 2005 14:42:06 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Support for (au1100) 64-bit physical address space broken on 2.6.12?
Message-ID: <20050716124205.GA26127@enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--kVXhAStRUZ/+rrGn
Content-Type: multipart/mixed; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

switching from linux-mips 2.6.12-rc3 to 2.6.12 I notice that the
following patch has been applied:

   http://www.linux-mips.org/archives/linux-mips/2005-06/msg00207.html

But, on my system, recompiling the source I noticed that compilation
stops with errors. Even downloading a clean version of source code
=66rom linux-mips's CVS and choosing, for instance, the board DB1100, I
got the same result.

The problem is that the above patch works well if the 64-bit physical
address space support is disabled, but, if enabled, it breaks
compilation stage.

Here what I get after getting source form CVS and doing the commands:

   # make pb1100_defconfig   (this board turn on CONFIG_64BIT_PHYS_ADDR opt=
ion)
   # make
   ...
   include/asm-mips/mach-au1x00/ioremap.h:25: warning: static declaration o=
f 'fixup_bigphys_addr' follows non-static declaration
   include/asm/pgtable.h:363: warning: 'fixup_bigphys_addr' declared inline=
 after being called
   include/asm/pgtable.h:363: warning: previous declaration of 'fixup_bigph=
ys_addr' was here
   include/asm-mips/mach-au1x00/ioremap.h: In function `fixup_bigphys_addr':
   include/asm-mips/mach-au1x00/ioremap.h:26: warning: implicit declaration=
 of function `__fixup_bigphys_addr'
   arch/mips/au1000/common/setup.c: At top level:
   arch/mips/au1000/common/setup.c:159: error: conflicting types for '__fix=
up_bigphys_addr'
   include/asm-mips/mach-au1x00/ioremap.h:26: error: previous implicit decl=
aration of '__fixup_bigphys_addr' was here
   arch/mips/au1000/common/setup.c: In function `__fixup_bigphys_addr':
   ...

After a little job I implemented the attached patch
(patch-64BIT_PHYS_ADDR) that works on my system on both settings
(CONFIG_64BIT_PHYS_ADDR on or off).

I don't know if it can resolve the above problem for others CPUs (I
tested it on au1100) but, at least, on this processor the PCMCIA
support now is functional. :)

I also suggest to apply the second patch (patch-PCMCIA_Kconfig) who
simply auto enable 64 bit support when choosing PCMCIA support.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-64BIT_PHYS_ADDR
Content-Transfer-Encoding: quoted-printable

Index: arch/mips/au1000/common/setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/develop/cvs_private/linux-mips-exadron/arch/mips/au1000/com=
mon/setup.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 setup.c
--- a/arch/mips/au1000/common/setup.c	2 Jul 2005 06:45:44 -0000	1.1.1.1
+++ b/arch/mips/au1000/common/setup.c	16 Jul 2005 12:27:18 -0000
@@ -152,38 +152,3 @@
 	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T0S);
 	au_writel(0, SYS_TOYTRIM);
 }
-
-#if defined(CONFIG_64BIT_PHYS_ADDR)
-/* This routine should be valid for all Au1x based boards */
-phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
-{
-	u32 start, end;
-
-	/* Don't fixup 36 bit addresses */
-	if ((phys_addr >> 32) !=3D 0) return phys_addr;
-
-#ifdef CONFIG_PCI
-	start =3D (u32)Au1500_PCI_MEM_START;
-	end =3D (u32)Au1500_PCI_MEM_END;
-	/* check for pci memory window */
-	if ((phys_addr >=3D start) && ((phys_addr + size) < end)) {
-		return (phys_t)((phys_addr - start) + Au1500_PCI_MEM_START);
-	}
-#endif
-
-	/* All Au1x SOCs have a pcmcia controller */
-	/* We setup our 32 bit pseudo addresses to be equal to the
-	 * 36 bit addr >> 4, to make it easier to check the address
-	 * and fix it.
-	 * The Au1x socket 0 phys attribute address is 0xF 4000 0000.
-	 * The pseudo address we use is 0xF400 0000. Any address over
-	 * 0xF400 0000 is a pcmcia pseudo address.
-	 */
-	if ((phys_addr >=3D 0xF4000000) && (phys_addr < 0xFFFFFFFF)) {
-		return (phys_t)(phys_addr << 4);
-	}
-
-	/* default nop */
-	return phys_addr;
-}
-#endif
Index: include/asm-mips/pgtable.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/develop/cvs_private/linux-mips-exadron/include/asm-mips/pgt=
able.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pgtable.h
--- a/include/asm-mips/pgtable.h	2 Jul 2005 06:47:30 -0000	1.1.1.1
+++ b/include/asm-mips/pgtable.h	16 Jul 2005 12:27:39 -0000
@@ -17,6 +17,7 @@
 #endif
=20
 #include <asm/pgtable-bits.h>
+#include <ioremap.h>
=20
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
@@ -360,7 +361,6 @@
 #endif
=20
 #ifdef CONFIG_64BIT_PHYS_ADDR
-extern phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size);
 extern int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,=
 unsigned long pfn, unsigned long size, pgprot_t prot);
=20
 static inline int io_remap_page_range(struct vm_area_struct *vma,
Index: include/asm-mips/mach-au1x00/ioremap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/develop/cvs_private/linux-mips-exadron/include/asm-mips/mac=
h-au1x00/ioremap.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ioremap.h
--- a/include/asm-mips/mach-au1x00/ioremap.h	2 Jul 2005 06:47:31 -0000	1.1.=
1.1
+++ b/include/asm-mips/mach-au1x00/ioremap.h	16 Jul 2005 12:27:39 -0000
@@ -11,7 +11,42 @@
=20
 #include <linux/types.h>
=20
-#ifndef CONFIG_64BIT_PHYS_ADDR
+#ifdef CONFIG_64BIT_PHYS_ADDR
+/* This routine should be valid for all Au1x based boards */
+static inline phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+#ifdef CONFIG_PCI
+	u32 start, end;
+#endif
+
+	/* Don't fixup 36 bit addresses */
+	if ((phys_addr >> 32) !=3D 0) return phys_addr;
+
+#ifdef CONFIG_PCI
+	start =3D (u32)Au1500_PCI_MEM_START;
+	end =3D (u32)Au1500_PCI_MEM_END;
+	/* check for pci memory window */
+	if ((phys_addr >=3D start) && ((phys_addr + size) < end)) {
+		return (phys_t)((phys_addr - start) + Au1500_PCI_MEM_START);
+	}
+#endif
+
+	/* All Au1x SOCs have a pcmcia controller */
+	/* We setup our 32 bit pseudo addresses to be equal to the
+	 * 36 bit addr >> 4, to make it easier to check the address
+	 * and fix it.
+	 * The Au1x socket 0 phys attribute address is 0xF 4000 0000.
+	 * The pseudo address we use is 0xF400 0000. Any address over
+	 * 0xF400 0000 is a pcmcia pseudo address.
+	 */
+	if ((phys_addr >=3D 0xF4000000) && (phys_addr < 0xFFFFFFFF)) {
+		return (phys_t)(phys_addr << 4);
+	}
+
+	/* default nop */
+	return phys_addr;
+}
+#else
 static inline phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 {
 	return phys_addr;

--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-PCMCIA_Kconfig
Content-Transfer-Encoding: quoted-printable

Index: drivers/pcmcia/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/develop/cvs_private/linux-mips-exadron/drivers/pcmcia/Kconf=
ig,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Kconfig
--- a/drivers/pcmcia/Kconfig	2 Jul 2005 06:46:44 -0000	1.1.1.1
+++ b/drivers/pcmcia/Kconfig	16 Jul 2005 12:27:31 -0000
@@ -137,6 +137,7 @@
 config PCMCIA_AU1X00
 	tristate "Au1x00 pcmcia support"
 	depends on SOC_AU1X00 && PCMCIA
+	select 64BIT_PHYS_ADDR
=20
 config PCMCIA_SA1100
 	tristate "SA1100 support"

--s2ZSL+KKDSLx8OML--

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC2QCdQaTCYNJaVjMRAt6JAJ43SzI2DhJ9h8mKRSUp7j+SNsAm5wCdHj8E
chV/HmC0ahgdhaXtv5Nb59Y=
=YBJh
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
