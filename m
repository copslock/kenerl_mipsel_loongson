Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB16nGR20747
	for linux-mips-outgoing; Fri, 30 Nov 2001 22:49:16 -0800
Received: from ns1.local (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB16mbo20743;
	Fri, 30 Nov 2001 22:48:40 -0800
Received: from dev1 (unknown [10.1.1.85])
	by ns1.local (Postfix) with ESMTP
	id 86815590A9; Sat,  1 Dec 2001 00:46:41 -0500 (EST)
Received: from brad by dev1 with local (Exim 3.32 #1 (Debian))
	id 16A2xr-0005mu-00; Sat, 01 Dec 2001 00:45:28 -0500
Date: Sat, 1 Dec 2001 00:45:27 -0500
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: PATCH: spurious_count cleanup
Message-ID: <20011201004526.A22248@dev1.ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: "Bradley D. LaRonde" <brad@ltc.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

2001-11-30  Bradley D. LaRonde <brad@ltc.com>

arch/mips/kernel/irq.c prints irq_err_count, but spurious_interupt
incremented spurious_count, not irq_err_count.  irq_err_count is
used for counting spurious interrupts on other platforms.

* increment irq_err_count instead of spurious_count in spurious_interrupt
* eliminate spurious_count variable
* use common spurious intterrupt handler in au1000


--- arch/mips/au1000/common/int-handler.S	2001/05/18 22:13:23	1.2
+++ arch/mips/au1000/common/int-handler.S	2001/11/30 18:42:05
@@ -65,7 +65,5 @@
 
 5:	
 	move	a0, sp
-	jal	mips_spurious_interrupt
-done:
-	j	ret_from_irq
+	j	spurious_interrupt
 END(au1000_IRQ)
--- arch/mips/au1000/common/irq.c	2001/10/31 12:47:14	1.8
+++ arch/mips/au1000/common/irq.c	2001/11/30 18:42:05
@@ -84,7 +84,7 @@
 inline void local_enable_irq(unsigned int irq_nr);
 inline void local_disable_irq(unsigned int irq_nr);
 
-unsigned long spurious_interrupts;
+volatile unsigned long irq_err_count;
 extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
 extern void __init init_generic_irq(void);
 
@@ -455,12 +455,6 @@
 	set_debug_traps();
 	breakpoint(); 
 #endif
-}
-
-
-void mips_spurious_interrupt(struct pt_regs *regs)
-{
-	spurious_interrupts++;
 }
 
 
--- arch/mips/baget/irq.c	2001/03/12 02:46:14	1.12
+++ arch/mips/baget/irq.c	2001/11/30 18:42:05
@@ -27,7 +27,7 @@
 
 #include <asm/baget/baget.h>
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 
 /*
  * This table is a correspondence between IRQ numbers and CPU PILs
--- arch/mips/dec/irq.c	2001/09/27 23:45:52	1.16
+++ arch/mips/dec/irq.c	2001/11/30 18:42:05
@@ -34,7 +34,7 @@
 
 extern asmlinkage void decstation_handle_int(void);
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 
 static inline void mask_irq(unsigned int irq_nr)
 {
--- arch/mips/galileo-boards/ev64120/irq.c	2001/11/05 20:15:26	1.6
+++ arch/mips/galileo-boards/ev64120/irq.c	2001/11/30 18:42:05
@@ -189,7 +189,7 @@
  */
 irq_desc_t irq_desc[NR_IRQS];
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 
 int get_irq_list(char *buf)
 {
@@ -219,7 +219,7 @@
 		}
 		len += sprintf(buf + len, "\n");
 	}
-	len += sprintf(buf + len, "BAD: %10lu\n", spurious_count);
+	len += sprintf(buf + len, "BAD: %10lu\n", irq_err_count);
 	return len;
 }
 
