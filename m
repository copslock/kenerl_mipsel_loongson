Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 18:01:22 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:50457 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133676AbVLFSBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 18:01:03 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jB6I0bXr031682;
	Tue, 6 Dec 2005 18:00:37 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jB6I0ZpX031681;
	Tue, 6 Dec 2005 18:00:35 GMT
Date:	Tue, 6 Dec 2005 18:00:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
Subject: Re: [PATCH] Philips PNX8550 ip3106 driver deadlock fix
Message-ID: <20051206180035.GG2698@linux-mips.org>
References: <4395D05C.9060408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4395D05C.9060408@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 06, 2005 at 08:54:36PM +0300, Vladimir A. Barinov wrote:

> This is a patch that fixes spin_lock deadlock in serial ip3106 driver.
> The spin_lock_irq(&port->lock,flags) is already called in generic driver 
> serial_core.c before
> port->ops->start_tx().
> So the second call of spin_lock_irq(&port->lock, flags) leads to 
> deadlock. This could be verified in PREEMPT_DESCTOP case when
> these options are enabled:
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_DEBUG_SPINLOCK=y

Serial drivers are maintained by rmk+serial@arm.linux.org.uk, please send
to him.

  Ralf
