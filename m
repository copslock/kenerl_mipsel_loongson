Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 23:03:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36198 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012913AbbHSVDe1hvdh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Aug 2015 23:03:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t7JL3V8m023288;
        Wed, 19 Aug 2015 23:03:31 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t7JL3U4H023287;
        Wed, 19 Aug 2015 23:03:30 +0200
Date:   Wed, 19 Aug 2015 23:03:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 5/5] MIPS: ath79: Use the common clk API
Message-ID: <20150819210330.GO3612@linux-mips.org>
References: <1429446604-15403-1-git-send-email-albeu@free.fr>
 <1429446604-15403-6-git-send-email-albeu@free.fr>
 <55C745B7.3040002@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55C745B7.3040002@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48947
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

On Sun, Aug 09, 2015 at 02:21:11PM +0200, Hauke Mehrtens wrote:
> Date:   Sun, 09 Aug 2015 14:21:11 +0200
> From: Hauke Mehrtens <hauke@hauke-m.de>
> To: Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org, Ralf Baechle
>  <ralf@linux-mips.org>
> CC: Andrew Bresticker <abrestic@chromium.org>, Qais Yousef
>  <qais.yousef@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, Sergey
>  Ryazanov <ryazanov.s.a@gmail.com>, Gabor Juhos <juhosg@openwrt.org>,
>  linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 5/5] MIPS: ath79: Use the common clk API
> Content-Type: text/plain; charset=windows-1252
> 
> On 04/19/2015 02:30 PM, Alban Bedel wrote:
> > Make the code simpler and open the way for device tree clocks.
> > 
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >  arch/mips/Kconfig       |  1 +
> >  arch/mips/ath79/clock.c | 29 ++---------------------------
> >  2 files changed, 3 insertions(+), 27 deletions(-)
> > 
> 
> I think this should be send at least to stable 4.1, because it fixes a
> linking problem we are seeing in OpenWrt.
> 
> ath79 does not export clk_set_rate() and clk_round_rate(), but some
> drivers are using it and they are not using the inline dummy method,
> because CONFIG_HAVE_CLK is set for ath79.
> 
> ERROR: "clk_set_rate" [drivers/usb/phy/phy-generic.ko] undefined!
> ERROR: "clk_round_rate" [drivers/media/v4l2-core/videodev.ko] undefined!
> ERROR: "clk_set_rate" [drivers/media/v4l2-core/videodev.ko] undefined!

Ok.  Will post the the patch in a separate email.

  Ralf
