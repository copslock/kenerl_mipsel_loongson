Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 09:12:07 +0200 (CEST)
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:49405 "EHLO
        e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824764Ab3F0HMC37uNS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jun 2013 09:12:02 +0200
Received: from /spool/local
        by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
        Thu, 27 Jun 2013 12:33:54 +0530
Received: from d28dlp02.in.ibm.com (9.184.220.127)
        by e28smtp02.in.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 27 Jun 2013 12:33:51 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
        by d28dlp02.in.ibm.com (Postfix) with ESMTP id ECDCD394005B;
        Thu, 27 Jun 2013 12:41:48 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
        by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r5R7C9P426542326;
        Thu, 27 Jun 2013 12:42:10 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
        by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r5R7BkQb032588;
        Thu, 27 Jun 2013 07:11:48 GMT
Received: from srivatsabhat.in.ibm.com ([9.79.176.128])
        by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id r5R7BjDU032481;
        Thu, 27 Jun 2013 07:11:45 GMT
Message-ID: <51CBE4EF.5040302@linux.vnet.ibm.com>
Date:   Thu, 27 Jun 2013 12:38:31 +0530
From:   "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     tglx@linutronix.de, peterz@infradead.org, tj@kernel.org,
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
Subject: Re: [PATCH v2 38/45] MIPS: Use get/put_online_cpus_atomic() to prevent
 CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com> <20130625203257.16593.15358.stgit@srivatsabhat.in.ibm.com> <20130626133912.GA4559@linux-mips.org>
In-Reply-To: <20130626133912.GA4559@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: No
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13062707-5816-0000-0000-000008A64A51
Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srivatsa.bhat@linux.vnet.ibm.com
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

On 06/26/2013 07:09 PM, Ralf Baechle wrote:
> On Wed, Jun 26, 2013 at 02:02:57AM +0530, Srivatsa S. Bhat wrote:
> 
>> Once stop_machine() is gone from the CPU offline path, we won't be able
>> to depend on disabling preemption to prevent CPUs from going offline
>> from under us.
>>
>> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
>> offline, while invoking from atomic context.
> 
> I think the same change also needs to be applied to r4k_on_each_cpu() in
> arch/mips/mm/c-r4k.c which currently looks like:
> 
> static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
> {
>         preempt_disable();
> 
> #if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
>         smp_call_function(func, info, 1);
> #endif
>         func(info);
>         preempt_enable();
> }
> 

Thanks for pointing this out! I'll include changes to this code in my
next version.

Regards,
Srivatsa S. Bhat

> This is a slightly specialized version of on_each_cpu() which only calls
> out to other CPUs in actual multi-core environments and also - unlike
> on_each_cpu() doesn't disable interrupts for the sake of better
> interrupt latencies.
> 
> Which reminds me ...
> 
> Andrew, I was wondering why did 78eef01b0fae087c5fadbd85dd4fe2918c3a015f
> [[PATCH] on_each_cpu(): disable local interrupts] disable interrupts?
> The log is:
> 
> ----- snip -----
>     When on_each_cpu() runs the callback on other CPUs, it runs with local
>     interrupts disabled.  So we should run the function with local interrupts
>     disabled on this CPU, too.
>     
>     And do the same for UP, so the callback is run in the same environment on bo
>     UP and SMP.  (strictly it should do preempt_disable() too, but I think
>     local_irq_disable is sufficiently equivalent).
> [...]
> ----- snip -----
> 
> I'm not entirely convinced the symmetry between UP and SMP environments is
> really worth it.  Would anybody mind removing the local_irq_disable() ...
> local_irq_enable() from on_each_cpu()?
> 
