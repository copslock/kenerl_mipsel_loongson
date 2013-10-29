Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2013 08:39:42 +0100 (CET)
Received: from ns1.pc-advies.be ([83.149.101.17]:39301 "EHLO
        spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6817537Ab3J2Hjh1juID (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Oct 2013 08:39:37 +0100
Received: from wimvs by spo001.leaseweb.com with local (Exim 4.50)
        id 1Vb3tn-000576-As; Tue, 29 Oct 2013 08:39:35 +0100
Date:   Tue, 29 Oct 2013 08:39:35 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] watchdog: MIPS: add ralink watchdog driver
Message-ID: <20131029073935.GD19569@spo001.leaseweb.com>
References: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.4.1i
Return-Path: <wimvs@spo001.leaseweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38399
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

Hi John,

> Add a driver for the watchdog timer found on Ralink SoC
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/watchdog/Kconfig      |    7 ++
>  drivers/watchdog/Makefile     |    1 +
>  drivers/watchdog/rt2880_wdt.c |  208 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 drivers/watchdog/rt2880_wdt.c

This patch (together with the DT binding part) has been added as 1 patch to linux-watchdog-next.

Kind regards,
Wim.
