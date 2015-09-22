Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:12:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39549 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009044AbbIVRMd5srzr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Sep 2015 19:12:33 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8MHCTO6018152;
        Tue, 22 Sep 2015 19:12:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8MHCT5v018151;
        Tue, 22 Sep 2015 19:12:29 +0200
Date:   Tue, 22 Sep 2015 19:12:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Couzens <lynxis@fe80.eu>, linux-mips@linux-mips.org,
        Alban Bedel <albeu@free.fr>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: ath79: add irq chip ar7240-misc-intc
Message-ID: <20150922171228.GB18064@linux-mips.org>
References: <1442636780-2891-1-git-send-email-lynxis@fe80.eu>
 <1442636780-2891-3-git-send-email-lynxis@fe80.eu>
 <alpine.DEB.2.11.1509221223280.5606@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1509221223280.5606@nanos>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49280
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

On Tue, Sep 22, 2015 at 12:24:26PM +0200, Thomas Gleixner wrote:

> > The ar7240 misc irq chip use ack handler
> > instead of ack_mask handler. All new ath79 chips use
> > the ar7240 misc irq chip
> > 
> > Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> > Acked-by: Alban Bedel <albeu@free.fr>
> > ---
> >  .../interrupt-controller/qca,ath79-misc-intc.txt     | 20 ++++++++++++++++++--
> >  arch/mips/ath79/irq.c                                | 10 ++++++++++
> 
> That driver should probably move into drivers/irqchip.

Like a fair number of other irq.c type files in arch/mips that could
reasonably easily be rewritten to go to drivers/irqchip.

> Other than that.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks, I replaced the previous version of this patch with this one.

  Ralf
