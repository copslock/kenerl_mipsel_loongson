Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2014 12:47:31 +0200 (CEST)
Received: from mail-by2on0140.outbound.protection.outlook.com ([207.46.100.140]:64935
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817664AbaELKrOi2EHP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 May 2014 12:47:14 +0200
Received: from alberich (2.174.248.214) by
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Mon, 12 May 2014 10:47:06 +0000
Date:   Mon, 12 May 2014 12:46:58 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 07/11] kvm tools: Provide per arch macro to specify type
 for KVM_CREATE_VM
Message-ID: <20140512104658.GC15623@alberich>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1399391491-5021-8-git-send-email-andreas.herrmann@caviumnetworks.com>
 <536D49E6.5050201@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <536D49E6.5050201@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.174.248.214]
X-ClientProxiedBy: DB4PR01CA012.eurprd01.prod.exchangelabs.com
 (10.242.152.42) To BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141)
X-Forefront-PRVS: 0209425D0A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(164054003)(189002)(199002)(479174003)(24454002)(51704005)(74502001)(31966008)(74662001)(81542001)(19580405001)(76482001)(33656001)(99396002)(76176999)(50986999)(23676002)(54356999)(4396001)(19580395003)(83322001)(575784001)(33716001)(86362001)(81342001)(46102001)(77982001)(42186004)(101416001)(64706001)(87976001)(20776003)(47776003)(50466002)(92566001)(66066001)(83072002)(92726001)(21056001)(85852003)(80022001)(79102001)(83506001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN1PR07MB389;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40080
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

On Fri, May 09, 2014 at 10:34:30PM +0100, James Hogan wrote:
> Hi Andreas,
> 
> On 06/05/14 16:51, Andreas Herrmann wrote:
> > This is is usually 0 for most archs. On mips we have two types.
> > TE (type 0) and MIPS-VZ (type 1). Default to 1 on mips.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  tools/kvm/arm/include/arm-common/kvm-arch.h |    2 ++
> >  tools/kvm/kvm.c                             |    2 +-
> >  tools/kvm/mips/include/kvm/kvm-arch.h       |    2 ++
> >  tools/kvm/powerpc/include/kvm/kvm-arch.h    |    2 ++
> >  tools/kvm/x86/include/kvm/kvm-arch.h        |    2 ++
> >  5 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/kvm/arm/include/arm-common/kvm-arch.h b/tools/kvm/arm/include/arm-common/kvm-arch.h
> > index b6c4bf8..a552163 100644
> > --- a/tools/kvm/arm/include/arm-common/kvm-arch.h
> > +++ b/tools/kvm/arm/include/arm-common/kvm-arch.h
> > @@ -32,6 +32,8 @@
> >  
> >  #define KVM_IRQ_OFFSET		GIC_SPI_IRQ_BASE
> >  
> > +#define KVM_VM_TYPE		0
> > +
> >  #define VIRTIO_DEFAULT_TRANS(kvm)	\
> >  	((kvm)->cfg.arch.virtio_trans_pci ? VIRTIO_PCI : VIRTIO_MMIO)
> >  
> > diff --git a/tools/kvm/kvm.c b/tools/kvm/kvm.c
> > index cfc0693..278b915 100644
> > --- a/tools/kvm/kvm.c
> > +++ b/tools/kvm/kvm.c
> > @@ -284,7 +284,7 @@ int kvm__init(struct kvm *kvm)
> >  		goto err_sys_fd;
> >  	}
> >  
> > -	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, 0);
> > +	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, KVM_VM_TYPE);
> >  	if (kvm->vm_fd < 0) {
> >  		pr_err("KVM_CREATE_VM ioctl");
> >  		ret = kvm->vm_fd;
> > diff --git a/tools/kvm/mips/include/kvm/kvm-arch.h b/tools/kvm/mips/include/kvm/kvm-arch.h
> > index 4a8407b..0210f0b 100644
> > --- a/tools/kvm/mips/include/kvm/kvm-arch.h
> > +++ b/tools/kvm/mips/include/kvm/kvm-arch.h
> > @@ -17,6 +17,8 @@
> >  
> >  #define KVM_IRQ_OFFSET		1
> >  
> > +#define KVM_VM_TYPE		1
> 
> A comment or define to clarify this wouldn't hurt.

Ok.

Thanks,
Andreas
