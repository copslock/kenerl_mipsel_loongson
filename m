Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 18:41:15 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:55441 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991063AbeG2QlMuMaJk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jul 2018 18:41:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Fx8GrSTStQFlbAFSLJoV42Qh2uvAYG+6HnfSescql4c=;
        b=OYl2hlXbr1cUquMUwj2A/In8XEzwrFL3wewIUCNytTP7d2q/PfJDXMl2NTFtK7UfQwXlPfb1bj6pQFm4yRe1WjGl94LWtnsnHuuVZxWTuX3wADrkQ4SahiytGt/lm2tpZO8MqQgPmBt9n7wgdSbnjOU2EX6/genn9UAuQS67dVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fjokW-0003nl-VU; Sun, 29 Jul 2018 18:40:52 +0200
Date:   Sun, 29 Jul 2018 18:40:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 3/4] net: lantiq: Add Lantiq / Intel vrx200 Ethernet
 driver
Message-ID: <20180729164052.GA14420@lunn.ch>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-4-hauke@hauke-m.de>
 <20180725152857.GB16819@lunn.ch>
 <0ba31982-1657-aea8-42bc-0ea838621256@hauke-m.de>
 <20180729155106.GB13198@lunn.ch>
 <18f8bbd5-0623-7bed-c96a-c7b10f1e2cd2@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f8bbd5-0623-7bed-c96a-c7b10f1e2cd2@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65231
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

> I am thinking about merging this into the switch driver, then we do not
> have to configure the dependency any more.

Hi Hauke

Are there any PHYs which are not part of the switch?

Making it part of the switch driver would make sense. Are there any
backwards compatibility issues? I don't actually see any boards in
mailine using the compatible strings.

Another option would be to write an independent mdio driver, and make
firmware download part of that. That gives the advantage of supporting
PHYs which are not part of the switch.

     Andrew
