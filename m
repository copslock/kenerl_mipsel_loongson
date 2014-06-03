Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 17:04:52 +0200 (CEST)
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:26363
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854770AbaFCPEmHje1v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jun 2014 17:04:42 +0200
Received: from alberich (2.173.120.4) by
 CO1PR07MB394.namprd07.prod.outlook.com (10.141.74.13) with Microsoft SMTP
 Server (TLS) id 15.0.954.9; Tue, 3 Jun 2014 15:04:33 +0000
Date:   Tue, 3 Jun 2014 17:03:37 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 09/13] MIPS: Add functions for hypervisor call
Message-ID: <20140603150337.GA28045@alberich>
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1401313936-11867-10-git-send-email-andreas.herrmann@caviumnetworks.com>
 <20140603083031.GP17197@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20140603083031.GP17197@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.173.120.4]
X-ClientProxiedBy: AM3PR01CA009.eurprd01.prod.exchangelabs.com (10.242.240.19)
 To CO1PR07MB394.namprd07.prod.outlook.com (10.141.74.13)
X-Microsoft-Antispam: BL:0;ACTION:Default;RISK:Low;SCL:0;SPMLVL:NotSpam;PCL:0;RULEID:
X-Forefront-PRVS: 02318D10FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(199002)(189002)(51704005)(24454002)(54356999)(50986999)(76176999)(86362001)(101416001)(21056001)(74662001)(74502001)(76482001)(83322001)(85852003)(83072002)(31966008)(99396002)(33716001)(33656002)(92566001)(87976001)(20776003)(92726001)(102836001)(46102001)(42186004)(4396001)(77982001)(23676002)(64706001)(66066001)(80022001)(47776003)(50466002)(81342001)(81542001)(79102001);DIR:OUT;SFP:;SCL:1;SRVR:CO1PR07MB394;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40421
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

On Tue, Jun 03, 2014 at 10:30:31AM +0200, Ralf Baechle wrote:
> On Wed, May 28, 2014 at 11:52:12PM +0200, Andreas Herrmann wrote:
> 
> > +/*
> > + * Hypercalls for KVM.
> > + *
> > + * Hypercall number is passed in v0.
> > + * Return value will be placed in v0.
> > + * Up to 3 arguments are passed in a0, a1, and a2.
> > + */
> > +static inline unsigned long kvm_hypercall0(unsigned long num)
> > +{
> > +	register unsigned long n asm("v0");
> > +	register unsigned long r asm("v0");
> 
> Btw, is it safe to put two variables in the same register?

I think it's safe.

If we would have a matching constraint letter (say "v" for register v0) the
asm should translate to

        __asm__ __volatile__(
	       KVM_HYPERCALL
                : "=v" (n) : "v" (r) : "memory"
                );

which isn't unusual on other archs. (Or maybe I am just biased from
x86 ... or missed something else.)

> The syscall wrappers that used to be in <asm/unistd.h> were occasionally
> hitting problems which eventually forced me to stop forcing variables
> into particular registers instead using a MOVE instruction to shove
> each variable into the right place.
> 
> Of course they were being used from non-PIC and PIC code, kernel and userland
> so GCC had a much better chance to do evil than in the hypercall wrapper
> case - but it made me paranoid ...



Andreas
