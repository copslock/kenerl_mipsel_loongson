Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 14:12:12 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:39941 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990418AbeKINK0OimYY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2018 14:10:26 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 58A9B20701; Fri,  9 Nov 2018 14:10:25 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 271D4207B0;
        Fri,  9 Nov 2018 14:10:15 +0100 (CET)
Date:   Fri, 9 Nov 2018 14:10:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-mips@linux-mips.org
Subject: dma_pool broken on MIPS generic?
Message-ID: <20181109131014.GA29768@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Hello,

I'm working on a (not yet upstreamed) dmaengine driver. While rebasing
from v4.19 to v4.20-rc1, I saw that it is not working properly anymore
because dma_pool is allocating descriptors in kseg0 which is cached
while in v4.19, it was allocating them in kseg1.

Am I missing something to explicitely state that the cache is not dma
coherent? How could I track this behaviour change?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
