Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 18:14:41 +0200 (CEST)
Received: from mail-bn1blp0187.outbound.protection.outlook.com ([207.46.163.187]:22356
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855114AbaEVQOjK9zWR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 18:14:39 +0200
Received: from alberich (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Thu, 22 May 2014 16:14:30 +0000
Date:   Thu, 22 May 2014 18:13:42 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 07/15] MIPS: Add mips_cpunum() function.
Message-ID: <20140522161342.GI11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-8-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537C89B5.2030907@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <537C89B5.2030907@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AMSPR04CA001.eurprd04.prod.outlook.com (10.242.77.149) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(24454002)(189002)(199002)(51704005)(479174003)(4396001)(83322001)(87976001)(85852003)(81542001)(19580405001)(42186004)(81342001)(33716001)(92566001)(99396002)(102836001)(33656002)(74662001)(83072002)(77982001)(19580395003)(76176999)(31966008)(54356999)(86362001)(21056001)(46102001)(50466002)(74502001)(23676002)(66066001)(79102001)(101416001)(76482001)(92726001)(20776003)(80022001)(83506001)(64706001)(50986999)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40246
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

On Wed, May 21, 2014 at 12:10:45PM +0100, James Hogan wrote:
> On 20/05/14 15:47, Andreas Herrmann wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > This returns the CPUNum from the low order Ebase bits.
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  arch/mips/include/asm/mipsregs.h |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> > index 3e025b5..f110d48 100644
> > --- a/arch/mips/include/asm/mipsregs.h
> > +++ b/arch/mips/include/asm/mipsregs.h
> > @@ -1916,6 +1916,11 @@ __BUILD_SET_C0(brcm_cmt_ctrl)
> >  __BUILD_SET_C0(brcm_config)
> >  __BUILD_SET_C0(brcm_mode)
> >  
> > +static inline unsigned int mips_cpunum(void)
> > +{
> > +	return read_c0_ebase() & 0x3ff; /* Low 10 bits of ebase. */
> > +}
> 
> If this is going to go in mips generic code I think it should be clearly
> defined, especially in the presence of MT, otherwise perhaps it makes
> sense for it to go in a paravirt specific header?

It's just wrapper to read ebase_cpunum. Currently only used in the
paravirt-code (to get CPUnum for a guest CPU -- which eventually is
read from guest cp0 context).

I am not sure whether it needs to be moved to a paravirt specific
header.

> I.e. does it return the core number of the running VPE (if so it should
> probably do something like below as in decode_configs() and go in
> smp.h), or does it simply always return that field in ebase register (in
> which case it should probably have ebase in the name and a comment to
> clarify that it doesn't necessarily map directly to core/vpe number).

Under KVM (MIPSVZ) it effectively returns vcpu_id and thus such a
comment could be added for clarification.

So, should we name it get_ebase_cpunum() but keep it in this header
(and also replace the 1 or 2 occurrences of "read_c0_ebase() & 0x3ff"
in the non-paravirt code with it)?

> unsigned int core = read_c0_ebase() & 0x3ff;
> if (cpu_has_mipsmt)
> 	core >>= fls(smp_num_siblings) - 1;
> 
> Cheers
> James


Andreas
