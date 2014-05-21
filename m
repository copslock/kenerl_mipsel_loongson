Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 23:04:10 +0200 (CEST)
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:3634
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854846AbaEUVEHNTVae (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 23:04:07 +0200
Received: from alberich (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Wed, 21 May 2014 21:03:41 +0000
Date:   Wed, 21 May 2014 23:02:12 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 06/15] MIPS: Add minimal support for OCTEON3 to c-r4k.c
Message-ID: <20140521210212.GH11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-7-git-send-email-andreas.herrmann@caviumnetworks.com>
 <20140521124041.GP10287@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20140521124041.GP10287@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AMSPR01CA013.eurprd01.prod.exchangelabs.com
 (10.255.167.158) To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(24454002)(189002)(199002)(51704005)(87976001)(83322001)(4396001)(76482001)(50986999)(92566001)(33716001)(81342001)(81542001)(42186004)(102836001)(99396002)(54356999)(86362001)(76176999)(74662001)(33656002)(83072002)(77982001)(31966008)(85852003)(21056001)(46102001)(50466002)(74502001)(23676002)(79102001)(101416001)(92726001)(83506001)(20776003)(80022001)(64706001)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:3;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40228
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

On Wed, May 21, 2014 at 02:40:41PM +0200, Ralf Baechle wrote:
> On Tue, May 20, 2014 at 04:47:07PM +0200, Andreas Herrmann wrote:
> 
> > +static inline void r4k_blast_dcache_page_dc128(unsigned long addr)
> > +{
> > +	R4600_HIT_CACHEOP_WAR_IMPL;
> 
> The R4600 has 32 byte cache lines that is this line will never be
> executed on an R4600 thus can be dropped.

So the line can also be removed from r4k_blast_dcache_page_dc64?

> > +	blast_dcache128_page(addr);
> > +}
> > +
> >  static void r4k_blast_dcache_page_setup(void)
> >  {
> >  	unsigned long  dc_lsize = cpu_dcache_line_size();
> > @@ -121,6 +127,8 @@ static void r4k_blast_dcache_page_setup(void)
> >  		r4k_blast_dcache_page = r4k_blast_dcache_page_dc32;
> >  	else if (dc_lsize == 64)
> >  		r4k_blast_dcache_page = r4k_blast_dcache_page_dc64;
> > +	else if (dc_lsize == 128)
> > +		r4k_blast_dcache_page = r4k_blast_dcache_page_dc128;
> 
> 
> For another patch - let's see if this can be turned into a switch
> construct which hopefully is more readable and produces just as
> afficient code with reasonable vintage of gcc.

Ok.

Andreas
