Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 15:39:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48099 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6831903Ab3FZNjlTnVri (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 15:39:41 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QDdRdi005754;
        Wed, 26 Jun 2013 15:39:27 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QDdCYa005753;
        Wed, 26 Jun 2013 15:39:12 +0200
Date:   Wed, 26 Jun 2013 15:39:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, tj@kernel.org,
        oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au,
        mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org,
        walken@google.com, vincent.guittot@linaro.org,
        laijs@cn.fujitsu.com, rostedt@goodmis.org,
        wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com,
        sbw@mit.edu, fweisbec@gmail.com, zhong@linux.vnet.ibm.com,
        nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Yong Zhang <yong.zhang0@gmail.com>,
        Sanjay Lal <sanjayl@kymasys.com>,
        "Steven J. Hill" <sjhill@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 38/45] MIPS: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Message-ID: <20130626133912.GA4559@linux-mips.org>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625203257.16593.15358.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130625203257.16593.15358.stgit@srivatsabhat.in.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Jun 26, 2013 at 02:02:57AM +0530, Srivatsa S. Bhat wrote:

> Once stop_machine() is gone from the CPU offline path, we won't be able
> to depend on disabling preemption to prevent CPUs from going offline
> from under us.
> 
> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
> offline, while invoking from atomic context.

I think the same change also needs to be applied to r4k_on_each_cpu() in
arch/mips/mm/c-r4k.c which currently looks like:

static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
{
        preempt_disable();

#if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
        smp_call_function(func, info, 1);
#endif
        func(info);
        preempt_enable();
}

This is a slightly specialized version of on_each_cpu() which only calls
out to other CPUs in actual multi-core environments and also - unlike
on_each_cpu() doesn't disable interrupts for the sake of better
interrupt latencies.

Which reminds me ...

Andrew, I was wondering why did 78eef01b0fae087c5fadbd85dd4fe2918c3a015f
[[PATCH] on_each_cpu(): disable local interrupts] disable interrupts?
The log is:

----- snip -----
    When on_each_cpu() runs the callback on other CPUs, it runs with local
    interrupts disabled.  So we should run the function with local interrupts
    disabled on this CPU, too.
    
    And do the same for UP, so the callback is run in the same environment on bo
    UP and SMP.  (strictly it should do preempt_disable() too, but I think
    local_irq_disable is sufficiently equivalent).
[...]
----- snip -----

I'm not entirely convinced the symmetry between UP and SMP environments is
really worth it.  Would anybody mind removing the local_irq_disable() ...
local_irq_enable() from on_each_cpu()?

  Ralf
