Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2013 20:52:15 +0100 (CET)
Received: from ns1.pc-advies.be ([83.149.101.17]:33175 "EHLO
        spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6824762Ab3A3TwOleEqW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jan 2013 20:52:14 +0100
Received: from wimvs by spo001.leaseweb.com with local (Exim 4.50)
        id 1U0dhc-0005L0-KA; Wed, 30 Jan 2013 20:52:12 +0100
Date:   Wed, 30 Jan 2013 20:52:12 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-watchdog@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] watchdog: ath79_wdt: convert to use devm_clk_get
Message-ID: <20130130195212.GA20513@spo001.leaseweb.com>
References: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.4.1i
X-archive-position: 35640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Gabor

> Use the managed version of clk_get. This allows to
> simplify the probe/remove functions a bit.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

All 3 patches added to linux-watchdog-next.

Kind regards,
Wim.
