Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 09:28:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37028 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006966AbcCHI2lfRH4b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Mar 2016 09:28:41 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u288SeVw001573;
        Tue, 8 Mar 2016 09:28:40 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u288Sdrq001572;
        Tue, 8 Mar 2016 09:28:39 +0100
Date:   Tue, 8 Mar 2016 09:28:39 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] bcm47xx_sprom: Fix compilation with ssb/bcma as module
Message-ID: <20160308082839.GA1076@linux-mips.org>
References: <1457420372-20584-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1457420372-20584-1-git-send-email-zajec5@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52551
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

On Tue, Mar 08, 2016 at 07:59:32AM +0100, Rafał Miłecki wrote:

> It was failing due to unknown ssb_arch_register_fallback_sprom or
> bcma_arch_register_fallback_sprom with CONFIG_SSB=m or CONFIG_BCMA=m
> 
> Fixes: e8a46c88b516 ("MIPS: BCM47xx: Move SPROM driver to drivers/firmware/¨)
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> Ralf, this is for mips-for-linux-next. If you happen to rebase your tree, you
> may squash this one with e8a46c88b516.

I've folded your patch into e8a46c88b516.

  Ralf
