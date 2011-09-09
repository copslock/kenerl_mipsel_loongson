Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Sep 2011 01:22:44 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:33453 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491753Ab1IIXWi convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Sep 2011 01:22:38 +0200
Received: by gyg13 with SMTP id 13so2218704gyg.36
        for <multiple recipients>; Fri, 09 Sep 2011 16:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=T58vLqBLP+43952JX17AHvMgSHgz2DsSIzSOncjS32o=;
        b=WX9KduO75zSoh65tqEPo6sympRkd+is3AbrORupL5+5KX7c3BbvWTRvz4G3F7tnsCA
         ru5HwyKEC15v81sc9pr7ykTn+EfUSeg4CR2rhPMdmdGK3hbKV/AHuuZnrCPVCtA46FPq
         Sf/0nJwxcjyyShfD4EQtVayvIhD2XsVo1WZxg=
MIME-Version: 1.0
Received: by 10.236.173.129 with SMTP id v1mr296416yhl.25.1315610552404; Fri,
 09 Sep 2011 16:22:32 -0700 (PDT)
Received: by 10.236.69.169 with HTTP; Fri, 9 Sep 2011 16:22:32 -0700 (PDT)
In-Reply-To: <1314820906-14004-3-git-send-email-david.daney@cavium.com>
References: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
        <1314820906-14004-3-git-send-email-david.daney@cavium.com>
Date:   Fri, 9 Sep 2011 18:22:32 -0500
Message-ID: <CAKWjMd7pa=BikH0VkUZEFZ9yH+g6g9RSus9woqs1hbR+rb3u9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
From:   Andy Fleming <afleming@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afleming@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5124

On Wed, Aug 31, 2011 at 3:01 PM, David Daney <david.daney@cavium.com> wrote:
> This patch adds a somewhat generic framework for MDIO bus
> multiplexers.  It is modeled on the I2C multiplexer.
>
> The multiplexer is needed if there are multiple PHYs with the same
> address connected to the same MDIO bus adepter, or if there is
> insufficient electrical drive capability for all the connected PHY
> devices.
>
> Conceptually it could look something like this:
>
>                   ------------------
>                   | Control Signal |
>                   --------+---------
>                           |
>  ---------------   --------+------
>  | MDIO MASTER |---| Multiplexer |
>  ---------------   --+-------+----
>                     |       |
>                     C       C
>                     h       h
>                     i       i
>                     l       l
>                     d       d
>                     |       |
>     ---------       A       B   ---------
>     |       |       |       |   |       |
>     | PHY@1 +-------+       +---+ PHY@1 |
>     |       |       |       |   |       |
>     ---------       |       |   ---------
>     ---------       |       |   ---------
>     |       |       |       |   |       |
>     | PHY@2 +-------+       +---+ PHY@2 |
>     |       |                   |       |
>     ---------                   ---------
>
> This framework configures the bus topology from device tree data.  The
> mechanics of switching the multiplexer is left to device specific
> drivers.
>
> The follow-on patch contains a multiplexer driven by GPIO lines.


It's amazing how various companies' board designers have come up with
the same brain-dead PHY topologies. We (Freescale) have some similar
code in our tree, but it's not this generically applicable.

>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: "David S. Miller" <davem@davemloft.net>

Looks good to me.

Acked-by: Andy Fleming <afleming@freescale.com>
