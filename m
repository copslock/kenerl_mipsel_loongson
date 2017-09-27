Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 04:53:01 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:35632 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdI0CwzEKvx3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 04:52:55 +0200
Received: from localhost (74-93-104-102-Washington.hfc.comcastbusiness.net [74.93.104.102])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 72B59133FDE7B;
        Tue, 26 Sep 2017 19:52:47 -0700 (PDT)
Date:   Tue, 26 Sep 2017 19:52:44 -0700 (PDT)
Message-Id: <20170926.195244.506518182147628099.davem@davemloft.net>
To:     paul.burton@imgtec.com
Cc:     matt.redfearn@imgtec.com, netdev@vger.kernel.org,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH] net: stmmac: Meet alignment requirements for DMA
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1752163.uYYNevmZpH@np-p-burton>
References: <71740323.RRBhnhefTi@np-p-burton>
        <20170926.133309.1916643567158187651.davem@davemloft.net>
        <1752163.uYYNevmZpH@np-p-burton>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Sep 2017 19:52:47 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60167
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
Date: Tue, 26 Sep 2017 14:30:33 -0700

> I'd suggest that at a minimum if you're unwilling to obey the API as
> described in Documentation/DMA-API.txt then it would be beneficial
> if you could propose a change to it such that it works for you, and
> perhaps we can extend the API & its documentation to allow your
> usage whilst also allowing us to catch broken uses.

The networking driver code works fine as is.

I also didn't write that ill-advised documentation in the DMA docs,
nor the non-merged new MIPS assertion.

So I'm trying to figure out on what basis I am required to do
anything.

Thank you.
