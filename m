Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2012 16:00:48 +0200 (CEST)
Received: from 204.208.187.81.in-addr.arpa ([81.187.208.204]:45280 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1903664Ab2DPOAo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2012 16:00:44 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q3GE0fEf002958;
        Mon, 16 Apr 2012 16:00:41 +0200
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q3GE0enC002957;
        Mon, 16 Apr 2012 16:00:40 +0200
Date:   Mon, 16 Apr 2012 16:00:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Yong Zhang <yong.zhang0@gmail.com>, linux-mips@linux-mips.org
Subject: Any NXP PNX user left (was: Re: pnx_clocksource broken?)
Message-ID: <20120416140040.GA2378@linux-mips.org>
References: <4F84E531.3010001@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F84E531.3010001@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Apr 10, 2012 at 06:58:09PM -0700, John Stultz wrote:

> Looking at arch/mips/pnx8550/common/time.c the pnx_clocksource never
> seems to be assigned a mult/shift value before it calls
> clocksource_register(). Clearly this is broken and I suspect this
> clocksource is never used.
> 
> I was hoping to convert this driver over (its the last of 3
> remaining) to use clocksource_register_hz/khz() but I'm not sure
> what the actual frequency of the hardware should be. Is
> mips_hpt_frequency the right value here?
> 
> Even so, if this is clocksource is never used, should it just be removed?

Iow PNX has not had a functioning clocksource for a very long time.  Equally
there has not been any user feedback for ages and I wonder if that makes the
PNX code a candidate for removal.

Any remaining PNX users should raise their voice now or PNX will be
toast.  Soon.

  Ralf
