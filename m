Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 14:09:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54748 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028944AbcEKMJCIRblY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 14:09:02 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4BC907Y017391;
        Wed, 11 May 2016 14:09:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4BC90iU017390;
        Wed, 11 May 2016 14:09:00 +0200
Date:   Wed, 11 May 2016 14:09:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: [PATCH] MIPS: ath79: Remove CLK_IS_ROOT
Message-ID: <20160511120900.GN16402@linux-mips.org>
References: <1461116001-768-1-git-send-email-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461116001-768-1-git-send-email-sboyd@codeaurora.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53364
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

On Tue, Apr 19, 2016 at 06:33:21PM -0700, Stephen Boyd wrote:

> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
> 
> Cc: Antony Pavlov <antonynpavlov@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, applied.

  Ralf
