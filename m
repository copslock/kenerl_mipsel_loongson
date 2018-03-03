Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 15:14:48 +0100 (CET)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:52483 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990588AbeCCOOhmg-pu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 15:14:37 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 0F9493F3A3;
        Sat,  3 Mar 2018 15:14:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HURXWF1Q57Zb; Sat,  3 Mar 2018 15:14:33 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id C69A93F35F;
        Sat,  3 Mar 2018 15:14:28 +0100 (CET)
Date:   Sat, 3 Mar 2018 15:14:27 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: [RFC] MIPS: PS2: Interrupt request (IRQ) support
Message-ID: <20180303141425.GA18796@localhost.localdomain>
References: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180303122657.GC24991@localhost.localdomain>
 <alpine.DEB.2.00.1803031306530.10166@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1803031306530.10166@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

>  I'm on holiday starting today and lasting two weeks.  I'll have a look at 
> your patch when I am back.

Nice! I believe all patches for the initial submission are ready for
comments and reviews now, but I'm happy for two additional weeks to improve
and polish them. :)

Fredrik
