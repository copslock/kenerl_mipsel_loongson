Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 10:02:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50192 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025966AbcDDIC0Ax2e3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 10:02:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u3482Oqn015499;
        Mon, 4 Apr 2016 10:02:24 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u3482NwS015491;
        Mon, 4 Apr 2016 10:02:23 +0200
Date:   Mon, 4 Apr 2016 10:02:23 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Qais Yousef <qsyousef@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
Message-ID: <20160404080222.GA15222@linux-mips.org>
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
 <20160401124852.GA5145@NP-P-BURTON>
 <56FFB8B7.8050607@gmail.com>
 <20160404064140.GA1368@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160404064140.GA1368@NP-P-BURTON>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52860
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

On Mon, Apr 04, 2016 at 07:41:40AM +0100, Paul Burton wrote:

> > On 01/04/2016 13:48, Paul Burton wrote:
> > >On Thu, Mar 17, 2016 at 09:08:09PM +0000, Qais Yousef wrote:
> > >>Malta defconfig compiles with GIC on. Hence when compiling for SMP it causes the
> > >>new IPI code to be activated. But on qemu malta there's no GIC causing a
> > >>BUG_ON(!ipidomain) to be hit in mips_smp_ipi_init().
> > >>
> > >>Since in that configuration one can only run a single core SMP (!), skip IPI
> > >>initialisation if we detect that this is the case. It is a sensible behaviour
> > >>to introduce and should keep such possible configuration to run rather than die
> > >>hard unnecessarily.
> > >Hi Qais/Ralf,
> > >
> > >This patch is insufficient I'm afraid. It's entirely possible to use SMP
> > >with multiple VPEs in a single core on Malta boards that don't have a
> > >GIC - we have code handling IPIs in that case guarded by #ifdef
> > >CONFIG_MIPS_MT_SMP in arch/mips/mti-malta/malta-int.c. I think the
> > >BUG_ON needs to be removed entirely, unless that single-core multi-VPE
> > >IPI code is also converted to use an IPI irqdomain.
> > >
> > 
> > I was under the impression that SMP is only supported under GIC and older
> > forms of SMP are deprecated.
> 
> Hi Qais,
> 
> That's incorrect. We're talking about systems that don't have any GIC -
> there are Malta configurations that don't. QEMU is the obvious one, and
> you can break it (at least v2.5.0 which has no GIC) with this patch just
> by using "-cpu 34Kf -smp 2" to show up 2 VPEs. I believe there are also
> real bitfiles (though probably unused these days) that would have the
> same problem.
> 
> > I think the problem you're describing is different to the one this is trying
> > to fix. The right fix for your issue is to make CONFIG_GENERIC_IRQ_IPI
> > selected when CONFIG_MIPS_GIC && !CONFIG_MIPS_MT_SMP.
> > 
> > Would it be easy for you to create such a patch and test it?
> 
> That would be insufficient, since we can have a kernel that includes GIC
> support & CONFIG_MIPS_MT_SMP (SMVP) support and not know whether
> there'll actually be a GIC or multiple VPEs until runtime. So Kconfig
> cannot solve this at compile time.
> 
> I believe that the best thing to do would be to convert the single-core
> MT IPI code to use the IRQ domain stuff you added (which I don't see any
> documentation for & am currently struggling to decipher). But given that
> we're post-merge-window on the way to v4.6 I think the best we can do is
> to just return when there's no IPI domain, rather than BUG_ON. I'll
> submit a patch to do that later this morning.

FYI, Qais' initial fix is in the pull request I sent to Linus yesterday so
any fixes please relative to that patch.

  Ralf
