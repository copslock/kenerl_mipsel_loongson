Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Dec 2015 06:01:58 +0100 (CET)
Received: from kirsty.vergenet.net ([202.4.237.240]:59900 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006567AbbL1FBxc-1e0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Dec 2015 06:01:53 +0100
Received: from penelope.kanocho.kobe.vergenet.net (58-6-44-103.dyn.iinet.net.au [58.6.44.103])
        by kirsty.vergenet.net (Postfix) with ESMTPSA id 9FC1825B7BC;
        Mon, 28 Dec 2015 16:01:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1451278908; bh=Nw/yUU/Iq/edqd+tt03x0TyF47TuXeG5OuTVZnZ9sAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfIk+C+9Fqv+/9SO4AnlM02f29iuVDMz5sc8CuZTNBUsQqhZtc1mnKEX4VC2QyXsh
         w7zt4/p0j44mo6dKxvQO8rmptoGLYWi1CBZjo6hSRQWba4CucHQIQ4A6PVeyODpfzA
         dgkR5YmahGtBkAHXV6yxBpCJevevEd+1Agu2yHjQ=
Received: by penelope.kanocho.kobe.vergenet.net (Postfix, from userid 7100)
        id 58000620D3; Mon, 28 Dec 2015 16:01:48 +1100 (AEDT)
Date:   Mon, 28 Dec 2015 16:01:48 +1100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     arm@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions"
 node
Message-ID: <20151228050147.GE1066@verge.net.au>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
Organisation: Horms Solutions Ltd.
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
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

On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
> 	Hi,
> 
> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
> subnode of an SPI FLASH device node must have a compatible property. The
> partitions are no longer detected if it is not present.
> 
> However, several DTSes in -next have already been converted to the
> "partitions" subnode without "compatible" property, introduced by
> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
> partitions in a special 'partitions' subnode"). Hence all of these are
> now broken in -next, and will be broken in upstream during the merge
> window.
> 
> This series fixes all users in next-20151221.
> Tested on r8a7791/koelsch.
> 
> Changes since v1:
>   - Add Acked-by,
>   - Fix new users in -next (kirkwood, ci20).
> 
> Most of these are in arm-soc/for-next. Exceptions are kirkwood (in
> mvebu/for-next), and ci20 (in mips/mips-for-linux-next).
> 
> Given we're late in the v4.4-rc cycle, perhaps it's easiest if the
> arm-soc maintainers take all applicable patches directly, bypassing the
> mvebu and shmobile maintainers?
> 
> Thanks for queuing for v4.5!
> 
> Geert Uytterhoeven (9):
>   ARM: mvebu: ix4-300d: Add compatible property to "partitions" node
>   ARM: mvebu: kirkwood: Add compatible property to "partitions" node
>   ARM: shmobile: bockw dts: Add compatible property to "partitions" node
>   ARM: shmobile: lager dts: Add compatible property to "partitions" node
>   ARM: shmobile: koelsch dts: Add compatible property to "partitions"
>     node
>   ARM: shmobile: porter dts: Add compatible property to "partitions"
>     node
>   ARM: shmobile: gose dts: Add compatible property to "partitions" node
>   ARM: shmobile: silk dts: Add compatible property to "partitions" node

Thanks, I have queued up the above "shmobile" patches for v4.6.

>   MIPS: dts: jz4780/ci20: Add compatible property to "partitions" node
> 
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  | 1 +
>  arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 1 +
>  arch/arm/boot/dts/r8a7778-bockw.dts              | 1 +
>  arch/arm/boot/dts/r8a7790-lager.dts              | 1 +
>  arch/arm/boot/dts/r8a7791-koelsch.dts            | 1 +
>  arch/arm/boot/dts/r8a7791-porter.dts             | 1 +
>  arch/arm/boot/dts/r8a7793-gose.dts               | 1 +
>  arch/arm/boot/dts/r8a7794-silk.dts               | 1 +
>  arch/mips/boot/dts/ingenic/ci20.dts              | 1 +
>  9 files changed, 9 insertions(+)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
