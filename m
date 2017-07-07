Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 16:17:57 +0200 (CEST)
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33731 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbdGGORvUU4ZC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 16:17:51 +0200
Received: by mail-yw0-f195.google.com with SMTP id f200so1827375ywb.0;
        Fri, 07 Jul 2017 07:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=beQ4dgmpdr/aPmyOdIzd1D2INzQGpM4kbNPbCWprsMc=;
        b=MIIgfN5RmDknv/pTSFX+zlkJOBvSSblYWPJSq/HUkv44L2r0m5KVzz0vSQeEMtLmJa
         Knl1R3YNsu3E97dWoCzwykvx3F0J1s+hFbixHXj4FmY7OqP/tTQSXav/UZTWXE5l7RQy
         bmVcaNP7I9yOf1FnfECcalIBU9iiA3HtJkXn0S5hOQ54ee/jDMeI5i9nKKVFb64s/Pu4
         zVjqHIalvgCsFjnqzQc5RLoDl3K26IrM0clauyZDCX99TZpEA97rAl0Q15KoWFX4+1g4
         eXo26FMKlHUzm1FEG4hUnaH2EVlA/ZUotyzTwSkGvWq0GJEDMwDy/tkfzGREK4KEkmiF
         ta8A==
X-Gm-Message-State: AIVw110mw1SKojSjFcImqIFL2tzUJ+3n3iGufVwJbh0SS+QuZJx+Woat
        Wm3kO/9pccECPQ==
X-Received: by 10.13.206.129 with SMTP id q123mr1929748ywd.266.1499437065636;
        Fri, 07 Jul 2017 07:17:45 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 142sm1335632ywf.32.2017.07.07.07.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jul 2017 07:17:45 -0700 (PDT)
Date:   Fri, 7 Jul 2017 09:17:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v7 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Message-ID: <20170707141744.atno6j3f7hcidxze@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-11-hauke@hauke-m.de>
 <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59050
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

On Mon, Jul 03, 2017 at 10:51:51AM +0300, Andy Shevchenko wrote:
> On Mon, Jul 3, 2017 at 1:40 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > The reset controllers (on xRX200 and newer SoCs have two of them) are
> > provided by the RCU module. This was initially implemented as a simple
> > reset controller. However, the RCU module provides more functionality
> > (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> > The old reset controller driver implementation from
> > arch/mips/lantiq/xway/reset.c did not honor this fact.
> >
> > For some devices the request and the status bits are different.
> 
> > +Required properties:
> > +- compatible           : Should be one of
> > +                               "lantiq,danube-reset"
> > +                               "lantiq,xrx200-reset"
> > +- offset-set           : Offset of the reset set register
> > +- offset-status                : Offset of the reset status register
> 
> Just one side comment (I'm fine with either choice, just for your
> information). Recently I have reviewed at24 patch which adds a
> property for getting MAC offset and my reseach ends up with the naming
> pattern mac-offset (as many others are doing this way). So, perhaps in
> your case it might make sense to do that way? Anyway, it's a matter of
> a (bit of a) chaos in DT bindings, whatever you decide users will live
> with.

Not a pattern I want to standardize. Describing offsets is generally an 
indication of the compatible not being specific enough.

Rob
