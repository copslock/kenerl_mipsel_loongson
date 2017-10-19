Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 16:12:29 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:54300 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992618AbdJSOMTPvHfJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 16:12:19 +0200
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1e5BYP-0000vc-Nl; Thu, 19 Oct 2017 16:12:09 +0200
Date:   Thu, 19 Oct 2017 16:12:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, dianders@chromium.org,
        James Hogan <james.hogan@imgtec.com>,
        Brian Norris <briannorris@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>, jeffy.chen@rock-chips.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        tfiga@chromium.org
Subject: Re: [RFC PATCH v1 6/9] MIPS: perf: percpu_devid interrupt support
In-Reply-To: <20170907232542.20589-7-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.20.1710191609480.1971@nanos>
References: <1682867.tATABVWsV9@np-p-burton> <20170907232542.20589-1-paul.burton@imgtec.com> <20170907232542.20589-7-paul.burton@imgtec.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60474
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

On Thu, 7 Sep 2017, Paul Burton wrote:
>  
> +static struct irqaction c0_perf_irqaction = {
> +	.handler = mipsxx_pmu_handle_irq,
> +	.flags = IRQF_PERCPU | IRQF_TIMER | IRQF_SHARED | IRQF_NOAUTOEN,
> +	.name = "mips_perf_pmu",
> +	.percpu_dev_id = &mipspmu,
> +};
> +
>  static int mipspmu_get_irq(void)
>  {
> -	int err;
> +	if (irq_is_percpu_devid(mipspmu.irq))
> +		return setup_percpu_irq(mipspmu.irq, &c0_perf_irqaction);
>  
> -	err = request_irq(mipspmu.irq, mipsxx_pmu_handle_irq,
> -			  IRQF_PERCPU | IRQF_NOBALANCING |
> -			  IRQF_NO_THREAD | IRQF_NO_SUSPEND |
> -			  IRQF_SHARED,
> -			  "mips_perf_pmu", &mipspmu);
> -	if (err)
> -		pr_warn("Unable to request IRQ%d for MIPS performance counters!\n",
> -			mipspmu.irq);
> -	return err;
> +	return setup_irq(mipspmu.irq, &c0_perf_irqaction);

request_irq() is really preferred over setup_irq(). setup_irq() exists for
historical reasons because back in the days the allocators were not working
when early interrupts got initialized. Today that's a non issue, but I
never got around to remove the setup_irq() cruft.

Thanks,

	tglx
