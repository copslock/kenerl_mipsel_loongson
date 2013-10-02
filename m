Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 11:25:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45775 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6865325Ab3JBJZDHJU3g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Oct 2013 11:25:03 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r929P0Qe024462;
        Wed, 2 Oct 2013 11:25:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r929Ov25024461;
        Wed, 2 Oct 2013 11:24:57 +0200
Date:   Wed, 2 Oct 2013 11:24:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: db1235: Don't use MMC_CLKGATE
Message-ID: <20131002092457.GB23236@linux-mips.org>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
 <1380552120-31003-2-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380552120-31003-2-git-send-email-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38090
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

On Mon, Sep 30, 2013 at 04:41:59PM +0200, Ulf Hansson wrote:

> As a first step in removing code for MMC_CLKGATE, MIPS db1235 defconfig
> which is the only current user, shall move away from this option.
> 
> The mmc host drivers au1xmmc and jz4740_mmc, which are used on MIPS
> don't support clock gating through MMC_CLKGATE, thus removing the
> config option will have no effect on power save - clock gating wise.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Feel free to feed this MIPS patch to Linus via the MMC tree.

  Ralf
