Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 18:55:49 +0200 (CEST)
Received: from mail-bn1blp0183.outbound.protection.outlook.com ([207.46.163.183]:48365
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855125AbaEVQzrqZOew (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 18:55:47 +0200
Received: from alberich (46.78.192.208) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Thu, 22 May 2014 16:55:40 +0000
Date:   Thu, 22 May 2014 18:54:47 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 10/15] MIPS: Add code for new system 'paravirt'.
Message-ID: <20140522165447.GJ11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537CAC74.4030800@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <537CAC74.4030800@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AMSPR01CA009.eurprd01.prod.exchangelabs.com
 (10.255.167.154) To BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(24454002)(189002)(199002)(51704005)(479174003)(22564002)(4396001)(54356999)(21056001)(99396002)(76482001)(86362001)(23676002)(79102001)(50986999)(92726001)(76176999)(31966008)(101416001)(85852003)(74662001)(81542001)(87976001)(92566001)(81342001)(83072002)(77982001)(74502001)(66066001)(46102001)(47776003)(42186004)(83322001)(50466002)(20776003)(102836001)(33716001)(80022001)(64706001)(83506001)(33656002);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40248
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

On Wed, May 21, 2014 at 02:39:00PM +0100, James Hogan wrote:
> On 20/05/14 15:47, Andreas Herrmann wrote:

 -- 8< --

> > diff --git a/arch/mips/paravirt/paravirt-irq.c b/arch/mips/paravirt/paravirt-irq.c
> > new file mode 100644
> > index 0000000..e1603dd
> > --- /dev/null
> > +++ b/arch/mips/paravirt/paravirt-irq.c
> > @@ -0,0 +1,388 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + *
> > + * Copyright (C) 2013 Cavium, Inc.
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mutex.h>
> > +
> > +#include <asm/io.h>
> > +
> > +#define MBOX_BITS_PER_CPU 2
> > +
> > +int cpunum_for_cpu(int cpu)
> 
> static?

Yes.

> > +{
> > +#ifdef CONFIG_SMP
> > +	return cpu_logical_map(cpu);
> > +#else
> > +	return mips_cpunum();
> > +#endif
> > +}

 -- 8< --

> > +static int irq_pci_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
> > +{
> > +	return 0;
> > +}
> 
> Is there any point even providing this callback?

Hmm, no, if we can't modify CPU affinity we shouldn't provide it.

> > +
> > +static void irq_pci_cpu_offline(struct irq_data *data)
> > +{
> > +}
> 
> Or this one?

No.

> > +
> > +static struct irq_chip irq_chip_pci = {
> > +	.name = "PCI",
> > +	.irq_enable = irq_pci_enable,
> > +	.irq_disable = irq_pci_disable,
> > +	.irq_ack = irq_pci_ack,
> > +	.irq_mask = irq_pci_mask,
> > +	.irq_unmask = irq_pci_unmask,
> > +	.irq_set_affinity = irq_pci_set_affinity,
> > +	.irq_cpu_offline = irq_pci_cpu_offline,
> > +};

 -- 8< --

> > +static void paravirt_boot_secondary(int cpu, struct task_struct *idle)
> > +{
> > +	paravirt_smp_gp[cpu] = (unsigned long)(task_thread_info(idle));
> 
> spurious brackets around task_thread_info(idle)

Ok.

> > +	wmb();
 
 -- 8< --

> > +int prom_putchar(char c)
> > +{
> > +	hypcall3(0 /* Console output */, 0 /*  port 0 */, (unsigned long)&c, 1 /* len == 1 */);
> 
> I think the hypcall API needs to be clearly specified and Documented
> somewhere along with its HYPCALL codes and scope. I.e. is it specific to
> kvmtool, or attempting to be a standard API across MIPS hypervisors.
> 
> It probably should have nice definitions in a header and wrappers
> somewhere to make the arguments explicit and so there's no need for the
> comments explaining what the magic values mean.

Agreed. I think when the definitions are moved to kvm_para.h,
appropriate macros for the hypercall numbers will also be provided
etc.


Andreas
