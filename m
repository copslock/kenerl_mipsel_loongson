Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 May 2010 01:31:50 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58120 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491926Ab0EUXbr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 May 2010 01:31:47 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4LNVdet003947;
        Sat, 22 May 2010 00:31:40 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4LNVcUr003944;
        Sat, 22 May 2010 00:31:38 +0100
Date:   Sat, 22 May 2010 00:31:37 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS:POWERTV: use O(1) algorthm for
 phys_to_dma/dma_to_phys
Message-ID: <20100521233137.GA2954@linux-mips.org>
References: <20100521182536.GA3331@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100521182536.GA3331@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 21, 2010 at 11:25:36AM -0700, David VomLehn wrote:

Queued for 2.6.36 - but may go upstream earlier than that.  Let's see.

Thanks,

  Ralf
