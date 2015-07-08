Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 15:01:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37869 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010454AbbGHNBvY35fu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jul 2015 15:01:51 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t68D1o9B008606;
        Wed, 8 Jul 2015 15:01:50 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t68D1nod008599;
        Wed, 8 Jul 2015 15:01:49 +0200
Date:   Wed, 8 Jul 2015 15:01:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] MIPS, IRQCHIP: Move i8259 irqchip driver to
 drivers/irqchip.
Message-ID: <20150708130149.GT18167@linux-mips.org>
References: <20150708124608.GS18167@linux-mips.org>
 <alpine.DEB.2.11.1507081456560.5134@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1507081456560.5134@nanos>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48118
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

On Wed, Jul 08, 2015 at 02:57:38PM +0200, Thomas Gleixner wrote:

> >  arch/mips/Kconfig           |   4 -
> >  arch/mips/kernel/Makefile   |   1 -
> >  arch/mips/kernel/i8259.c    | 384 --------------------------------------------
> >  drivers/irqchip/Kconfig     |   4 +
> >  drivers/irqchip/Makefile    |   1 +
> >  drivers/irqchip/irq-i8259.c | 383 +++++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 388 insertions(+), 389 deletions(-)
> 
> Should I carry it, or want you merge it via the mips tree?
> 
> In the latter case: Acked-by-me.

I guess the conflict potencial will be lower if you carry it - and if
somebody wants to merge it with one of the other i8259.c littered through
the tree it probably also is better if you carry it.

Thanks!

  Ralf
