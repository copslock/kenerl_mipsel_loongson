Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 15:16:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46281 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6831921Ab3HVNQTjl2Px (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Aug 2013 15:16:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r7MDGIOg011595;
        Thu, 22 Aug 2013 15:16:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r7MDGH5t011594;
        Thu, 22 Aug 2013 15:16:17 +0200
Date:   Thu, 22 Aug 2013 15:16:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: question about drivers/net/ethernet/sgi
Message-ID: <20130822131617.GZ2163@linux-mips.org>
References: <alpine.DEB.2.02.1308131742100.2263@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1308131742100.2263@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37644
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

On Tue, Aug 13, 2013 at 05:43:32PM +0200, Julia Lawall wrote:

> The files in drivers/net/ethernet/sgi (meth.c and ioc3-eth.c) both use
> alloc_skb.  Is there a reason why they do not use netdev_alloc_skb, like
> most other ethernet drivers?

netdev_alloc_skb is such newfangled (2.6.19) interface - and both of these
drivers date back to the 2.3 days.  So the answer is, nobody bothered so
far.

  Ralf
