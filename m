Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DJB4X22144
	for linux-mips-outgoing; Wed, 13 Jun 2001 12:11:04 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DJB2P22139
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 12:11:02 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f5DIns005987;
	Wed, 13 Jun 2001 11:49:54 -0700
Message-ID: <3B27B56F.65BAE189@mvista.com>
Date: Wed, 13 Jun 2001 11:48:15 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
References: <20010613082417.C9739@lucon.org> <Pine.GSO.3.96.1010613173820.9854M-100000@delta.ds2.pg.gda.pl> <20010613084416.A10334@lucon.org>
Content-Type: multipart/mixed;
 boundary="------------ECC83C97D960AE7BCDCCC103"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------ECC83C97D960AE7BCDCCC103
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"H . J . Lu" wrote:
> 
> On Wed, Jun 13, 2001 at 05:39:08PM +0200, Maciej W. Rozycki wrote:
> > On Wed, 13 Jun 2001, H . J . Lu wrote:
> >
> > > I don't have problem with 2.4.0-test11. It is the change in 2.4.3
> > > which breaks glibc.
> >
> >  You mean someone changed sysmips() in an incompatible way?  Aaarghh...
> 
> I don't remeber the detail, it is eithet kernel crash or glibc crash.
> I switched to mips II for glibc as the result.
> 
> H.J.

The latest CVS tree removed MIPS_ATOMIC_SET for CPUs without ll/sc.  See the
diff below.

RCS file: /cvs/linux/arch/mips/kernel/sysmips.c,v
retrieving revision 1.17
retrieving revision 1.18
diff -r1.17 -r1.18
77a78
> #ifdef CONFIG_CPU_HAS_LLSC
120a122,124
> #else
>       printk("sys_sysmips(MIPS_ATOMIC_SET, ...) not ready for !CONFIG_CPU_HAS_LLSC\n");
> #endif

However the log says:

date: 2001/04/08 13:24:27;  author: ralf;  state: Exp;  lines: +4 -0
Fix ll/sc emulation.  Extracted from Linux-VR tree by Harald.

It seems that the checkin is a mistake because apparently it is not what
linux-vr is doing.  They used to have a piece of code for CPUs without ll/sc. 
And recently they moved to ll/sc instruction emulation.

Ralf, the following patch includes the original vr code for MIPS_ATOMIC_SET,
no ll/sc case.  Although we all know it is buggy (for small negative set
values), it is still better than nothing.

Jun
--------------ECC83C97D960AE7BCDCCC103
Content-Type: text/plain; charset=us-ascii;
 name="junk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="junk"

diff -Nru sysmips.c.orig sysmips.c
--- sysmips.c.orig	Wed Jun 13 11:32:09 2001
+++ sysmips.c	Wed Jun 13 11:46:06 2001
@@ -120,7 +120,23 @@
 			: "r" (&cmd));
 		/* Unreached */
 #else
-	printk("sys_sysmips(MIPS_ATOMIC_SET, ...) not ready for !CONFIG_CPU_HAS_LLSC\n");
+               /* this is handled in assembly now */
+               panic("Unexpected MIPS_ATOMIC_SET call in sys_sysmips()");
+#else
+               int flags;
+
+               /* without ll/sc, we have a broken code that kind of works */
+                /* This is broken in case of page faults and SMP ...
+                   Risc/OS fauls after maximum 20 tries with EAGAIN.  */
+                p = (int *) arg1;
+                retval = verify_area(VERIFY_WRITE, p, sizeof(*p));
+                if (retval)
+                        goto out;
+                save_and_cli(flags);
+                retval = *p;
+                *p = arg2;
+                restore_flags(flags);
+                goto out;
 #endif
 	}
 

--------------ECC83C97D960AE7BCDCCC103--
