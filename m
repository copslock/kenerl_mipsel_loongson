Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 18:41:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59915 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013045AbbE1Ql03gjlN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 May 2015 18:41:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4SGfSSP009954;
        Thu, 28 May 2015 18:41:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4SGfS5u009953;
        Thu, 28 May 2015 18:41:28 +0200
Date:   Thu, 28 May 2015 18:41:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Petri Gynther <pgynther@google.com>, linux-mips@linux-mips.org,
        cernekee@gmail.com
Subject: Re: [PATCH] MIPS: BMIPS: fix bmips_wr_vec()
Message-ID: <20150528164128.GC7012@linux-mips.org>
References: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
 <556600B5.70402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556600B5.70402@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47709
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

On Wed, May 27, 2015 at 10:36:53AM -0700, Florian Fainelli wrote:

> On 26/05/15 23:25, Petri Gynther wrote:
> > bmips_wr_vec() copies exception vector code from start to dst.
> > 
> > The call to dma_cache_wback() needs to flush (end-start) bytes,
> > starting at dst, from write-back cache to memory.
> > 
> > Signed-off-by: Petri Gynther <pgynther@google.com>
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Fixes: df0ac8a406718 ("MIPS: BMIPS: Add SMP support code for
> BMIPS43xx/BMIPS5000")
> CC: stable@vger.kernel.org # 3.4+

Actually 3.3+ I think.

  Ralf
