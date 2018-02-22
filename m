Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2018 18:27:37 +0100 (CET)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:37057 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994577AbeBVR1awMhMY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Feb 2018 18:27:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 930163F594;
        Thu, 22 Feb 2018 18:27:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id csGs2ZMim0Xx; Thu, 22 Feb 2018 18:27:22 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 334553F433;
        Thu, 22 Feb 2018 18:27:11 +0100 (CET)
Date:   Thu, 22 Feb 2018 18:27:10 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: [RFC v2] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
Message-ID: <20180222172709.GB2310@localhost.localdomain>
References: <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211075608.GC2222@localhost.localdomain>
 <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk>
 <20180215191502.GA2736@localhost.localdomain>
 <alpine.DEB.2.00.1802151934180.3553@tp.orcam.me.uk>
 <20180218084723.GA2577@localhost.localdomain>
 <alpine.DEB.2.00.1802201410300.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802201410300.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62689
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

>  Do you use the netconsole then too?  Using a USB serial port adapter 
> would be an alternative, although not a very powerful one either, because 
> you need to have many parts of the OS initialised before you can get to 
> such a port.

No, I haven't used netconsole, but I do have a frame buffer. There have been
a few very early kernel crashes during the porting from v2.6 to v4.15. All
of them could be identified to a single commit by bisection, and then it was
easy to find a solution to proceed, fortunately.

Eventually I'd like to get kexec working. I suspect it could be somewhat
tricky to debug though.

Fredrik
