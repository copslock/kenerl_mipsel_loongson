Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 00:26:13 +0100 (CET)
Received: from spo001.leaseweb.nl ([83.149.101.17]:57852 "EHLO
        spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012377AbbBBX0LeGB20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 00:26:11 +0100
Received: from wimvs by spo001.leaseweb.nl with local (Exim 4.50)
        id 1YIQNd-0004Rn-5W; Tue, 03 Feb 2015 00:26:09 +0100
Date:   Tue, 3 Feb 2015 00:26:09 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: rt2880_wdt: minor clean up
Message-ID: <20150202232609.GA17080@spo001.leaseweb.nl>
References: <1413489665-52342-1-git-send-email-blogic@openwrt.org> <1413489665-52342-2-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413489665-52342-2-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.4.1i
Return-Path: <wimvs@spo001.leaseweb.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45620
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

> Replace device_reset() with devm_reset_control_get() + reset_control_deassert().
> Make use of watchdog_init_timeout() instead of setting the timeout manually.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

This patch has been edded to linux-watchdog-next.

Kind regards,
Wim.
