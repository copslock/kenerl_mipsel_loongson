Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2014 00:11:18 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47537 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825879AbaAVXLQG5-RA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jan 2014 00:11:16 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s0MNBFR5007791;
        Thu, 23 Jan 2014 00:11:15 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s0MNBDeC007790;
        Thu, 23 Jan 2014 00:11:13 +0100
Date:   Thu, 23 Jan 2014 00:11:13 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org
Subject: Re: [PATCH mips-for-linux-next] MIPS: check for D$ line size and
 CONFIG_MIPS_L1_SHIFT
Message-ID: <20140122231113.GE14169@linux-mips.org>
References: <1389812722-30035-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1389812722-30035-1-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39075
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

On Wed, Jan 15, 2014 at 11:05:22AM -0800, Florian Fainelli wrote:

> When a platform overrides the dcache_line_size detection in its
> cpu-features-override.h file, check that the value matches
> (1 << CONFIG_MIPS_L1_SHIFT) to ensure both settings are correct.

Conceptually wrong - the two values serve an entirely different purpose.
dcache_line_size is used for cache maintenance by the MIPS code while
CONFIG_MIPS_L1_SHIFT - which has to be a constant due to the way it's
being used - are being used to define L1_CACHE_SHIFT in <asm/cache.h>
which in turn is being used primarily to optimize the memory layout of
various structures for performance - and in case of IP27 we lie, set
L1_CACHE_SHIFT to 7 which is the size of the S-cache.

On top of that it breaks the ip27 build.

And while we're at it, the use of CONFIG_MIPS_L1_SHIFT in
arch/mips/kernel/vmlinux.lds.S is fishy - but it needs a constant and
this should be good enough for all users.

  Ralf
