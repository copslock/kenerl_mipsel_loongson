Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 17:31:30 +0100 (CET)
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:53478 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010588AbcAWQb22FnxF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 17:31:28 +0100
Received: from io (unknown [74.98.172.136])
        by outbound1.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Sat, 23 Jan 2016 16:32:12 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id D4D3C80026;
        Sat, 23 Jan 2016 16:31:22 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io D4D3C80026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1453566682;
        bh=UPcsSm8PbwFqMh4y7gfIyoVdJMccoCh4wJXkUT2DpUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=sPKn74WV27i/YQhnZuWafkgDvu0HPiD2lI99jztLHlugF7G7u5TW2IbCcC7JujYgz
         49dBCI3eYqYXyK9RpdEZ5fjItodLE7FdwEo75BZ31jqqa46ORhkXWj9EjZUSzIkq3W
         fryX01QmthJ2FRpcLz9KGDegBGkqDaD4fhO6k82iCrZVZJsBJrDQhTX8Sm/+nqB/iB
         ZGU3gfl7tCf5oN0O+ysQOK4UEORT4qNMPVneDrcv0bH+LvSrkAxIR+4jIUhJsAGvu5
         TNs3X9p1ChOpySSYtimz3mSjDUi1gRa5EpYvlqisCY8iPDC9aeA25qSmWQDSAVdF+h
         40HISkoBierTw==
Date:   Sat, 23 Jan 2016 16:31:22 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
Message-ID: <20160123163122.GF676@io.lakedaemon.net>
References: <1453553867-27003-1-git-send-email-albeu@free.fr>
 <20160123150200.5bc027a6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160123150200.5bc027a6@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51325
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

On Sat, Jan 23, 2016 at 03:02:00PM +0000, Marc Zyngier wrote:
> On Sat, 23 Jan 2016 13:57:46 +0100
> Alban Bedel <albeu@free.fr> wrote:
> 
> > The driver stays the same but the initialization changes a bit.
> > For OF boards we now get the memory map from the OF node and use
> > a linear mapping instead of the legacy mapping. For legacy boards
> > we still use a legacy mapping and just pass down all the parameters
> > from the board init code.
> > 
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks Marc, I'll pick this up when -rc1 drops.

thx,

Jason.
