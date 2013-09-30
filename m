Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 21:35:17 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:47446 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823043Ab3I3TfNi4mwW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 21:35:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 04B5619BFEA;
        Mon, 30 Sep 2013 22:35:11 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 8osjCV+ja8As; Mon, 30 Sep 2013 22:35:06 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with SMTP id 021695BC005;
        Mon, 30 Sep 2013 22:35:04 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Mon, 30 Sep 2013 22:35:02 +0300
Date:   Mon, 30 Sep 2013 22:35:02 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Daney <david.daney@cavium.com>, richard@nod.at
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0 is
 special
Message-ID: <20130930193502.GE4572@blackmetal.musicnaut.iki.fi>
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
 <5249B37E.4050000@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5249B37E.4050000@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

On Mon, Sep 30, 2013 at 10:23:10AM -0700, David Daney wrote:
> On 09/28/2013 12:50 PM, Aaro Koskinen wrote:
> >Currently the driver assumes that CPU 0 is handling all the hard IRQs.
> >This is wrong in Linux SMP systems where user is allowed to assign to
> >hardware IRQs to any CPU. The driver will stop working if user sets
> >smp_affinity so that interrupts end up being handled by other than CPU
> >0. The patch fixes that.
> >
> >Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >---
> >  drivers/staging/octeon/ethernet-rx.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> >index e14a1bb..de831c1 100644
> >--- a/drivers/staging/octeon/ethernet-rx.c
> >+++ b/drivers/staging/octeon/ethernet-rx.c
> >@@ -80,6 +80,8 @@ struct cvm_oct_core_state {
> >
> >  static struct cvm_oct_core_state core_state __cacheline_aligned_in_smp;
> >
> >+static int cvm_irq_cpu = -1;
> >+
> >  static void cvm_oct_enable_napi(void *_)
> >  {
> >  	int cpu = smp_processor_id();
> >@@ -112,11 +114,7 @@ static void cvm_oct_no_more_work(void)
> >  {
> >  	int cpu = smp_processor_id();
> >
> >-	/*
> >-	 * CPU zero is special.  It always has the irq enabled when
> >-	 * waiting for incoming packets.
> >-	 */
> >-	if (cpu == 0) {
> >+	if (cpu == cvm_irq_cpu) {
> >  		enable_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group);
> >  		return;
> >  	}
> >@@ -135,6 +133,7 @@ static irqreturn_t cvm_oct_do_interrupt(int cpl, void *dev_id)
> >  {
> >  	/* Disable the IRQ and start napi_poll. */
> >  	disable_irq_nosync(OCTEON_IRQ_WORKQ0 + pow_receive_group);
> >+	cvm_irq_cpu = smp_processor_id();
> >  	cvm_oct_enable_napi(NULL);
> >
> >  	return IRQ_HANDLED;
> >@@ -547,8 +546,9 @@ void cvm_oct_rx_initialize(void)
> >  	cvmx_write_csr(CVMX_POW_WQ_INT_PC, int_pc.u64);
> >
> >
> >-	/* Scheduld NAPI now.  This will indirectly enable interrupts. */
> >+	/* Schedule NAPI now. */
> >  	cvm_oct_enable_one_cpu();
> >+	enable_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group);
> 
> The fact that you have to manually enable irqs here indicates that
> the patch is not good.
> 
> Either the enable_irq() is unnecessary, or you broke the logic for
> enabling NAPI on more than one CPU.
> 
> I am not sure which is the case, but I think it would be best if you
> supplied a fixed patch set that corrects whichever happens to be the
> case.

No, the original logic was already broken. The code assumed that the
NAPI scheduled by the driver init gets executed always on CPU 0. The
IRQ got enabled just because we are lucky.

The patch removes such assumption. During the driver init, the IRQ is
disabled and cvm_irq_cpu is -1. So when the NAPI scheduled (on whatever
CPU) by the init is done, the check in cvm_oct_no_more_work() will be
false and the IRQ remains disabled. So the init routine has to enable IRQ
"manually". This is a special case only for the driver initialization.

During the normal operation, the IRQ handler record the CPU (on which
it's going the schedule for the first NAPI poll) in cvm_irq_cpu so
cvm_oct_no_more_work() will always re-enable the IRQ correctly.

A.
