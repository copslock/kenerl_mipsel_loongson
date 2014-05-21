Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 15:19:34 +0200 (CEST)
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:22742
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6842298AbaEUNTcPeLzV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 15:19:32 +0200
Received: from alberich (46.78.192.208) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Wed, 21 May 2014 13:19:22 +0000
Date:   Wed, 21 May 2014 15:17:40 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 05/15] MIPS: Don't build fast TLB refill handler with
 32-bit kernels.
Message-ID: <20140521131740.GG11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-6-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537C741F.60104@imgtec.com>
 <20140521130420.GR10287@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20140521130420.GR10287@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM3PR01CA010.eurprd01.prod.exchangelabs.com
 (10.242.240.20) To BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(164054003)(24454002)(189002)(199002)(479174003)(51704005)(76482001)(99396002)(74662001)(21056001)(4396001)(54356999)(87976001)(81542001)(76176999)(85852003)(23676002)(81342001)(77982001)(74502001)(83072002)(101416001)(50986999)(79102001)(92726001)(86362001)(66066001)(46102001)(47776003)(42186004)(83322001)(50466002)(19580405001)(20776003)(33716001)(19580395003)(83506001)(33656002)(64706001)(102836001)(80022001)(158023001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40218
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

On Wed, May 21, 2014 at 03:04:20PM +0200, Ralf Baechle wrote:
> On Wed, May 21, 2014 at 10:38:39AM +0100, James Hogan wrote:
> 
> > On 20/05/14 15:47, Andreas Herrmann wrote:
> > > From: David Daney <david.daney@cavium.com>
> > > 
> > > The fast handler only supports 64-bit kernels.
> > > 
> > > Signed-off-by: David Daney <david.daney@cavium.com>
> > > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > > ---
> > >  arch/mips/mm/tlbex.c |    8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> > > index ee88367..781e183 100644
> > > --- a/arch/mips/mm/tlbex.c
> > > +++ b/arch/mips/mm/tlbex.c
> > > @@ -1250,13 +1250,17 @@ static void build_r4000_tlb_refill_handler(void)
> > >  	unsigned int final_len;
> > >  	struct mips_huge_tlb_info htlb_info __maybe_unused;
> > >  	enum vmalloc64_mode vmalloc_mode __maybe_unused;
> > > -
> > > +#ifdef CONFIG_64BIT
> > > +	bool is64bit = true;
> > > +#else
> > > +	bool is64bit = false;
> > > +#endif
> > >  	memset(tlb_handler, 0, sizeof(tlb_handler));
> > >  	memset(labels, 0, sizeof(labels));
> > >  	memset(relocs, 0, sizeof(relocs));
> > >  	memset(final_handler, 0, sizeof(final_handler));
> > >  
> > > -	if ((scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
> > > +	if (is64bit && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
> > >  		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
> > >  							  scratch_reg);
> > >  		vmalloc_mode = refill_scratch;
> > > 
> > 
> > This looks like a good place to use IS_ENABLED(CONFIG_64BIT) to reduce
> > ifdefery.
> 
> Or even the classic "if (sizeof(unsigned long) == 8)" which is a little less
> expressive but more portable.

Ok, makes sense.
(Will use one of the two suggestions.)


Thanks,

Andreas
