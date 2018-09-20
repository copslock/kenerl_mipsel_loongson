Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 23:39:08 +0200 (CEST)
Received: from mail-io1-xd43.google.com ([IPv6:2607:f8b0:4864:20::d43]:38029
        "EHLO mail-io1-xd43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994648AbeITVjEeAuMu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 23:39:04 +0200
Received: by mail-io1-xd43.google.com with SMTP id y3-v6so9918009ioc.5
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2018 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eg+vd5ggFSRvBp1nMxn8WnsMDdMW/WuDRawGX4bRb64=;
        b=CMU491cecrua94hYBC1oJl50GK+SchZvptcORr8XA3cjCM1fji485Wl3tL+KvebnjM
         N1pOyziM58hsWkAWZS4z8wxyTk1DdIo43a1XokIibPD2Fi8Rr1dwKwqH4n/apfrK/tX6
         Z22qTJdltEKlV0zIEMOqLhSUM/q/whkSc+PRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eg+vd5ggFSRvBp1nMxn8WnsMDdMW/WuDRawGX4bRb64=;
        b=HJqrDt2ZYh76hTS8+exoM5IA6REM8DNJUse2mpYxaku64RLjo50W8qRYsKZSLaKbHM
         DUpV8bRo4PbG3nqx7JsPpNFZ4hhdXqZi0YEtC7vwKOmqPSRnglg913yRBiLZFCjy38VO
         bgNP2eHgFYGqVJf9QVUOQVUdKMk84V642lJIeOwO5De+d6C099PCr/XYVpFoQqffvLyr
         bJpa4VIveNrUAmKpL520J14ZDXXc6hR9gLciZk1bAyhpP4+E0OJw0Iy81taRmEDPdMAU
         IF6IyAc/ZzBIISluQNlQ7K01nItURVu2fu6KvjzZ5+ErImnmCocupXt6zbT9EKvG0olr
         daOA==
X-Gm-Message-State: APzg51AstGHxPULHEmZfActzVrt3D4uVfoMj4RjoglR8a/JDwrcvVp5k
        uagX0cZgi/iD1X18l9ivwaG2TBYK4EHdfXwTo43Z9g==
X-Google-Smtp-Source: ANB0VdYVaju2MILde8XiDVZ3Y4Ywjp9Hck54iuCB7EJPzxXUu5SAa6qhxP182TFkVlA9l8QqgFb4LZCmIMm58oQM11A=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr3865756itd.130.1537479538060;
 Thu, 20 Sep 2018 14:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 14:38:44 -0700
Message-ID: <CACRpkdZYpDJGzexRr7y4LO+hyJ92aEu_eRquK50iBWaaox5H5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] add support for VSC8584 and VSC8574
 Microsemi quad-port PHYs
To:     quentin.schulz@bootlin.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        allan.nielsen@microchip.com,
        Linux MIPS <linux-mips@linux-mips.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

Just as a drive-by comment this seems vaguely related to the Vitesse
DSA switch I merged in drivers/net/dsa/vitesse-vsc73xx.c
The VSC* product name handily gives away the origin in Vitesse's
product line.

The VSC73xx also have the 8051 CPU and internal RAM, but are
accessed (typically) over SPI, and AFAICT this thing is talking over
MDIO.

The Vitesse 73xx however also supports a WAN port and VLANs
which makes it significantly different, falling into switch class I
guess.

These VSC85*4's does have an SPI interface as well, according
to the data sheet but I assume your target boards don't even
connect it?

When it comes to 8051 code we have quite a lot of this in the kernel
these days, I suspect the 8051 snippets in this code could be
disassembled and put into linux-firmware in source form, but
that is maybe a bit overly ambitious. We have done that for a few
USB to serial controllers using the EzUSB 8051 though:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/keyspan_pda
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/usbdux

These can rebuild their firmware using the as31 assembler.
https://github.com/nitsky/as31

Yours,
Linus Walleij
