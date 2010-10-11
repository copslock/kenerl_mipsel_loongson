Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 14:32:37 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59594 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491027Ab0JKMcf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Oct 2010 14:32:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9BCUPhh027001;
        Mon, 11 Oct 2010 13:30:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9BCUNB7027000;
        Mon, 11 Oct 2010 13:30:23 +0100
Date:   Mon, 11 Oct 2010 13:30:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     ddaney@caviumnetworks.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Reinstate plat_map_dma_mem_page()
Message-ID: <20101011123023.GA26997@linux-mips.org>
References: <9ab1e21b7c9b1b40a3de371d3a35ebd3@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab1e21b7c9b1b40a3de371d3a35ebd3@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 09, 2010 at 06:50:13PM -0700, Kevin Cernekee wrote:

> [Patch is against linux-queue.git]
> 
> plat_map_dma_mem_page() is required in order to translate a "struct page"
> directly to a physical address.  plat_map_dma_mem() is not effective on
> HIGHMEM pages.

Seems to make sense.  I've folded your patch into patch 6 of David Daney's
series and fixed up the resulting reject in patch 8.

Thanks!

  Ralf
