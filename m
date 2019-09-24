Return-Path: <SRS0=Yu4+=XT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B68EC432C1
	for <linux-mips@archiver.kernel.org>; Tue, 24 Sep 2019 12:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5849C21655
	for <linux-mips@archiver.kernel.org>; Tue, 24 Sep 2019 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569327909;
	bh=i5wvYOhUJ0EqS4IRzg2a3hBW2UnLMGocUzWH2O/8Lio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bT2n4XBNPdXySFZwSHafD02vYnybZN7Ula9D5K1UANwPYRGup7+39Rp0Bt4T0uOr9
	 q58YbYwV2dArrH8QlgzqxYUiaQEuuKNr/+uwBYhGxwvj3xymBhTtkMsxUlvPERopjD
	 320YmCAuLPeedkI80y+B8brQi0ZH98Hjh1Yd+zEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390193AbfIXMZJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:25:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390187AbfIXMZI (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 24 Sep 2019 08:25:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CB02AF23;
        Tue, 24 Sep 2019 12:25:04 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:25:00 +0200
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
Message-ID: <20190924122500.GP23050@dhcp22.suse.cz>
References: <20190923152856.GB17206@dhcp22.suse.cz>
 <20190923154852.GG2369@hirez.programming.kicks-ass.net>
 <20190923165235.GD17206@dhcp22.suse.cz>
 <20190923203410.GI2369@hirez.programming.kicks-ass.net>
 <20190924074751.GB23050@dhcp22.suse.cz>
 <20190924091714.GJ2369@hirez.programming.kicks-ass.net>
 <20190924105622.GH23050@dhcp22.suse.cz>
 <20190924112349.GJ2332@hirez.programming.kicks-ass.net>
 <20190924115401.GM23050@dhcp22.suse.cz>
 <20190924120943.GP2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924120943.GP2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue 24-09-19 14:09:43, Peter Zijlstra wrote:
> On Tue, Sep 24, 2019 at 01:54:01PM +0200, Michal Hocko wrote:
> > On Tue 24-09-19 13:23:49, Peter Zijlstra wrote:
> > > On Tue, Sep 24, 2019 at 12:56:22PM +0200, Michal Hocko wrote:
> > [...]
> > > > To be honest I really fail to see why to object to a simple semantic
> > > > that NUMA_NO_NODE imply all usable cpus. Could you explain that please?
> > > 
> > > Because it feels wrong. The device needs to be _somewhere_. It simply
> > > cannot be node-less.
> > 
> > What if it doesn't have any numa preference for what ever reason? There
> > is no other way to express that than NUMA_NO_NODE.
> 
> Like I said; how does that physically work? The device needs to be
> somewhere. It _must_ have a preference.
> 
> > Anyway, I am not going to argue more about this because it seems more of
> > a discussion about "HW shouldn't be doing that although the specification
> > allows that" which cannot really have any outcome except of "feels
> > correct/wrong".
> 
> We can push back and say we don't respect the specification because it
> is batshit insane ;-)

Here is my fingers crossed.

[...]

> Now granted; there's a number of virtual devices that really don't have
> a node affinity, but then, those are not hurt by forcing them onto a
> random node, they really don't do anything. Like:

Do you really consider a random node a better fix than simply living
with a more robust NUMA_NO_NODE which tells the actual state? Page
allocator would effectivelly use the local node in that case. Any code
using the cpumask will know that any of the online cpus are usable.

Compare that to a wild guess that might be easily wrong and have subtle
side effects which are really hard to debug. You will only see a higher
utilization on a specific node. Good luck with a bug report like that.

Anyway, I really do  not feel strongly about that. If you really consider
it a bad idea then I can live with that. This just felt easier and
reasonably consistent to address. Implementing the guessing and fighting
vendors who really do not feel like providing a real affinity sounds
harder and more error prone.
-- 
Michal Hocko
SUSE Labs
