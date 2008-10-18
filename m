Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Oct 2008 13:44:03 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:3041 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21784969AbYJRMoA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Oct 2008 13:44:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9IChx5E011853;
	Sat, 18 Oct 2008 13:43:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9IChxtF011851;
	Sat, 18 Oct 2008 13:43:59 +0100
Date:	Sat, 18 Oct 2008 13:43:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Anirban Sinha <ASinha@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: stop_this_cpu - redundant code?
Message-ID: <20081018124358.GC17322@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C50130734A@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C50130734A@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 17, 2008 at 07:57:12PM -0700, Anirban Sinha wrote:

> This function  (stop_this_cpu) in /arch/mips/kernel/smp.c does a
> local_irq_enable() and the adjacent comment says that it's because it
> may need to service _machine_restart IPI. Unfortunately,
> smp_call_function only sends IPIs to cores that are still online ( it
> uses the cpu_online_map U all_but_myself_map in
> smp_call_function_map()).

Usually a system would be restarted through some hardware mechanism -
probably a reset - anyway.

> So the bottom-line is, should we still keep the local irqs enabled or is
> this code totally redundant? I have seen other similar functions in
> other archs where they actually disable the local irqs.

You're right.  The code is ancient old and once uppon a time it made sense
to do things this way but the MIPS version was never updates.  Stop_this_cpu
also should try to minimize the power consumption by using the WAIT
instruction or whatever else a particular process has to offer.

I didn't try to optimize this for the 34K where a TC could try to halt
itself - there isn't really a point, I think.

A few other architectures are explicitly disabling interrupts but that's
also redundant because smp_call_function() invokes the function on other
processors with interrupts disabled.

Thanks for posting this,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 7b59cfb..b79ea70 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -163,8 +163,10 @@ static void stop_this_cpu(void *dummy)
 	 * Remove this CPU:
 	 */
 	cpu_clear(smp_processor_id(), cpu_online_map);
-	local_irq_enable();	/* May need to service _machine_restart IPI */
-	for (;;);		/* Wait if available. */
+	for (;;) {
+		if (cpu_wait)
+			(*cpu_wait)();		/* Wait if available. */
+	}
 }
 
 void smp_send_stop(void)
