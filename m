Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 14:46:10 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:34974 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992408AbeIJMqGNF4ZV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Sep 2018 14:46:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=OKYuKTm5TVHNDl9LmhBPHHvEn6zMTmRZ6wGkroN9sDM=;
        b=VnHKsPpNg4nqlIsCm4q8tYL5SEJZW5chMPJuaU8y/N+xYcQePr+elJyWYWnCBVUSGLznwuITIMTUoJTrjQqG4C42c6lrqDedjuV0v+Amkmj515515pPxSI2uxdMPblSn6h630s8NiWhsDq+p38i9Qqmv4oPOd5H1Wwy18Lz1aQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fzLZW-0008Ji-Tt; Mon, 10 Sep 2018 14:45:42 +0200
Date:   Mon, 10 Sep 2018 14:45:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org,
        hauke.mehrtens@intel.com, paul.burton@mips.com
Subject: Re: [PATCH v2 net] MIPS: lantiq: dma: add dev pointer
Message-ID: <20180910124542.GB30395@lunn.ch>
References: <20180909192623.14998-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909192623.14998-1-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

On Sun, Sep 09, 2018 at 09:26:23PM +0200, Hauke Mehrtens wrote:
> dma_zalloc_coherent() now crashes if no dev pointer is given.
> Add a dev pointer to the ltq_dma_channel structure and fill it in the
> driver using it.
> 
> This fixes a bug introduced in kernel 4.19.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
> 
> no changes since v1.
> 
> This should go into kernel 4.19 and I have some other patches adding new 
> features for kernel 4.20 which are depending on this, so I would prefer 
> if this goes through the net tree. 

Hi Hauke

Is this a build time dependency, or a runtime dependency?

What we don't want to do is add the switch driver to net-next and find
it does not compile because this change is not in net-next yet.

   Andrew
