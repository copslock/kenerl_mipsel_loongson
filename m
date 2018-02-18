Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 17:15:23 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:35878 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992828AbeBRQPM5pOFl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Feb 2018 17:15:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0T3yMbk8OShEVQcF/rvCd0lyg0aUjsJ0/5Y7q6TSHgA=;
        b=hFCocxf4G5I/wSmEu9tdeGLKIaN3uH8lQhO//38fv2gWM95knxOR/R+q57ro1rpK2qR2RyT9bEOnuOqDL+PSvog+SejzUThl5HBo/iF5RWcozg/eimi0NvNhtRJe1eQdGqe8TMiPYSRxegppBfhnCxiaOHBQS21D1gb94o1+0IU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1enRcB-00086a-2H; Sun, 18 Feb 2018 17:14:59 +0100
Date:   Sun, 18 Feb 2018 17:14:59 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     netdev@vger.kernel.org, Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>, linux-mips@linux-mips.org
Subject: Re: [PATCH v5 02/14] net: pch_gbe: Pull PHY GPIO handling out of
 Minnow code
Message-ID: <20180218161459.GA31083@lunn.ch>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-3-paul.burton@mips.com>
 <20180217222933.GB21315@lunn.ch>
 <20180217225022.x45ozstehuuunpp3@pburton-laptop>
 <20180217233442.GA24375@lunn.ch>
 <20180218155045.dbmplf3itouvantp@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218155045.dbmplf3itouvantp@pburton-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62613
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

> How would you feel if I were to adjust the binding to match the standard
> PHY binding, but internally leave the driver's PHY handling as-is for
> now?

Hi Paul

That is a reasonable compromise.

Thanks

     Andrew
