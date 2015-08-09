Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Aug 2015 14:21:14 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:38101 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009776AbbHIMVMagR8P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Aug 2015 14:21:12 +0200
Received: from [192.168.178.24] (p5DE948B6.dip0.t-ipconnect.de [93.233.72.182])
        by hauke-m.de (Postfix) with ESMTPSA id D1CD4100733;
        Sun,  9 Aug 2015 14:21:11 +0200 (CEST)
Message-ID: <55C745B7.3040002@hauke-m.de>
Date:   Sun, 09 Aug 2015 14:21:11 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] MIPS: ath79: Use the common clk API
References: <1429446604-15403-1-git-send-email-albeu@free.fr> <1429446604-15403-6-git-send-email-albeu@free.fr>
In-Reply-To: <1429446604-15403-6-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 04/19/2015 02:30 PM, Alban Bedel wrote:
> Make the code simpler and open the way for device tree clocks.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/Kconfig       |  1 +
>  arch/mips/ath79/clock.c | 29 ++---------------------------
>  2 files changed, 3 insertions(+), 27 deletions(-)
> 

I think this should be send at least to stable 4.1, because it fixes a
linking problem we are seeing in OpenWrt.

ath79 does not export clk_set_rate() and clk_round_rate(), but some
drivers are using it and they are not using the inline dummy method,
because CONFIG_HAVE_CLK is set for ath79.

ERROR: "clk_set_rate" [drivers/usb/phy/phy-generic.ko] undefined!
ERROR: "clk_round_rate" [drivers/media/v4l2-core/videodev.ko] undefined!
ERROR: "clk_set_rate" [drivers/media/v4l2-core/videodev.ko] undefined!

Hauke
