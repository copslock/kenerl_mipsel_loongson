Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 21:42:39 +0200 (CEST)
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:13624
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3I3TmgORWK2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Sep 2013 21:42:36 +0200
Received: from BLUPR07MB196.namprd07.prod.outlook.com (10.242.200.146) by
 BLUPR07MB404.namprd07.prod.outlook.com (10.141.27.156) with Microsoft SMTP
 Server (TLS) id 15.0.775.9; Mon, 30 Sep 2013 19:42:05 +0000
Received: from BL2PRD0712HT002.namprd07.prod.outlook.com (10.255.236.35) by
 BLUPR07MB196.namprd07.prod.outlook.com (10.242.200.146) with Microsoft SMTP
 Server (TLS) id 15.0.775.9; Mon, 30 Sep 2013 19:42:03 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.35) with Microsoft SMTP Server (TLS) id 14.16.359.1; Mon, 30 Sep
 2013 19:42:01 +0000
Message-ID: <5249D407.2090904@caviumnetworks.com>
Date:   Mon, 30 Sep 2013 12:41:59 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     <devel@driverdev.osuosl.org>, <linux-mips@linux-mips.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        David Daney <david.daney@cavium.com>, <richard@nod.at>
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0
 is special
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi> <5249B37E.4050000@caviumnetworks.com> <20130930193502.GE4572@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130930193502.GE4572@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0985DA2459
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(377454003)(479174003)(51704005)(24454002)(199002)(189002)(77982001)(59766001)(59896001)(23756003)(50466002)(81342001)(65956001)(74662001)(64126003)(54316002)(66066001)(83072001)(31966008)(53416003)(69226001)(83506001)(76482001)(76796001)(76786001)(83322001)(19580405001)(19580395003)(56776001)(56816003)(77096001)(80316001)(74706001)(36756003)(50986001)(63696002)(74502001)(49866001)(53806001)(47446002)(46102001)(47736001)(33656001)(80976001)(81686001)(74366001)(81542001)(81816001)(4396001)(47976001)(80022001)(74876001)(47776003)(65806001)(54356001)(51856001)(79102001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB196;H:BL2PRD0712HT002.namprd07.prod.outlook.com;CLIP:64.2.3.195;FPR:;RD:InfoNoRecords;A:1;MX:3;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 09/30/2013 12:35 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Sep 30, 2013 at 10:23:10AM -0700, David Daney wrote:
>> On 09/28/2013 12:50 PM, Aaro Koskinen wrote:
>>> Currently the driver assumes that CPU 0 is handling all the hard IRQs.
>>> This is wrong in Linux SMP systems where user is allowed to assign to
>>> hardware IRQs to any CPU. The driver will stop working if user sets
>>> smp_affinity so that interrupts end up being handled by other than CPU
>>> 0. The patch fixes that.
>>>
>>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>> ---
>>>   drivers/staging/octeon/ethernet-rx.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
>>> index e14a1bb..de831c1 100644
>>> --- a/drivers/staging/octeon/ethernet-rx.c
>>> +++ b/drivers/staging/octeon/ethernet-rx.c
>>> @@ -80,6 +80,8 @@ struct cvm_oct_core_state {
>>>
>>>   static struct cvm_oct_core_state core_state __cacheline_aligned_in_smp;
>>>
>>> +static int cvm_irq_cpu = -1;
>>> +
>>>   static void cvm_oct_enable_napi(void *_)
>>>   {
>>>   	int cpu = smp_processor_id();
>>> @@ -112,11 +114,7 @@ static void cvm_oct_no_more_work(void)
>>>   {
>>>   	int cpu = smp_processor_id();
>>>
>>> -	/*
>>> -	 * CPU zero is special.  It always has the irq enabled when
>>> -	 * waiting for incoming packets.
>>> -	 */
>>> -	if (cpu == 0) {
>>> +	if (cpu == cvm_irq_cpu) {
>>>   		enable_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group);
>>>   		return;
>>>   	}
>>> @@ -135,6 +133,7 @@ static irqreturn_t cvm_oct_do_interrupt(int cpl, void *dev_id)
>>>   {
>>>   	/* Disable the IRQ and start napi_poll. */
>>>   	disable_irq_nosync(OCTEON_IRQ_WORKQ0 + pow_receive_group);
>>> +	cvm_irq_cpu = smp_processor_id();
>>>   	cvm_oct_enable_napi(NULL);
>>>
>>>   	return IRQ_HANDLED;
>>> @@ -547,8 +546,9 @@ void cvm_oct_rx_initialize(void)
>>>   	cvmx_write_csr(CVMX_POW_WQ_INT_PC, int_pc.u64);
>>>
>>>
>>> -	/* Scheduld NAPI now.  This will indirectly enable interrupts. */
>>> +	/* Schedule NAPI now. */
>>>   	cvm_oct_enable_one_cpu();
>>> +	enable_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group);
>>
>> The fact that you have to manually enable irqs here indicates that
>> the patch is not good.
>>
>> Either the enable_irq() is unnecessary, or you broke the logic for
>> enabling NAPI on more than one CPU.
>>
>> I am not sure which is the case, but I think it would be best if you
>> supplied a fixed patch set that corrects whichever happens to be the
>> case.
>
> No, the original logic was already broken. The code assumed that the
> NAPI scheduled by the driver init gets executed always on CPU 0. The
> IRQ got enabled just because we are lucky.

No.  The default affinity for all irqs is CPU0 for just this reason.  So 
there was no luck involved.

>
> The patch removes such assumption. During the driver init, the IRQ is
> disabled and cvm_irq_cpu is -1. So when the NAPI scheduled (on whatever
> CPU) by the init is done, the check in cvm_oct_no_more_work() will be
> false and the IRQ remains disabled. So the init routine has to enable IRQ
> "manually". This is a special case only for the driver initialization.

No.  We schedule NAPI at this point.  If there are no packets available, 
the normal driver logic enables the irq.  There is no need to explicitly 
enable it in cvm_oct_rx_initialize().

If this doesn't work, and you need to have an additional place that you 
enable the irq, then you broke something.


>
> During the normal operation, the IRQ handler record the CPU (on which
> it's going the schedule for the first NAPI poll) in cvm_irq_cpu so
> cvm_oct_no_more_work() will always re-enable the IRQ correctly.
>
> A.
>
>
>
