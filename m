Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 14:30:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41908 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028268AbcEQMaepIokl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2016 14:30:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4HCUXwc005358;
        Tue, 17 May 2016 14:30:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4HCUWFx005357;
        Tue, 17 May 2016 14:30:32 +0200
Date:   Tue, 17 May 2016 14:30:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Joshua Henderson <digitalpeer@digitalpeer.com>
Subject: Re: [PATCH 03/11] MIPS: pic32mzda: fix getting timer clock rate.
Message-ID: <20160517123032.GD14481@linux-mips.org>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
 <1463461560-9629-3-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463461560-9629-3-git-send-email-purna.mandal@microchip.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53481
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

On Tue, May 17, 2016 at 10:35:52AM +0530, Purna Chandra Mandal wrote:

> PIC32 clock driver is now implemented as platform driver instead of
> as part of of_clk_init(). It meants all the clock modules are available
> quite late in the boot sequence. So request for CPU clock by clk_get_sys()
> and clk_get_rate() to find c0_timer rate fails.
> 
> To fix this use PIC32 specific early clock functions implemented for early
> console support.
> 
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> 
> ---
> Note: Please pull this complete series through the MIPS tree.
> 
> ---
> 
>  arch/mips/pic32/pic32mzda/time.c | 13 ++++---------

For now I applied only this patch as it seems independent of the remainder
of the series which still will need to be reviewed and acked by the
respective maintainers.

  Ralf
