Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PKnLF12187
	for linux-mips-outgoing; Fri, 25 May 2001 13:49:21 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PKn8F12178;
	Fri, 25 May 2001 13:49:08 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 153OWD-0006n3-00; Fri, 25 May 2001 13:49:09 -0700
Date: Fri, 25 May 2001 13:49:09 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
Message-ID: <20010525134909.A26065@nevyn.them.org>
References: <20010523145257.A13013@nevyn.them.org> <Pine.GSO.3.96.1010524134521.6990F-100000@delta.ds2.pg.gda.pl> <20010525172746.B6578@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010525172746.B6578@bacchus.dhis.org>; from ralf@oss.sgi.com on Fri, May 25, 2001 at 05:27:46PM -0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2001 at 05:27:46PM -0300, Ralf Baechle wrote:
> On Thu, May 24, 2001 at 03:42:56PM +0200, Maciej W. Rozycki wrote:
> 
> > > The ll/sc constructs in the kernel use ".set noat" to inhibit use of $at,
> > > and proceed to use it themselves.  This is fine, except for one problem: the
> > > constraints on memory operands are "o" and "=o", which means offsettable
> > > memory references.  If I'm not mistaken, the assembler will (always?)
> > > turn these into uses of $at if the offset is not 0 - at least, it certainly
> > > seems to do that here (gcc 2.95.3, binutils 2.10.91.0.2).  Just being honest
> > > with the compiler and asking for a real memory reference does the trick. 
> > 
> >  Both "m" and "o" seem to be incorrect here as both are the same for MIPS; 
> > "R" seems to be appropriate, OTOH.  Still gcc 2.95.3 doesn't handle "R" 
> > fine for all cases, but it works most of the time and emits a warning
> > otherwise.  I can't comment on 3.0.
> 
> I admit the construction is somewhat fragile and will take any patches to
> cleanup this.

How about the attached, then?  If the p[0x100000] case is of sufficient
concern, we can work around that too, but this catches all current
uses.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips-offset2.diff"

Index: arch/mips/kernel/sysmips.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/sysmips.c,v
retrieving revision 1.18
diff -u -r1.18 sysmips.c
--- arch/mips/kernel/sysmips.c	2001/04/08 13:24:27	1.18
+++ arch/mips/kernel/sysmips.c	2001/05/23 21:49:29
@@ -99,8 +99,8 @@
 			".word\t1b, 3b\n\t"
 			".word\t2b, 3b\n\t"
 			".previous\n\t"
-			: "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno)
-			: "r" (arg2), "o" (* (u32 *) p), "2" (errno)
+			: "=&r" (tmp), "=R" (* (u32 *) p), "=r" (errno)
+			: "r" (arg2), "R" (* (u32 *) p), "2" (errno)
 			: "$1");
 
 		if (errno)
Index: include/asm-mips/system.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/system.h,v
retrieving revision 1.27
diff -u -r1.27 system.h
--- include/asm-mips/system.h	2001/03/28 01:35:12	1.27
+++ include/asm-mips/system.h	2001/05/23 21:49:29
@@ -219,8 +219,8 @@
 		" ll\t%0, %3\n\t"
 		".set\tat\n\t"
 		".set\treorder"
-		: "=r" (val), "=o" (*m), "=r" (dummy)
-		: "o" (*m), "2" (val)
+		: "=r" (val), "=R" (*m), "=r" (dummy)
+		: "R" (*m), "2" (val)
 		: "memory");
 
 	return val;

--huq684BweRXVnRxX--
