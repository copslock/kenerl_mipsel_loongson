Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 09:14:19 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:60403 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491022Ab1CXION (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 09:14:13 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2fgF-000484-1j; Thu, 24 Mar 2011 09:14:07 +0100
Date:   Thu, 24 Mar 2011 09:14:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 01/38] mips; Convert alchemy to new irq chip functions
In-Reply-To: <AANLkTimkSzuTu6AWij=T_J7W6KTTjB6BBTOyTLcxi_Kq@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1103240910280.31464@localhost6.localdomain6>
References: <20110323210437.398062704@linutronix.de> <20110323210534.669706549@linutronix.de> <AANLkTimkSzuTu6AWij=T_J7W6KTTjB6BBTOyTLcxi_Kq@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463795968-1161343172-1300954447=:31464"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795968-1161343172-1300954447=:31464
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 24 Mar 2011, Manuel Lauss wrote:

> On Wed, Mar 23, 2011 at 10:08 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Fix the deadlock in set_type() while at it.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/mips/alchemy/common/irq.c     |   98 ++++++++++++++++++-------------------
> >  arch/mips/alchemy/devboards/bcsr.c |   18 +++---
> >  2 files changed, 59 insertions(+), 57 deletions(-)
> 
> Tested on the db1200, works fine.
> 
> I'm curious though: could you please elaborate on where the deadlock came from?
> Is it not safe to call set_irq_type() at all times?

The code called set_irq_chip_and_handler_name() resp. set_irq_chip()
from the set_type() callback. That only works on UP and lock debugging
disabled. Otherwise it would dead lock on desc->lock.

__irq_set_chip_handler_name_locked() avoids that.

Thanks,

	tglx
---1463795968-1161343172-1300954447=:31464--
