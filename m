Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 17:01:01 +0200 (CEST)
Received: from mogw0639.ocn.ad.jp ([153.149.228.40]:51106 "EHLO
        mogw0639.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991894AbcIMPAwlt7cz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 17:00:52 +0200
Received: from mf-smf-ucb008.ocn.ad.jp (mf-smf-ucb008.ocn.ad.jp [153.149.227.68])
        by mogw0639.ocn.ad.jp (Postfix) with ESMTP id 37167130049B;
        Wed, 14 Sep 2016 00:00:49 +0900 (JST)
Received: from ntt.pod01.mv-mta-ucb019 ([mv-mta-ucb019.ocn.ad.jp [153.128.50.2]]) by mf-smf-ucb008.ocn.ad.jp with RELAY id u8DF0bWu055572 ;
          Wed, 14 Sep 2016 00:00:48 +0900
Received: from smtp.ocn.ne.jp ([153.149.227.135])
        by ntt.pod01.mv-mta-ucb019 with 
        id j30n1t0042vuoep0130ntQ; Tue, 13 Sep 2016 15:00:48 +0000
Received: from localhost (p5005-ipngn4301funabasi.chiba.ocn.ne.jp [114.165.168.5])
        by smtp.ocn.ne.jp (Postfix) with ESMTPA;
        Wed, 14 Sep 2016 00:00:47 +0900 (JST)
Date:   Wed, 14 Sep 2016 00:00:43 +0900 (JST)
Message-Id: <20160914.000043.2112235063844984466.anemo@mba.ocn.ne.jp>
To:     geert@linux-m68k.org
Cc:     ralf@linux-mips.org, wim@iguana.be, linux@roeck-us.net,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MIPS: TXx9: Convert to Common Clock Framework
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1473584398-12942-3-git-send-email-geert@linux-m68k.org>
References: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
        <1473584398-12942-3-git-send-email-geert@linux-m68k.org>
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
X-archive-position: 55126
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

On Sun, 11 Sep 2016 10:59:58 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Replace the custom minimal clock implementation for Toshiba TXx9 by a
> basic implementation using the Common Clock Framework.
> 
> The only clocks that are provided are those needed by TXx9-specific
> drivers ("imbus" and "spi" (TX4938 only)), and their common parent
> clock "gbus". Other clocks can be added when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Tested on RBTX4927.
> 
> v2:
>   - Protect the TX4938_REV_PCODE() check by #ifdef CONFIG_CPU_TX49XX,
>   - Use new clk_hw-centric clock registration API.

Thank you for updated patch.

Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
