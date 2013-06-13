Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 15:59:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56897 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834961Ab3FMN7acA287 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jun 2013 15:59:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5DDxQcN023372;
        Thu, 13 Jun 2013 15:59:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5DDxMkd023371;
        Thu, 13 Jun 2013 15:59:22 +0200
Date:   Thu, 13 Jun 2013 15:59:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Miller <davem@davemloft.net>
Cc:     florian@openwrt.org, netdev@vger.kernel.org, blogic@openwrt.org,
        linux-mips@linux-mips.org, mbizon@freebox.fr, jogo@openwrt.org,
        cernekee@gmail.com
Subject: Re: [PATCH net-next] bcm63xx_enet: add support Broadcom BCM6345
 Ethernet
Message-ID: <20130613135921.GA22906@linux-mips.org>
References: <CAGVrzcYE4VDWtL_Uj1DrkZ6GqX6ghqPAXPpyLptc6PGwReixSQ@mail.gmail.com>
 <20130613.022524.568792627006552244.davem@davemloft.net>
 <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
 <20130613.025619.2170890039313059326.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130613.025619.2170890039313059326.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36852
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

On Thu, Jun 13, 2013 at 02:56:19AM -0700, David Miller wrote:

> From: Florian Fainelli <florian@openwrt.org>
> Date: Thu, 13 Jun 2013 10:49:18 +0100
> 
> > We are in the slow process to switch to Device Tree to precisely
> > eliminate all of this (although not everyone agrees yet on the
> > details). Hopefully you should not see such things in the future.
> 
> Fair enough, I'll put this patch back into my TODO queue.

David is right, one pair of welding goggles isn't enough to cope with the
uglyness of this but as a temporary thing I can live with it, so

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Dave, feel free to merge this through next-next.  I'm going to drop
this patch from the MIPS patchwork then.

  Ralf
