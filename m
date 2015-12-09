Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:54:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38062 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007162AbbLINyyjfmw9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Dec 2015 14:54:54 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tB9DspoK002315;
        Wed, 9 Dec 2015 14:54:51 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tB9DsnCJ002314;
        Wed, 9 Dec 2015 14:54:49 +0100
Date:   Wed, 9 Dec 2015 14:54:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 135/182] MIPS: alchemy: switch to gpiochip_add_data()
Message-ID: <20151209135448.GI4722@linux-mips.org>
References: <1449668342-4446-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449668342-4446-1-git-send-email-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50476
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

On Wed, Dec 09, 2015 at 02:39:02PM +0100, Linus Walleij wrote:

> We're planning to remove the gpiochip_add() function to swith
> to gpiochip_add_data() with NULL for data argument.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Ralf: please ACK this so I can take it through the GPIO tree.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

> BTW: would be nice if the MIPS GPIO drivers could move down
> to drivers/gpio in the long run.

I agree - but for practical reasons this won't happen quickly.

  Ralf
