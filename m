Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 00:16:52 +0200 (CEST)
Received: from mail-bl2lp0203.outbound.protection.outlook.com ([207.46.163.203]:9464
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-FAIL-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854811AbaE1WM309muo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 00:12:29 +0200
Received: from alberich (31.213.222.82) by
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 22:11:30 +0000
Date:   Thu, 29 May 2014 00:10:40 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 11/15] MIPS: paravirt: Add pci controller for virtio
Message-ID: <20140528221040.GB6335@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-12-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537C913C.1060903@imgtec.com>
 <20140522201707.GK11800@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20140522201707.GK11800@alberich>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: AMSPR05CA003.eurprd05.prod.outlook.com (10.242.77.161) To
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(51704005)(69234005)(199002)(189002)(479174003)(24454002)(102836001)(33656002)(81342001)(86362001)(81542001)(77982001)(92566001)(46102001)(76482001)(92726001)(42186004)(101416001)(31966008)(19580395003)(87976001)(83322001)(19580405001)(83506001)(21056001)(74502001)(23676002)(15975445006)(15395725003)(74662001)(50986999)(83072002)(76176999)(15202345003)(54356999)(20776003)(80022001)(47776003)(79102001)(4396001)(99396002)(66066001)(64706001)(50466002)(85852003)(33716001)(6606295002);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB397;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

On Thu, May 22, 2014 at 10:17:07PM +0200, Andreas Herrmann wrote:
> On Wed, May 21, 2014 at 12:42:52PM +0100, James Hogan wrote:
> > On 20/05/14 15:47, Andreas Herrmann wrote:
> > > From: David Daney <david.daney@cavium.com>
> > > 
> > > Signed-off-by: David Daney <david.daney@cavium.com>
> > > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > > ---
> > >  arch/mips/Kconfig                |    1 +
> > >  arch/mips/paravirt/Kconfig       |    6 ++
> > >  arch/mips/pci/Makefile           |    2 +-
> > >  arch/mips/pci/pci-virtio-guest.c |  140 ++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 148 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/mips/paravirt/Kconfig
> > >  create mode 100644 arch/mips/pci/pci-virtio-guest.c
> > 
> > If I understand correctly this just drives a simple PCI controller for a
> > PCI bus that a virtio device happens to be usually plugged in to, yeh?
> 
> Yes.
> 
> > It sounds like it would make sense to take advantage of Will Deacon's
> > recent efforts to make a generic pci controller driver for this sort of
> > thing which specifically mentions emulation by kvmtool? Is it
> > effectively the same PCI controller that is being emulated?
> 
> I think, it's very similar. But it depends on OF.
>  
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/thread.html#233491
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233491.html
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233490.html
> 
> Currently we are at v6:
> http://marc.info/?i=1399478839-3564-1-git-send-email-will.deacon@arm.com
> 
> Will take a closer look (trying to get it running for mips_paravirt).

FYI, I've dismissed this (for v2) after taking a closer look and after
I've seen https://lkml.org/lkml/2014/5/18/54.


Andreas
