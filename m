Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2014 12:46:52 +0200 (CEST)
Received: from mail-by2on0141.outbound.protection.outlook.com ([207.46.100.141]:65349
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817664AbaELKqlhSOsv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 May 2014 12:46:41 +0200
Received: from alberich (2.174.248.214) by
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Mon, 12 May 2014 10:46:33 +0000
Date:   Mon, 12 May 2014 12:46:20 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 06/11] kvm tools, mips: Enable build of mips support
Message-ID: <20140512104620.GB15623@alberich>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1399391491-5021-7-git-send-email-andreas.herrmann@caviumnetworks.com>
 <536D4707.5090207@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <536D4707.5090207@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.174.248.214]
X-ClientProxiedBy: DB4PR01CA012.eurprd01.prod.exchangelabs.com
 (10.242.152.42) To BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141)
X-Forefront-PRVS: 0209425D0A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(164054003)(189002)(199002)(479174003)(24454002)(51704005)(74502001)(31966008)(74662001)(81542001)(19580405001)(76482001)(33656001)(99396002)(76176999)(50986999)(23676002)(54356999)(4396001)(19580395003)(83322001)(33716001)(86362001)(81342001)(46102001)(77982001)(42186004)(101416001)(64706001)(87976001)(20776003)(47776003)(50466002)(92566001)(66066001)(83072002)(92726001)(21056001)(85852003)(80022001)(79102001)(83506001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN1PR07MB389;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40079
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

On Fri, May 09, 2014 at 10:22:15PM +0100, James Hogan wrote:
> Hi Andreas,
> 
> On 06/05/14 16:51, Andreas Herrmann wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  tools/kvm/Makefile |   11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/kvm/Makefile b/tools/kvm/Makefile
> > index b872651..91286ad 100644
> > --- a/tools/kvm/Makefile
> > +++ b/tools/kvm/Makefile
> > @@ -105,7 +105,7 @@ OBJS	+= virtio/mmio.o
> >  
> >  # Translate uname -m into ARCH string
> >  ARCH ?= $(shell uname -m | sed -e s/i.86/i386/ -e s/ppc.*/powerpc/ \
> > -	  -e s/armv7.*/arm/ -e s/aarch64.*/arm64/)
> > +	  -e s/armv7.*/arm/ -e s/aarch64.*/arm64/ -e s/mips64/mips/)
> >  
> >  ifeq ($(ARCH),i386)
> >  	ARCH         := x86
> > @@ -184,6 +184,15 @@ ifeq ($(ARCH), arm64)
> >  	ARCH_WANT_LIBFDT := y
> >  endif
> >  
> > +ifeq ($(ARCH),mips)
> > +	DEFINES		+= -DCONFIG_MIPS
> > +	ARCH_INCLUDE	:= mips/include
> > +	CFLAGS		+= -I../../arch/mips/include/asm/mach-cavium-octeon
> > +	CFLAGS		+= -I../../arch/mips/include/asm/mach-generic
> 
> I can't see any obvious includes from these two directories in the
> previous patch. Are there any?

No, there aren't.
Both lines should be removed.

> > +	OBJS		+= mips/kvm.o
> > +	OBJS		+= mips/kvm-cpu.o
> > +	OBJS		+= mips/irq.o
> > +endif
> >  ###
> >  
> >  ifeq (,$(ARCH_INCLUDE))
> > 
> 
> Cheers
> James


Thanks,
Andreas
