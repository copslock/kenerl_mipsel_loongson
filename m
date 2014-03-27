Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2014 08:40:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54439 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822083AbaC0HkWzeDfP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Mar 2014 08:40:22 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2R7eJxp023062;
        Thu, 27 Mar 2014 08:40:19 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2R7eGrA023061;
        Thu, 27 Mar 2014 08:40:16 +0100
Date:   Thu, 27 Mar 2014 08:40:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: fix EARLY_PRINTK_8250 build failure
Message-ID: <20140327074016.GN17197@linux-mips.org>
References: <1395777525-28910-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1395777525-28910-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39589
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

On Tue, Mar 25, 2014 at 09:58:45PM +0200, Aaro Koskinen wrote:

> Enabling EARLY_PRINTK_8250 breaks OCTEON builds because of multiple
> prom_putchar() implementations. OCTEON provides its own prom_putchar()
> (also used by the watchdog driver), so we should prevent user from
> selecting EARLY_PRINTK_8250 on OCTEON.

There shouldn't be Octeon-specific code in the 8250-driver, not even
the Kconfig bits.  Also other systems - at least Sibyte - affected
by the same issue so I went for a different patch.

  Ralf
