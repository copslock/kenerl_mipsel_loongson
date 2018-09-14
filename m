Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 15:11:37 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:40404 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeINNLa0BUp- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 15:11:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=s4nWFdd2MpkduTJPxDk3TBXtEB+2ugjg25uHMGhgH48=;
        b=TibkeP1dQtYjh2sXq71ZxloV4FbR1ovXcu6Snup7ZGjb3j+y5CTxIi2SIRVw0Ilm/N7na+GF1VKAOmKIGQpe+S5ULeheHKL2CujtlmLn4xz2yRtpyx1nMsEFAdPTKqAva4ZipAsShNjwO7pjgHS8AvV+fOYOmy1Jq8bjGDt9F3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0nsV-0004K9-H7; Fri, 14 Sep 2018 15:11:19 +0200
Date:   Fri, 14 Sep 2018 15:11:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 1/7] dt-bindings: net: vsc8531: add two
 additional LED modes for VSC8584
Message-ID: <20180914131119.GF14865@lunn.ch>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66290
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

On Fri, Sep 14, 2018 at 11:44:22AM +0200, Quentin Schulz wrote:
> The VSC8584 (and most likely other PHYs in the same generation) has two
> additional LED modes that can be picked, so let's add them.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
