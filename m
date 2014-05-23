Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2014 22:32:32 +0200 (CEST)
Received: from dns-bn1lp0143.outbound.protection.outlook.com ([207.46.163.143]:37302
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6830033AbaEWUcOh0X1V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 May 2014 22:32:14 +0200
Received: from alberich (46.78.192.208) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Fri, 23 May 2014 20:32:07 +0000
Date:   Fri, 23 May 2014 22:31:18 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 10/15] MIPS: Add code for new system 'paravirt'.
Message-ID: <20140523203118.GM11800@alberich>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-11-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537CAC74.4030800@imgtec.com>
 <537CD4C6.5080905@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <537CD4C6.5080905@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: DB3PR04CA001.eurprd04.prod.outlook.com (10.242.134.21) To
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(479174003)(377454003)(24454002)(199002)(189002)(51704005)(76482001)(64706001)(77982001)(20776003)(4396001)(47776003)(92726001)(101416001)(86362001)(92566001)(81342001)(81542001)(42186004)(66066001)(80022001)(79102001)(50466002)(33656002)(46102001)(85852003)(74662001)(74502001)(31966008)(23676002)(99396002)(54356999)(50986999)(83322001)(76176999)(102836001)(83072002)(33716001)(87976001)(21056001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40260
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

On Wed, May 21, 2014 at 09:31:02AM -0700, David Daney wrote:
> On 05/21/2014 06:39 AM, James Hogan wrote:
> [...]
> >>diff --git a/arch/mips/paravirt/paravirt-irq.c b/arch/mips/paravirt/paravirt-irq.c
> >>new file mode 100644
> >>index 0000000..e1603dd
> >>--- /dev/null
> >>+++ b/arch/mips/paravirt/paravirt-irq.c
> [...]
> >
> >>+static void irq_core_set_enable_local(void *arg)
> >>+{
> >>+	struct irq_data *data = arg;
> >>+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> >>+	unsigned int mask = 0x100 << cd->bit;
> >>+
> >>+	/*
> >>+	 * Interrupts are already disabled, so these are atomic.
> >
> >Really? Even when called directly from irq_core_bus_sync_unlock with
> >only a single core online?
> >
> 
> Yes, but...
> 
> 
> >>+	 */
> >>+	if (cd->desired_en)
> >>+		set_c0_status(mask);
> >>+	else
> >>+		clear_c0_status(mask);
> >>+
> >>+}
> >>+
> >>+static void irq_core_disable(struct irq_data *data)
> >>+{
> >>+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> >>+	cd->desired_en = false;
> >>+}
> >>+
> >>+static void irq_core_enable(struct irq_data *data)
> >>+{
> >>+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> >>+	cd->desired_en = true;
> >>+}
> >>+
> >>+static void irq_core_bus_lock(struct irq_data *data)
> >>+{
> >>+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> >>+
> >>+	mutex_lock(&cd->core_irq_mutex);
> >>+}
> >>+
> >>+static void irq_core_bus_sync_unlock(struct irq_data *data)
> >>+{
> >>+	struct core_chip_data *cd = irq_data_get_irq_chip_data(data);
> >>+
> >>+	if (cd->desired_en != cd->current_en) {
> >>+		/*
> >>+		 * Can be called in early init when on_each_cpu() will
> >>+		 * unconditionally enable irqs, so handle the case
> >>+		 * where only a single CPU is online specially, and
> >>+		 * directly call.
> >>+		 */
> >>+		if (num_online_cpus() == 1)
> >>+			irq_core_set_enable_local(data);
> >>+		else
> >>+			on_each_cpu(irq_core_set_enable_local, data, 1);
> >>+
> 
> 
> ...  This code is not correct.  It was initially done as a
> workaround for the issues fixed in commit 202da4005.
> 
> Now that on_each_cpu() is less buggy, we can unconditionally use it
> and the assertion above about "Interrupts are already disabled" will
> be true.


I'll adapt this in the next version of the patch.


Andreas
