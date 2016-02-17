Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 14:15:44 +0100 (CET)
Received: from smtp2-g21.free.fr ([212.27.42.2]:7216 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011271AbcBQNPm08qz1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Feb 2016 14:15:42 +0100
Received: from tock (unknown [78.50.169.39])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 36B074B01B6;
        Wed, 17 Feb 2016 14:12:37 +0100 (CET)
Date:   Wed, 17 Feb 2016 14:15:29 +0100
From:   Alban <albeu@free.fr>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Aban Bedel <albeu@free.fr>, Marc Zyngier <marc.zyngier@arm.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
Message-ID: <20160217141529.74b49deb@tock>
In-Reply-To: <20160123163122.GF676@io.lakedaemon.net>
References: <1453553867-27003-1-git-send-email-albeu@free.fr>
        <20160123150200.5bc027a6@arm.com>
        <20160123163122.GF676@io.lakedaemon.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sat, 23 Jan 2016 16:31:22 +0000
Jason Cooper <jason@lakedaemon.net> wrote:

> On Sat, Jan 23, 2016 at 03:02:00PM +0000, Marc Zyngier wrote:
> > On Sat, 23 Jan 2016 13:57:46 +0100
> > Alban Bedel <albeu@free.fr> wrote:
> > 
> > > The driver stays the same but the initialization changes a bit.
> > > For OF boards we now get the memory map from the OF node and use
> > > a linear mapping instead of the legacy mapping. For legacy boards
> > > we still use a legacy mapping and just pass down all the parameters
> > > from the board init code.
> > > 
> > > Signed-off-by: Alban Bedel <albeu@free.fr>
> > 
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thanks Marc, I'll pick this up when -rc1 drops.

RC1 has been released for a while now, however I still can't see
these patches in the irqchip git trees. I checked both tree:

git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
git://git.infradead.org/users/jcooper/linux.git irqchip/core

or are these still queued and going to be merged later?

Alban
