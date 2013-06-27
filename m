Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 13:30:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52209 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824786Ab3F0LaTuEDHr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 13:30:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5RBUDxs006754;
        Thu, 27 Jun 2013 13:30:13 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5RBUAsv006753;
        Thu, 27 Jun 2013 13:30:10 +0200
Date:   Thu, 27 Jun 2013 13:30:10 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        netdev@vger.kernel.org, Michael Buesch <m@bues.ch>
Subject: Re: [PATCH 6/7] drivers: ssb: Kconfig: Amend SSB_EMBEDDED
 dependencies
Message-ID: <20130627113010.GU7171@linux-mips.org>
References: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
 <1371477641-7989-7-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371477641-7989-7-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37170
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

On Mon, Jun 17, 2013 at 03:00:40PM +0100, Markos Chandras wrote:

> SSB_EMBEDDED needs functions from driver_pcicore which are only
> available if SSD_DRIVER_HOSTMODE is selected so make it
> depend on that symbol.
> 
> Fixes the following linking problem:
> 
> drivers/ssb/embedded.c:202:
> undefined reference to `ssb_pcicore_plat_dev_init'
> drivers/built-in.o: In function `ssb_pcibios_map_irq':
> drivers/ssb/embedded.c:247:
> undefined reference to `ssb_pcicore_pcibios_map_irq'
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Cc: sibyte-users@bitmover.com
> Cc: netdev@vger.kernel.org
> Cc: Michael Buesch <m@bues.ch>

No comments received but Florian acked it over IRC so applied.

And btw, why is sibyte-users on cc - we don't want to disrupt the silence
of that list too badly ;-)

  Ralf
