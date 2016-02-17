Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 17:13:47 +0100 (CET)
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:58959 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012362AbcBQQNOtIdX4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2016 17:13:14 +0100
X-MHO-User: 649f097a-d591-11e5-8dfb-c75234cc769e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.100
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.100])
        by outbound1.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Wed, 17 Feb 2016 16:13:33 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 082C480017;
        Wed, 17 Feb 2016 16:13:07 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 082C480017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1455725587;
        bh=o4oasor9juHIize7+tWG0to6n4OnCpGSlDG1/HTRfkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=x85WKRNmi6QwGzo60vnMNz9A6EBYDUUPzQyagIB/6lXKQH/TKC0ltWu6SrZXwZkkW
         nYki5701sVzNFVxmZyner5xpEFj+LmqGLIllDJ65ZN9mpjA7NShjV83O/i2OlNxy4O
         f36G3WyVtPNOCRClCNyeoEqxtNRs2vgpLXHT6XvTkOnT25xs7J60xhUbSHuJnyjD1D
         n2A1RpictgGRdVGfOwgiHlnT71pZD4Y+eiLsZhvIsC7HmQhtwrIt+VAmoJ8/+jsbpy
         tNDCY3yfYS4TXqEH79SvsbIU+2rO8pUptEqoamm4UX8sxgZmJSr2IxtipFDek/5kDc
         4oK7luQBQwhdQ==
Date:   Wed, 17 Feb 2016 16:13:06 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Alban <albeu@free.fr>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
Message-ID: <20160217161306.GI5183@io.lakedaemon.net>
References: <1453553867-27003-1-git-send-email-albeu@free.fr>
 <20160123150200.5bc027a6@arm.com>
 <20160123163122.GF676@io.lakedaemon.net>
 <20160217141529.74b49deb@tock>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160217141529.74b49deb@tock>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Hey Alban,

On Wed, Feb 17, 2016 at 02:15:29PM +0100, Alban wrote:
> On Sat, 23 Jan 2016 16:31:22 +0000
> Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > On Sat, Jan 23, 2016 at 03:02:00PM +0000, Marc Zyngier wrote:
> > > On Sat, 23 Jan 2016 13:57:46 +0100
> > > Alban Bedel <albeu@free.fr> wrote:
> > > 
> > > > The driver stays the same but the initialization changes a bit.
> > > > For OF boards we now get the memory map from the OF node and use
> > > > a linear mapping instead of the legacy mapping. For legacy boards
> > > > we still use a legacy mapping and just pass down all the parameters
> > > > from the board init code.
> > > > 
> > > > Signed-off-by: Alban Bedel <albeu@free.fr>
> > > 
> > > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Thanks Marc, I'll pick this up when -rc1 drops.
> 
> RC1 has been released for a while now, however I still can't see
> these patches in the irqchip git trees. I checked both tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> git://git.infradead.org/users/jcooper/linux.git irqchip/core
> 
> or are these still queued and going to be merged later?

I've just queued them up, but ran into a needed git gc...  They should
be pushed by the end of the day.

thx,

Jason.
