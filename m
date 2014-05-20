Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:56:46 +0200 (CEST)
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:59194
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855025AbaETO4nmKVhQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:56:43 +0200
Received: from alberich (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:56:34 +0000
Date:   Tue, 20 May 2014 16:55:45 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 08/12] kvm tools: Provide per arch macro to specify
 type for KVM_CREATE_VM
Message-ID: <20140520145545.GB23042@alberich>
References: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400518411-9759-9-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537B3B8A.5000600@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <537B3B8A.5000600@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: DBXPR06CA020.eurprd06.prod.outlook.com (10.141.8.166) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(479174003)(24454002)(51704005)(164054003)(199002)(189002)(79102001)(23676002)(66066001)(77982001)(92726001)(50466002)(74502001)(46102001)(64706001)(47776003)(80022001)(83506001)(20776003)(101416001)(50986999)(76482001)(33716001)(42186004)(81542001)(33656001)(92566001)(81342001)(87976001)(4396001)(19580395003)(83072002)(85852003)(21056001)(76176999)(83322001)(31966008)(54356999)(74662001)(86362001)(99396002)(102836001)(19580405001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40190
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

On Tue, May 20, 2014 at 12:24:58PM +0100, James Hogan wrote:
> On 19/05/14 17:53, Andreas Herrmann wrote:
> > This is is usually 0 for most archs. On mips we have two types.
> > TE (type 0) and MIPS-VZ (type 1). Default to 1 on mips.
> 
> Minor thing I didn't spot with v1 (sorry).
> I think this patch should probably be moved before patch 6 with the mips
> part squashed into patch 6, otherwise AFAICT the mips support in patch
> 6/7 is broken out of the box until this patch fixes it.

Yes, you are correct, the patch sequence should be changed.
(Will have to send out a new version of the patch set. But first I am
waiting a little bit to see whether there are further comments.)


Thanks,

Andreas


> Cheers
> James
> 
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  tools/kvm/arm/include/arm-common/kvm-arch.h |    2 ++
> >  tools/kvm/kvm.c                             |    2 +-
> >  tools/kvm/mips/include/kvm/kvm-arch.h       |    5 +++++
> >  tools/kvm/powerpc/include/kvm/kvm-arch.h    |    2 ++
> >  tools/kvm/x86/include/kvm/kvm-arch.h        |    2 ++
> >  5 files changed, 12 insertions(+), 1 deletion(-)
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
> > index 6046434..e1b9f6c 100644
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
> > index 4a8407b..7eadbf4 100644
> > --- a/tools/kvm/mips/include/kvm/kvm-arch.h
> > +++ b/tools/kvm/mips/include/kvm/kvm-arch.h
> > @@ -17,6 +17,11 @@
> >  
> >  #define KVM_IRQ_OFFSET		1
> >  
> > +/*
> > + * MIPS-VZ (trap and emulate is 0)
> > + */
> > +#define KVM_VM_TYPE		1
> > +
> >  #define VIRTIO_DEFAULT_TRANS(kvm)	VIRTIO_PCI
> >  
> >  #include <stdbool.h>
> > diff --git a/tools/kvm/powerpc/include/kvm/kvm-arch.h b/tools/kvm/powerpc/include/kvm/kvm-arch.h
> > index f8627a2..fdd518f 100644
> > --- a/tools/kvm/powerpc/include/kvm/kvm-arch.h
> > +++ b/tools/kvm/powerpc/include/kvm/kvm-arch.h
> > @@ -44,6 +44,8 @@
> >  
> >  #define KVM_IRQ_OFFSET			16
> >  
> > +#define KVM_VM_TYPE			0
> > +
> >  #define VIRTIO_DEFAULT_TRANS(kvm)	VIRTIO_PCI
> >  
> >  struct spapr_phb;
> > diff --git a/tools/kvm/x86/include/kvm/kvm-arch.h b/tools/kvm/x86/include/kvm/kvm-arch.h
> > index a9f23b8..673bdf1 100644
> > --- a/tools/kvm/x86/include/kvm/kvm-arch.h
> > +++ b/tools/kvm/x86/include/kvm/kvm-arch.h
> > @@ -27,6 +27,8 @@
> >  
> >  #define KVM_IRQ_OFFSET		5
> >  
> > +#define KVM_VM_TYPE		0
> > +
> >  #define VIRTIO_DEFAULT_TRANS(kvm)	VIRTIO_PCI
> >  
> >  struct kvm_arch {
> > 
