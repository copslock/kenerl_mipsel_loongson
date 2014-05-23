Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2014 22:30:14 +0200 (CEST)
Received: from mail-bl2lp0203.outbound.protection.outlook.com ([207.46.163.203]:7965
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821443AbaEWUaMW0sNh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 May 2014 22:30:12 +0200
Received: from alberich (46.78.192.208) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Fri, 23 May 2014 20:29:46 +0000
Date:   Fri, 23 May 2014 22:28:55 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 10/15] MIPS: Add code for new system 'paravirt'.
Message-ID: <20140523202855.GL11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537CAC74.4030800@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <537CAC74.4030800@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: DB3PR04CA004.eurprd04.prod.outlook.com (10.242.134.24) To
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(479174003)(24454002)(199002)(189002)(51704005)(76482001)(64706001)(77982001)(20776003)(4396001)(47776003)(92726001)(101416001)(86362001)(92566001)(81342001)(81542001)(42186004)(66066001)(80022001)(79102001)(50466002)(33656002)(46102001)(85852003)(74662001)(74502001)(31966008)(23676002)(99396002)(54356999)(50986999)(83322001)(76176999)(102836001)(83072002)(33716001)(87976001)(21056001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40259
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
> > diff --git a/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
> > new file mode 100644
> > index 0000000..c812efa
> > --- /dev/null
> > +++ b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
> > @@ -0,0 +1,49 @@
> 
> > +/*
> > + * Do SMP slave processor setup necessary before we can safely execute
> > + * C code.
> > + */
> > +	.macro  smp_slave_setup
> > +	mfc0	t0, CP0_EBASE
> > +	andi	t0, t0, 0x3ff		# CPUNum
> > +	slti	t1, t0, NR_CPUS
> > +	bnez	t1, 1f
> > +2:
> > +	di
> > +	wait
> > +	b	2b			# Unknown CPU, loop forever.
> > +1:
> > +	PTR_LA	t1, paravirt_smp_sp
> > +	PTR_SLL	t0, PTR_SCALESHIFT
> > +	PTR_ADDU t1, t1, t0
> > +3:
> > +	PTR_L	sp, 0(t1)
> > +	beqz	sp, 3b			# Spin until told to proceed.
> > +
> > +	PTR_LA	t1, paravirt_smp_gp
> > +	PTR_ADDU t1, t1, t0
> 
> Usually smp_wmb() at the writer needs to be paired with smp_rmb() at the
> reader (i.e. here) to guarantee that the two memory locations become
> visible to this CPU in the correct order, so I think you need a sync of
> some kind between here to be portable beyond Octeon.

Yes, I think, I should add a sync here ...

> > +	PTR_L	gp, 0(t1)
> > +	.endm

 -- 8< --

> > +static void paravirt_boot_secondary(int cpu, struct task_struct *idle)
> > +{
> > +	paravirt_smp_gp[cpu] = (unsigned long)(task_thread_info(idle));
> 
> spurious brackets around task_thread_info(idle)
> 
> > +	wmb();
> 
> Wouldn't smp_wmb() be more accurate?

... use smp_wmb there ...

> > +	paravirt_smp_sp[cpu] = __KSTK_TOS(idle);
> > +	mb();
> 
> is this barrier necessary?

... and omit this one.


Andreas
