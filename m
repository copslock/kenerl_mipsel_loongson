Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 13:33:44 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:38120 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025537AbcDFLdlv0524 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 13:33:41 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1anQzk-00037F-CR; Tue, 05 Apr 2016 15:26:12 +0200
Date:   Tue, 5 Apr 2016 15:26:11 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        rt@linutronix.de
Subject: Re: [PREEMPT-RT] [PATCH] MIPS: Remove no longer needed work_on_cpu()
 call
In-Reply-To: <20160404150332.GD15222@linux-mips.org>
Message-ID: <alpine.DEB.2.11.1604051508030.12514@hypnos>
References: <1459772283-40657-1-git-send-email-anna-maria@linutronix.de> <20160404150332.GD15222@linux-mips.org>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <anna-maria@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anna-maria@linutronix.de
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

On Mon, 4 Apr 2016, Ralf Baechle wrote:

> On Mon, Apr 04, 2016 at 02:18:03PM +0200, Anna-Maria Gleixner wrote:
> 
> > Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> > hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> > CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this
> > work_on_cpu() calls are no longer required.
> > 
> > Replace work_on_cpu() with a direct call of mips_cdmm_bus_up() or
> > mips_cdmm_bus_down(). Description of those functions are adapted.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > ---
> >  drivers/bus/mips_cdmm.c |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> Thanks, queued for 4.7.
> 

Please do not queue it. Heiko Carstens pointed out a problem: It isn't
ensured, that the callbacks of CPU_DOWN_FAILED are always processed on
the CPU that failed in CPU_DOWN_PREPARE (see
http://marc.info/?l=linux-s390&m=145985621421250&w=2 ). Once this
issue is fixed, I will resend the patch.

Anna-Maria
