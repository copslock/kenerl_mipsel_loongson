Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 12:36:04 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:35339 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992495AbeENKfRoms0x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 12:35:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=v2zVuptGWyUoqTdtAD/3O9aAhl26RB4s9cxFvpajoZM=;
        b=CcXIuhjKwOmggbt1Sxg/SsKHnCSjg999Yi3Ku7PFyx9EKPxFDeaiKHVwKFLfifRjxjEedN0SjhxC5k+VP9MyUX7dr657GC3CNSPAZrxTOADUU4cTNhdykgizNBJLmLEA62DA7S16Fz5KXCw6QRw82zn0ZPkZltdF8/4OtJ4iqtM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fGvv5-0008Us-DT; Fri, 11 May 2018 02:28:23 +0200
Date:   Fri, 11 May 2018 02:28:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v6 6/6] MIPS: Boston: Adjust DT for pch_gbe PHY support
Message-ID: <20180511002823.GE5527@lunn.ch>
References: <20180510231657.28503-1-paul.burton@mips.com>
 <20180510231657.28503-7-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231657.28503-7-paul.burton@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63928
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

> +					ethernet-phy@0 {
> +						compatible = "ethernet-phy-id001c.c915";

You only need to specify the compatible string like this if the PHY
has its own ID wrong. The AT802x gets this right, so you don't need
this.

	Andrew
