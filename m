Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 17:09:10 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:65470 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007992AbaICPJIcrZt- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2014 17:09:08 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
        id 0Leu47-1YByNO3MhL-00qhr2; Wed, 03 Sep 2014 17:08:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] MIPS: GIC: Move MIPS_GIC_IRQ_BASE into platform irq.h
Date:   Wed, 03 Sep 2014 17:08:43 +0200
Message-ID: <3376106.3oS8jj7piF@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAL1qeaETzZ3EaC8RVXm3K4GLZbknk5iMUR1X2naaAboon4s6fQ@mail.gmail.com>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org> <CAL1qeaHryi7noBMiHxJPybByuvVts23reuiiQbV9mCQj+Ngqjw@mail.gmail.com> <CAL1qeaETzZ3EaC8RVXm3K4GLZbknk5iMUR1X2naaAboon4s6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:dWGDpT87OTkZOn9i/jQzU4qxJ2lzAKAnyIz1NpvIilA
 11yQEDXhK6eFlcM5KHJyK68K0S8Y2SJ2mfrYM/Tg04OfP/tq3i
 YGbp2LJ6mmF6BnAitDIDDzWouhjlGNSGYpj++Hjtn1sH5GNo1N
 5ZlSEfgMumOnFx2tm39GoosFZVklRYUTHJyvlN2KQqRsb0M0xy
 OMsY/9fOsHNt7qxaqO6Zh7C1PxzI+Zoq1GItheRvtpbU1ml+/o
 jEebvacRoXPoQxKYVw7qQoH1ROMo71E9iqvxi0Eri/nJw7VX5e
 KB3NttP5xpU0gmaMlT89irLXz7dSpKSs/PmZ1T6wfzH0W7ViOn
 mZCmxrY/mFEY/+IHPF7s=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tuesday 02 September 2014 15:22:31 Andrew Bresticker wrote:
> On Mon, Sep 1, 2014 at 5:08 PM, Andrew Bresticker <abrestic@chromium.org> wrote:
> > On Mon, Sep 1, 2014 at 1:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Sunday 31 August 2014 11:54:04 Andrew Bresticker wrote:
> >>> On Sat, Aug 30, 2014 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>> > On Friday 29 August 2014 15:14:31 Andrew Bresticker wrote:
> >>> >> Define a generic MIPS_GIC_IRQ_BASE which is suitable for Malta and
> >>> >> the upcoming Danube board in <mach-generic/irq.h>.  Since Sead-3 is
> >>> >> different and uses a MIPS_GIC_IRQ_BASE equal to the CPU IRQ base (0),
> >>> >> define its MIPS_GIC_IRQ_BASE in <mach-sead3/irq.h>.
> >>> >>
> >>> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> >>> >>
> >>> >
> >>> > Why do you actually have to hardwire an IRQ base? Can't you move
> >>> > to the linear irqdomain code for DT based MIPS systems yet?
> >>>
> >>> Neither Malta nor SEAD-3 use device-tree for interrupts yet, so they
> >>> still require a hard-coded IRQ base.  For boards using device-tree, I
> >>> stuck with a legacy IRQ domain as it allows most of the existing GIC
> >>> irqchip code to be reused.
> >>
> >> I see. Note that we now have irq_domain_add_simple(), which should
> >> do the right think in either case: use a legacy domain when a
> >> nonzero base is provided for the old boards, but use the simple
> >> domain when probed from DT without an irq base.
> >>
> >> This makes the latter case more memory efficient (it avoids
> >> allocating the irq descriptors for every possibly but unused
> >> IRQ number) and helps ensure that you don't accidentally rely
> >> on hardcoded IRQ numbers for the DT based machines, which would
> >> be considered a bug.
> >
> > Ah, ok.  It looks like add_simple() is what I want then.
> 
> Actually, never mind.  To re-use the existing GIC irqchip code I want
> a legacy IRQ domain.

It shouldn't be hard to change the existing code to use irq domain
accessors. The main part is probably just to replace 'd->irq -
gic_irq_base' with 'd->hwirq', in case you make up your mind about
it again.

	Arnd
