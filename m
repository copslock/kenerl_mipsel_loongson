Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2018 20:01:49 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:55395 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992408AbeIASBqMSU9l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2018 20:01:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GaZgnOdxb3crri8FWiVpVUpMMbiwQnfiJq0BSoBw6hY=;
        b=LlCsMNjw2pbpmkUMekc7IYF/nTlqNI7q02B2PmULg4+5HDn+dbgTxAly809r5ftFTOrd9DHcpB64uTokvnL1C75EMZDFe4IcwC2VHJ3IBn5DfojvN+V3ulqWB48lKCWb4huK26km12lKN2gqeMSmgAp0Ozn9AFSScpMXDbe2yFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fwAD9-00021c-Vb; Sat, 01 Sep 2018 20:01:27 +0200
Date:   Sat, 1 Sep 2018 20:01:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/7] net: dsa: Add Lantiq / Intel GSWIP tag
 support
Message-ID: <20180901180127.GC6305@lunn.ch>
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120332.9792-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901120332.9792-1-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65845
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

On Sat, Sep 01, 2018 at 02:03:32PM +0200, Hauke Mehrtens wrote:
> This handles the tag added by the PMAC on the VRX200 SoC line.
> 
> The GSWIP uses internally a GSWIP special tag which is located after the
> Ethernet header. The PMAC which connects the GSWIP to the CPU converts
> this special tag used by the GSWIP into the PMAC special tag which is
> added in front of the Ethernet header.
> 
> This was tested with GSWIP 2.1 found in the VRX200 SoCs, other GSWIP
> versions use slightly different PMAC special tags.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
