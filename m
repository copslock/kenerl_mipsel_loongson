Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1HWLX16482
	for linux-mips-outgoing; Thu, 1 Nov 2001 09:32:21 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1HWB016467
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 09:32:11 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id JAA26171;
	Thu, 1 Nov 2001 09:31:58 -0800
Date: Thu, 1 Nov 2001 09:31:58 -0800
From: Jun Sun <jsun@mvista.com>
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [Fwd: Kernel panic: Caught reserved exception - should not happen.]
Message-ID: <20011101093158.C26148@mvista.com>
References: <3BE15781.73CE64DD@cotw.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE15781.73CE64DD@cotw.com>; from samcconn@cotw.com on Thu, Nov 01, 2001 at 09:09:05AM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2001 at 09:09:05AM -0500, Scott A McConnell wrote:
> 
> -- 
> Scott A. McConnell
> X-Mozilla-Status2: 00000000
> Date: Thu, 01 Nov 2001 09:05:52 -0500
> From: Scott A McConnell <samcconn@cotw.com>
> X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-xfs-1.0.1 i686)
> X-Accept-Language: en
> To: Jun Sun <jsun@mvista.com>
> Subject: Re: Kernel panic: Caught reserved exception - should not happen.
> 
> Jun Sun wrote:
> > 
> > Scott A McConnell wrote:
> > >
> > > I have been getting a fair amount of the above type of errors when
> > > compiling on a mipsel box.
> > >
> > > 2.4.5 kernel on a NEC VR5432 box. Anyone aware of known problems?
> > >
> > 
> > What is the exception vector?  Is it the "watch exception"?
> 
> No it is not a watch exception it appears to always be an Interrupt
> exception.
>

Try the following patch.  It is outdated, and it may not apply cleanly.
But you should get an idea about the intention of the fix.

Please let me know the result.

Jun


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="R5432-cp0-interrupt-bug-workaround.X.010626.patch"


This is a possible fix for the R5432 cp0/interrupt bug.  Not tested or
verified by NEC engineers.

Not checked in yet.  Pending on more info on this bug.

Jun

diff -Nru linux/arch/mips/kernel/head.S.orig linux/arch/mips/kernel/head.S
--- linux/arch/mips/kernel/head.S.orig	Tue Jun 26 16:15:26 2001
+++ linux/arch/mips/kernel/head.S	Tue Jun 26 16:27:49 2001
@@ -59,6 +59,12 @@
 	.set	noat
 	LEAF(except_vec0_r4000)
 	.set	mips3
+#if defined(CONFIG_CPU_R5432)
+	la 	k0, 1f
+	jr	k0
+	nop
+1:
+#endif
 	mfc0	k0, CP0_BADVADDR		# Get faulting address
 	srl	k0, k0, 22			# get pgd only bits
 	lw	k1, current_pgd			# get pgd pointer
@@ -329,6 +335,12 @@
 	/* Register saving is delayed as long as we don't know
 	 * which registers really need to be saved.
 	 */
+#if defined(CONFIG_CPU_R5432)
+	la 	k0, 1f
+	jr	k0
+	nop
+1:
+#endif
 	mfc0	k1, CP0_CONTEXT
 	dsra	k1, 1
 	lwu	k0,  (k1)		# May cause another exception
@@ -357,6 +369,12 @@
 	 * in the cache, we may not be able to recover.  As a
 	 * first-order desperate measure, turn off KSEG0 cacheing.
 	 */
+#if defined(CONFIG_CPU_R5432)
+	la 	k0, 1f
+	jr	k0
+	nop
+1:
+#endif
 	mfc0	k0,CP0_CONFIG
 	li	k1,~CONF_CM_CMASK
 	and	k0,k0,k1
@@ -374,6 +392,12 @@
 	/* General exception vector R4000 version. */
 	NESTED(except_vec3_r4000, 0, sp)
 	.set	noat
+#if defined(CONFIG_CPU_R5432)
+	la 	k0, 1f
+	jr	k0
+	nop
+1:
+#endif
 	mfc0	k1, CP0_CAUSE
 	andi	k1, k1, 0x7c
 	li	k0, 31<<2
@@ -427,6 +451,12 @@
 	NESTED(except_vec3_generic, 0, sp)
 	.set	noat
 	.set	mips0
+#if defined(CONFIG_CPU_R5432)
+	la 	k0, 1f
+	jr	k0
+	nop
+1:
+#endif
 	mfc0	k1, CP0_CAUSE
 	la	k0, exception_handlers
 	andi	k1, k1, 0x7c

--HcAYCG3uE/tztfnV--
