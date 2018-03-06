Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 13:00:57 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:44439 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994683AbeCFMAtnfrLr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2018 13:00:49 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A3BE6207A3; Tue,  6 Mar 2018 13:00:32 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4CA33203A0;
        Tue,  6 Mar 2018 13:00:22 +0100 (CET)
Date:   Tue, 6 Mar 2018 13:00:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 5/6] MIPS: generic: Add support for Microsemi Ocelot
Message-ID: <20180306120023.GS3035@piout.net>
References: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
 <20180302224811.26840-6-alexandre.belloni@bootlin.com>
 <20180303002528.GE4197@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180303002528.GE4197@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 03/03/2018 at 00:25:29 +0000, James Hogan wrote:
> Similarly if the platform is little endian only, you could also add:
> # require CONFIG_CPU_LITTLE_ENDIAN=y
> 

It supports big endian.

> > +
> > +CONFIG_LEGACY_BOARD_OCELOT=y
> > +
> > +CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
> 
> Hmm, can this break any other generic platforms that already make the
> DTB command line override the arcs_cmdline? Paul?
> 
> I.e. In arch_mem_init() the condition of copying arcs_cmdline to
> boot_command_line would switch from !boot_command_line[0] to
> arcs_cmdline[0]. I suppose arcs_cmdline[] may not have been written in
> those cases. If its safe then it should probably be a standard thing
> selected by MIPS_GENERIC instead of a board specific thing.
> 

Actually, this is not needed so I'm removing it.

> > +CONFIG_MAGIC_SYSRQ=y
> 
> Perhaps its worth adding this to the base generic_defconfig if its
> useful to have.
> 

Our test automation tool is using it to reboot the platform but I don't
know if this is useful for anybody else.

> > +static __init bool ocelot_detect(void)
> > +{
> > +	u32 rev;
> > +
> > +	rev = __raw_readl((void *)DEVCPU_GCB_CHIP_REGS_CHIP_ID);
> 
> Isn't that an address in the user segment, i.e. TLB mapped virtual
> memory? Does the bootloader set up a wired mapping for it or something?
> 
> The address looks similar to UART_UART which is given to ioremap so must
> be a physical address. Perhaps the mapping you're using is 1:1
> virtual:physical address?
> 
> If its using a TLB mapping, then:
> 1) That isn't safe this early to run on other platforms, as it'll give a
>    TLB refill exception. It should be quite possible to detect such a
>    mapping to make it safer though.
> 2) If yamon initialises the TLB to a known state, then that may well be
>    a hacky but workable way to distinguish yamon (sead3) from redboot
>    (mscc) in future.
> 

Yes, this is an identity mapping that is installed by redboot because
all the peripherals are in the user segment.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