--- arch/mips/galileo-boards/ev96100/irq.c	2001/11/30 13:28:06	1.10
+++ arch/mips/galileo-boards/ev96100/irq.c	2001/11/30 18:42:06
@@ -64,7 +64,7 @@
 extern asmlinkage void ev96100IRQ(void);
 unsigned int local_bh_count[NR_CPUS];
 unsigned int local_irq_count[NR_CPUS];
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 irq_desc_t irq_desc[NR_IRQS];
 irq_desc_t *irq_desc_base=&irq_desc[0];
 
@@ -153,7 +153,7 @@
                 }
                 len += sprintf(buf+len, "\n");
         }
-        len += sprintf(buf+len, "BAD: %10lu\n", spurious_count);
+        len += sprintf(buf+len, "BAD: %10lu\n", irq_err_count);
         return len;
 }
 
@@ -210,7 +210,7 @@
 	}
 	else
 	{
-		spurious_count++;
+		irq_err_count++;
 		printk("Unhandled interrupt %x, cause %x, disabled\n", 
 				(unsigned)irq, (unsigned)cause);
 		disable_irq(1<<irq);
--- arch/mips/galileo-boards/ev96100/time.c	2001/10/05 15:08:28	1.5
+++ arch/mips/galileo-boards/ev96100/time.c	2001/11/30 18:42:06
@@ -48,7 +48,6 @@
 
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
 
-extern unsigned long spurious_count;
 extern volatile unsigned long wall_jiffies;
 unsigned long missed_heart_beats = 0;
 
--- arch/mips/kernel/entry.S	2001/11/27 01:26:46	1.32
+++ arch/mips/kernel/entry.S	2001/11/30 18:42:07
@@ -95,12 +95,12 @@
 		 * Someone tried to fool us by sending an interrupt but we
 		 * couldn't find a cause for it.
 		 */
-		lui     t1,%hi(spurious_count)
+		lui     t1,%hi(irq_err_count)
 		.set	reorder
-		lw      t0,%lo(spurious_count)(t1)
+		lw      t0,%lo(irq_err_count)(t1)
 		.set	noreorder
 		addiu   t0,1
-		sw      t0,%lo(spurious_count)(t1)
+		sw      t0,%lo(irq_err_count)(t1)
 		j	ret_from_irq
 		END(spurious_interrupt)
 
--- arch/mips/kernel/irq.c	2001/10/12 01:41:17	1.36
+++ arch/mips/kernel/irq.c	2001/11/30 18:42:09
@@ -64,7 +64,7 @@
 	end_none
 };
 
-volatile unsigned long irq_err_count, spurious_count;
+volatile unsigned long irq_err_count;
 
 /*
  * Generic, controller-independent functions:
--- arch/mips/kernel/old-irq.c	2001/08/22 03:23:59	1.5
+++ arch/mips/kernel/old-irq.c	2001/11/30 18:42:09
@@ -69,7 +69,7 @@
 #define cached_21       (__byte(0,cached_irq_mask))
 #define cached_A1       (__byte(1,cached_irq_mask))
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 
 /*
  * (un)mask_irq, disable_irq() and enable_irq() only handle (E)ISA and
--- arch/mips/mips-boards/atlas/atlas_int.c	2001/05/04 20:43:25	1.7
+++ arch/mips/mips-boards/atlas/atlas_int.c	2001/11/30 18:42:09
@@ -42,7 +42,7 @@
 extern asmlinkage void mipsIRQ(void);
 extern void do_IRQ(int irq, struct pt_regs *regs);
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 irq_desc_t irq_desc[NR_IRQS];
 
 #if 0
@@ -196,7 +196,7 @@
 	/* if action == NULL, then we don't have a handler for the irq */
 	if ( action == NULL ) {
 		printk("No handler for hw0 irq: %i\n", irq);
-		spurious_count++;
+		irq_err_count++;
 		return;
 	}
 
--- arch/mips64/kernel/entry.S	2001/08/22 03:23:59	1.10
+++ arch/mips64/kernel/entry.S	2001/11/30 18:42:09
@@ -81,9 +81,9 @@
 		 * Someone tried to fool us by sending an interrupt but we
 		 * couldn't find a cause for it.
 		 */
