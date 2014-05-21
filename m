Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 08:24:31 +0200 (CEST)
Received: from mail-bl2lp0211.outbound.protection.outlook.com ([207.46.163.211]:14013
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6842298AbaEUGYKS4Rer (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 08:24:10 +0200
Received: from alberich (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Wed, 21 May 2014 06:23:37 +0000
Date:   Wed, 21 May 2014 08:22:10 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 03/15] MIPS: OCTEON: Move CAVIUM_OCTEON_CVMSEG_SIZE to
 CPU_CAVIUM_OCTEON
Message-ID: <20140521062210.GA11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-4-git-send-email-andreas.herrmann@caviumnetworks.com>
 <3124276.AVUgu1xWyv@radagast>
 <537BE3D7.1070904@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <537BE3D7.1070904@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: DB3PR04CA006.eurprd04.prod.outlook.com (10.242.134.26) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(52604005)(479174003)(377454003)(24454002)(51704005)(199002)(189002)(66066001)(23676002)(101416001)(46102001)(50466002)(74502001)(80022001)(64706001)(47776003)(83506001)(20776003)(92726001)(50986999)(76482001)(33716001)(42186004)(81542001)(92566001)(81342001)(87976001)(4396001)(83322001)(77982001)(21056001)(85852003)(31966008)(86362001)(54356999)(76176999)(19580405001)(99396002)(102836001)(83072002)(19580395003)(74662001)(33656002);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40203
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

On Tue, May 20, 2014 at 04:23:03PM -0700, David Daney wrote:
> On 05/20/2014 03:52 PM, James Hogan wrote:
> >Hi Andreas,
> >
> >On Tuesday 20 May 2014 16:47:04 Andreas Herrmann wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>CVMSEG is related to the CPU core not the SoC system.  So needs to be
> >>configurable there.
> >>
> >>Signed-off-by: David Daney <david.daney@cavium.com>
> >>Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> >>---
> >>  arch/mips/cavium-octeon/Kconfig |   30 ++++++++++++++++++++----------
> >>  1 file changed, 20 insertions(+), 10 deletions(-)
> >>
> >>diff --git a/arch/mips/cavium-octeon/Kconfig
> >>b/arch/mips/cavium-octeon/Kconfig index 227705d..c5e9975 100644
> >>--- a/arch/mips/cavium-octeon/Kconfig
> >>+++ b/arch/mips/cavium-octeon/Kconfig
> [...]
> >>-config CAVIUM_OCTEON_CVMSEG_SIZE
> >>-	int "Number of L1 cache lines reserved for CVMSEG memory"
> >>-	range 0 54
> >>-	default 1
> >>+config CAVIUM_OCTEON_HW_FIX_UNALIGNED
> >>+	bool "Enable hardware fixups of unaligned loads and stores"
> >>+	default "y"
> >
> >Is adding CAVIUM_OCTEON_HW_FIX_UNALIGNED in this patch intentional? It seems
> >unrelated.
> >
> 
> Good catch.  CAVIUM_OCTEON_HW_FIX_UNALIGNED and its users were
> removed, we shouldn't add it back.  I think this is a case of
> rebasing gone wrong.


Oops, sorry, that wasn't intentional.
James, thanks for catching this.


Andreas
