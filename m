Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 08:31:17 +0200 (CEST)
Received: from mail-by2lp0236.outbound.protection.outlook.com ([207.46.163.236]:39660
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822166AbaEUGbPDzgJd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 08:31:15 +0200
Received: from alberich (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Wed, 21 May 2014 06:31:06 +0000
Date:   Wed, 21 May 2014 08:29:44 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 13/15] MIPS: Add defconfig for mips_paravirt
Message-ID: <20140521062944.GB11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-14-git-send-email-andreas.herrmann@caviumnetworks.com>
 <5385064.E38JNkq7Qq@radagast>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5385064.E38JNkq7Qq@radagast>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: DB4PR07CA042.eurprd07.prod.outlook.com (10.242.229.52) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(24454002)(164054003)(189002)(199002)(51704005)(92566001)(4396001)(83322001)(87976001)(575784001)(81342001)(76482001)(33716001)(50986999)(81542001)(42186004)(76176999)(19580405001)(99396002)(86362001)(54356999)(19580395003)(83072002)(33656002)(74662001)(102836001)(77982001)(21056001)(31966008)(85852003)(46102001)(74502001)(50466002)(23676002)(66066001)(101416001)(83506001)(92726001)(20776003)(64706001)(80022001)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40204
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

On Wed, May 21, 2014 at 12:14:31AM +0100, James Hogan wrote:
> Hi Andreas,
> 
> On Tuesday 20 May 2014 16:47:14 Andreas Herrmann wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  arch/mips/configs/mips_paravirt_defconfig | 1524
> > +++++++++++++++++++++++++++++ 1 file changed, 1524 insertions(+)
> >  create mode 100644 arch/mips/configs/mips_paravirt_defconfig
> > 
> > diff --git a/arch/mips/configs/mips_paravirt_defconfig
> > b/arch/mips/configs/mips_paravirt_defconfig new file mode 100644
> > index 0000000..f0cac9c
> > --- /dev/null
> > +++ b/arch/mips/configs/mips_paravirt_defconfig
> > @@ -0,0 +1,1524 @@
> > +#
> > +# Automatically generated file; DO NOT EDIT.
> > +# Linux/mips 3.15.0-rc4 Kernel Configuration
> > +#
> 
> This isn't a minimal defconfig.
> 
> Try make savedefconfig and copy the resulting defconfig file.

Ok.

Thanks,
Andreas
