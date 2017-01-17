Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 15:50:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57216 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993889AbdAQOuYOB71d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 15:50:24 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0HEoImn024374;
        Tue, 17 Jan 2017 15:50:18 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0HEoHHc024373;
        Tue, 17 Jan 2017 15:50:17 +0100
Date:   Tue, 17 Jan 2017 15:50:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 04/15] MIPS: Alchemy: Don't rely on public mmc header
 to include interrupt.h
Message-ID: <20170117145017.GA24215@linux-mips.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-5-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484313256-25993-5-git-send-email-ulf.hansson@linaro.org>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56343
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

On Fri, Jan 13, 2017 at 02:14:05PM +0100, Ulf Hansson wrote:

> The MIPS Alchemy db1300 dev board depends on interrupt.h. Explicitly
> include it instead of relying on the public mmc header host.h.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: <linux-mips@linux-mips.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> I am seeking an ack for this change as following changes for mmc in the
> series, has build-dependencies to it.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
