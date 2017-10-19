Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 15:29:36 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:54133 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990392AbdJSN3aZGNbJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 15:29:30 +0200
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1e5At3-0008BA-E1; Thu, 19 Oct 2017 15:29:25 +0200
Date:   Thu, 19 Oct 2017 15:29:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Redfearn <matt.redfearn@mips.com>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clockevents: Retry programming min delta up to 10
 times
In-Reply-To: <5b782526-b130-77f2-6d9a-15839e12e065@mips.com>
Message-ID: <alpine.DEB.2.20.1710191527570.1971@nanos>
References: <1508414135-29123-1-git-send-email-matt.redfearn@mips.com> <alpine.DEB.2.20.1710191435280.1971@nanos> <5b782526-b130-77f2-6d9a-15839e12e065@mips.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60469
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
> On 19/10/17 13:43, Thomas Gleixner wrote:
> > 	delta = 0;
> > 	for (i = 0; i < 10; i++) {
> > 		delta += dev->min_delta_ns;
> > 		dev->next_event = ktime_add_ns(ktime_get(), delta);
> > 		clc = .....
> > 	   	.....
> > 
> > That makes it more likely to succeed fast. Hmm?
> 
> That will set the target time to increasing multiples of min_delta_ns in the
> future, right?

Yes, but without fiddling with min_delta_ns itself.

> Sure, it should make it succeed faster - I'll make it like
> that. Are you OK with the arbitrarily chosen 10 retries?

I lost my crystalball so I have to trust yours :)

Thanks,

	tglx
