Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 14:05:17 +0200 (CEST)
Received: from mogw0636.ocn.ad.jp ([153.149.228.37]:44474 "EHLO
        mogw0636.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992149AbcHSMFKOBA0E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 14:05:10 +0200
Received: from mf-smf-ucb002.ocn.ad.jp (mf-smf-ucb002.ocn.ad.jp [153.149.227.4])
        by mogw0636.ocn.ad.jp (Postfix) with ESMTP id D6898F0046E;
        Fri, 19 Aug 2016 21:05:06 +0900 (JST)
Received: from ntt.pod01.mv-mta-ucb022 ([mv-mta-ucb022.ocn.ad.jp [153.128.50.8]]) by mf-smf-ucb002.ocn.ad.jp with RELAY id u7JC55XR047050 ;
          Fri, 19 Aug 2016 21:05:06 +0900
Received: from smtp.ocn.ne.jp ([153.149.227.166])
        by ntt.pod01.mv-mta-ucb022 with 
        id Z0551t0023c2f7501055iM; Fri, 19 Aug 2016 12:05:05 +0000
Received: from localhost (p5005-ipngn4301funabasi.chiba.ocn.ne.jp [114.165.168.5])
        by smtp.ocn.ne.jp (Postfix) with ESMTPA;
        Fri, 19 Aug 2016 21:05:05 +0900 (JST)
Date:   Fri, 19 Aug 2016 21:05:04 +0900 (JST)
Message-Id: <20160819.210504.65713466261092409.anemo@mba.ocn.ne.jp>
To:     geert@linux-m68k.org
Cc:     ralf@linux-mips.org, broonie@kernel.org, wim@iguana.be,
        linux@roeck-us.net, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
        <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.5 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
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

On Thu, 18 Aug 2016 19:34:27 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Replace the custom minimal clock implementation for Toshiba TXx9 by a
> basic implementation using the Common Clock Framework.

Thank you for good cleanup.

> +	if (TX4938_REV_PCODE() == 0x4938) {
> +		clk = clk_register_fixed_factor(NULL, "spi", "gbus", 0, 1, 4);
> +		error = clk_register_clkdev(clk, "spi-baseclk", NULL);
> +		if (error)
> +			goto fail;
> +	}

Unfortunately, TX4938_REV_PCODE() can be used only on TX49 based
platforms.  Please enclose this block with #ifdef CONFIG_CPU_TX49XX.

Or, while registering unused clkdev will not bloat kernel so much,
just remove this TX4938 checking.

---
Atsushi Nemoto
