Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 12:36:16 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:35339 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992496AbeENKfRu7TLx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 12:35:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=2NMUvX435kZBIo7BvLkkKByBTJBZVCBcRhcooZ6Z3yY=;
        b=uqKtlcDvSGeSWW04lCd36ihhoeVWdU4L8g1dFfJFmIFVYJlzUSVcajKQ5ji4H0ndHKvrvBFimABe558oIifaNA5zgDzc0uaYD/pMbjXR16RI8Gnz3LWsI6n6DJt9RcJqya8Agrv88gKGaaUfd8xy3z0C2rVliqkzXtyMvzsgexE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fGvt5-0008TJ-7v; Fri, 11 May 2018 02:26:19 +0200
Date:   Fri, 11 May 2018 02:26:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v6 1/6] net: phy: at803x: Export at803x_debug_reg_mask()
Message-ID: <20180511002619.GD5527@lunn.ch>
References: <20180510231657.28503-1-paul.burton@mips.com>
 <20180510231657.28503-2-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231657.28503-2-paul.burton@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63929
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

On Thu, May 10, 2018 at 04:16:52PM -0700, Paul Burton wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> On some boards, this PHY has a problem when it hibernates. Export this
> function to a board can register a PHY fixup to disable hibernation.

What do you know about the problem?

https://patchwork.ozlabs.org/patch/686371/

I don't remember how it was solved, but you should probably do the
same.

	Andrew
