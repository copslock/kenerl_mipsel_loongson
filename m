Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 16:22:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57765 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009552AbbCaOWtHA2ir (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 16:22:49 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2VEMm57025521;
        Tue, 31 Mar 2015 16:22:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2VEMlAE025520;
        Tue, 31 Mar 2015 16:22:47 +0200
Date:   Tue, 31 Mar 2015 16:22:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bert Vermeulen <bert@biot.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 0/1] spi: Add driver for Routerboard RB4xx boards
Message-ID: <20150331142247.GG28951@linux-mips.org>
References: <1427739857-13395-1-git-send-email-bert@biot.com>
 <20150331084425.GI2869@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150331084425.GI2869@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46652
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

On Tue, Mar 31, 2015 at 09:44:25AM +0100, Mark Brown wrote:

> On Mon, Mar 30, 2015 at 08:24:16PM +0200, Bert Vermeulen wrote:
> > Changes in v2:
> > This is a near complete rewrite of the original OpenWrt driver. All comments
> > were taken into account, and the spi_transfer.fast_write flag is gone.
> > Instead, the cs_change flag is used. It's not too bad a hack, as it really
> > does use CS.
> 
> Don't send cover letters for single patches, if there's anything that
> needs saying it should either be in the changelog or after the ---.  A
> separate cover letter adds to the mail volume and probably means that
> the patch itself is inadequately described.

My personal grief with cover letters is that patchwork only collects
patches but cover letters themselves aren't patches.  Which means working
through patchwork I might miss important information.  Maybe I should
request an enhancement to patchwork.

  Ralf
