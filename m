Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2018 15:52:59 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:49879 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994592AbeERNwwlqqGj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 May 2018 15:52:52 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 240CF68D0F; Fri, 18 May 2018 15:57:37 +0200 (CEST)
Date:   Fri, 18 May 2018 15:57:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@linux-mips.org
Subject: status of arch/mips/jazz
Message-ID: <20180518135737.GA32605@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

Hi Ralf, hi James, hi Thomas,

does anyone of you know the status of the Mips Jazz platform?
I've recently started work consolidating the various direct mapping
dma mapping implementations, and Jazz is soley responsible for a lot
of the complications of the common mips dma mapping implementation.

At the same time the port looks very much like bitrot given that the
last real JAzz commit was from Thomas in 2007.  So if there is any
chance to drop it, that would make my life a lot easier, if not
I'll accomodate it but I might need some help.
