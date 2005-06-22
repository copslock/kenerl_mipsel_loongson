Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 18:49:50 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:14273
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8225410AbVFVRte>; Wed, 22 Jun 2005 18:49:34 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP
	id E3EAD14B6B2; Wed, 22 Jun 2005 13:48:19 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.42083.756755.92799@cortez.sw.starentnetworks.com>
Date:	Wed, 22 Jun 2005 13:48:19 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] various sibyte 2.6.x bugfixes
In-Reply-To: <Pine.LNX.4.61L.0506221616020.4849@blysk.ds.pg.gda.pl>
References: <17081.32401.574987.337795@cortez.sw.starentnetworks.com>
	<Pine.LNX.4.61L.0506221616020.4849@blysk.ds.pg.gda.pl>
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki writes:
> On Wed, 22 Jun 2005 djohnson+linuxmips@sw.starentnetworks.com wrote:
> 
> > -	if (mask) {
> > -		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
> > +	if ((i == NR_CPUS) || (next_cpu(i, mask) != NR_CPUS)) {
> > +		printk("attempted to set irq affinity for irq %d to zero/multiple CPUs\n", irq);
> 
>  This printk() should be split into two lines.

Now that I look at it more that check isn't needed at all.

zero bits wont make it past irq_affinity_write_proc() so that's not
needed.

multiple bits are valid (it's also the default) so just using the
first bit that is set should be fine.


> >  	d->sbdma_dscrtable = (sbdmadscr_t *) 
> > -		kmalloc(d->sbdma_maxdescr*sizeof(sbdmadscr_t), GFP_KERNEL);
> > +		kmalloc(d->sbdma_maxdescr*sizeof(sbdmadscr_t)+SMP_CACHE_BYTES, GFP_KERNEL);
> 
>  Formatting!
> 
> > +	/*
> > +	 * The descriptor table must be aligned to at least 16 bytes or the
> > +	 * MAC will corrupt it. Align it to 32 bytes.
> > +	 */
> 
>  Why 32 bytes then?  Too much memory left?
> 
> > +	if ((unsigned long)d->sbdma_dscrtable & (SMP_CACHE_BYTES-1)) {
> > +		(unsigned long)d->sbdma_dscrtable += SMP_CACHE_BYTES - ((unsigned long)d->sbdma_dscrtable & (SMP_CACHE_BYTES-1));
> > +	}
> 
>  Hmm, there's that generic ALIGN() macro -- you should use it...  
> Besides, casts as lvalues are not allowed anymore (and they are hideous 
> anyway).
> 

Ya, 16 is all that's needed. tested fine and changed.

new patch is below.

-- 
Dave Johnson
Starent Networks




===== arch/mips/sibyte/sb1250/irq.c 1.7 vs edited =====
--- 1.7/arch/mips/sibyte/sb1250/irq.c	Mon Jun 20 13:01:09 2005
+++ edited/arch/mips/sibyte/sb1250/irq.c	Wed Jun 22 11:55:34 2005
@@ -53,7 +53,7 @@
 static unsigned int startup_sb1250_irq(unsigned int irq);
 static void ack_sb1250_irq(unsigned int irq);
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask);
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask);
 #endif
 
 #ifdef CONFIG_SIBYTE_HAS_LDT
@@ -117,29 +117,15 @@
 }
 
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask)
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask)
 {
-	int i = 0, old_cpu, cpu, int_on;
+	int old_cpu, cpu, int_on;
 	u64 cur_ints;
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
-	while (mask) {
-		if (mask & 1) {
-			mask >>= 1;
-			break;
-		}
-		mask >>= 1;
-		i++;
-	}
-
-	if (mask) {
-		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
-		return;
-	}
-
 	/* Convert logical CPU to physical CPU */
-	cpu = cpu_logical_map(i);
+	cpu = cpu_logical_map(first_cpu(mask));
 
 	/* Protect against other affinity changers and IMR manipulation */
 	spin_lock_irqsave(&desc->lock, flags);
===== arch/mips/sibyte/swarm/setup.c 1.7 vs edited =====
--- 1.7/arch/mips/sibyte/swarm/setup.c	Tue Jan  4 21:48:16 2005
+++ edited/arch/mips/sibyte/swarm/setup.c	Mon Jun 20 17:19:25 2005
@@ -74,7 +74,7 @@
 	if (!is_fixup && (regs->cp0_cause & 4)) {
 		/* Data bus error - print PA */
 #ifdef CONFIG_MIPS64
-		printk("DBE physical address: %010lx\n",
+		printk("DBE physical address: %010llx\n",
 		       __read_64bit_c0_register($26, 1));
 #else
 		printk("DBE physical address: %010llx\n",
===== drivers/net/sb1250-mac.c 1.16 vs edited =====
--- 1.16/drivers/net/sb1250-mac.c	Mon Jun 20 13:01:12 2005
+++ edited/drivers/net/sb1250-mac.c	Wed Jun 22 13:25:15 2005
@@ -750,7 +750,13 @@
 	d->sbdma_maxdescr = maxdescr;
 	
 	d->sbdma_dscrtable = (sbdmadscr_t *) 
-		kmalloc(d->sbdma_maxdescr*sizeof(sbdmadscr_t), GFP_KERNEL);
+		kmalloc((d->sbdma_maxdescr+1)*sizeof(sbdmadscr_t), GFP_KERNEL);
+	
+	/*
+	 * The descriptor table must be aligned to at least 16 bytes or the
+	 * MAC will corrupt it.
+	 */
+	d->sbdma_dscrtable = (sbdmadscr_t *)ALIGN((unsigned long)d->sbdma_dscrtable, sizeof(sbdmadscr_t));
 	
 	memset(d->sbdma_dscrtable,0,d->sbdma_maxdescr*sizeof(sbdmadscr_t));
 	
