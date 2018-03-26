Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 00:50:43 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:48688 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992827AbeCZWue7eukh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Mar 2018 00:50:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=KHhWlmjjNNmZCs2CqfUq2ORbuwMUCcDKVVt2tsP5O3Q=;
        b=JAH1Ol2UWyI/f+x/sXz4j2EBkK8IbKK41JgrrfrD1O1nsJ2MlcnjOAgWc/S5Xt/uoNlN+86ZgIiaJ2WCLpKK95tcyalfmM4lwTcLsmInGeLioTtQrt2S7RodLtXZVZXFqW9bqHGzKTLOlfEkzGZghBZAUukkal95GtbNFmNqnbc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1f0awW-0004Yd-EU; Tue, 27 Mar 2018 00:50:20 +0200
Date:   Tue, 27 Mar 2018 00:50:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
Message-ID: <20180326225020.GF5862@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com>
 <a5db6109-c5d9-f573-893c-f7d66c3168c2@gmail.com>
 <20180326222514.4eciw66aihhcjgtw@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326222514.4eciw66aihhcjgtw@rob-hp-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63239
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

> ports and port collide with the OF graph binding. It would be good if 
> this moved to ethernet-port(s) or similar.

Hi Rob

Well, we have been using port in DSA since March 2013. ports is a bit
newer, June 2016.

Changing DSA is not going to happen. But new switch bindings could use
ethernet-port(s). It just makes them inconsistent with existing switch
drivers.

       Andrew
