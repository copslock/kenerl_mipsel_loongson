Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 15:22:18 +0200 (CEST)
Received: from ns1.pc-advies.be ([83.149.101.17]:57733 "EHLO
        spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903664Ab2EDNWM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2012 15:22:12 +0200
Received: from wimvs by spo001.leaseweb.com with local (Exim 4.50)
        id 1SQISZ-00034l-L8; Fri, 04 May 2012 15:22:11 +0200
Date:   Fri, 4 May 2012 15:22:11 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 11/14] watchdog: MIPS: lantiq: implement OF support and minor fixes
Message-ID: <20120504132211.GV3074@spo001.leaseweb.com>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-11-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1336133919-26525-11-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.4.1i
X-archive-position: 33154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

> Add support for OF. We also apply the following small fixes
> * reduce boiler plate by using devm_request_and_ioremap
> * sane error path for the clock
> * move LTQ_RST_CAUSE_WDTRST to a soc specific header file
> * add a message to show that the driver loaded
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org
> 
> ---
> This patch is part of a series moving the mips/lantiq target to OF and clkdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.
