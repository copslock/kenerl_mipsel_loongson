Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 16:27:28 +0200 (CEST)
Received: from Galois.linutronix.de ([146.0.238.70]:58714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992028AbcIGO1VVNWRb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 16:27:21 +0200
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1bhdom-0002jl-Cs; Wed, 07 Sep 2016 16:27:12 +0200
Date:   Wed, 7 Sep 2016 16:27:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, rt@linutronix.de,
        tglx@linutronix.de, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 15/21] mips: octeon: smp: Convert to hotplug state machine
Message-ID: <20160907142712.rr34s2c6xiwcrjaz@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
 <20160906170457.32393-16-bigeasy@linutronix.de>
 <6ef2674b-aca6-f45f-03b2-ec9aa9a5bf91@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ef2674b-aca6-f45f-03b2-ec9aa9a5bf91@imgtec.com>
User-Agent: NeoMutt/ (1.7.0)
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bigeasy@linutronix.de
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

On 2016-09-07 09:24:57 [+0100], Matt Redfearn wrote:
> HI Sebastian,
Hi Matt,

> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -44,6 +44,7 @@ enum cpuhp_state {
> >   	CPUHP_SH_SH3X_PREPARE,
> >   	CPUHP_X86_MICRCODE_PREPARE,
> >   	CPUHP_NOTF_ERR_INJ_PREPARE,
> > +	CPUHP_MIPS_CAVIUM_PREPARE,
> 
> But I'm curious why we have to create a new state here - this is going to
> get very unwieldy if every variant of every architecture has to have it's
> own state values in that enumeration. Can this use, what I assume is (and
> perhaps could be documented better in include/linux/cpuhotplug.h), the
> generic prepare state CPUHP_NOTIFY_PREPARE?

We can't share the states - one state is for one callback and one
callback only. If you want CPUHP_MIPS_PREPARE and you ensure that this
used only _once_ then this can be arranged.
For online states we have dynamic allocation of ids (which is what most
drivers should use). We don't have this of STARTING + PREPARE callbacks.

> Thanks,
> Matt
> 

Sebastian
