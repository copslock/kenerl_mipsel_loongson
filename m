Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 06:16:25 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:47239 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491134Ab1IOEQV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Sep 2011 06:16:21 +0200
Received: by iaep9 with SMTP id p9so1043389iae.36
        for <multiple recipients>; Wed, 14 Sep 2011 21:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xRgenVzK32h1nsbjcOU2elNyb7NaXr7GjZKuIePRNzM=;
        b=e3Jq5amCTqQ6LGrzzjC+fCT/pezv6II91fLD+mMYJqjq04LEroUj1dLs1kmoZp1Bqt
         v4orBVm5Wa11NydBEvi8LVhrx/gsThnGYHBdNgcYYjBMtJiP5mr99lSpUNDWwzWS8V5L
         GYSA4g+XSzQ1Rm1y7kAHZsqtUXOx7L3F2eCcU=
Received: by 10.42.77.73 with SMTP id h9mr335135ick.185.1316060174002;
        Wed, 14 Sep 2011 21:16:14 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-68-122-40-123.dsl.pltn13.pacbell.net. [68.122.40.123])
        by mx.google.com with ESMTPS id a11sm2934289ibg.3.2011.09.14.21.16.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 21:16:13 -0700 (PDT)
Message-ID: <4E717C0A.5050905@gmail.com>
Date:   Wed, 14 Sep 2011 21:16:10 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc13 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     David Daney <david.daney@cavium.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
References: <1314820906-14004-1-git-send-email-david.daney@cavium.com>        <1314820906-14004-3-git-send-email-david.daney@cavium.com> <CACxGe6tA6D9JVf0_K-JAGnKcQmDmD=1ytqqYb6or-KjP9uZNxg@mail.gmail.com>
In-Reply-To: <CACxGe6tA6D9JVf0_K-JAGnKcQmDmD=1ytqqYb6or-KjP9uZNxg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7583

On 09/14/2011 05:51 PM, Grant Likely wrote:
>
>
> On Aug 31, 2011 2:01 PM, "David Daney" <david.daney@cavium.com 
> <mailto:david.daney@cavium.com>> wrote:
> >
> > This patch adds a somewhat generic framework for MDIO bus
> > multiplexers.  It is modeled on the I2C multiplexer.
> >
>
[...]
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mdio-mux.txt
> > @@ -0,0 +1,132 @@
> > +Common MDIO bus multiplexer/switch properties.
> > +
> > +An MDIO bus multiplexer/switch will have several child busses that are
> > +numbered uniquely in a device dependent manner.  The nodes for an MDIO
> > +bus multiplexer/switch will have one child node for each child bus.
> > +
> > +Required properties:
> > +- parent-bus : phandle to the parent MDIO bus.
>
> As discussed, I like mdio-parent-bus.
>
> > +
> > +Optional properties:
> > +- Other properties specific to the multiplexer/switch hardware.
> > +
> > +Required properties for child nodes:
> > +- #address-cells = <1>;
> > +- #size-cells = <0>;
> > +- cell-index : The sub-bus number.
>
> Use reg, not cell-index. That is what it is there for. And add the 
> appropriate #address/size-cells in the parent.
>
> I've not reviewed the implementation, but with the changes. I'm okay 
> with the binding.
>

Thanks for the prompt reply Grant.

I will rework this with the binding changes and send a new version soon.

David Daney
