Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2010 21:52:41 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:48659 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492094Ab0KYUwf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Nov 2010 21:52:35 +0100
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id oAPKq5Jq029744;
        Thu, 25 Nov 2010 14:52:06 -0600
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     michael@ellerman.id.au, linux-arch <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org
In-Reply-To: <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
References: <1290607413.12457.44.camel@concordia>
         <1290692075.689.20.camel@concordia>
         <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 26 Nov 2010 07:52:04 +1100
Message-ID: <1290718324.32570.127.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Thu, 2010-11-25 at 15:01 +0100, Geert Uytterhoeven wrote:
> 
> I always read it as "for each child-OF-node", so I would rename it to
> "dt_for_each_child_node".

Well, it was meant to be for_child_of_node not _OF_node :-)

Cheers,
Ben.
