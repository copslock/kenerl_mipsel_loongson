Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 14:56:50 +0200 (CEST)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:58600 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2100873Ab1C2M4q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2011 14:56:46 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id B15AC1B4242;
        Tue, 29 Mar 2011 21:56:41 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Tue, 29 Mar 2011 21:56:41 +0900 (JST)
Date:   Tue, 29 Mar 2011 21:56:37 +0900 (JST)
Message-Id: <20110329.215637.193684107.anemo@mba.ocn.ne.jp>
To:     macro@linux-mips.org
Cc:     tglx@linutronix.de, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch 06/38] mips: dec: Convert to new irq_chip functions
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <alpine.LFD.2.00.1103250005470.18858@eddie.linux-mips.org>
References: <alpine.LFD.2.00.1103241808300.18858@eddie.linux-mips.org>
        <alpine.LFD.2.00.1103242024470.31464@localhost6.localdomain6>
        <alpine.LFD.2.00.1103250005470.18858@eddie.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 25 Mar 2011 00:33:22 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > Then that code was broken before. Since MIPS was converted to the flow
> > handlers nothing ever called .end(). I seem to miss something.
...
>  I'll see what I can do about it, but I need a pointer to the offending 
> change -- Ralf or anyone, can you provide me with one?

JFYI from my old memory...

On 2006, I once converted ioasic_irq and ioasic_dma_irq to the flow
handlers, and then revert ioasic_dma_irq to old style.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20061202.000803.05599975.anemo%40mba.ocn.ne.jp

Then, Franck Bui-Huu added GENERIC_HARDIRQS_NO__DO_IRQ to some
platforms but not DECstation.

And then, on 2009, Ralf enabled GENERIC_HARDIRQS_NO__DO_IRQ for all
platforms.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20090311112806.GA24541%40linux-mips.org

I suppose something was lost at this conversion, but not sure.

---
Atsushi Nemoto
