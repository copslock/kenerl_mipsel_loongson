Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 18:29:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38666 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008755AbbIVQ3mQ-bnr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Sep 2015 18:29:42 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8MGTdQl017309;
        Tue, 22 Sep 2015 18:29:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8MGTXVL017308;
        Tue, 22 Sep 2015 18:29:33 +0200
Date:   Tue, 22 Sep 2015 18:29:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Andy Gross <agross@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Paul Walmsley <paul@pwsan.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 3/3] FIRMWARE: bcm47xx_nvram: Use __ioread32_copy()
 instead of open-coding
Message-ID: <20150922162932.GB16339@linux-mips.org>
References: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
 <1442516531-16071-4-git-send-email-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1442516531-16071-4-git-send-email-sboyd@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49273
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

On Thu, Sep 17, 2015 at 12:02:11PM -0700, Stephen Boyd wrote:

> Now that we have a generic library function for this, replace the
> open-coded instance.
> 
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Rafał Miłecki <zajec5@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Looking good.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
