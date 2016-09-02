Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 15:28:28 +0200 (CEST)
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:38917 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991344AbcIBN2VG-en4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 15:28:21 +0200
X-MHO-User: 1a33dec5-7111-11e6-b159-2d56437e1029
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 173.50.81.193
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [173.50.81.193])
        by outbound1.eu.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Fri,  2 Sep 2016 13:28:14 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 990268008C;
        Fri,  2 Sep 2016 13:28:06 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 990268008C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1472822886;
        bh=G/C7fTK328zHDMUZR2oSTxlhH29xDiY6s3KznzxX6N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=r88vn6hmXJZhpieVxOzpeMWci9kRChfFJHw1nZfFZZDoP6WDHme/j9xshbcIsaA8/
         cKdLTV2BMZdm+1N4krdGa9GQpX1LAHbt7E5gJSpZhgiB4/FLPUNbYeKxSjqdJS5RNF
         NgUvF66XiNl4AZyusGnehM58N2Dulog4gBOXGLLHdjb+rIMbLCZRUjl0JP7H8ER5/h
         120fs6OI9B0OjRQPQNgUnyvWQpYZphCVPjSOY52UpxQTB3IYxndwixy7GBbxC5v6Ij
         lz9qWd8Ksoas0zaM9usy31mWgW89Z4v0RMRvKiigApngB1jrhxnVHFiwS0kcD16SEt
         R6NSUu6UmsaLw==
Date:   Fri, 2 Sep 2016 13:28:06 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        marc.zyngier@arm.com, soren.brinkmann@xilinx.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [Patch v4 01/12] microblaze: irqchip: Move intc driver to irqchip
Message-ID: <20160902132806.GK10637@io.lakedaemon.net>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
 <772f883f-79fe-9197-f27c-3ffe91019aaf@xilinx.com>
 <5d98fd3b-4722-cdd3-4540-c1d1fec1c98c@imgtec.com>
 <4931182d-7b30-582f-f291-5be59b6b89e4@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4931182d-7b30-582f-f291-5be59b6b89e4@xilinx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Hi Michal, Zubair,

On Fri, Sep 02, 2016 at 12:27:54PM +0200, Michal Simek wrote:
> On 2.9.2016 12:06, Zubair Lutfullah Kakakhel wrote:
> > On 09/02/2016 07:25 AM, Michal Simek wrote:
...
> >> Also there is another copy of this driver in the tree which was using
> >> old ppc405 and ppc440 xilinx platforms.
> >>
> >> arch/powerpc/include/asm/xilinx_intc.h
> >> arch/powerpc/sysdev/xilinx_intc.c
> >>
> >> These should be also removed by moving this driver to generic folder.
> > 
> > I didn't know about that drivers existence.
> > 
> > This patch series already touches microblaze, mips and irqchip.
> > Both microblaze and mips platforms using this driver are little-endian.
> 
> MB is big ending too and as you see there is big endian support in the
> driver already.
> 
> > 
> > Adding a big-endian powerpc driver + platform to the mix is going to
> > complicate the series further and make it super hard to synchronize
> > various subsystems, test stuff, and then move the drivers without
> > breakage.

The whole point of Linus' push to move drivers out of arch/ is to
reduce code duplication and create more robust drivers.

> > I'd highly recommend letting this move happen. And then the powerpc
> > driver can transition over time to this driver.

I've seen this argument before, and despite everyone's best intentions,
it never happens. :(

We have linux-next, 0-day and other resources to test these sorts of
changes and catch errors before they hit mainline.

Let's take our time and do it right.

thx,

Jason.
