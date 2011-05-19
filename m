Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 05:33:21 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:45137 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490987Ab1ESDdM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 05:33:12 +0200
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4J3W8hG009979;
        Wed, 18 May 2011 22:32:49 -0500
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-m32r@ml.linux-m32r.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        sparclinux@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 19 May 2011 13:32:07 +1000
Message-ID: <1305775927.7481.31.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Fri, 2011-05-06 at 22:57 -0700, Stephen Boyd wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
> 
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.

Sorry for the delay...

For powerpc:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
