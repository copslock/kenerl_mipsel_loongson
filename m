Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75D3ORw007514
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 06:03:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75D3OAm007513
	for linux-mips-outgoing; Mon, 5 Aug 2002 06:03:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75D32Rw007501;
	Mon, 5 Aug 2002 06:03:02 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g75D4EXb006583;
	Mon, 5 Aug 2002 06:04:14 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA06942;
	Mon, 5 Aug 2002 06:04:14 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g75D4Eb24739;
	Mon, 5 Aug 2002 15:04:14 +0200 (MEST)
Message-ID: <3D4E77CD.A4E7B78B@mips.com>
Date: Mon, 05 Aug 2002 15:04:13 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4: Revert interface removal
References: <Pine.GSO.3.96.1020805105624.18894C-100000@delta.ds2.pg.gda.pl> <20020805124154.B6365@dea.linux-mips.net> <3D4E5BFE.595DA175@mips.com> <3D4E6743.58776F67@mips.com>
Content-Type: multipart/mixed;
 boundary="------------DD625EA309C62AE684359CB8"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------DD625EA309C62AE684359CB8
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Ok, I finally figured out what the problem is.
The attached patch fix the problems, please apply.

/Carsten



Carsten Langgaard wrote:

> Ralf, could we please revert the latest changes to include/asm-mips/scatterlist.h
> and include/asm-mips/pci.h
>
> /Carsten
>
> Carsten Langgaard wrote:
>
> > Changing the scatterlist and the pci functions seems to break things in the IDE
> > interface.
> >
> > /Carsten
> >
> > Ralf Baechle wrote:
> >
> > > On Mon, Aug 05, 2002 at 11:05:40AM +0200, Maciej W. Rozycki wrote:
> > >
> > > >  A recent change to include/asm-mips/scatterlist.h broke
> > > > drivers/scsi/dec_esp.c.  Since 2.4.19 is not the proper version to remove
> > > > interfaces, I'm going to check in the following patch to the 2.4 branch to
> > > > revert the change (with a slightly sanitized type for the dvma_address
> > > > member).
> > > >
> > > >  Any objections?
> > >
> > > Sorry for simply removing the structure, that was an accident.  The
> > > question why the use of struct mmu_sglist still hasn't been replaced by
> > > newer interfaces stays ...
> > >
> > > So please go ahead and commit your patch.
> > >
> > >   Ralf
> >
> > --
> > _    _ ____  ___   Carsten Langgaard Mailto:carstenl@mips.com
> > |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> > | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
> >   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
> >                    Denmark           http://www.mips.com
>
> --
> _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark            http://www.mips.com

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------DD625EA309C62AE684359CB8
Content-Type: text/plain; charset=iso-8859-15;
 name="pci.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.3.patch"

Index: arch/mips/kernel/pci-dma.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/pci-dma.c,v
retrieving revision 1.7.2.1
diff -u -r1.7.2.1 pci-dma.c
--- arch/mips/kernel/pci-dma.c	2002/08/01 12:40:14	1.7.2.1
+++ arch/mips/kernel/pci-dma.c	2002/08/05 12:54:19
@@ -30,11 +30,11 @@
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
+		*dma_handle = virt_to_bus(ret);
 #ifdef CONFIG_NONCOHERENT_IO
 		dma_cache_wback_inv((unsigned long) ret, size);
 		ret = UNCAC_ADDR(ret);
 #endif
-		*dma_handle = virt_to_bus(ret);
 	}
 
 	return ret;
Index: include/asm-mips/page.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/page.h,v
retrieving revision 1.14.2.9
diff -u -r1.14.2.9 page.h
--- include/asm-mips/page.h	2002/08/01 12:40:14	1.14.2.9
+++ include/asm-mips/page.h	2002/08/05 12:54:32
@@ -125,8 +125,8 @@
 #define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | VM_EXEC | \
 				VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define UNCAC_ADDR(addr)	((addr) - (PAGE_OFFSET + UNCAC_BASE))
-#define CAC_ADDR(addr)		((addr) - (UNCAC_BASE + PAGE_OFFSET))
+#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
+#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
 
 /*
  * Memory above this physical address will be considered highmem.
Index: include/asm-mips/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.24.2.7
diff -u -r1.24.2.7 pci.h
--- include/asm-mips/pci.h	2002/08/01 12:40:14	1.24.2.7
+++ include/asm-mips/pci.h	2002/08/05 12:54:32
@@ -180,7 +180,7 @@
 		else if (!sg->address && !sg->page)
 			out_of_line_bug();
 
-		if (sg[i].address) {
+		if (sg->address) {
 			dma_cache_wback_inv((unsigned long)sg->address,
 			                    sg->length);
 			sg->dma_address = virt_to_bus(sg->address);
@@ -317,7 +317,7 @@
  * returns, or alternatively stop on the first sg_dma_len(sg) which
  * is 0.
  */
-#define sg_dma_address(sg)	((sg)->address)
+#define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
 #endif /* __KERNEL__ */

--------------DD625EA309C62AE684359CB8--
