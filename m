Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 22:18:09 +0200 (CEST)
Received: from mail-by2lp0236.outbound.protection.outlook.com ([207.46.163.236]:43163
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855125AbaEVUSGoR71b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 22:18:06 +0200
Received: from alberich (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Thu, 22 May 2014 20:17:57 +0000
Date:   Thu, 22 May 2014 22:17:07 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 11/15] MIPS: paravirt: Add pci controller for virtio
Message-ID: <20140522201707.GK11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-12-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537C913C.1060903@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <537C913C.1060903@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: DBXPR04CA007.eurprd04.prod.outlook.com (10.255.191.155)
 To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(479174003)(24454002)(51704005)(199002)(189002)(101416001)(74502001)(50466002)(79102001)(66066001)(15975445006)(23676002)(80022001)(47776003)(83506001)(50986999)(64706001)(76482001)(92726001)(20776003)(42186004)(81542001)(19580405001)(92566001)(81342001)(33716001)(87976001)(15202345003)(4396001)(83322001)(85852003)(76176999)(54356999)(31966008)(86362001)(46102001)(21056001)(102836001)(33656002)(99396002)(77982001)(15395725003)(74662001)(19580395003)(83072002)(6606295002);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:3;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40250
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

On Wed, May 21, 2014 at 12:42:52PM +0100, James Hogan wrote:
> On 20/05/14 15:47, Andreas Herrmann wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  arch/mips/Kconfig                |    1 +
> >  arch/mips/paravirt/Kconfig       |    6 ++
> >  arch/mips/pci/Makefile           |    2 +-
> >  arch/mips/pci/pci-virtio-guest.c |  140 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 148 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/mips/paravirt/Kconfig
> >  create mode 100644 arch/mips/pci/pci-virtio-guest.c
> 
> If I understand correctly this just drives a simple PCI controller for a
> PCI bus that a virtio device happens to be usually plugged in to, yeh?

Yes.

> It sounds like it would make sense to take advantage of Will Deacon's
> recent efforts to make a generic pci controller driver for this sort of
> thing which specifically mentions emulation by kvmtool? Is it
> effectively the same PCI controller that is being emulated?

I think, it's very similar. But it depends on OF.
 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/thread.html#233491
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233491.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233490.html

Currently we are at v6:
http://marc.info/?i=1399478839-3564-1-git-send-email-will.deacon@arm.com

Will take a closer look (trying to get it running for mips_paravirt).


Andreas
