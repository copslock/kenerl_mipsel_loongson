Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 06:53:40 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:38110 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdI0ExcorrgC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 06:53:32 +0200
Received: from localhost (74-93-104-102-Washington.hfc.comcastbusiness.net [74.93.104.102])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2279F1340112D;
        Tue, 26 Sep 2017 21:53:22 -0700 (PDT)
Date:   Tue, 26 Sep 2017 21:53:21 -0700 (PDT)
Message-Id: <20170926.215321.424825014223425519.davem@davemloft.net>
To:     paul.burton@imgtec.com
Cc:     matt.redfearn@imgtec.com, netdev@vger.kernel.org,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH] net: stmmac: Meet alignment requirements for DMA
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2520219.WSsBr6LeCR@np-p-burton>
References: <1752163.uYYNevmZpH@np-p-burton>
        <20170926.195244.506518182147628099.davem@davemloft.net>
        <2520219.WSsBr6LeCR@np-p-burton>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Sep 2017 21:53:22 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60169
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

From: Paul Burton <paul.burton@imgtec.com>
Date: Tue, 26 Sep 2017 21:30:56 -0700

> Nobody said that you are required to do anything, I suggested that
> it would be beneficial if you were to suggest a change to the
> documented DMA API such that it allows your usage where it currently
> does not.

Documentation is often wrong and it is here.  What 200+ drivers
actually do and depend upon trumps a simple text document.

The requirement is that the memory remains quiescent on the cpu side
while the device messes with it.  And that this quiescence requirement
may or may not be on a cache line basis.

There is absolutely no requirement that the buffers themselves are
cache line aligned.

In fact, receive buffers for networking are intentionally 2-byte
aligned in order for the ipv4 headers to be naturally 32-bit aligned.

Cache line aligning receive buffers will actually make some
architectures trap because of the bad alignment.

So see, this cache line alignment requirement is pure madness from
just about any perspective whatsoever.
