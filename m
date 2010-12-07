Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2010 15:30:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38479 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491888Ab0LGOa1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Dec 2010 15:30:27 +0100
Date:   Tue, 7 Dec 2010 14:30:27 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
cc:     Matt Turner <mattst88@gmail.com>,
        Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
In-Reply-To: <20101207051438.GA20144@ericsson.com>
Message-ID: <alpine.LFD.2.00.1012070740130.17185@eddie.linux-mips.org>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com> <20101206173040.GA18372@ericsson.com> <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org> <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com> <alpine.LFD.2.00.1012070148050.17185@eddie.linux-mips.org>
 <20101207051438.GA20144@ericsson.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 6 Dec 2010, Guenter Roeck wrote:

> A quick look through sb1250 vs. sb1480 code shows that the 1480 uses different
> interrupt numbers. The patch assigns the sb1250 interrupt numbers, so unless
> I am missing something the code as written can not work for sb1480.

 That well could be -- I never had access to a BigSur board.  The 
board-specific interrupt numbers should either be available from the board 
manual (I haven't checked if one has been released; I certainly have one 
for my SWARM) or quoted somewhere in our tree.  Otherwise figuring them 
out by trial and error should be a trivial exercise for someone with 
actual hardware at hand.

  Maciej
