Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 23:15:55 +0200 (CEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:54727 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992200AbcGYVPtY3lNo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2016 23:15:49 +0200
Received: from blackmetal.musicnaut.iki.fi (85-76-96-157-nat.elisa-mobile.fi [85.76.96.157])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id C895D1A270D;
        Tue, 26 Jul 2016 00:15:46 +0300 (EEST)
Date:   Tue, 26 Jul 2016 00:15:45 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <sjhill@bethel-hill.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Improve USB reset code for OCTEON II.
Message-ID: <20160725211545.GB17344@blackmetal.musicnaut.iki.fi>
References: <57967A2C.3020002@bethel-hill.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57967A2C.3020002@bethel-hill.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54374
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

On Mon, Jul 25, 2016 at 03:44:28PM -0500, Steven J. Hill wrote:
> -	.dma_mask_64	= 1,
> +	/*
> +	 * We can DMA from anywhere. But the descriptors must be in
> +	 * the lower 4GB.
> +	 */
> +	.dma_mask_64	= 0,

Is this change really related to USB reset code?

A.
