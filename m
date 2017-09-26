Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 22:33:27 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:54902 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990633AbdIZUdUo2u4I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 22:33:20 +0200
Received: from localhost (74-93-104-102-Washington.hfc.comcastbusiness.net [74.93.104.102])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 138C41340110D;
        Tue, 26 Sep 2017 13:33:12 -0700 (PDT)
Date:   Tue, 26 Sep 2017 13:33:09 -0700 (PDT)
Message-Id: <20170926.133309.1916643567158187651.davem@davemloft.net>
To:     paul.burton@imgtec.com
Cc:     matt.redfearn@imgtec.com, netdev@vger.kernel.org,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH] net: stmmac: Meet alignment requirements for DMA
From:   David Miller <davem@davemloft.net>
In-Reply-To: <71740323.RRBhnhefTi@np-p-burton>
References: <587dc9a8-b974-e222-95b4-93c2a8f2aba2@imgtec.com>
        <20170926.103400.1009342814128022820.davem@davemloft.net>
        <71740323.RRBhnhefTi@np-p-burton>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Sep 2017 13:33:12 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60165
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
Date: Tue, 26 Sep 2017 11:48:19 -0700

>> The device writes into only the bytes it was given access to, which
>> starts at the DMA address.
> 
> OK - still fine but *only* if we don't write to anything that happens to be 
> part of the cache lines that are only partially covered by the DMA mapping & 
> make them dirty. If we do then any writeback of those lines will clobber data 
> the device wrote, and any invalidation of them will discard data the CPU 
> wrote.
> 
> How would you have us ensure that such writes don't occur?
> 
> This really does not feel to me like something to leave up to drivers without 
> any means of checking or enforcing correctness. The requirement to align DMA 
> mappings at cache-line boundaries, as outlined in Documentation/DMA-API.txt, 
> allows this to be enforced. If you want to ignore this requirement then there 
> is no clear way to verify that we aren't writing to cache lines involved in a 
> DMA transfer whilst the transfer is occurring, and no sane way to handle those 
> cache lines if we do.

The memory immediately before skb->data and immediately after
skb->data+skb->len will not be accessed.  This is guaranteed.

I will request something exactly one more time to give you the benfit
of the doubt that you want to show me why this is _really_ a problem
and not a problem only in theory.

Please show me an exact sequence, with current code, in a current driver
that uses the DMA API properly, where corruption really can occur.

The new restriction is absolutely not reasonable for this use case.
It it furthermore impractical to require the 200+ drivers the use this
technique to allocate and map networking buffers to abide by this new
rule.  Many platforms with even worse cache problems that MIPS handle
this just fine.

Thank you.
