Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4DIKenC006534
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 13 May 2002 11:20:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4DIKeW1006533
	for linux-mips-outgoing; Mon, 13 May 2002 11:20:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4DIK5nC006521
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 11:20:05 -0700
Received: from lahoo.mshome.net (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA03874
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 07:33:12 -0700 (PDT)
	mail_from (brad@ltc.com)
Received: from prefect.mshome.net ([192.168.0.76] helo=prefect)
	by lahoo.mshome.net with smtp (Exim 3.12 #1 (Debian))
	id 177Gl1-0000MI-00
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 10:24:59 -0400
Message-ID: <006c01c1fa8a$68ad1910$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <linux-mips@oss.sgi.com>
Subject: Fw: Mips scalibility problems & softirq.c improvments
Date: Mon, 13 May 2002 10:28:10 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0069_01C1FA68.E14F06C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0069_01C1FA68.E14F06C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

----- Original Message -----
From: "D.J. Barrow" <barrow_dj@yahoo.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>; "Netfilter"
<netfilter-devel@lists.samba.org>
Sent: Monday, May 13, 2002 6:12 AM
Subject: Mips scalibility problems & softirq.c improvments


> Hi,
> While testing the SMP performance of iptables with a lot of rules on a
mips based cpu,
> I found that the SMP performance was 40% lower on 2 cpus than 1 cpu.
>
> There is a number of reasons for this the primary being that the rules
were bigger
> than the shared L2 cache, little enough can be done about this.
>
> The second is that interrupts are on every mips port I bothered checking
> are only delivered on cpu 0 ( this is really pathetic ).
>
>
> See the code that prints /proc/interrupts in arch/mips/kernel/irq.c
> int get_irq_list(char *buf)
> {
> struct irqaction * action;
> char *p = buf;
> int i;
>
> p += sprintf(p, "           ");
> for (i=0; i < 1 /*smp_num_cpus*/; i++)
>
> Need I say more.....
>
> As softirqs are usually bound to the same
> cpu that start the softirqs softirqs performs really really badly,
> also the fact that the softirq.c code checks in_interrupt on
> entry means that it frequently does a quick exit.
>
>
> I also will be providing a patch I developed to the developers of a mips
based
> system on chip which distributes the irqs over all cpus using 2 polices
> even interrupts to cpu 0 odd interrupts to cpu 1 or leaving the interrupts
> enter in all cpus & only call do_IRQ on the cpu with the lowest
local_irq_count
>  & local_bh_count this should cause softirqs to perform will on this
> system anyway.
>
>
> I've provided a small patch to irq.c which fixes /proc/interrupts in
2.4.18 mips32
> hopefully somebody will be kind enough to fix up the 64 bit &
> the latest stuff in mips64 & the latest oss.sgi.com cvs trees.
>
> --- linux.orig/arch/mips/kernel/irq.c   Sun Sep  9 18:43:01 2001
> +++ linux/arch/mips/kernel/irq.c        Mon May 13 10:34:15 2002
> @@ -71,13 +71,13 @@
>
>  int get_irq_list(char *buf)
>  {
> +       int i, j;
>         struct irqaction * action;
>         char *p = buf;
> -       int i;
>
>         p += sprintf(p, "           ");
> -       for (i=0; i < 1 /*smp_num_cpus*/; i++)
> -               p += sprintf(p, "CPU%d       ", i);
> +       for (j=0; j<smp_num_cpus; j++)
> +               p += sprintf(p, "CPU%d       ",j);
>         *p++ = '\n';
>
>         for (i = 0 ; i < NR_IRQS ; i++) {
> @@ -85,7 +85,13 @@
>                 if (!action)
>                         continue;
>                 p += sprintf(p, "%3d: ",i);
> +#ifndef CONFIG_SMP
>                 p += sprintf(p, "%10u ", kstat_irqs(i));
> +#else
> +               for (j = 0; j < smp_num_cpus; j++)
> +                       p += sprintf(p, "%10u ",
> +                               kstat.irqs[cpu_logical_map(j)][i]);
> +#endif
>                 p += sprintf(p, " %14s", irq_desc[i].handler->typename);
>                 p += sprintf(p, "  %s", action->name);
>
> @@ -93,7 +99,7 @@
>                         p += sprintf(p, ", %s", action->name);
>                 *p++ = '\n';
>         }
> -       p += sprintf(p, "ERR: %10lu\n", irq_err_count);
> +       p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
>         return p - buf;
>  }
>
>
>
> I also provide a small patch for softirq.c which makes sure the
> the softirqs stay running if in cpu_idle & no reschedule is pending.
> This improves softirq.c performance a small bit as it usually exits
> after calling each softirq once rather than staying in the loop
> if it has nothing better to do.
>
> --- linux.old/kernel/softirq.c  Tue Jan 15 04:13:43 2002
> +++ linux.new/kernel/softirq.c  Thu May  9 12:36:46 2002
> @@ -95,7 +95,8 @@
>                 local_irq_disable();
>
>                 pending = softirq_pending(cpu);
> -               if (pending & mask) {
> +               if ((pending && current==idle_task(cpu) &&
!current->need_resched )
> +                   || (pending & mask) ) {
>                         mask &= ~pending;
>                         goto restart;
>                 }
> diff -u -r linux.old/include/linux/sched.h linux.new/include/linux/sched.h
> --- linux.old/include/linux/sched.h     Thu May  9 18:08:42 2002
> +++ linux.new/include/linux/sched.h     Thu May  9 10:30:34 2002
> @@ -936,6 +936,19 @@
>         return res;
>  }
>
> +#ifdef CONFIG_SMP
> +
> +#define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
> +#define can_schedule(p,cpu) \
> +       ((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
> +
> +#else
> +
> +#define idle_task(cpu) (&init_task)
> +#define can_schedule(p,cpu) (1)
> +
> +#endif
> +
>  #endif /* __KERNEL__ */
>
>  #endif
>
> diff -u -r linux.old/kernel/sched.c linux.new/kernel/sched.c
> --- linux.old/kernel/sched.c    Wed May  1 10:40:26 2002
> +++ linux.new/kernel/sched.c    Thu May  9 10:30:26 2002
> @@ -112,18 +112,7 @@
>  struct kernel_stat kstat;
>  extern struct task_struct *child_reaper;
>
> -#ifdef CONFIG_SMP
>
> -#define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
> -#define can_schedule(p,cpu) \
> -       ((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
> -
> -#else
> -
> -#define idle_task(cpu) (&init_task)
> -#define can_schedule(p,cpu) (1)
> -
> -#endif
>
>  void scheduling_functions_start_here(void) { }
>
>
> Also find the patches sent as attachments.
>
>
> =====
> D.J. Barrow Linux kernel developer
> eMail: dj_barrow@ariasoft.ie
> Home: +353-22-47196.
> Work: +353-91-758353
>
> __________________________________________________
> Do You Yahoo!?
> LAUNCH - Your Yahoo! Music Experience
> http://launch.yahoo.com

------=_NextPart_000_0069_01C1FA68.E14F06C0
Content-Type: application/octet-stream;
	name="softirq_fix.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="softirq_fix.diff"

--- linux.old/kernel/softirq.c	Tue Jan 15 04:13:43 2002=0A=
+++ linux.new/kernel/softirq.c	Thu May  9 12:36:46 2002=0A=
@@ -95,7 +95,8 @@=0A=
 		local_irq_disable();=0A=
 =0A=
 		pending =3D softirq_pending(cpu);=0A=
-		if (pending & mask) {=0A=
+		if ((pending && current=3D=3Didle_task(cpu) && !current->need_resched =
)=0A=
+		    || (pending & mask) ) {=0A=
 			mask &=3D ~pending;=0A=
 			goto restart;=0A=
 		}=0A=
diff -u -r linux.old/include/linux/sched.h =
linux.new/include/linux/sched.h=0A=
--- linux.old/include/linux/sched.h	Thu May  9 18:08:42 2002=0A=
+++ linux.new/include/linux/sched.h	Thu May  9 10:30:34 2002=0A=
@@ -936,6 +936,19 @@=0A=
 	return res;=0A=
 }=0A=
 =0A=
+#ifdef CONFIG_SMP=0A=
+=0A=
+#define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])=0A=
+#define can_schedule(p,cpu) \=0A=
+	((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))=0A=
+=0A=
+#else=0A=
+=0A=
+#define idle_task(cpu) (&init_task)=0A=
+#define can_schedule(p,cpu) (1)=0A=
+=0A=
+#endif=0A=
+=0A=
 #endif /* __KERNEL__ */=0A=
 =0A=
 #endif=0A=
=0A=
diff -u -r linux.old/kernel/sched.c linux.new/kernel/sched.c=0A=
--- linux.old/kernel/sched.c	Wed May  1 10:40:26 2002=0A=
+++ linux.new/kernel/sched.c	Thu May  9 10:30:26 2002=0A=
@@ -112,18 +112,7 @@=0A=
 struct kernel_stat kstat;=0A=
 extern struct task_struct *child_reaper;=0A=
 =0A=
-#ifdef CONFIG_SMP=0A=
 =0A=
-#define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])=0A=
-#define can_schedule(p,cpu) \=0A=
-	((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))=0A=
-=0A=
-#else=0A=
-=0A=
-#define idle_task(cpu) (&init_task)=0A=
-#define can_schedule(p,cpu) (1)=0A=
-=0A=
-#endif=0A=
 =0A=
 void scheduling_functions_start_here(void) { }=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

------=_NextPart_000_0069_01C1FA68.E14F06C0
Content-Type: application/octet-stream;
	name="mips32_irq.c_fix.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mips32_irq.c_fix.diff"

--- linux.orig/arch/mips/kernel/irq.c	Sun Sep  9 18:43:01 2001=0A=
+++ linux/arch/mips/kernel/irq.c	Mon May 13 10:34:15 2002=0A=
@@ -71,13 +71,13 @@=0A=
 =0A=
 int get_irq_list(char *buf)=0A=
 {=0A=
+	int i, j;=0A=
 	struct irqaction * action;=0A=
 	char *p =3D buf;=0A=
-	int i;=0A=
 =0A=
 	p +=3D sprintf(p, "           ");=0A=
-	for (i=3D0; i < 1 /*smp_num_cpus*/; i++)=0A=
-		p +=3D sprintf(p, "CPU%d       ", i);=0A=
+	for (j=3D0; j<smp_num_cpus; j++)=0A=
+		p +=3D sprintf(p, "CPU%d       ",j);=0A=
 	*p++ =3D '\n';=0A=
 =0A=
 	for (i =3D 0 ; i < NR_IRQS ; i++) {=0A=
@@ -85,7 +85,13 @@=0A=
 		if (!action) =0A=
 			continue;=0A=
 		p +=3D sprintf(p, "%3d: ",i);=0A=
+#ifndef CONFIG_SMP=0A=
 		p +=3D sprintf(p, "%10u ", kstat_irqs(i));=0A=
+#else=0A=
+		for (j =3D 0; j < smp_num_cpus; j++)=0A=
+			p +=3D sprintf(p, "%10u ",=0A=
+				kstat.irqs[cpu_logical_map(j)][i]);=0A=
+#endif=0A=
 		p +=3D sprintf(p, " %14s", irq_desc[i].handler->typename);=0A=
 		p +=3D sprintf(p, "  %s", action->name);=0A=
 =0A=
@@ -93,7 +99,7 @@=0A=
 			p +=3D sprintf(p, ", %s", action->name);=0A=
 		*p++ =3D '\n';=0A=
 	}=0A=
-	p +=3D sprintf(p, "ERR: %10lu\n", irq_err_count);=0A=
+	p +=3D sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));=0A=
 	return p - buf;=0A=
 }=0A=
 =0A=

------=_NextPart_000_0069_01C1FA68.E14F06C0--
