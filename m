Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 13:45:12 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8224861AbTFQMpK>; Tue, 17 Jun 2003 13:45:10 +0100
Date: Tue, 17 Jun 2003 13:45:10 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Juan Quintela <quintela@trasno.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
Message-ID: <20030617134510.B32079@ftp.linux-mips.org>
References: <20030617085346.A27590@ftp.linux-mips.org> <Pine.GSO.3.96.1030617134735.22214B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030617134735.22214B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jun 17, 2003 at 02:14:55PM +0200
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 17, 2003 at 02:14:55PM +0200, Maciej W. Rozycki wrote:
> On Tue, 17 Jun 2003, Ladislav Michl wrote:
> 
> > Idea is to have only one way for printing kernel messages. In case of Indy,
> > O2 and SNI RM200 "arc" console will do it. Here you can find where should
> > be early console initialized:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=105519188505235&w=2
> > As Juan pointed out setup for such console is actually a nop and one is
> > supposed to enable this feature only when debugging kernel. DEC prom console
> 
>  That's a valid point, as long as enabling it does not require a
> reconfiguration.
> 
> > however needs some setup to determine REX entry points. early console is
> > currently used on sh, alpha, x86_64 and ia64 architectures. Btw, see comment
> > at the top of arch/sparc/prom/printf.c
> 
>  The DEC's entry points are a part of the problem only -- to support a
> generic kernel, we need to move early_printk setup after setup_arch(), as
> the level of variation is huge then.. 

yes, you'll have to do basic setup in your setup_console function...

>  There is also that minor implementation problem -- how to pass varargs
> from printk() to ROM's printf()?  At least the firmware of the DECstation
> implements a full-featured printf() as in the C library.

you are implementing early console not printf (sorry again for confusion),
so there is no need to pass varargs anywhere. btw, early_printk() as known
from other archs is supposed to die in future. printk() should be used
everywhere.

better to show patch...
(note that setup_early_printk() will be probably called before init_arch.
how to choose right early console is still open question, but as we have
not generic kernel yet, we can use same way as we are using for choosing
proper prom_printf function. this patch was included in hope that it can
show principle nothing more...)


Index: arch/mips/kernel/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/Makefile,v
retrieving revision 1.69
diff -u -r1.69 Makefile
--- arch/mips/kernel/Makefile	13 Jun 2003 13:58:30 -0000	1.69
+++ arch/mips/kernel/Makefile	17 Jun 2003 12:33:14 -0000
@@ -43,4 +43,6 @@
 
 obj-$(CONFIG_MODULES)		+= module.o
 
+obj-$(CONFIG_EARLY_PRINTK)	+= earlyprintk.o
+
 EXTRA_AFLAGS := $(CFLAGS)
Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.147
diff -u -r1.147 setup.c
--- arch/mips/kernel/setup.c	15 Jun 2003 23:42:07 -0000	1.147
+++ arch/mips/kernel/setup.c	17 Jun 2003 12:33:15 -0000
@@ -113,6 +113,8 @@
 asmlinkage void __init
 init_arch(int argc, char **argv, char **envp, int *prom_vec)
 {
+	setup_early_printk();
+
 	/* Determine which MIPS variant we are running on. */
 	cpu_probe();
 
--- /dev/null	2003-01-06 08:25:00.000000000 +0100
+++ arch/mips/kernel/earlyprintk.c	2003-06-16 09:06:12.000000000 +0200
@@ -0,0 +1,35 @@
+#include <linux/console.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/config.h>
+
+struct console *early_console = NULL;
+
+int __init setup_early_printk(void)
+{  
+#ifdef CONFIG_ARC_CONSOLE
+	{
+		extern struct console arc_console;
+		early_console = &arc_console;
+	}
+#endif
+#ifdef CONFIG_PROM_CONSOLE
+	{
+		extern struct console prom_console;
+		early_console = &prom_console;
+	}
+#endif
+
+	register_console(early_console);
+	return 0;
+}
+
+void __init disable_early_printk(void)
+{ 
+	if (!early_console)
+		return;
+
+	printk(KERN_INFO "Disabling early console...\n");
+	unregister_console(early_console);
+} 
