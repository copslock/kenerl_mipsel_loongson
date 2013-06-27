Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 21:59:35 +0200 (CEST)
Received: from ns1.pc-advies.be ([83.149.101.17]:52763 "EHLO
        spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6835048Ab3F0T7dkdbya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jun 2013 21:59:33 +0200
Received: from wimvs by spo001.leaseweb.com with local (Exim 4.50)
        id 1UsILr-0007xW-UR; Thu, 27 Jun 2013 21:59:31 +0200
Date:   Thu, 27 Jun 2013 21:59:31 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, sibyte-users@bitmover.com
Subject: Re: [PATCH v2 5/7] drivers: watchdog: sb_wdog: Fix 32bit linking problems
Message-ID: <20130627195931.GD30433@spo001.leaseweb.com>
References: <1371564006-31805-1-git-send-email-markos.chandras@imgtec.com> <20130618141420.GA15141@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130618141420.GA15141@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <wimvs@spo001.leaseweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37182
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

Hi Ralf,

> > Fixes the following linking problem:
> > drivers/watchdog/sb_wdog.c:211: undefined reference to `__udivdi3'
> > 
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> > Cc: sibyte-users@bitmover.com
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > ---
> > This patch is for the upstream-sfr/mips-for-linux-next tree
> 
> That looks ok.
> 
> Wim, are going to merge this or shall I carry it?  If you take it,
> feel free to add my Acked-by.

I'll take it and add your Acked-by.

Kind regards,
Wim.