-		lui     t1,%hi(spurious_count)
-		lw      t0,%lo(spurious_count)(t1)
+		lui     t1,%hi(irq_err_count)
+		lw      t0,%lo(irq_err_count)(t1)
 		addiu   t0,1
-		sw      t0,%lo(spurious_count)(t1)
+		sw      t0,%lo(irq_err_count)(t1)
 		j	ret_from_irq
 		END(spurious_interrupt)
--- arch/mips64/mips-boards/atlas/atlas_int.c	2001/04/27 13:19:19	1.1
+++ arch/mips64/mips-boards/atlas/atlas_int.c	2001/11/30 18:42:09
@@ -43,7 +43,7 @@
 extern asmlinkage void mipsIRQ(void);
 extern void do_IRQ(int irq, struct pt_regs *regs);
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 irq_desc_t irq_desc[NR_IRQS];
 
 #if 0
@@ -192,7 +192,7 @@
 	/* if action == NULL, then we don't have a handler for the irq */
 	if ( action == NULL ) {
 	        printk("No handler for hw0 irq: %i\n", irq);
-		spurious_count++;
+		irq_err_count++;
 		return;
 	}
 
--- arch/mips64/mips-boards/malta/malta_int.c	2001/04/27 13:19:19	1.1
+++ arch/mips64/mips-boards/malta/malta_int.c	2001/11/30 18:42:10
@@ -45,7 +45,7 @@
 
 unsigned int local_bh_count[NR_CPUS];
 unsigned int local_irq_count[NR_CPUS];
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 
 static struct irqaction *hw0_irq_action[MALTAINT_END] = {
 	NULL, NULL, NULL, NULL,
--- arch/mips64/sgi-ip22/ip22-int.c	2001/03/18 04:20:23	1.10
+++ arch/mips64/sgi-ip22/ip22-int.c	2001/11/30 18:42:12
@@ -68,7 +68,7 @@
 extern void rs_kgdb_hook(int);
 #endif
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 
 /* Local IRQ's are layed out logically like this:
  *
--- arch/mips64/sgi-ip27/ip27-irq.c	2001/11/30 13:28:06	1.43
+++ arch/mips64/sgi-ip27/ip27-irq.c	2001/11/30 18:42:12
@@ -73,7 +73,7 @@
 int intr_connect_level(int cpu, int bit);
 int intr_disconnect_level(int cpu, int bit);
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 
 /*
  * There is a single intpend register per node, and we want to have
--- arch/mips64/sgi-ip32/ip32-irq.c	2001/10/27 00:49:55	1.3
+++ arch/mips64/sgi-ip32/ip32-irq.c	2001/11/30 18:42:13
@@ -116,7 +116,7 @@
 			       0, "CRIME CPU error", NULL,
 			       NULL };
 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 extern void ip32_handle_int (void);
 asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs);
 
@@ -605,7 +605,7 @@
 	do_IRQ (CLOCK_IRQ, regs);
 }
 
-volatile unsigned long irq_err_count, spurious_count;
+volatile unsigned long irq_err_count;
 
 /*
  * Generic, controller-independent functions:
--- arch/mips64/sibyte/sb1250/irq.c	2001/11/08 02:22:49	1.1
+++ arch/mips64/sibyte/sb1250/irq.c	2001/11/30 18:42:13
@@ -188,12 +188,12 @@
 /* Defined in arch/mips/sibyte/sb1250/irq_handler.S */
 extern void sb1250_irq_handler(void);
 /* 
- *  spurious_count is used in arch/mips/kernel/entry.S to record the 
+ *  irq_err_count is used in arch/mips/kernel/entry.S to record the 
  *  number of spurious interrupts we see before the handler is installed. 
  *  It doesn't provide any particularly relevant information for us, so
  *  we basically ignore it.
  */ 
-unsigned long spurious_count = 0;
+volatile unsigned long irq_err_count;
 
 /*
  * The interrupt handler calls this once for every unmasked interrupt
