Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 14:43:37 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:53805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992540AbdJSMna7K5Cf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 14:43:30 +0200
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1e5AAU-0007SL-4i; Thu, 19 Oct 2017 14:43:22 +0200
Date:   Thu, 19 Oct 2017 14:43:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Redfearn <matt.redfearn@mips.com>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clockevents: Retry programming min delta up to 10
 times
In-Reply-To: <1508414135-29123-1-git-send-email-matt.redfearn@mips.com>
Message-ID: <alpine.DEB.2.20.1710191435280.1971@nanos>
References: <1508414135-29123-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60466
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

On Thu, 19 Oct 2017, Matt Redfearn wrote:
>  	unsigned long long clc;
>  	int64_t delta;
> +	int i;
>  
> -	delta = dev->min_delta_ns;
> -	dev->next_event = ktime_add_ns(ktime_get(), delta);
> +	for (i = 0;;) {

Bah. What's wrong with

	for (i = 0; i < 10; i++) {

	    	....
		if (!(dev->set_next_event((unsigned long) clc, dev))
			return 0;
	}
	return -ETIME;

Hmm?

> +		delta = dev->min_delta_ns;
> +		dev->next_event = ktime_add_ns(ktime_get(), delta);
>  
> -	if (clockevent_state_shutdown(dev))
> -		return 0;
> +		if (clockevent_state_shutdown(dev))
> +			return 0;
>  
> -	dev->retries++;
> -	clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
> -	return dev->set_next_event((unsigned long) clc, dev);
> +		dev->retries++;
> +		clc = ((unsigned long long) delta * dev->mult) >> dev->shift;

I'd rather make that:

	delta = 0;
	for (i = 0; i < 10; i++) {
		delta += dev->min_delta_ns;
		dev->next_event = ktime_add_ns(ktime_get(), delta);
		clc = .....
	   	.....

That makes it more likely to succeed fast. Hmm?

Thanks,

	tglx
