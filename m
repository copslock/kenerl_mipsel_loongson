Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5SEWwK30223
	for linux-mips-outgoing; Thu, 28 Jun 2001 07:32:58 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5SEWuV30219
	for <linux-mips@oss.sgi.com>; Thu, 28 Jun 2001 07:32:56 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id QAA40198
	for <linux-mips@oss.sgi.com>; Thu, 28 Jun 2001 16:32:51 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15Fcqh-00016p-00
	for <linux-mips@oss.sgi.com>; Thu, 28 Jun 2001 16:32:51 +0200
Date: Thu, 28 Jun 2001 16:32:51 +0200
To: linux-mips@oss.sgi.com
Subject: Re: ksymoops changes for mips
Message-ID: <20010628163250.D28583@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16633.993608517@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith Owens wrote:
[snip]
> >The best option is for a mips64 kernel to indicate that it is 64 bit
> >and its endianess.  Instead of printing
> >
> >  "epc     : %016lx\n"
> >
> >print
> >
> >  "epc     : %016lx (64 "
> >#ifdef __MIPSEL__
> >		"LSB"
> >#else
> >		"MSB"
> >#endif
> >		")\n"
> 
> I have a new ksymoops release coming up.  Is it OK if I include code to
> look for (64 LSB) and (64 MSB) in the oops and decode accordingly.  I
> don't expect the kernel to produce this output immediately, I just want
> agreement on the format that will be produced.

The appended patch introduces the new format in mips64. Maybe this speeds
up agreement about it. :-)


Thiemo


diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/mm/andes.c linux/arch/mips64/mm/andes.c
--- linux-orig/arch/mips64/mm/andes.c	Sat May 26 00:25:39 2001
+++ linux/arch/mips64/mm/andes.c	Thu Jun 28 15:19:32 2001
@@ -332,7 +381,13 @@
 	printk("Lo      : %016lx\n", regs->lo);
 
 	/* Saved cp0 registers. */
-	printk("epc     : %016lx\nbadvaddr: %016lx\n",
+	printk("epc     : %016lx (64 "
+#ifdef __MIPSEL__
+	       "LSB"
+#else
+	       "MSB"
+#endif
+	       ")\nbadvaddr: %016lx\n",
 	       regs->cp0_epc, regs->cp0_badvaddr);
 	printk("Status  : %08x\nCause   : %08x\n",
 	       (unsigned int) regs->cp0_status, (unsigned int) regs->cp0_cause);
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/mm/r4xx0.c linux/arch/mips64/mm/r4xx0.c
--- linux-orig/arch/mips64/mm/r4xx0.c	Thu Mar 29 17:11:46 2001
+++ linux/arch/mips64/mm/r4xx0.c	Thu Jun 28 14:51:20 2001
@@ -2125,7 +2118,13 @@
 	printk("Lo      : %016lx\n", regs->lo);
 
 	/* Saved cp0 registers. */
-	printk("epc     : %016lx\nbadvaddr: %016lx\n",
+	printk("epc     : %016lx (64 "
+#ifdef __MIPSEL__
+	       "LSB"
+#else
+	       "MSB"
+#endif
+	       ")\nbadvaddr: %016lx\n",
 	       regs->cp0_epc, regs->cp0_badvaddr);
 	printk("Status  : %08x\nCause   : %08x\n",
 	       (unsigned int) regs->cp0_status, (unsigned int) regs->cp0_cause);
