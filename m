Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2003 02:30:27 +0100 (BST)
Received: from p508B6063.dip.t-dialin.net ([IPv6:::ffff:80.139.96.99]:55508
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225213AbTG3BaW>; Wed, 30 Jul 2003 02:30:22 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6U1UKx6008307;
	Wed, 30 Jul 2003 03:30:20 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6U1UKJS008306;
	Wed, 30 Jul 2003 03:30:20 +0200
Date: Wed, 30 Jul 2003 03:30:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Louis Hamilton <hamilton@redhat.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Mips64 Ocelot-C and Jaguar ATX platform support
Message-ID: <20030730013019.GA7366@linux-mips.org>
References: <3F1F0BDC.8040609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1F0BDC.8040609@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 23, 2003 at 05:27:40PM -0500, Louis Hamilton wrote:

> Notes the board support lives under arch/mips/momentum.
> Also, CONFIG_BOARD_SCACHE and CONFIG_RM7000_CPU_SCACHE are utilized and
> integrated into each platform's default configuration files.
> As in the first patch, drivers/net/mv64340_eth.{c,h} is added to provide 
> ethernet support.
> 
> If it looks ok, please check changes into the tree.

Ehhh, sorry.  This CONFIG_JAGUAR_DMALOW thing just isn't the way to go.
I know the Jaguar's DMA architecture is unpleassant to say the least but
still, cluttering generic code with ifdefs isn't the way to go.  Declare
all memory above the DMA limit high-memory and put the rest into ZONE_DMA
rsp. ZONE_NORMAL, as appropriate for the Jaguar.  Then provide a dummy
implementation of kmap, kunmap etc. (unless you have "real" highmem of
course) that does the same thing as if highmem was disabled, see
<linux/highmem.h>.

  Ralf
