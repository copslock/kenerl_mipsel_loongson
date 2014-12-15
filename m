Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 17:30:02 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47747 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008804AbaLOQaAhGg88 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 17:30:00 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBFGTxmS027503;
        Mon, 15 Dec 2014 17:29:59 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBFGTwQk027502;
        Mon, 15 Dec 2014 17:29:58 +0100
Date:   Mon, 15 Dec 2014 17:29:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Linux MIPS List <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/02 resend] MIPS: IP32: Add platform data hooks to use
 DS1685 driver
Message-ID: <20141215162957.GC26674@linux-mips.org>
References: <548B689A.1010007@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548B689A.1010007@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44680
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

On Fri, Dec 12, 2014 at 05:13:46PM -0500, Joshua Kinard wrote:

> This modifies the IP32 (SGI O2) platform and reset code to utilize the new
> rtc-ds1685 driver.  The old mc146818rtc.h header is removed and ip32_defconfig
> is updated as well.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/configs/ip32_defconfig              |    3
>  arch/mips/include/asm/mach-ip32/mc146818rtc.h |   36 ----
>  arch/mips/sgi-ip32/ip32-platform.c            |   52 +++++-
>  arch/mips/sgi-ip32/ip32-reset.c               |  132 ++++------------
>  4 files changed, 85 insertions(+), 138 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-ip32/mc146818rtc.h
> 
> Ralf,
> 
>   Similar to Maciej's DEC/RTC patches from a few months ago, this patch
> requires the rtc-ds1685 driver be added upstream first before this can go into
> into the LMO tree.  If you can queue this someplace until that makes it in,
> that would be great.  Thanks!

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Alessandro,

I don't think there is much of a chance of this patch conflicting with
others so feel free to funnel this through the RTC tree.  Or I carry
both patches - I don't care which way.

Cheers,

  Ralf
