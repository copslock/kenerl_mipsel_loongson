Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2010 15:42:22 +0100 (CET)
Received: from imr4.ericy.com ([198.24.6.8]:45667 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491888Ab0LGOmR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Dec 2010 15:42:17 +0100
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id oB7FBLAR023712;
        Tue, 7 Dec 2010 09:11:24 -0600
Received: from localhost (147.117.20.213) by eusaamw0707.eamcs.ericsson.se
 (147.117.20.92) with Microsoft SMTP Server id 8.2.234.1; Tue, 7 Dec 2010
 09:41:51 -0500
Date:   Tue, 7 Dec 2010 06:41:50 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Matt Turner <mattst88@gmail.com>,
        Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Message-ID: <20101207144150.GA21872@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
 <20101206173040.GA18372@ericsson.com>
 <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org>
 <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com>
 <alpine.LFD.2.00.1012070148050.17185@eddie.linux-mips.org>
 <20101207051438.GA20144@ericsson.com>
 <alpine.LFD.2.00.1012070740130.17185@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1012070740130.17185@eddie.linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <groeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 07, 2010 at 09:30:27AM -0500, Maciej W. Rozycki wrote:
> On Mon, 6 Dec 2010, Guenter Roeck wrote:
> 
> > A quick look through sb1250 vs. sb1480 code shows that the 1480 uses different
> > interrupt numbers. The patch assigns the sb1250 interrupt numbers, so unless
> > I am missing something the code as written can not work for sb1480.
> 
>  That well could be -- I never had access to a BigSur board.  The 
> board-specific interrupt numbers should either be available from the board 
> manual (I haven't checked if one has been released; I certainly have one 
> for my SWARM) or quoted somewhere in our tree.  Otherwise figuring them 
> out by trial and error should be a trivial exercise for someone with 
> actual hardware at hand.
> 
I already sent a reply to the original patch - I confirmed that the interrupts are different.
Those are SOC interrupts, so they are CPU specific, not board specific. Code started working 
after I replaced the sb1250 interrupts with bcm1480 interrupts.

Guenter
