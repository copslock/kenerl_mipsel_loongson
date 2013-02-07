Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2013 23:29:32 +0100 (CET)
Received: from ns1.pc-advies.be ([83.149.101.17]:34173 "EHLO
        spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6827531Ab3BGW3cLYvsr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2013 23:29:32 +0100
Received: from wimvs by spo001.leaseweb.com with local (Exim 4.50)
        id 1U3ZyB-0007MT-Ec; Thu, 07 Feb 2013 23:29:27 +0100
Date:   Thu, 7 Feb 2013 23:29:27 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs with PMU
Message-ID: <20130207222927.GA28281@spo001.leaseweb.com>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.4.1i
X-archive-position: 35726
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

Hi Hauke

> This patch series improves the functions for setting the watchdog 
> driver for bcm47xx based SoCs using ssb and bcma. This makes the 
> watchdog driver use the platform device provided by bcma or ssb.
> 
> This code is currently based on the linux-watchdog/master tree by 
> Wim Van Sebroeck.

V5 patches have been added to linux-watchdog-next.

Kind regards,
Wim.
