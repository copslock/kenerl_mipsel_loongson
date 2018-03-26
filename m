Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 00:25:28 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37781 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992618AbeCZWZVsrb6o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 00:25:21 +0200
Received: by mail-oi0-f67.google.com with SMTP id e8-v6so3774163oii.4
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2018 15:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BiqRyVESSsVLRKTDM4JFk4wK1JiD6x6TTk1rOIves0s=;
        b=nyQ6UcV8hc7MV4N78TzkCwR6jyCmMD5IuW5i5LU7dySagibCzMRVaGsF4GGrHxNL2a
         4FSZzbgWpo7Y5Kyafc1d1NeWRz1mAB6UM/+A9LyEE8nMjp7p6Cam1D+xtjW22y4Eb3r2
         c9brfPhU0g6uJ6IQ+FnS+NoGRr/LzMzQC2iDKzcGGkimsQOsQkcL6MfOllSXJUHqE5Vu
         8okoA/ZlG3GpO+TL4RssGQ6om86eN0pFnZbGEHCLAV8GVfsl9bXAgA+WvfJy6KO5xgIv
         86+SnwQRtGVvVUHhIR3FXjpHRCbZOHuZoVfoamCBe3CaFegA+T5du/aGBQnRazeecY6C
         C39g==
X-Gm-Message-State: AElRT7Gtw40x2Tn582u4WgpCAx17d+OHZ2/T6Nf+J/nbiWViO6zYh9/t
        YyDtnGZXAVU0hb7XdvMQcA==
X-Google-Smtp-Source: AG47ELsKEe5zzrQjDAURC5iEmCnPG78hNobK2dHb2egwp7H4j+xIgtlctFYe+IHPgzv3WcDTtFVRCw==
X-Received: by 10.202.206.148 with SMTP id e142mr16199314oig.194.1522103115619;
        Mon, 26 Mar 2018 15:25:15 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id g33-v6sm10771224otc.61.2018.03.26.15.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 15:25:15 -0700 (PDT)
Date:   Mon, 26 Mar 2018 17:25:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
Message-ID: <20180326222514.4eciw66aihhcjgtw@rob-hp-laptop>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com>
 <a5db6109-c5d9-f573-893c-f7d66c3168c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5db6109-c5d9-f573-893c-f7d66c3168c2@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Mar 23, 2018 at 02:11:35PM -0700, Florian Fainelli wrote:
> On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> > DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  .../devicetree/bindings/net/mscc-ocelot.txt        | 62 ++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> > new file mode 100644
> > index 000000000000..ee092a85b5a0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> > @@ -0,0 +1,62 @@
> > +Microsemi Ocelot network Switch
> > +===============================
> > +
> > +The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
> > +VSC7514)
> > +
> > +Required properties:
> > +- compatible: Should be "mscc,ocelot-switch"
> > +- reg: Must contain an (offset, length) pair of the register set for each
> > +  entry in reg-names.
> > +- reg-names: Must include the following entries:
> > +  - "sys"
> > +  - "rew"
> > +  - "qs"
> > +  - "hsio"
> > +  - "qsys"
> > +  - "ana"
> > +  - "portX" with X from 0 to the number of last port index available on that
> > +    switch
> > +- interrupts: Should contain the switch interrupts for frame extraction and
> > +  frame injection
> > +- interrupt-names: should contain the interrupt names: "xtr", "inj"
> 
> You are not documenting the "ports" subnode(s).Please move the
> individual ports definition under a ports subnode, mainly for two reasons:
> 
> - it makes it easy at the .dtsi level to have all ports disabled by default
> 
> - this makes you strictly conforming to the DSA binding for Ethernet
> switches and this is good for consistency (both parsing code and just
> representation).

ports and port collide with the OF graph binding. It would be good if 
this moved to ethernet-port(s) or similar.

Rob
