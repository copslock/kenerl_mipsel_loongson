Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 15:07:05 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994666AbeIKNG7C81Sn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 15:06:59 +0200
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A1C20870
        for <linux-mips@linux-mips.org>; Tue, 11 Sep 2018 13:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536671212;
        bh=bsy+ELPuKHMEREOgDeSwVnRFIFOHGnnik/+RNqHgqSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O0e9Rv8/O2S/7JK66xds4n69vdUQztHc7LhofUWMA8Htelpd0boZEmaJ40gOdD3Lv
         MedQ2EFXqO6w5f2qGIouU9bfWdOR+OzZtWeCu8D0pN23TnTDAEqZJSw4NJeD8I6YBw
         VE5ZNxo6+i6em2e+50nG2ACjGCy9dVKCx9k+Ls5g=
Received: by mail-qt0-f170.google.com with SMTP id g53-v6so28027959qtg.10
        for <linux-mips@linux-mips.org>; Tue, 11 Sep 2018 06:06:52 -0700 (PDT)
X-Gm-Message-State: APzg51B3pVOmq73J7jQoanMDR2Tfsybk6O8mTS6bUhqdI2f6O/vaOy9j
        Ytc4P2CJMEYTpT4K9V6CacZAUHS/3n1uGeJXNQ==
X-Google-Smtp-Source: ANB0VdYHwymkXckykJ1nrJxWjLE2OLIni9H7bR8uJ4u+hT0xuts91sXH6XjIFJSNLvBpjp9vFsubn0vmfq32j8MuvMw=
X-Received: by 2002:ad4:414b:: with SMTP id z11-v6mr18545034qvp.77.1536671211543;
 Tue, 11 Sep 2018 06:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180909201647.32727-1-hauke@hauke-m.d> <20180909202027.411-1-hauke@hauke-m.de>
 <20180910220119.GA32582@bogus> <20180910220516.GA16024@lunn.ch>
In-Reply-To: <20180910220516.GA16024@lunn.ch>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Sep 2018 08:06:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+uvEK+rUXY9g+PUGtLGZVpAH0ws5QFHJSKghkeKrTqrA@mail.gmail.com>
Message-ID: <CAL_Jsq+uvEK+rUXY9g+PUGtLGZVpAH0ws5QFHJSKghkeKrTqrA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/6] dt-bindings: net: dsa: Add
 lantiq,xrx200-gswip DT bindings
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, dev@kresin.me,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66201
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

On Mon, Sep 10, 2018 at 5:05 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > +See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of
> > > +additional required and optional properties.
> > > +
> > > +
>
> snip
>
> > > +   #address-cells = <1>;
> > > +   #size-cells = <0>;
> > > +   compatible = "lantiq,xrx200-gswip";
> > > +   reg = < 0xE108000 0x3000 /* switch */
> > > +           0xE10B100 0x70 /* mdio */
> > > +           0xE10B1D8 0x30 /* mii */
> > > +           >;
> > > +   dsa,member = <0 0>;
> >
> > Not documented.
>
> Hi Rob
>
> It is documented in Documentation/devicetree/bindings/net/dsa/dsa.txt
> referenced above.

Hum, okay. Not something I recall reviewing. Not that I tend to
remember, but 'dsa' is not a vendor and the property should be
'dsa-member'.

Rob
