Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 16:10:55 +0200 (CEST)
Received: from mail-yb0-f195.google.com ([209.85.213.195]:32853 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbdGGOKricXSC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 16:10:47 +0200
Received: by mail-yb0-f195.google.com with SMTP id 84so1453481ybe.0;
        Fri, 07 Jul 2017 07:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qZx0CwDz1Mgg9yRtNUETt1BwDoHazrDf/TtSZmYFsKg=;
        b=lazl2M0eR+WJDNFkNppEzb8xyjxbhDDcS5ZOmLRgSBbegtdR+sF+h0svuPm/N3RX3P
         ufleFquNHUe54vBSYzrMMo5hji2k3lxIBo0zkn9GdeZyAikRJb+MPx2H/PY8/iRiHWD3
         M3lCmgQYFto862LbF2IHks4ZS7XIlC3uYDzOVlWhIyVXvS4MmKy7m2S77KanUut9Vgzh
         RYtK2GM3tzfGvxx0GklkoGyMDUacl/IzUVHXimb0FyLIIz7wAtZnphnKGiQhg1TDt1JZ
         CPnU8G7VpUOnRWXoyhBYX8e+SifWCYFOegpijvinSCIsW7mCrTHsaDWMJ2exymPttGZa
         GK5w==
X-Gm-Message-State: AIVw111d7yveY/U+DSbf8cPP6AenibJjQ6NfXQnDGsR/hyYiRY2wT7/G
        JBQtBTYhghQ4gg==
X-Received: by 10.37.97.86 with SMTP id v83mr4629093ybb.124.1499436642024;
        Fri, 07 Jul 2017 07:10:42 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r206sm1360115ywb.41.2017.07.07.07.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jul 2017 07:10:41 -0700 (PDT)
Date:   Fri, 7 Jul 2017 09:10:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v7 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
Message-ID: <20170707141040.nidxo4qn2a5uyr6u@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-8-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702224051.15109-8-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59047
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

On Mon, Jul 03, 2017 at 12:40:42AM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).
> 
> The RCU register range is used for multiple purposes. Mostly one device
> uses one or multiple register exclusively, but for some registers some
> bits are for one driver and some other bits are for a different driver.
> With this patch all accesses to the RCU registers will go through
> syscon.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

Acked-by: Rob Herring <robh@kernel.org>
