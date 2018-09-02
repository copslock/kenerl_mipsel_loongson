Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2018 03:27:17 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:55484 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992891AbeIBB1Ox2G0O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 2 Sep 2018 03:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=saBiqD4pL2lbCpTU+iyPzwMx2CuD/Q8RPrDTtn8QxS8=;
        b=L+0rBMVDxKufS42Nv4yCHVHRahAgCSCu3Rgq5lyP/VGiuZpSGz6COXUwnHJgdspH9ZpbcFx28zYR/RRLtLHEC0LQ+zOzRtocdZGnCEpsb840RT0j6HdReYu5aZQcMukf8uXsBiW7qM1b9JPEWPH523C6xHus8yVoSEfDfMomkqI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fwHAB-0002uW-Ak; Sun, 02 Sep 2018 03:26:51 +0200
Date:   Sun, 2 Sep 2018 03:26:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/7] MIPS: lantiq: dma: add dev pointer
Message-ID: <20180902012651.GB9776@lunn.ch>
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901114535.9070-2-hauke@hauke-m.de>
 <20180901145700.GB6305@lunn.ch>
 <6674a5ca-2a9f-b2cf-6127-2dea5ca24ab0@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6674a5ca-2a9f-b2cf-6127-2dea5ca24ab0@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65849
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

> Hi Andrew,
> 
> Thanks for the review.
> 
> Yes this should go into 4.19-rcX.
> The "lantiq: Add Lantiq / Intel VRX200 Ethernet driver" patch has a
> compile dependency on this patch. Should I send "MIPS: lantiq: dma: add
> dev pointer" separately or just mark it as 4.19-rcX in this series?

Hi Hauke

Please send it separately. DaveM will merge net in net-next every so
often, at which point your patches which depend on it can be include.
       
       Andrew
