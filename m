Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Feb 2003 03:50:38 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:48774 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225202AbTBVDui>;
	Sat, 22 Feb 2003 03:50:38 +0000
Received: (qmail 617 invoked by uid 6180); 22 Feb 2003 03:50:31 -0000
Date: Fri, 21 Feb 2003 19:50:31 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Dan Malek <dan@embeddededge.com>
Cc: ppopov@mvista.com, linux-mips@linux-mips.org
Subject: Re: fixup_bigphys_addr and DBAu1500 dev board
Message-ID: <20030221195031.I20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <200302201135.09154.krishnakumar@naturesoft.net> <20030221.112456.41627052.nemoto@toshiba-tops.co.jp> <20030221122515.E20129@luca.pas.lab> <3E568ECC.2090601@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E568ECC.2090601@embeddededge.com>; from dan@embeddededge.com on Fri, Feb 21, 2003 at 03:40:44PM -0500
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Dan & Pete:

Thank you very much for your help!

I've patched things up, and my kernel runs, but the yenta_socket kernel module
still locks the system. Time to break out GDB and take a look at everything!
Please let me know if ya'll have some suggestions. :*)

After the 36-bit PCI patch, I had to alter include/asm-mips/io.h in order to
get drivers/net/wireless to compile. Preprocessor expansion of outw_p in the
hermes.h -> hermes_enable_interrupt and hermes_set_irqmask inline functions
caused some issues; I hope this patch is of some use!

Regards,

Jeff


diff -u -r1.29.2.19 include/asm-mips/io.h
--- include/asm-mips/io.h        28 Nov 2002 23:04:11 -0000      1.29.2.19
+++ include/asm-mips/io.h        22 Feb 2003 03:44:27 -0000
@@ -329,12 +329,25 @@
        SLOW_DOWN_IO;                                                   \
 } while(0)
 
-#define outw_p(val,port)                                               \
-do {                                                                   \
-       *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
-               __ioswab16(val);                                        \
-       SLOW_DOWN_IO;                                                   \
-} while(0)
+/* baitisj */
+static inline u16 outw_p(u16 val, unsigned long port)
+{
+    register u16 retval;
+    do {
+        retval = *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) =
+            __ioswab16(val);
+        SLOW_DOWN_IO;
+    } while(0);
+    return retval;
+}
+/*  
+ *  #define outw_p(val,port)                                           \
+ *  do {                                                                       \
+ *     *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
+ *             __ioswab16(val);                                        \
+ *     SLOW_DOWN_IO;                                                   \
+ *  } while(0)
+ */
 
 #define outl_p(val,port)                                               \
 do {                                                                   \



On Fri, Feb 21, 2003 at 03:40:44PM -0500, Dan Malek wrote:
> Jeff Baitis wrote:
> 
> > I'd love to know where this mystery fixup_bigphys_addr comes from!?
> 
> You need the 36-bit patch from Pete that is not yet part of the
> linux-mips tree.
> 
> You can find it on linux-mips.org in /pub/linux/mips/people/ppopov.
> 
> Have fun!
> 
> 
> 	-- Dan
> 
> 
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
