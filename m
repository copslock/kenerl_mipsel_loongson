Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 12:35:50 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:35339 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992494AbeENKfR1ngVx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 12:35:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=V0XUMB0R5Zl83b72D4Y1RV+5t2FE4KGS/vDN0429Cxc=;
        b=xZq1LF52parPScZGqMgZOZRSErKVN6cjlAY32dCEcsvMBYM4xf6E/+IXSm69Hc1e245hrKRt9dgUdTPVZhpdFhFBSp1lccEdY5/0YIbZKm0hqFJvU02Yj5WPiKhh7MEIjAIz/+T5vr3WFHdKvOBU8J4+l3dP+BUcX80xAqUs8Ec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fHDeo-0004bk-S4; Fri, 11 May 2018 21:24:46 +0200
Date:   Fri, 11 May 2018 21:24:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Darren Hart <dvhart@linux.intel.com>, netdev@vger.kernel.org,
        linux-mips@linux-mips.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v6 1/6] net: phy: at803x: Export at803x_debug_reg_mask()
Message-ID: <20180511192446.GD12738@lunn.ch>
References: <20180510231657.28503-1-paul.burton@mips.com>
 <20180510231657.28503-2-paul.burton@mips.com>
 <20180511002619.GD5527@lunn.ch>
 <20180511182502.y74wm6dmtf3dbcln@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511182502.y74wm6dmtf3dbcln@pburton-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63927
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

> I could reorder the probe function a little to initialize the PHY before
> performing the MAC reset, drop this patch and the AR803X hibernation
> stuff from patch 2 if you like. But again, I can't actually test the
> result on the affected hardware.

Hi Paul

I don't like a MAC driver poking around in PHY registers.

So if you can rearrange the code, that would be great.

   Thanks
	Andrew
