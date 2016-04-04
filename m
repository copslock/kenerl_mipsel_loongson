Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 08:41:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28445 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025214AbcDDGlzBPdOH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 08:41:55 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id BC1F78ED37DE4;
        Mon,  4 Apr 2016 07:41:46 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 4 Apr 2016 07:41:48 +0100
Received: from localhost (10.100.200.13) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 4 Apr
 2016 07:41:46 +0100
Date:   Mon, 4 Apr 2016 07:41:40 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Qais Yousef <qsyousef@gmail.com>
CC:     <ralf@linux-mips.org>, Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
Message-ID: <20160404064140.GA1368@NP-P-BURTON>
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
 <20160401124852.GA5145@NP-P-BURTON>
 <56FFB8B7.8050607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <56FFB8B7.8050607@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.13]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Sat, Apr 02, 2016 at 01:19:03PM +0100, Qais Yousef wrote:
> Hi Paul,
> 
> On 01/04/2016 13:48, Paul Burton wrote:
> >On Thu, Mar 17, 2016 at 09:08:09PM +0000, Qais Yousef wrote:
> >>Malta defconfig compiles with GIC on. Hence when compiling for SMP it causes the
> >>new IPI code to be activated. But on qemu malta there's no GIC causing a
> >>BUG_ON(!ipidomain) to be hit in mips_smp_ipi_init().
> >>
> >>Since in that configuration one can only run a single core SMP (!), skip IPI
> >>initialisation if we detect that this is the case. It is a sensible behaviour
> >>to introduce and should keep such possible configuration to run rather than die
> >>hard unnecessarily.
> >Hi Qais/Ralf,
> >
> >This patch is insufficient I'm afraid. It's entirely possible to use SMP
> >with multiple VPEs in a single core on Malta boards that don't have a
> >GIC - we have code handling IPIs in that case guarded by #ifdef
> >CONFIG_MIPS_MT_SMP in arch/mips/mti-malta/malta-int.c. I think the
> >BUG_ON needs to be removed entirely, unless that single-core multi-VPE
> >IPI code is also converted to use an IPI irqdomain.
> >
> 
> I was under the impression that SMP is only supported under GIC and older
> forms of SMP are deprecated.

Hi Qais,

That's incorrect. We're talking about systems that don't have any GIC -
there are Malta configurations that don't. QEMU is the obvious one, and
you can break it (at least v2.5.0 which has no GIC) with this patch just
by using "-cpu 34Kf -smp 2" to show up 2 VPEs. I believe there are also
real bitfiles (though probably unused these days) that would have the
same problem.

> I think the problem you're describing is different to the one this is trying
> to fix. The right fix for your issue is to make CONFIG_GENERIC_IRQ_IPI
> selected when CONFIG_MIPS_GIC && !CONFIG_MIPS_MT_SMP.
> 
> Would it be easy for you to create such a patch and test it?

That would be insufficient, since we can have a kernel that includes GIC
support & CONFIG_MIPS_MT_SMP (SMVP) support and not know whether
there'll actually be a GIC or multiple VPEs until runtime. So Kconfig
cannot solve this at compile time.

I believe that the best thing to do would be to convert the single-core
MT IPI code to use the IRQ domain stuff you added (which I don't see any
documentation for & am currently struggling to decipher). But given that
we're post-merge-window on the way to v4.6 I think the best we can do is
to just return when there's no IPI domain, rather than BUG_ON. I'll
submit a patch to do that later this morning.

Thanks,
    Paul
