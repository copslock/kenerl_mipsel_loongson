Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 19:57:26 +0100 (CET)
Received: from spo001.leaseweb.nl ([83.149.101.17]:59174 "EHLO
        spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025231AbbBCS5ZHl99n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 19:57:25 +0100
Received: from wimvs by spo001.leaseweb.nl with local (Exim 4.50)
        id 1YIif3-0000kU-Tw; Tue, 03 Feb 2015 19:57:21 +0100
Date:   Tue, 3 Feb 2015 19:57:21 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V3] watchdog: add MT7621 watchdog support
Message-ID: <20150203185721.GA2875@spo001.leaseweb.nl>
References: <1413489665-52342-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413489665-52342-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.4.1i
Return-Path: <wimvs@spo001.leaseweb.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45639
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

> This patch adds support for the watchdog core found on newer mediatek/ralink
> Wifi SoCs.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Patch has been added to linux-watchdog-next. I removed the owner field in the platform_driver struct.

Kind regards,
Wim.
