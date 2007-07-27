Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2007 14:53:48 +0100 (BST)
Received: from madara.hpl.hp.com ([192.6.19.124]:56561 "EHLO madara.hpl.hp.com")
	by ftp.linux-mips.org with ESMTP id S20022084AbXG0Nxl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2007 14:53:41 +0100
Received: from masterns.hpl.hp.com (masterns.hpl.hp.com [15.0.48.4])
	by madara.hpl.hp.com (8.14.1/8.14.1/HPL-PA Relay) with ESMTP id l6RDrOFi024486;
	Fri, 27 Jul 2007 06:53:24 -0700 (PDT)
Received: from frankl.hpl.hp.com (frankl.hpl.hp.com [15.4.89.73])
	by masterns.hpl.hp.com (8.13.8/8.13.8/HPL-PA Hub) with ESMTP id l6RDrOSV012877;
	Fri, 27 Jul 2007 06:53:24 -0700
Received: from frankl.hpl.hp.com (localhost [127.0.0.1])
	by frankl.hpl.hp.com (8.12.8/8.12.8) with ESMTP id l6RDrOj8010708;
	Fri, 27 Jul 2007 06:53:24 -0700
Received: (from eranian@localhost)
	by frankl.hpl.hp.com (8.12.8/8.12.8/Submit) id l6RDrNPZ010706;
	Fri, 27 Jul 2007 06:53:23 -0700
X-Authentication-Warning: frankl.hpl.hp.com: eranian set sender to eranian@hpl.hp.com using -f
Date:	Fri, 27 Jul 2007 06:53:23 -0700
From:	Stephane Eranian <eranian@hpl.hp.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-kernel@vger.kernel.org, mucci@cs.utk.edu,
	linux-mips@linux-mips.org, ak@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH] MIPS: add smp_call_function_single()
Message-ID: <20070727135323.GF9828@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20070727124451.GC9828@frankl.hpl.hp.com> <20070727125533.GD5118@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070727125533.GD5118@linux-mips.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail:	eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From:	eranian@hpl.hp.com
Return-Path: <eranian@hpl.hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eranian@hpl.hp.com
Precedence: bulk
X-list: linux-mips

Ralf,

Here is take 2.

[MIPS] add smp_call_function_single (take 2)

signed-off-by: Stephane Eranian <eranian@hpl.hp.com>
signed-off-by: Phil Mucci <mucci@cs.utk.edu>

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index be7362b..d47234c 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -193,6 +193,53 @@ void smp_call_function_interrupt(void)
 	}
 }
 
+int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int retry,
+			     int wait)
+{
+	struct call_data_struct data;
+	int me = smp_processor_id();
+
+	/*
+	 * Can die spectacularly if this CPU isn't yet marked online
+	 */
+	BUG_ON(!cpu_online(me));
+	if (cpu == me) {
+		WARN_ON(1);
+		return -EBUSY;
+	}
+
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&smp_call_lock);
+	call_data = &data;
+	mb();
+
+	/* Send a message to the other CPU */
+	core_send_ipi(cpu, SMP_CALL_FUNCTION);
+
+	/* Wait for response */
+	/* FIXME: lock-up detection, backtrace on lock-up */
+	while (atomic_read(&data.started) != 1)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&data.finished) != 1)
+			barrier();
+	call_data = NULL;
+	spin_unlock(&smp_call_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(smp_call_function_single);
+
 static void stop_this_cpu(void *dummy)
 {
 	/*
