Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Mar 2004 06:46:41 +0100 (BST)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:25596
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8224863AbUC1Fqk>; Sun, 28 Mar 2004 06:46:40 +0100
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 5DE72120; Sun, 28 Mar 2004 07:46:33 +0200 (DFT)
Received: from mx5.informatik.uni-tuebingen.de ([127.0.0.1])
 by localhost (mx5 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 33410-03; Sun, 28 Mar 2004 07:46:31 +0200 (DFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 29320112; Sun, 28 Mar 2004 07:46:31 +0200 (DFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1B7T7u-0005k8-00; Sun, 28 Mar 2004 07:46:30 +0200
To: "ashish anand" <ashish_ibm@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: clearing interrupt outside handler..?
References: <20040326130600.4179.qmail@webmail7.rediffmail.com>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 28 Mar 2004 07:46:30 +0200
In-Reply-To: <20040326130600.4179.qmail@webmail7.rediffmail.com>
Message-ID: <87zna1r0ax.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

"ashish  anand" <ashish_ibm@rediffmail.com> writes:

> Hello,
> 
> I am restarting a thread discussed november last year regarding
> spurious interrupts generation due to edge triggering .
> pls. refer ,
> http://www.linux-mips.org/archives/linux-mips/2003-11/msg00071.html
> 
> somehow this problem is again surfaced.
> I am interfacing a peripheral to mips CP0 interrupt controller
> through GPIO which converts edge to level .
> now my question is that ,
> 
> is it always safe to clear the interrupt status outside the interrupt handler in a driver under some particular path flow ?
> I think it is not as it may land-up in a situation where by the time
> GPIO detects the edge due to requirement of certain  minimum pulse width duration , it is already cleared and thus a spurious interrupt generation will happen.
> 
> I might be wrong .I am looking for comments on above mentioned situation.
> 
> Best Regards,
> Ashish

I might be wrong, I'm just starting learing about the details of mips,
but its my understanding that the interrupt would reassert itself
imediatly when you leave the interrupt vector without clearing it
first.

That said, when you are outside the interrupt handler the interrupt
bit should always be unset. The only thing I can imagine hapening is
the interrupt getting triggered while the clear instruction is
running. You might or might not have a race condition there then.

But why would you ever want to clear an interrupt outside the handler,
it normaly cannot be set. Spurious interrupts shouldn't be caused by
this I think. If at all you would miss some interrupt completly.


Or am I totally off there?

MfG
        Goswin
