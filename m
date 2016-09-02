Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 14:48:52 +0200 (CEST)
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:48307 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991984AbcIBMsoWGUpY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 14:48:44 +0200
X-MHO-User: 90e2d9b5-710b-11e6-b159-2d56437e1029
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 173.50.81.193
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [173.50.81.193])
        by outbound1.eu.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Fri,  2 Sep 2016 12:48:36 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id E6D3B80059;
        Fri,  2 Sep 2016 12:48:28 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io E6D3B80059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1472820509;
        bh=cRKQkKjRbSmK7Wa49MPfro6K/Jk/OcGKD441uNTLoQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=sbs8ZaxIW4XlhRPJuqQGF2ivvrrW+VkKIZ13NDteBGSUEiE3roBU/GrSvZ6CMbcXE
         pHX7QssXkSsNWUtWmrBmIYDgQ9uzw+iWlkdCX2RpsKCcc7y9Q4umOMNktDc55ZJuCH
         dtlVqnJ3wheaC7goDHTaTQPIlhDfEd6RATw8CAUlhLkBZJoDFBRZw7+KCSawkHbj6R
         PsAi/9oEV4ifUH7KOUizvKcCPFeUlWRw770XCuir8CtdIZ2piBGvJSH4sV7dj0kct6
         fTISOsnJr8kXpSOJCsAISV3Dn+aWu9gEKbQ4WoaPVMpvanbnAA6Zu/zQA7o+G/SQBk
         f3dHzpDuOoABQ==
Date:   Fri, 2 Sep 2016 12:48:28 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        marc.zyngier@arm.com, soren.brinkmann@xilinx.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [Patch v4 01/12] microblaze: irqchip: Move intc driver to irqchip
Message-ID: <20160902124828.GI10637@io.lakedaemon.net>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
 <772f883f-79fe-9197-f27c-3ffe91019aaf@xilinx.com>
 <5d98fd3b-4722-cdd3-4540-c1d1fec1c98c@imgtec.com>
 <4931182d-7b30-582f-f291-5be59b6b89e4@xilinx.com>
 <03e1ee8a-3053-8823-751d-7513b0e316dc@imgtec.com>
 <6c47c2fd-016e-fe88-ddcb-43d42ed5dbb1@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c47c2fd-016e-fe88-ddcb-43d42ed5dbb1@xilinx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54991
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

Hi Michal,

On Fri, Sep 02, 2016 at 02:06:40PM +0200, Michal Simek wrote:
> On 2.9.2016 13:46, Zubair Lutfullah Kakakhel wrote:
> > On 09/02/2016 11:27 AM, Michal Simek wrote:
> >> On 2.9.2016 12:06, Zubair Lutfullah Kakakhel wrote:
> >>> On 09/02/2016 07:25 AM, Michal Simek wrote:
> >>>> On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
> >>>>> V1 -> V2
> >>>>>
> >>>>> Renamed irq-xilinx to irq-axi-intc
> >>>>> Renamed CONFIG_XILINX_INTC to CONFIG_XILINX_AXI_INTC
> >>>>
> >>>>
> >>>> I see that this was suggested by Jason Cooper but using axi name
> >>>> here is
> >>>> not correct.
> >>>> There is xps-intc name which is the name used on old OPB hardware
> >>>> designs. It means this driver can be still used only on system which
> >>>> uses it.
> >>>
> >>> Wouldn't axi-intc be more suitable moving forwards?
> >>> The IP block is now known as axi intc for 5 years as far as I can tell.
> >>>
> >>> Searching "axi intc" online results in the right docs for current and
> >>> future platforms.

Please add links to the relevant docs in the comments of the code.

> >>
> >> yes but we still should support older platform and it is more then this.
> >> This is soft-IP core and in future when there is new bus then IP will
> >> just change bus interface, etc.
> > 
> > That makes sense. I'll rename the driver to irq-xps-intc.c
> > and CONFIG_XILINX_XPS_INTC
> > 
> > Please shout now if anybody has issues with this.
> 
> XPS was shortcut for design tools. You had CONFIG_XILINX_INTC which is
> IMHO the best name you can have.

Michal, thanks for the background info!

Zubair, any problem with CONFIG_XILINX_INTC/irq-xilinx-intc.c ?

thx,

Jason.
