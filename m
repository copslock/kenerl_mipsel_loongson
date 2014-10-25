Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2014 14:59:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33692 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010799AbaJYM7F7XBKP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Oct 2014 14:59:05 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9PCx3kf017088;
        Sat, 25 Oct 2014 14:59:03 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9PCx1cP017087;
        Sat, 25 Oct 2014 14:59:01 +0200
Date:   Sat, 25 Oct 2014 14:59:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] MIPS: Alchemy: Remove direct access to
 prepare_count field of struct clk
Message-ID: <20141025125901.GC16738@linux-mips.org>
References: <1413812442-24956-1-git-send-email-tomeu.vizoso@collabora.com>
 <1413812442-24956-2-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413812442-24956-2-git-send-email-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43564
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

On Mon, Oct 20, 2014 at 03:40:01PM +0200, Tomeu Vizoso wrote:

> Replacing it with a call to __clk_is_prepared(), which isn't entirely
> equivalent but in practice shouldn't matter.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

I'm going to merge this via the MIPS tree so it's going to receive some
testing.

Thanks,

  Ralf
