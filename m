Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2018 16:57:30 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:55352 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990471AbeIAO51ASrRw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2018 16:57:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=r687OzTzHsNQAk+R1W9pVc1G9KyksXTjC3ztJ36+H7w=;
        b=L9Ft3MbWVuNfFM3Fh34k6aJ7k6ixIewbdZVxD2e1OWgjlhr/SMI1okwZLvSlR601fEMpXUr2MvcbGuoGFA97+oi37apNq14PRChhFLG5SFN4RyxrIO7p1FDr5wjKHoV9jfZ6ZYG1bvfJ2Vu1QozuNzGtIO94MvHq9WYQpmIGN6I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fw7Ke-0001jc-HO; Sat, 01 Sep 2018 16:57:00 +0200
Date:   Sat, 1 Sep 2018 16:57:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/7] MIPS: lantiq: dma: add dev pointer
Message-ID: <20180901145700.GB6305@lunn.ch>
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901114535.9070-2-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901114535.9070-2-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65844
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

On Sat, Sep 01, 2018 at 01:45:29PM +0200, Hauke Mehrtens wrote:
> dma_zalloc_coherent() now crashes if no dev pointer is given.
> Add a dev pointer to the ltq_dma_channel structure and fill it in the
> driver using it.
> 
> This fixes a bug introduced in kernel 4.19.

Hi Hauke

Should this be added to stable so that it appears in 4.19-rcX?  If so,
please send it to net, not net-next.

       Andrew
