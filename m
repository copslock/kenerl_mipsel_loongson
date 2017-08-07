Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 21:58:24 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:33869
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994843AbdHGT6OM7hD2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2017 21:58:14 +0200
Received: by mail-wr0-x242.google.com with SMTP id o33so1016330wrb.1;
        Mon, 07 Aug 2017 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bl6QQG1P+Mcwme7G5YLDoW+iZjclxWmsFryzoZFsXII=;
        b=vclGSGqwjt5jBOkgr45BmcOWDx8OHu1Ree18Z6eSjqfKEvJNj5kKit92u3jGXOEZEt
         v8d1Tv9Go9ru01v0FDz6mS4okQc9FR7cOJfG9Uz9fYwTm/jVj9CUpIci6kB4sylOdcEz
         lgjdG/zWUYZC2FVBnMRH2mcYeyCcjVainerbSOc/GXiRpdTMNz2E7SSjk39cpWF1sLRx
         VmsHpEC8LVF7WHGNfzv2OGTtzLW5zp4jrqgS+PWIG5uPSB0PN6DIHIc+2PKdc2/P1gGW
         oAd8T0OELm0aGCYIpm/+qJbMxfsI6+WTxuxrXmVbH6Hs99godQZkLOZ8vwOxlV3OWa5e
         UGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bl6QQG1P+Mcwme7G5YLDoW+iZjclxWmsFryzoZFsXII=;
        b=l57zx8mGLjmDPti8AaVmuguNKK0BGbKEddEH12Ix/irlLopsyy9AeZIp4VgYZ3dRsS
         t13nq0Wr6VXvaZmTWPHFeLaJ0R/2mAAyBE9sIYU1pHIE/8SFGp/hnqz+UYvPlav2sff+
         nyzLMMBuCs9EqbGY4/v0osIsDrQECruafPNmB5/zdZC7DCmFeAKdWMmLJAGJU3CDRh6B
         I6Fs6UvRHUGw3AsG2jBUnNiC9tFghKhBYT9qJ96MG2Sn7aCWx0sZImlwSOHg5xRyQatx
         /l09MyfAvERNfEqvDSgBEvFFScBPWzOlKFw+QSzXCGRznArOyF8J6OumSCgY+z9SVVc0
         8yOA==
X-Gm-Message-State: AHYfb5ifScvGv+L6dS1B8YUM8dWl7lAL7rHa4PL26yEkWvHN9n3jjILp
        PQgt9sP6dFOiwA==
X-Received: by 10.223.148.103 with SMTP id 94mr1257065wrq.174.1502135888934;
        Mon, 07 Aug 2017 12:58:08 -0700 (PDT)
Received: from [192.168.0.32] (cpc75568-harg6-2-0-cust427.7-1.cable.virginm.net. [86.0.241.172])
        by smtp.gmail.com with ESMTPSA id h18sm36618wme.3.2017.08.07.12.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 12:58:08 -0700 (PDT)
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Peter Pan <peterpandong@micron.com>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Steven Miao <realmz6@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Stefan Agner <stefan@agner.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org,
        linux-oxnas@lists.tuxfamily.org, linuxppc-dev@lists.ozlabs.org,
        devel@driverdev.osuosl.org
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
From:   Harvey Hunt <harveyhuntnexus@gmail.com>
Message-ID: <8fa469f8-63d6-9305-db8e-88416ea2c6cc@gmail.com>
Date:   Mon, 7 Aug 2017 20:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <harveyhuntnexus@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harveyhuntnexus@gmail.com
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

Hi Boris,

On 08/04/2017 04:29 PM, Boris Brezillon wrote:
[...]
>   drivers/mtd/nand/jz4780_nand.c                  | 2 +-
[...]

For JZ4780,

Acked-By: Harvey Hunt <harveyhuntnexus@gmail.com>
