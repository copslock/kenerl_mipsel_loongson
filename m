Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PA76Rw031306
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 03:07:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PA751j031305
	for linux-mips-outgoing; Thu, 25 Jul 2002 03:07:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PA6qRw031288
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 03:06:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA28885;
	Thu, 25 Jul 2002 12:08:15 +0200 (MET DST)
Date: Thu, 25 Jul 2002 12:08:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Johannes Stezenbach <js@convergence.de>
cc: linux-mips@oss.sgi.com
Subject: Re: _stext is ill-defined / SysRq-T broken
In-Reply-To: <20020724181708.GA5399@convergence.de>
Message-ID: <Pine.GSO.3.96.1020725114648.27463B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 24 Jul 2002, Johannes Stezenbach wrote:

> I found that the cause for this is that _stext (defined in head.S) is in
> .text.init instead of .text, so it's past _etext.
> 
> I suggest the patch below to fix the bad formatting, but I'm
> not shure about _stext. Should kernel_entry be placed into the .text
> section, or should _stext = _ftext in ld.script?

 I think the intent is to skip initial parts of .text, specifically the
exception handlers (if linked at KSEG0).  kernel_entry is in .text.init
deliberately, as it's not needed except early in the boot process.  I
propose the following change.  Does it work for you? 

> Another nit (I don't have ejtag, so I don't care much):
>   head.S: Assembler messages:
>   head.S:102: Warning: Macro instruction expanded into multiple instructions in a branch delay slot
> Maybe someone has spare nop to put there.

 The warning is spurious, but there seems no way to shut up gas in this
condition.  Thus an extra "nop" looks like the right workaround.

 I'll check your patch at run-time later -- I've noticed that the current
output is less than satisfying.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020719-stext-0
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/kernel/head.S linux-mips-2.4.19-rc1-20020719/arch/mips/kernel/head.S
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/kernel/head.S	2002-06-04 03:04:12.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/kernel/head.S	2002-07-25 10:03:16.000000000 +0000
@@ -35,6 +35,10 @@
 		 */
 		.fill	0x400
 
+		/* The following two symbols are used for kernel profiling. */
+		EXPORT(stext)
+		EXPORT(_stext)
+
 		__INIT
 
 		/* Cache Error */
@@ -144,9 +148,6 @@ ejtag_return:
 		 */
 		NESTED(kernel_entry, 16, sp)
 		.set	noreorder
-		/* The following two symbols are used for kernel profiling. */
-		EXPORT(stext)
-		EXPORT(_stext)
 
 		/*
 		 * Stack for kernel and init, current variable
