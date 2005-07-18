Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 18:29:36 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:16295 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8226838AbVGRR3U>; Mon, 18 Jul 2005 18:29:20 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DuZS8-0005Ny-00; Mon, 18 Jul 2005 19:30:53 +0200
Date:	Mon, 18 Jul 2005 19:30:52 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Dan Malek <dan@embeddededge.com>
Cc:	linux-mips@linux-mips.org
Subject: Power Management for au1100 fixed! :)
Message-ID: <20050718173052.GC28995@enneenne.com>
References: <20050712142202.GB9234@gundam.enneenne.com> <20050712181013.GC9234@gundam.enneenne.com> <a2882b70a3d6c0f32728086e0c63764c@embeddededge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <a2882b70a3d6c0f32728086e0c63764c@embeddededge.com>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--9UV9rz0O2dU/yYYn
Content-Type: multipart/mixed; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2005 at 11:52:30AM -0700, Dan Malek wrote:
> Now that you know the reason for the change, perhaps we
> should try to make it work properly :-)

Ok, Fixed! :)

Here you can see the patch. Please note that I also fixed some type
mismatches and some comments.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-PM_CONFIG
Content-Transfer-Encoding: quoted-printable

Index: arch/mips/au1000/common/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/develop/cvs_private/linux-mips-exadron/arch/mips/au1000/com=
mon/irq.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- a/arch/mips/au1000/common/irq.c	2 Jul 2005 06:45:44 -0000	1.1.1.1
+++ b/arch/mips/au1000/common/irq.c	18 Jul 2005 17:16:57 -0000	1.2
@@ -83,7 +83,7 @@
 void	(*board_init_irq)(void);
=20
 #ifdef CONFIG_PM
-extern void counter0_irq(int irq, void *dev_id, struct pt_regs *regs);
+extern irqreturn_t counter0_irq(int irq, void *dev_id, struct pt_regs *reg=
s);
 #endif
=20
 static DEFINE_SPINLOCK(irq_lock);
@@ -293,29 +293,32 @@
 };
=20
 #ifdef CONFIG_PM
-void startup_match20_interrupt(void (*handler)(int, void *, struct pt_regs=
 *))
+void startup_match20_interrupt(irqreturn_t (*handler)(int, void *, struct =
pt_regs *))
 {
+	struct irq_desc *desc =3D &irq_desc[AU1000_TOY_MATCH2_INT];
+
 	static struct irqaction action;
+	memset(&action, 0, sizeof(struct irqaction));
+
 	/* This is a big problem.... since we didn't use request_irq
 	   when kernel/irq.c calls probe_irq_xxx this interrupt will
 	   be probed for usage. This will end up disabling the device :(
=20
-       Give it a bogus "action" pointer -- this will keep it from
+           Give it a bogus "action" pointer -- this will keep it from
 	   getting auto-probed!
=20
-       By setting the status to match that of request_irq() we
-       can avoid it.  --cgray
+           By setting the status to match that of request_irq() we
+           can avoid it.  --cgray
 	*/
 	action.dev_id =3D handler;
-	action.flags =3D 0;
-	action.mask =3D 0;
+	action.flags =3D SA_INTERRUPT;
+	cpus_clear(action.mask);
 	action.name =3D "Au1xxx TOY";
 	action.handler =3D handler;
 	action.next =3D NULL;
=20
-	irq_desc[AU1000_TOY_MATCH2_INT].action =3D &action;=20
-	irq_desc[AU1000_TOY_MATCH2_INT].status=20
-		 &=3D ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
+	desc->action =3D &action;=20
+	desc->status &=3D ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INP=
ROGRESS);
=20
 	local_enable_irq(AU1000_TOY_MATCH2_INT);
 }
Index: arch/mips/au1000/common/power.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/develop/cvs_private/linux-mips-exadron/arch/mips/au1000/com=
mon/power.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- a/arch/mips/au1000/common/power.c	2 Jul 2005 06:45:44 -0000	1.1.1.1
+++ b/arch/mips/au1000/common/power.c	18 Jul 2005 17:16:57 -0000	1.2
@@ -34,11 +34,13 @@
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/jiffies.h>
=20
 #include <asm/string.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/cacheflush.h>
 #include <asm/mach-au1x00/au1000.h>
=20
 #ifdef CONFIG_PM
@@ -50,7 +52,7 @@
 #  define DPRINTK(fmt, args...)
 #endif
