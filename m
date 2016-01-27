Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 10:37:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51954 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010574AbcA0Jh12jCUB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 10:37:27 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u0R9bM1H005447;
        Wed, 27 Jan 2016 10:37:22 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u0R9bLV7005445;
        Wed, 27 Jan 2016 10:37:21 +0100
Date:   Wed, 27 Jan 2016 10:37:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 2/2] MIPS: dt: Explicitly specify native endian
 behaviour for syscon
Message-ID: <20160127093721.GA2939@linux-mips.org>
References: <1453848410-24949-1-git-send-email-broonie@kernel.org>
 <1453848410-24949-2-git-send-email-broonie@kernel.org>
 <56A7FE3F.5090909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A7FE3F.5090909@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jan 26, 2016 at 03:16:15PM -0800, Florian Fainelli wrote:

> diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi
> b/arch/mips/boot/dts/brcm/bcm6368.dtsi
> index 9c8d3fe28b31..1f6b9b5cddb4 100644
> --- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
> @@ -54,7 +54,7 @@
>                 periph_cntl: syscon@10000000 {
>                         compatible = "syscon";
>                         reg = <0x10000000 0x14>;
> -                       little-endian;
> +                       native-endian;
>                 };
> 
>                 reboot: syscon-reboot@10000008 {

Acked-by: Ralf Baechle <ralf@linux-mips.org>

for the combined patch.

  Ralf
