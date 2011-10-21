Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2011 14:25:55 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50309 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491206Ab1JUMZv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Oct 2011 14:25:51 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9LCPoAA012885;
        Fri, 21 Oct 2011 13:25:50 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9LCPnWp012881;
        Fri, 21 Oct 2011 13:25:49 +0100
Date:   Fri, 21 Oct 2011 13:25:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Revert "MIPS: MTX-1: Make au1000_eth probe all PHY
Message-ID: <20111021122549.GA12686@linux-mips.org>
References: <201110171943.06143.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201110171943.06143.florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15720

On Mon, Oct 17, 2011 at 07:43:06PM +0200, Florian Fainelli wrote:

> Commit ec3eb823 was not applicable in 2.6.32 and introduces a build breakage.
> Revert that commit since it is irrelevant for this kernel version.
> 
> CC: stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Greg, this is applicable from 2.6.32+ to 2.6.33+ included.

On 2.6.33-stable the commit ID to be reverted is 34dce55d.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

(Or should it be Un-Acked-by: for reverting a patch?  ;-)

  Ralf
