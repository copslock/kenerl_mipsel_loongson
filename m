Return-Path: <SRS0=OSiB=XS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7E8C4CEC4
	for <linux-mips@archiver.kernel.org>; Mon, 23 Sep 2019 16:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32C8217F4
	for <linux-mips@archiver.kernel.org>; Mon, 23 Sep 2019 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569257571;
	bh=0rX2u3ss+9k8U1HmW2xq32m/iZ74rLK2iPek/VwpF2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fG5mra2M3wFwAAgMOGKthJVf6R85OBFr6JOkFel+Mx2rT6ScBFmOnsma5l8+MwrOp
	 natvP3hDRCMJ5cOXfHCV4zRPfscOBxzWgZrJAKqs0B4DD5CHKIYzHB4pB1A12Vfoi6
	 6GWqSIV+cqCpYQzwWzxXDJgAYQzYSg8KSTdMq+cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbfIWQwu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:52:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387683AbfIWQwu (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 23 Sep 2019 12:52:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05249B618;
        Mon, 23 Sep 2019 16:52:44 +0000 (UTC)
Date:   Mon, 23 Sep 2019 18:52:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com,
        chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com,
        axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com,
        linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tbogendoerfer@suse.de,
        linux-mips@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190923165235.GD17206@dhcp22.suse.cz>
References: <1568724534-146242-1-git-send-email-linyunsheng@huawei.com>
 <20190923151519.GE2369@hirez.programming.kicks-ass.net>
 <20190923152856.GB17206@dhcp22.suse.cz>
 <20190923154852.GG2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923154852.GG2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon 23-09-19 17:48:52, Peter Zijlstra wrote:
> On Mon, Sep 23, 2019 at 05:28:56PM +0200, Michal Hocko wrote:
> > On Mon 23-09-19 17:15:19, Peter Zijlstra wrote:
> 
> > > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > > index 4123100e..9859acb 100644
> > > > --- a/arch/x86/mm/numa.c
> > > > +++ b/arch/x86/mm/numa.c
> > > > @@ -861,6 +861,9 @@ void numa_remove_cpu(int cpu)
> > > >   */
> > > >  const struct cpumask *cpumask_of_node(int node)
> > > >  {
> > > > +	if (node == NUMA_NO_NODE)
> > > > +		return cpu_online_mask;
> > > 
> > > This mandates the caller holds cpus_read_lock() or something, I'm pretty
> > > sure that if I put:
> > > 
> > > 	lockdep_assert_cpus_held();
> > 
> > Is this documented somewhere?
> 
> No idea... common sense :-)

I thought that and cpuhotplug were forbiden to be used in the same
sentence :p

> > Also how does that differ from a normal
> > case when a proper node is used? The cpumask will always be dynamic in
> > the cpu hotplug presence, right?
> 
> As per normal yes, and I'm fairly sure there's a ton of bugs. Any
> 'online' state is subject to change except when you're holding
> sufficient locks to stop it.
> 
> Disabling preemption also stabilizes it, because cpu unplug relies on
> stop-machine.

OK, I guess it is fair to document that callers should be careful when
using this if they absolutely need any stability. But I strongly suspect
they simply do not care all that much. They mostly do care to have
something that gives them an idea which CPUs are close to the device and
that can tolerate some race.

In other words this is more of an optimization than a correctness issue.
 
> > > here, it comes apart real quick. Without holding the cpu hotplug lock,
> > > the online mask is gibberish.
> > 
> > Can the returned cpu mask go away?
> 
> No, the cpu_online_mask itself has static storage, the contents OTOH can
> change at will. Very little practical difference :-)
 
OK, thanks for the confirmation. I was worried that I've overlooked
something.

To the NUMA_NO_NODE itself. Your earlier email noted:
: > +
: >  	if ((unsigned)node >= nr_node_ids) {
: >  		printk(KERN_WARNING
: >  			"cpumask_of_node(%d): (unsigned)node >= nr_node_ids(%u)\n",
: 
: I still think this makes absolutely no sense what so ever.

Did you mean the NUMA_NO_NODE handling or the specific node >= nr_node_ids
check?

Because as to NUMA_NO_NODE I believe this makes sense because this is
the only way that a device is not bound to any numa node. I even the
ACPI standard is considering this optional. Yunsheng Lin has referred to
the specific part of the standard in one of the earlier discussions.
Trying to guess the node affinity is worse than providing all CPUs IMHO.
-- 
Michal Hocko
SUSE Labs
