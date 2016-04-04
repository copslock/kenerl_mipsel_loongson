Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 17:03:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35824 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006926AbcDDPDgd7ljs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 17:03:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u34F3X1r024058;
        Mon, 4 Apr 2016 17:03:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u34F3XRm024057;
        Mon, 4 Apr 2016 17:03:33 +0200
Date:   Mon, 4 Apr 2016 17:03:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rt@linutronix.de,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Remove no longer needed work_on_cpu() call
Message-ID: <20160404150332.GD15222@linux-mips.org>
References: <1459772283-40657-1-git-send-email-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459772283-40657-1-git-send-email-anna-maria@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52876
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

On Mon, Apr 04, 2016 at 02:18:03PM +0200, Anna-Maria Gleixner wrote:

> Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this
> work_on_cpu() calls are no longer required.
> 
> Replace work_on_cpu() with a direct call of mips_cdmm_bus_up() or
> mips_cdmm_bus_down(). Description of those functions are adapted.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
>  drivers/bus/mips_cdmm.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Thanks, queued for 4.7.

  Ralf
