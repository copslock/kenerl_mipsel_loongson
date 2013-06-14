Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 10:22:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59989 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822998Ab3FNIWZn871B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 10:22:25 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5E8MNe7011475;
        Fri, 14 Jun 2013 10:22:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5E8MKY7011474;
        Fri, 14 Jun 2013 10:22:20 +0200
Date:   Fri, 14 Jun 2013 10:22:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Grant Likely <grant.likely@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] irqdomain: Remove temporary MIPS workaround code
Message-ID: <20130614082220.GC22589@linux-mips.org>
References: <1371165583-21907-1-git-send-email-grant.likely@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371165583-21907-1-git-send-email-grant.likely@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36872
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

On Fri, Jun 14, 2013 at 12:19:43AM +0100, Grant Likely wrote:

> The MIPS interrupt controllers are all registering their own irq_domains
> now. Drop the MIPS specific code because it is no longer needed.
> 
> Signed-off-by: Grant Likely <grant.likely@linaro.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
> 
> Ralf, this should be okay to pull out now. I'll be submitting it for
> v3.11 unless someone yells. Even if so, all the irqdomain infrastructure
> is in place to make it trivial to add an irqdomain where missing.

I would like to merge this through the MIPS tree so it'll receive
maximum testing, just in case, ok?

  Ralf
