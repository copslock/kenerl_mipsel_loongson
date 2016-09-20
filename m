Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 11:42:50 +0200 (CEST)
Received: from Galois.linutronix.de ([146.0.238.70]:49129 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991984AbcITJmnsgmLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 11:42:43 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1bmHZY-0001M5-JF; Tue, 20 Sep 2016 11:42:40 +0200
Date:   Tue, 20 Sep 2016 11:40:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, linux-mips@linux-mips.org,
        linux-remoteproc@vger.kernel.org, lisa.parratt@imgtec.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 1/6] irqchip: mips-gic: Add context saving for
 MIPS_REMOTEPROC
In-Reply-To: <1474361249-31064-2-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.20.1609201139130.6905@nanos>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com> <1474361249-31064-2-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Tue, 20 Sep 2016, Matt Redfearn wrote:
> +/*
> + * The MIPS remote processor driver allows non-Linux firmware to take control
> + * of and execute on one of the systems VPEs. If that VPE is brought back under
> + * Linux, it is necessary to ensure that all GIC interrupts are routed and
> + * masked as Linux expects them, as the firmware can have done anything it
> + * likes with the GIC configuration (hopefully just for that VPEs local
> + * interrupt sources, but allow for shared external interrupts as well).
> + */
> +static int gic_cpu_notify(struct notifier_block *nfb, unsigned long action,
> +			       void *hcpu)
> +{
> +	unsigned int cpu = mips_cm_vp_id((unsigned long)hcpu);
> +
> +	switch (action) {
> +	case CPU_UP_PREPARE:
> +	case CPU_DOWN_FAILED:
> +		gic_restore_shared();
> +		gic_restore_local(cpu);
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}

Please use the new state machine based infrastructure.

Thanks,

	tglx
