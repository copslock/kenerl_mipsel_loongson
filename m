Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 11:49:47 +0200 (CEST)
Received: from Galois.linutronix.de ([146.0.238.70]:49148 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992688AbcITJtkUFO9C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 11:49:40 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1bmHgI-0001QI-Bi; Tue, 20 Sep 2016 11:49:38 +0200
Date:   Tue, 20 Sep 2016 11:47:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, linux-mips@linux-mips.org,
        linux-remoteproc@vger.kernel.org, lisa.parratt@imgtec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] remoteproc/MIPS: Add a remoteproc driver for
 MIPS
In-Reply-To: <1474361249-31064-6-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.20.1609201141120.6905@nanos>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com> <1474361249-31064-6-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55201
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
> +/* Intercept CPU hotplug events for syfs purposes */
> +static int mips_rproc_callback(struct notifier_block *nfb, unsigned long action,
> +			       void *hcpu)
> +{

Please convert to cpu hotplug state machine.

> +	unsigned int cpu = (unsigned long)hcpu;
> +
> +	switch (action) {
> +	case CPU_UP_PREPARE:
> +	case CPU_DOWN_FAILED:
> +		mips_rproc_device_unregister(cpu);
> +		break;
> +	case CPU_DOWN_PREPARE:
> +		mips_rproc_device_register(cpu);
> +		break;
> +	}

There is no reason why you need to setup the rproc device on
DOWN_PREPARE. It's sufficient to do that when the CPU is dead, so you can
use a symetric callback prep/dead.

> +	/* Dynamically create mips-rproc class devices based on hotplug data */
> +	get_online_cpus();
> +	for_each_possible_cpu(cpu)
> +		if (!cpu_online(cpu))
> +			mips_rproc_device_register(cpu);
> +	register_hotcpu_notifier(&mips_rproc_notifier);
> +	put_online_cpus();

Perhaps we should add support for "reverse" functionality to the state
machine core. I'll have a look later how hard that'd be.

Thanks,

	tglx
