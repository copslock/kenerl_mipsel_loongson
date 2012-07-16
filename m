Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2012 16:20:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46140 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903725Ab2GPOUV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jul 2012 16:20:21 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q6GEKAkC012991;
        Mon, 16 Jul 2012 16:20:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q6GEK0EF012958;
        Mon, 16 Jul 2012 16:20:00 +0200
Date:   Mon, 16 Jul 2012 16:20:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joe Perches <joe@perches.com>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Mike Frysinger <vapier@gentoo.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-c6x-dev@linux-c6x.org, linux-mips@linux-mips.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: [PATCH net-next 8/8] arch: Use eth_random_addr
Message-ID: <20120716141959.GA12338@linux-mips.org>
References: <cover.1342157022.git.joe@perches.com>
 <14a91278564bb5a263c561a7f1bd10ea6386d90a.1342157022.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a91278564bb5a263c561a7f1bd10ea6386d90a.1342157022.git.joe@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33936
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Jul 12, 2012 at 10:33:12PM -0700, Joe Perches wrote:

> Convert the existing uses of random_ether_addr to
> the new eth_random_addr.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/blackfin/mach-bf537/boards/stamp.c |    2 +-
>  arch/c6x/kernel/soc.c                   |    2 +-
>  arch/mips/ar7/platform.c                |    4 ++--
>  arch/mips/powertv/powertv_setup.c       |    6 +++---
>  arch/um/drivers/net_kern.c              |    2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf
