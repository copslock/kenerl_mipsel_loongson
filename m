Return-Path: <SRS0=Yu4+=XT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D7DC432C1
	for <linux-mips@archiver.kernel.org>; Tue, 24 Sep 2019 11:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080B72168B
	for <linux-mips@archiver.kernel.org>; Tue, 24 Sep 2019 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569326050;
	bh=+b20oWsrdyRmCcSWEc204xa1rhqLzX2QQVrONvtLvvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cvspRTVsDs734mFicKmBvPd0Io1XdWjhoXV26afsvpeZxKI4psmnPV3oPpKLIGK8B
	 QCcjIYAYfqZDqbYTuFumyz8PcnV0S13NLGjqe1Eg7lohFMViqd75ZWvIluq3TmvWQ2
	 itd2lJb5Sk/vWAlxpyraT8HxaVCcC7fyQNPkolF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440894AbfIXLyG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:54:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:37390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440891AbfIXLyF (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 24 Sep 2019 07:54:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4E24AE6E;
        Tue, 24 Sep 2019 11:54:02 +0000 (UTC)
Date:   Tue, 24 Sep 2019 13:54:01 +0200
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
Message-ID: <20190924115401.GM23050@dhcp22.suse.cz>
References: <1568724534-146242-1-git-send-email-linyunsheng@huawei.com>
 <20190923151519.GE2369@hirez.programming.kicks-ass.net>
 <20190923152856.GB17206@dhcp22.suse.cz>
 <20190923154852.GG2369@hirez.programming.kicks-ass.net>
 <20190923165235.GD17206@dhcp22.suse.cz>
 <20190923203410.GI2369@hirez.programming.kicks-ass.net>
 <20190924074751.GB23050@dhcp22.suse.cz>
 <20190924091714.GJ2369@hirez.programming.kicks-ass.net>
 <20190924105622.GH23050@dhcp22.suse.cz>
 <20190924112349.GJ2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924112349.GJ2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue 24-09-19 13:23:49, Peter Zijlstra wrote:
> On Tue, Sep 24, 2019 at 12:56:22PM +0200, Michal Hocko wrote:
[...]
> > To be honest I really fail to see why to object to a simple semantic
> > that NUMA_NO_NODE imply all usable cpus. Could you explain that please?
> 
> Because it feels wrong. The device needs to be _somewhere_. It simply
> cannot be node-less.

What if it doesn't have any numa preference for what ever reason? There
is no other way to express that than NUMA_NO_NODE.

Anyway, I am not going to argue more about this because it seems more of
a discussion about "HW shouldn't be doing that although the specification
allows that" which cannot really have any outcome except of "feels
correct/wrong".

If you really feel strongly about this then we should think of a proper
way to prevent this to happen because an out-of-bound access is
certainly not something we really want, right?
-- 
Michal Hocko
SUSE Labs
