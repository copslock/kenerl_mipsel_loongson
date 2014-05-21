Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 08:38:10 +0200 (CEST)
Received: from mail-bn1blp0183.outbound.protection.outlook.com ([207.46.163.183]:30223
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821198AbaEUGiHV7o90 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 08:38:07 +0200
Received: from alberich (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Wed, 21 May 2014 06:37:58 +0000
Date:   Wed, 21 May 2014 08:36:36 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 14/15] MIPS: paravirt: Update mips_paravirt_defconfig
Message-ID: <20140521063636.GC11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-15-git-send-email-andreas.herrmann@caviumnetworks.com>
 <2583927.Tb84BXCILT@radagast>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2583927.Tb84BXCILT@radagast>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM2PR06CA010.eurprd06.prod.outlook.com (10.255.61.27) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(24454002)(189002)(199002)(51704005)(92566001)(4396001)(83322001)(87976001)(81342001)(76482001)(33716001)(50986999)(81542001)(42186004)(76176999)(99396002)(86362001)(54356999)(83072002)(33656002)(74662001)(102836001)(77982001)(21056001)(31966008)(85852003)(46102001)(74502001)(50466002)(23676002)(66066001)(101416001)(83506001)(92726001)(20776003)(64706001)(80022001)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40205
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

On Wed, May 21, 2014 at 12:17:37AM +0100, James Hogan wrote:
> On Tuesday 20 May 2014 16:47:15 Andreas Herrmann wrote:
> > Change CPU selection, enable SMP, enable almost all virtio options.
> 
> Looks like this should just be squashed into the previous patch if the 
> original defconfig was insufficient.

I'll merge it.


Andreas