=20
-static void calibrate_delay(void);
+static void au1000_calibrate_delay(void);
=20
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
@@ -260,7 +262,7 @@
 }
=20
 static int pm_do_sleep(ctl_table * ctl, int write, struct file *file,
-		       void *buffer, size_t * len)
+		       void __user *buffer, size_t * len, loff_t *ppos)
 {
 	int retval =3D 0;
 #ifdef SLEEP_TEST_TIMEOUT
@@ -294,7 +296,7 @@
 }
=20
 static int pm_do_suspend(ctl_table * ctl, int write, struct file *file,
-			 void *buffer, size_t * len)
+			 void __user *buffer, size_t * len, loff_t *ppos)
 {
 	int retval =3D 0;
=20
@@ -313,7 +315,7 @@
=20
=20
 static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
-		      void *buffer, size_t * len)
+		      void __user *buffer, size_t * len, loff_t *ppos)
 {
 	int retval =3D 0, i;
 	unsigned long val, pll;
@@ -408,14 +410,14 @@
=20
=20
 	/* We don't want _any_ interrupts other than
-	 * match20. Otherwise our calibrate_delay()
+	 * match20. Otherwise our au1000_calibrate_delay()
 	 * calculation will be off, potentially a lot.
 	 */
 	intc0_mask =3D save_local_and_disable(0);
 	intc1_mask =3D save_local_and_disable(1);
 	local_enable_irq(AU1000_TOY_MATCH2_INT);
 	spin_unlock_irqrestore(&pm_lock, flags);
-	calibrate_delay();
+	au1000_calibrate_delay();
 	restore_local_and_enable(0, intc0_mask);
 	restore_local_and_enable(1, intc1_mask);
 	return retval;
@@ -455,7 +457,7 @@
    better than 1% */
 #define LPS_PREC 8
=20
-static void calibrate_delay(void)
+static void au1000_calibrate_delay(void)
 {
 	unsigned long ticks, loopbit;
 	int lps_precision =3D LPS_PREC;
Index: arch/mips/au1000/common/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/develop/cvs_private/linux-mips-exadron/arch/mips/au1000/com=
mon/time.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- a/arch/mips/au1000/common/time.c	2 Jul 2005 06:45:44 -0000	1.1.1.1
+++ b/arch/mips/au1000/common/time.c	18 Jul 2005 17:16:57 -0000	1.2
@@ -63,8 +63,11 @@
 static unsigned int timerhi =3D 0, timerlo =3D 0;
=20
 #ifdef CONFIG_PM
-#define MATCH20_INC 328
-extern void startup_match20_interrupt(void (*handler)(int, void *, struct =
pt_regs *));
+#if HZ < 100 || HZ > 1000
+#error "unsupported HZ value! Must be in [100,1000]"
+#endif
+#define MATCH20_INC (328*100/HZ) /* magic number 328 is for HZ=3D100... */
+extern void startup_match20_interrupt(irqreturn_t (*handler)(int, void *, =
struct pt_regs *));
 static unsigned long last_pc0, last_match20;
 #endif
=20
@@ -116,17 +119,16 @@
 }
=20
 #ifdef CONFIG_PM
-void counter0_irq(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t counter0_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long pc0;
 	int time_elapsed;
 	static int jiffie_drift =3D 0;
=20
-	kstat.irqs[0][irq]++;
 	if (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20) {
 		/* should never happen! */
-		printk(KERN_WARNING "counter 0 w status eror\n");
-		return;
+		printk(KERN_WARNING "counter 0 w status error\n");
+		return IRQ_NONE;
 	}
=20
 	pc0 =3D au_readl(SYS_TOYREAD);
@@ -163,6 +165,8 @@
 		update_process_times(user_mode(regs));
 #endif
 	}
+
+	return IRQ_HANDLED;
 }
=20
 /* When we wakeup from sleep, we have to "catch up" on all of the
@@ -439,7 +443,7 @@
 		au_sync();
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
=20
-		/* setup match20 to interrupt once every 10ms */
+		/* setup match20 to interrupt once every HZ */
 		last_pc0 =3D last_match20 =3D au_readl(SYS_TOYREAD);
 		au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
 		au_sync();

--+xNpyl7Qekk2NvDX--

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC2+dMQaTCYNJaVjMRAvCOAKDfiTuP5gvNW0F5q3SO+CEOSkc9uQCeND4m
i9WZ9oG6QBf0IiirzQWwYMg=
=9+GP
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
