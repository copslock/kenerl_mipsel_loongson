Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2014 12:48:17 +0200 (CEST)
Received: from mail-by2lp0240.outbound.protection.outlook.com ([207.46.163.240]:55193
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822276AbaELKsN3WxDz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 May 2014 12:48:13 +0200
Received: from alberich (2.174.248.214) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.939.12; Mon, 12 May 2014 10:48:05 +0000
Date:   Mon, 12 May 2014 12:47:53 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 10/11] kvm tools: Introduce weak (default) load_bzimage
 function
Message-ID: <20140512104753.GD15623@alberich>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1399391491-5021-11-git-send-email-andreas.herrmann@caviumnetworks.com>
 <536D4C38.2010300@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <536D4C38.2010300@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.174.248.214]
X-ClientProxiedBy: DB4PR01CA014.eurprd01.prod.exchangelabs.com
 (10.242.152.44) To BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0209425D0A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(164054003)(189002)(199002)(51704005)(479174003)(24454002)(77982001)(76482001)(92566001)(92726001)(86362001)(76176999)(83072002)(85852003)(50986999)(99396002)(46102001)(42186004)(101416001)(19580405001)(54356999)(4396001)(83322001)(19580395003)(74662001)(74502001)(47776003)(64706001)(20776003)(66066001)(80022001)(81342001)(33656001)(79102001)(83506001)(81542001)(23676002)(31966008)(87976001)(50466002)(33716001)(21056001);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR07MB386;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40081
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

On Fri, May 09, 2014 at 10:44:24PM +0100, James Hogan wrote:
> Hi Andreas,
> 
> On 06/05/14 16:51, Andreas Herrmann wrote:
> > ... to get rid of its function definition from archs that don't
> > support it.
> 
> Maybe it makes sense to put this patch before the main mips one so that
> the function doesn't have to be added for mips in the first place

Yes, that makes sense.

Thanks,
Andreas

> Cheers
> James
> 
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  tools/kvm/arm/fdt.c     |    7 -------
> >  tools/kvm/kvm.c         |    6 ++++++
> >  tools/kvm/mips/kvm.c    |    6 ------
> >  tools/kvm/powerpc/kvm.c |    7 -------
> >  4 files changed, 6 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/kvm/arm/fdt.c b/tools/kvm/arm/fdt.c
> > index 30cd75a..186a718 100644
> > --- a/tools/kvm/arm/fdt.c
> > +++ b/tools/kvm/arm/fdt.c
> > @@ -276,10 +276,3 @@ int load_flat_binary(struct kvm *kvm, int fd_kernel, int fd_initrd,
> >  
> >  	return true;
> >  }
> > -
> > -bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
> > -		  const char *kernel_cmdline)
> > -{
> > -	/* To b or not to b? That is the zImage. */
> > -	return false;
> > -}
> > diff --git a/tools/kvm/kvm.c b/tools/kvm/kvm.c
> > index 278b915..e1b9f6c 100644
> > --- a/tools/kvm/kvm.c
> > +++ b/tools/kvm/kvm.c
> > @@ -355,6 +355,12 @@ int __attribute__((__weak__)) load_elf_binary(struct kvm *kvm, int fd_kernel,
> >  	return false;
> >  }
> >  
> > +bool __attribute__((__weak__)) load_bzimage(struct kvm *kvm, int fd_kernel,
> > +				int fd_initrd, const char *kernel_cmdline)
> > +{
> > +	return false;
> > +}
> > +
> >  bool kvm__load_kernel(struct kvm *kvm, const char *kernel_filename,
> >  		const char *initrd_filename, const char *kernel_cmdline)
> >  {
> > diff --git a/tools/kvm/mips/kvm.c b/tools/kvm/mips/kvm.c
> > index 09192c8..fc0428b 100644
> > --- a/tools/kvm/mips/kvm.c
> > +++ b/tools/kvm/mips/kvm.c
> > @@ -323,12 +323,6 @@ int load_elf_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *k
> >  	return true;
> >  }
> >  
> > -bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
> > -		  const char *kernel_cmdline)
> > -{
> > -	return false;
> > -}
> > -
> >  void ioport__map_irq(u8 *irq)
> >  {
> >  }
> > diff --git a/tools/kvm/powerpc/kvm.c b/tools/kvm/powerpc/kvm.c
> > index c1712cf..2b03a12 100644
> > --- a/tools/kvm/powerpc/kvm.c
> > +++ b/tools/kvm/powerpc/kvm.c
> > @@ -204,13 +204,6 @@ int load_flat_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *
> >  	return true;
> >  }
> >  
> > -bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
> > -		  const char *kernel_cmdline)
> > -{
> > -	/* We don't support bzImages. */
> > -	return false;
> > -}
> > -
> >  struct fdt_prop {
> >  	void *value;
> >  	int size;
> > 
