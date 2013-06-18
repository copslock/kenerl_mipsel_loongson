Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 16:14:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46457 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824790Ab3FROO0czVRI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 16:14:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5IEENgY018225;
        Tue, 18 Jun 2013 16:14:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5IEEKt0018224;
        Tue, 18 Jun 2013 16:14:20 +0200
Date:   Tue, 18 Jun 2013 16:14:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v2 5/7] drivers: watchdog: sb_wdog: Fix 32bit linking
 problems
Message-ID: <20130618141420.GA15141@linux-mips.org>
References: <1371564006-31805-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371564006-31805-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36973
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

On Tue, Jun 18, 2013 at 03:00:06PM +0100, Markos Chandras wrote:

> Fixes the following linking problem:
> drivers/watchdog/sb_wdog.c:211: undefined reference to `__udivdi3'
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Cc: sibyte-users@bitmover.com
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
> This patch is for the upstream-sfr/mips-for-linux-next tree

That looks ok.

Wim, are going to merge this or shall I carry it?  If you take it,
feel free to add my Acked-by.

Thanks,

  Ralf
