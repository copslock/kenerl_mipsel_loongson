Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2016 03:13:30 +0200 (CEST)
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:49155 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbcHWBNXgw0cZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2016 03:13:23 +0200
X-MHO-User: cd7ff8ea-68ce-11e6-b68f-d7e0fd28072a
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.99.77.15
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.99.77.15])
        by outbound1.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Tue, 23 Aug 2016 01:13:29 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 86D5680336;
        Tue, 23 Aug 2016 01:13:17 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 86D5680336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1471914797;
        bh=qQPpiK3qu0cAXd/9MxG1TGDauZWIrr1OTxzOtmZZJQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FQBmXgAkO7NGaFGBvfPiyYXckSxPqFwY2gs3T32sSf7fihYZ1p7/JZhQariYZ9mz9
         WQiD1nVq27Os05o2gvH7Gfny6WxK4WDoZfvpX9UfGPV8HLY+g1hkJRojXJNiIZlpQJ
         aSZDfci4niY4/fGxRzbR91NwYQotonOdEgQkfPAf4VyvBShaF6HfLqIRdcULeqT+LM
         fYvZgprhk7yBa+kps5c42KP0ZNm3D0JfpaXy4cMxlCo1ikF2OhTIc8VhBcnG7flJp7
         ExmlEtZ+vysYCd/DuAv4mfn8UHVhFjWinzYYFo+AHY0fX7R0YpPhGLeYtZ/FpMUreG
         zn8qYlrp2X/Rw==
Date:   Tue, 23 Aug 2016 01:13:17 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] irqchip: mips-gic: Use for_each_set_bit to iterate over
 IRQs
Message-ID: <20160823011317.GV3353@io.lakedaemon.net>
References: <20160819171119.28121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160819171119.28121-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Hi Paul,

On Fri, Aug 19, 2016 at 06:11:19PM +0100, Paul Burton wrote:
> The MIPS GIC driver has previously iterated over bits set in a bitmap
> representing pending IRQs by calling find_first_bit, clearing that bit
> then calling find_first_bit again until all bits are clear. If multiple
> interrupts are pending then this is wasteful, as find_first_bit will
> have to loop over the whole bitmap from the start. Use the
> for_each_set_bit macro which performs exactly what we need here instead.
> It will use find_next_bit and thus only scan over the relevant part of
> the bitmap, and it makes the intent of the code clearer.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>  drivers/irqchip/irq-mips-gic.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied to irqchip/core.

thx,

Jason.
