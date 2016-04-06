Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:29:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40042 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026138AbcDFM3WrmQqZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Apr 2016 14:29:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u36CTMnx009419;
        Wed, 6 Apr 2016 14:29:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u36CTIlq009418;
        Wed, 6 Apr 2016 14:29:18 +0200
Date:   Wed, 6 Apr 2016 14:29:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        rt@linutronix.de
Subject: Re: [PREEMPT-RT] [PATCH] MIPS: Remove no longer needed work_on_cpu()
 call
Message-ID: <20160406122918.GB26267@linux-mips.org>
References: <1459772283-40657-1-git-send-email-anna-maria@linutronix.de>
 <20160404150332.GD15222@linux-mips.org>
 <alpine.DEB.2.11.1604051508030.12514@hypnos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604051508030.12514@hypnos>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52905
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

On Tue, Apr 05, 2016 at 03:26:11PM +0200, Anna-Maria Gleixner wrote:

> On Mon, 4 Apr 2016, Ralf Baechle wrote:
> 
> > On Mon, Apr 04, 2016 at 02:18:03PM +0200, Anna-Maria Gleixner wrote:
> > 
> > > Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> > > hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> > > CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this
> > > work_on_cpu() calls are no longer required.
> > > 
> > > Replace work_on_cpu() with a direct call of mips_cdmm_bus_up() or
> > > mips_cdmm_bus_down(). Description of those functions are adapted.
> > > 
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > Cc: linux-mips@linux-mips.org
> > > Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > > ---
> > >  drivers/bus/mips_cdmm.c |   12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > Thanks, queued for 4.7.
> > 
> 
> Please do not queue it. Heiko Carstens pointed out a problem: It isn't
> ensured, that the callbacks of CPU_DOWN_FAILED are always processed on
> the CPU that failed in CPU_DOWN_PREPARE (see
> http://marc.info/?l=linux-s390&m=145985621421250&w=2 ). Once this
> issue is fixed, I will resend the patch.

Thanks for letting me know, patch dropped.

  Ralf
