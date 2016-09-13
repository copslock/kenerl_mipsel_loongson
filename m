Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 14:43:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36464 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992186AbcIMMnRA5wof (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Sep 2016 14:43:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8DChFD4021236;
        Tue, 13 Sep 2016 14:43:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8DChEeX021235;
        Tue, 13 Sep 2016 14:43:14 +0200
Date:   Tue, 13 Sep 2016 14:43:14 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        "stable # v4 . 4+" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Remove compact branch policy Kconfig entries
Message-ID: <20160913124314.GA20655@linux-mips.org>
References: <20160912095806.4411-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160912095806.4411-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55123
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

On Mon, Sep 12, 2016 at 10:58:06AM +0100, Paul Burton wrote:

> Fixing this by hiding the Kconfig entry behind another seems to be more
> hassle than it's worth, as MIPSr6 & compact branches have been around
> for a while now and if policy does need to be set for debug it can be
> done easily enough with KCFLAGS. Therefore remove the compact branch
> policy Kconfig entries & their handling in the Makefile.

I've applied your patch - and given where we are wrt. to R6 I think this
simply and bulletproof solution is certainly the right thing.

But, have you considered probing for the option and only using it where
it actually is available with something like:

cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_NEVER)   += $(call cc-option,-mcompact-branches=never)
cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_OPTIMAL) += $(call cc-option,-mcompact-branches=optimal)
cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_ALWAYS)  += $(call cc-option,-mcompact-branches=always)

?

I'm also wondering how much we gain from -mcompact-branches?

  Ralf
