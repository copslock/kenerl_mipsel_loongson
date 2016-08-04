Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2016 16:05:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34034 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993049AbcHDOF3abKu2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Aug 2016 16:05:29 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u74E5SK6025085;
        Thu, 4 Aug 2016 16:05:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u74E5Q0Q025084;
        Thu, 4 Aug 2016 16:05:26 +0200
Date:   Thu, 4 Aug 2016 16:05:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        James Hartley <james.hartley@imgtec.com>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: dont specify STACKPROTECTOR in defconfigs
Message-ID: <20160804140526.GA23195@linux-mips.org>
References: <20160803190359.6486-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160803190359.6486-1-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54413
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

On Wed, Aug 03, 2016 at 03:03:59PM -0400, Paul Gortmaker wrote:

> Only one defconfig has a STACKPROTECTOR value.  And it asks for
> the strong variant, which isn't supported by older toolchains.
> 
> Due to the nature of MIPS having more platform specific code than say
> x86, the allyesconfig and allmodconfig aren't as effective for build
> coverage.  So, in addition, I like to use a trivial script to walk all
> the defconfigs and build each one.
> 
> However I will get false positives on unsupported stackprotector values
> with an older toolchain like gcc-4.6.3.  As in this instance I am just
> using the compiler as a glorified syntax checker on a machine where I
> build a bunch of other arch for the same reason, there is no real
> motivation to get a newer toolchain for improved optimization etc.
> 
> Since there is only one of them, and there is nothing about these
> settings that are board/platform specific, I propose we just eliminate
> the existing instance and take the default.

Yeah, I can see how that one may get annoying.  I wish there was something
along the lines of KCONFIG_ALLCONFIG that was working not only for
allyesconfig/allmodconfig/allnoconfig/randconfig.

Applied.  Thanks,

  Ralf
