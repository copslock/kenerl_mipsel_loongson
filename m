Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 20:41:02 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:43140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993041AbeEPSkzIN55o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2018 20:40:55 +0200
Received: from localhost (67.110.78.66.ptr.us.xo.net [67.110.78.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 67FCC14075F70;
        Wed, 16 May 2018 11:40:48 -0700 (PDT)
Date:   Wed, 16 May 2018 14:40:47 -0400 (EDT)
Message-Id: <20180516.144047.1624723916101183580.davem@davemloft.net>
To:     geert@linux-m68k.org
Cc:     arnd@arndb.de, linux@dominikbrodowski.net, anemo@mba.ocn.ne.jp,
        netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 8390: ne: Fix accidentally removed RBTX4927
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1526462281-20772-1-git-send-email-geert@linux-m68k.org>
References: <1526462281-20772-1-git-send-email-geert@linux-m68k.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 May 2018 11:40:49 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 May 2018 11:18:01 +0200

> The configuration settings for RBTX4927 were accidentally removed,
> leading to a silently broken network interface.
> 
> Re-add the missing settings to fix this.
> 
> Fixes: 8eb97ff5a4ec941d ("net: 8390: remove m32r specific bits")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Bisected between v4.9-rc2 (doh) and v4.17-rc5.
> 
> Note to myself: I should do more boot testing on RBTX4927.
> Fortunately I caught it before it ends up in a point release ;-)

Better to go on a wild bisect ride than not be able to find the
bug at all :-)

Applied, thanks.
