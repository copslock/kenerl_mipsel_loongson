Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 00:04:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40556 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491128Ab1AXXEo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 00:04:44 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0ON3ous013487;
        Tue, 25 Jan 2011 00:03:50 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0ON3QSm013467;
        Tue, 25 Jan 2011 00:03:26 +0100
Date:   Tue, 25 Jan 2011 00:03:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
Message-ID: <20110124230326.GA9121@linux-mips.org>
References: <1295262433.30950.53.camel@laptop>
 <20110117112637.GA18599@n2100.arm.linux.org.uk>
 <1295263884.30950.54.camel@laptop>
 <1295264509.30950.59.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295264509.30950.59.camel@laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2011 at 12:41:49PM +0100, Peter Zijlstra wrote:

> I visited existing smp_send_reschedule() implementations and tried to
> add a call to scheduler_ipi() in their handler part, but esp. for MIPS
> I'm not quite sure I actually got all of them.

No, you didn't.  Here are a few more for you to fold into the existing patch.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/cavium-octeon/smp.c       |    2 ++
 arch/mips/mti-malta/malta-int.c     |    2 ++
 arch/mips/pmc-sierra/yosemite/smp.c |    4 ++++
 arch/mips/sgi-ip27/ip27-irq.c       |    2 ++
 4 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 391cefe..170684a 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -44,6 +44,8 @@ static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
 
 	if (action & SMP_CALL_FUNCTION)
 		smp_call_function_interrupt();
+	if (action & SMP_RESCHEDULE_YOURSELF)
+		scheduler_ipi();
 
 	/* Check if we've been told to flush the icache */
 	if (action & SMP_ICACHE_FLUSH)
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index b79b24a..fc7571f 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -309,6 +309,8 @@ static void ipi_call_dispatch(void)
 
 static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 {
+	scheduler_ipi();
+
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/mips/pmc-sierra/yosemite/smp.c b/arch/mips/pmc-sierra/yosemite/smp.c
index efc9e88..2608752 100644
--- a/arch/mips/pmc-sierra/yosemite/smp.c
+++ b/arch/mips/pmc-sierra/yosemite/smp.c
@@ -55,6 +55,8 @@ void titan_mailbox_irq(void)
 
 		if (status & 0x2)
 			smp_call_function_interrupt();
+		if (status & 0x4)
+			scheduler_ipi();
 		break;
 
 	case 1:
@@ -63,6 +65,8 @@ void titan_mailbox_irq(void)
 
 		if (status & 0x2)
 			smp_call_function_interrupt();
+		if (status & 0x4)
+			scheduler_ipi();
 		break;
 	}
 }
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 6a123ea..81d6548 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -147,8 +147,10 @@ static void ip27_do_irq_mask0(void)
 #ifdef CONFIG_SMP
 	if (pend0 & (1UL << CPU_RESCHED_A_IRQ)) {
 		LOCAL_HUB_CLR_INTR(CPU_RESCHED_A_IRQ);
+		scheduler_ipi();
 	} else if (pend0 & (1UL << CPU_RESCHED_B_IRQ)) {
 		LOCAL_HUB_CLR_INTR(CPU_RESCHED_B_IRQ);
+		scheduler_ipi();
 	} else if (pend0 & (1UL << CPU_CALL_A_IRQ)) {
 		LOCAL_HUB_CLR_INTR(CPU_CALL_A_IRQ);
 		smp_call_function_interrupt();
