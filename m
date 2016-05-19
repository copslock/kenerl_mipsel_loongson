Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 14:32:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34706 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028848AbcESMcGBmAkW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2016 14:32:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4JCW3au008450;
        Thu, 19 May 2016 14:32:03 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4JCW1Vt008449;
        Thu, 19 May 2016 14:32:01 +0200
Date:   Thu, 19 May 2016 14:32:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Joe Perches <joe@perches.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/3] External Interrupt Controller (EIC) fixes
Message-ID: <20160519123200.GP14481@linux-mips.org>
References: <1463495466-29689-1-git-send-email-paul.burton@imgtec.com>
 <alpine.DEB.2.11.1605191120220.3851@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1605191120220.3851@nanos>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53545
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

On Thu, May 19, 2016 at 11:21:22AM +0200, Thomas Gleixner wrote:

> On Tue, 17 May 2016, Paul Burton wrote:
> 
> > This series fixes a few small issues with support for External Interrupt
> > Controllers (cpu_has_veic), ensuring that it is configured to service
> > all interrupts by default & that when a GIC is present it's enabled when
> > expected.
> > 
> > Applies atop v4.6.
> > 
> > Paul Burton (3):
> >   MIPS: Clear Status IPL field when using EIC
> >   MIPS: smp-cps: Clear Status IPL field when using EIC
> >   irqchip: mips-gic: Setup EIC mode on each CPU if it's in use
> 
> I was not on CC for patch 1/3 and I assume this should go through one
> tree. Ralf, can you pick that up with my acked-by for the irqchip change?

Yes, will do.

Thanks!

  Ralf
