Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 20:28:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54571 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012151AbcBKT21HQCya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 20:28:27 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 03C98441479E5;
        Thu, 11 Feb 2016 19:28:16 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 11 Feb 2016
 19:28:18 +0000
Date:   Thu, 11 Feb 2016 19:28:17 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mmc@vger.kernel.org>, <david.daney@cavium.com>,
        <ulf.hansson@linaro.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>,
        Aleksey Makarov <aleksey.makarov@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC
 controller
In-Reply-To: <56BBD6AD.2090902@caviumnetworks.com>
Message-ID: <alpine.DEB.2.00.1602111910240.15885@tp.orcam.me.uk>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com> <56BB7B2F.60307@caviumnetworks.com> <20160210234907.GC1640@darkstar.musicnaut.iki.fi> <56BBD6AD.2090902@caviumnetworks.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Thu, 11 Feb 2016, David Daney wrote:

> > > The vast majority of people that see it will not be able to change their
> > > firmware.  So it will be forever cluttering up their boot logs.
> > 
> > Until they switch to use APPENDED_DTB. :-)
> > 
> 
> I am philosophically opposed to making the DTB an internal kernel
> implementation detail.
> 
> For OCTEON boards, it is an ABI between the boot firmware and the kernel, and
> is impractical to change.
> 
> One could argue that many years ago, when the decision was made (by me), that
> we should have opted to carry in the kernel source code tree the DTS files for
> all OCTEON boards ever made, but we did not do that.  Due to the
> non-reversibility of time, the decision is hard to reverse.

 I concur, a very good decision as far as I'm concerned!

 I had the misfortune to work with some Freescale Power boards which used 
in-kernel DTS files in a hope to match the respective board's firmware 
(U-boot).  Needless to say, that didn't quite work.  The mapping of board 
resources was reportedly changed in some version of the firmware to give 
more flexibility and the DTS files bundled with Linux updated accordingly, 
however no version of the old files was kept around and maintained.  So a 
kernel upgrade, which turned out inevitable at one point, became a 
challenging task to update the DTS files so as to match the version of the 
firmware the boards had.

 With some pain I was eventually able to sort this out through patching 
the old DTS files to match the ever-changing DTS syntax and get them 
accepted for a DTB build and work to an acceptable extent with the then 
current version of Linux.  However some board resources were lost, for 
example the IDE interface was no longer accessible; fortunately I didn't 
need it, so I just left it like that and didn't figure out what else I'd 
have to do to regain access.

 So no, no standalone DTS/DTBs please, thank you very much.

  Maciej
