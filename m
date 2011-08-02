Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 21:23:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42520 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491192Ab1HBTXH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2011 21:23:07 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p72JN44s016030;
        Tue, 2 Aug 2011 20:23:04 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p72JN3QI016029;
        Tue, 2 Aug 2011 20:23:03 +0100
Date:   Tue, 2 Aug 2011 20:23:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/15] net: au1000_eth: pass MACDMA address through
 platform resource info.
Message-ID: <20110802192303.GA15961@linux-mips.org>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
 <1312307470-6841-3-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1312307470-6841-3-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1685

On Tue, Aug 02, 2011 at 07:50:57PM +0200, Manuel Lauss wrote:

> This patch removes the last hardcoded base address from the au1000_eth
> driver.  The base address of the MACDMA unit was derived from the
> platform device id; if someone registered the MACs in inverse order
> both would not work.
> So instead pass the base address of the DMA unit to the driver with
> the other platform resource information.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks, queued for 3.2.

  Ralf
