Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 14:07:17 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:13977 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22209401AbYJWNHO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2008 14:07:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9ND7DvG006556;
	Thu, 23 Oct 2008 14:07:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9ND7D5V006555;
	Thu, 23 Oct 2008 14:07:13 +0100
Date:	Thu, 23 Oct 2008 14:07:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Anirban Sinha <ASinha@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: panic logic defeats arch dependent code
Message-ID: <20081023130712.GB16564@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C50130734A@exchange.ZeugmaSystems.local> <20081018124358.GC17322@linux-mips.org> <DDFD17CC94A9BD49A82147DDF7D545C501307489@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C501307489@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 20, 2008 at 12:05:43PM -0700, Anirban Sinha wrote:

> Thanks for responding and posting the patch. There is actually a another
> important issue of a more general nature. I have already posted this in
> the general Linux kernel mailing list under the subject "panic() logic".
> The crux of the issue is:
> 
> The panic() call does a smp_send_stop() pretty early in the call
> process for SMP systems. smp_send_stop basically marks all the other
> cores as 'down' and
> updates the cpu bitmap. One implication of this is that you cannot do
> an IPI later on to other cores. However, interestingly, mips sibyte
> processor tries to do a cfe_exit() through an IPI as a part of
> emergency_reboot() that is called pretty late in the panic() logic. 
> 
> As a consequence of this, if a panic happens on a back core, the system
> simply hangs and never actually does a "rebooting in 5 sec" thing. 

Interesting.  I've observed this effect frequently.  But without researching
the issue further I did blame CFE for it.

> I believe the way panic logic is organized is in conflict with the
> requirements of some archs, for example our mips sibyte arch. Currently,
> the arch independent logic defeats the main purpose of the arch
> dependent emergency_restart() function which is to restart the system.
> In a vast majority of the cases, we do have a perfectly sane and
> functional front core and we are just not able to gracefully reboot the
> system because we are limited by the way panic() handles the shutdown
> logic. If there are other archs that does a similar specific operation
> for the front core as a part of 'emergency restart', they are all
> defeated.

SMP systems generally have some sledgehammer mechanism that can be used to
trigger a hardware reset of another or all cores.  We probably should
use that instead of relying on firmware - which in many cases becomes
unusable after Linux initialization.

> I believe, the way to solve this problem is that the archs themselves
> take the responsibility of shutting down the core and not the generic
> panic() call. The actual power down mechanism is arch dependent anyway,
> so I guess it can be made to be a part of emergency_shutdown(). The arch
> independent kernel code will then simply do the necessary arch
> independent things to handle panic and simply call emergency_reboot() to
> do the rest of the arch specific stuff, including powering down the
> cores.

It would certainly make some sense in this particular scenario.

  Ralf
