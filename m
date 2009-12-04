Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 17:03:56 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:43765 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492994AbZLDQDx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2009 17:03:53 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1NGadJ-0006bq-00; Fri, 04 Dec 2009 17:03:49 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id E1F32DE1DF; Fri,  4 Dec 2009 17:03:33 +0100 (CET)
Date:   Fri, 4 Dec 2009 17:03:33 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     myuboot@fastmail.fm
Cc:     linux-kernel@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: PIR OFFSET for AR7
Message-ID: <20091204160333.GA8842@alpha.franken.de>
References: <20091028103551.0b4052d8@pixies.home.jungo.com> <1259891550.19943.1348372917@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259891550.19943.1348372917@webmail.messagingengine.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Dec 03, 2009 at 07:52:30PM -0600, myuboot@fastmail.fm wrote:
> Hi, What is the use of PIR register for AR7 board in file
> arch/mips/ar7/irq.c?

it gives back the channel and line of the pending interrupt with the
highest priority.

> If I understand it right, PIR is used to define the
> polarity of the interrupts. It seems to me that it needs to initialized?

no, it's a read only register. Why do you think it has something to do
with interrupt polarity ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
