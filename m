Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 01:45:24 +0200 (CEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:50711 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992298AbcIAXpQOPx0V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 01:45:16 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 80178234271;
        Fri,  2 Sep 2016 02:45:15 +0300 (EEST)
Date:   Fri, 2 Sep 2016 02:45:15 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/6] MIPS: OCTEON: delete legacy code for PHY access
Message-ID: <20160901234515.GL14316@raspberrypi.musicnaut.iki.fi>
References: <20160901204400.16562-1-aaro.koskinen@iki.fi>
 <20160901204400.16562-6-aaro.koskinen@iki.fi>
 <57C8B313.6030206@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57C8B313.6030206@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Thu, Sep 01, 2016 at 04:00:35PM -0700, David Daney wrote:
> On 09/01/2016 01:43 PM, Aaro Koskinen wrote:
> >PHY access through the board helper should be impossible with the
> >current drivers, so delete this code and add BUG_ON().
> >
> >Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >---
> >  .../cavium-octeon/executive/cvmx-helper-board.c    | 110 +--------------------
> >  1 file changed, 5 insertions(+), 105 deletions(-)
> >
> >diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> >index 5572e39..8d75242 100644
> >--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> >+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> [...]
> >+	BUG_ON(cvmx_helper_board_get_mii_address(ipd_port) != -1);
> >
> 
> Can we do WARN_ON instead?
> 
> No need to crash the kernel for this I think.

I could change it, but I really think it is 100% unreachable case with
the current mainline: If we know the mii address then the in-tree DTB
pruning code would have set up the phy node properly, and this code
never gets called. So reaching the BUG_ON condition really would mean
a fatal bug somewhere.

The only case you can hit the BUG_ON is:

	1) you add new switch case CVMX_BOARD_TYPE_* into
	   cvmx_helper_board_get_mii_address()

	2) you pass your own DTB without proper phy-handle (or fixed-link)

But we should not allow 1) as there is no reason to add new
CVMX_BOARD_TYPE_* types anymore, and the best way to tell people not to
do that is BUG_ON...

A.
