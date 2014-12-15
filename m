Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 16:44:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47358 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008819AbaLOPoSxzh0y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 16:44:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBFFiANR026656;
        Mon, 15 Dec 2014 16:44:10 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBFFi89Z026654;
        Mon, 15 Dec 2014 16:44:08 +0100
Date:   Mon, 15 Dec 2014 16:44:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: jz4740: Convert to GPIO descriptor API
Message-ID: <20141215154408.GD9382@linux-mips.org>
References: <1417549706-28420-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1417549706-28420-1-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44678
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

On Tue, Dec 02, 2014 at 08:48:26PM +0100, Lars-Peter Clausen wrote:

> Use the GPIO descriptor API instead of the deprecated legacy GPIO API to
> manage the busy GPIO.
> 
> The patch updates both the jz4740 nand driver and the only user of the driver
> the qi-lb60 board driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> This patch should preferably be merged through the MTD tree with Ralf's ack for
> the MIPS bits.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Though in my experience MIPS-specific patches to non-arch/mips code receive
best testing in the MIPS tree.

Cheers,

  Ralf
