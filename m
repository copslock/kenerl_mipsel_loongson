Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 16:24:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59214 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993179AbdIAOYRFdHTf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Sep 2017 16:24:17 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v81ENuQg031612;
        Fri, 1 Sep 2017 16:23:56 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v81ENt2t031611;
        Fri, 1 Sep 2017 16:23:55 +0200
Date:   Fri, 1 Sep 2017 16:23:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-spi@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        hauke.mehrtens@intel.com
Subject: Re: Applied "spi: spi-falcon: drop check of boot select" to the spi
 tree
Message-ID: <20170901142355.GB31297@linux-mips.org>
References: <20170417192942.32219-4-hauke@hauke-m.de>
 <E1dnjTy-0006AD-Ox@debutante>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1dnjTy-0006AD-Ox@debutante>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59909
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

On Fri, Sep 01, 2017 at 11:47:26AM +0100, Mark Brown wrote:

> The patch
> 
>    spi: spi-falcon: drop check of boot select
> 
> has been applied to the spi tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

Thanks Mark - but there are some ordering dependencies in Hauke's
patch series so it would be great if I could have an Acked-by to merge
this patch through the MIPS tree along with the rest of Hauke's series.

  Ralf
