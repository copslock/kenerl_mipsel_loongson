Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2015 12:48:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32161 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009236AbbJPKszoYoCM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2015 12:48:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E7503CA52732D;
        Fri, 16 Oct 2015 11:48:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Oct 2015 11:48:49 +0100
Received: from localhost (192.168.159.35) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 16 Oct
 2015 11:48:49 +0100
Date:   Fri, 16 Oct 2015 11:48:48 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Alex Smith <alex@alex-smith.me.uk>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        <linux-mtd@lists.infradead.org>,
        Alex Smith <alex.smith@imgtec.com>,
        "Zubair Lutfullah Kakakhel" <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH v7,3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
Message-ID: <20151016104848.GA1408@NP-P-BURTON>
References: <1444148837-10770-1-git-send-email-harvey.hunt@imgtec.com>
 <1444148837-10770-4-git-send-email-harvey.hunt@imgtec.com>
 <20151015084727.GG14475@jhogan-linux.le.imgtec.org>
 <CAOFt0_D5mO-7_cnpvm_MwvsZNv1yCFynbeA3dSw=H5hVyQbgTA@mail.gmail.com>
 <20151016103112.GB29285@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20151016103112.GB29285@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.35]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Fri, Oct 16, 2015 at 11:31:12AM +0100, James Hogan wrote:
> > >> +
> > >> +&nemc {
> > >> +     status = "okay";
> > >> +
> > >> +     nand: nand@1 {
> > >> +             compatible = "ingenic,jz4780-nand";
> > >
> > > Isn't the NAND a micron part? This doesn't seem right. Is the device
> > > driver and binding already accepted upstream with that compatible
> > > string?
> > 
> > This is the compatible string for the JZ4780 NAND driver, this patch
> > is part of the series adding that. Detection of the NAND part is
> > handled by the MTD subsystem.
> 
> Right (didn't spot that it was part of a series).
> 
> The node appears to describe the NAND interface itself, i.e. a part of
> the SoC, so should be in the SoC dtsi file, with overrides in the board
> file if necessary for it to work with a particular NAND part
> (potentially utilising status="disabled"). Would you agree?

Hi James,

The "nemc" node there is for the Nand & External Memory Controller which
is a hardware block inside the SoC. It has 6 banks (ie. 6 chip select
pins, each associated with a different address range, that connect to
different devices). NAND flash is one such possible device, but a board
could connect it to any of the 6 chip selects, or banks. To represent
that in the SoC dtsi you'd want to have 6 NAND nodes, each disabled by
default, which doesn't make a whole lot of sense to me. Other, non-NAND
devices can connect to the NEMC too - for example the ethernet
controller on the CI20 is connected to one bank.

The NAND device nodes are sort of a mix of describing the NAND flash
(ie. Micron part as you point out) and its connections & properties, the
way the NEMC should be used to interact with it alongside the BCH block,
and the configuration for the NEMC such as timing parameters.

I imagine the most semantically correct means of describing it would
probably be for the compatible string to reflect the Micron NAND part,
and the NEMC driver to pick up on the relevant properties of its child
nodes for configuring timings, whether the device is NAND etc. However
the handling of registering NAND devices with MTD would probably then
have to be part of the NEMC driver, which feels a bit off too.

Thanks,
    Paul
