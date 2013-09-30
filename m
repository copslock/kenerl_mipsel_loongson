Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 19:23:35 +0200 (CEST)
Received: from mail-bl2lp0209.outbound.protection.outlook.com ([207.46.163.209]:51527
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823120Ab3I3RXdUkM4u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Sep 2013 19:23:33 +0200
Received: from BL2PRD0712HT002.namprd07.prod.outlook.com (10.255.236.35) by
 BLUPR07MB002.namprd07.prod.outlook.com (10.255.209.36) with Microsoft SMTP
 Server (TLS) id 15.0.775.9; Mon, 30 Sep 2013 17:23:13 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.35) with Microsoft SMTP Server (TLS) id 14.16.359.1; Mon, 30 Sep
 2013 17:23:12 +0000
Message-ID: <5249B37E.4050000@caviumnetworks.com>
Date:   Mon, 30 Sep 2013 10:23:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     <devel@driverdev.osuosl.org>, <linux-mips@linux-mips.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        David Daney <david.daney@cavium.com>, <richard@nod.at>
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0
 is special
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 0985DA2459
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(199002)(24454002)(51704005)(189002)(479174003)(377454003)(63696002)(81686001)(83506001)(79102001)(66066001)(81342001)(33656001)(69226001)(77096001)(47776003)(65956001)(36756003)(74366001)(81816001)(76786001)(76796001)(81542001)(83322001)(56816003)(19580405001)(23756003)(54356001)(56776001)(74706001)(53806001)(31966008)(53416003)(46102001)(80976001)(74502001)(47446002)(19580395003)(74876001)(80316001)(64126003)(50466002)(50986001)(74662001)(83072001)(65806001)(47976001)(51856001)(77982001)(59896001)(54316002)(49866001)(76482001)(80022001)(47736001)(59766001)(4396001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB002;H:BL2PRD0712HT002.namprd07.prod.outlook.com;CLIP:64.2.3.195;FPR:;RD:InfoNoRecords;A:1;MX:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38070
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

On 09/28/2013 12:50 PM, Aaro Koskinen wrote:
> Currently the driver assumes that CPU 0 is handling all the hard IRQs.
> This is wrong in Linux SMP systems where user is allowed to assign to
> hardware IRQs to any CPU. The driver will stop working if user sets
> smp_affinity so that interrupts end up being handled by other than CPU
> 0. The patch fixes that.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>   drivers/staging/octeon/ethernet-rx.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> index e14a1bb..de831c1 100644
> --- a/drivers/staging/octeon/ethernet-rx.c
> +++ b/drivers/staging/octeon/ethernet-rx.c
> @@ -80,6 +80,8 @@ struct cvm_oct_core_state {
>
>   static struct cvm_oct_core_state core_state __cacheline_aligned_in_smp;
>
> +static int cvm_irq_cpu = -1;
> +
>   static void cvm_oct_enable_napi(void *_)
>   {
>   	int cpu = smp_processor_id();
> @@ -112,11 +114,7 @@ static void cvm_oct_no_more_work(void)
>   {
>   	int cpu = smp_processor_id();
>
> -	/*
> -	 * CPU zero is special.  It always has the irq enabled when
> -	 * waiting for incoming packets.
> -	 */
> -	if (cpu == 0) {
> +	if (cpu == cvm_irq_cpu) {
>   		enable_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group);
>   		return;
>   	}
> @@ -135,6 +133,7 @@ static irqreturn_t cvm_oct_do_interrupt(int cpl, void *dev_id)
>   {
>   	/* Disable the IRQ and start napi_poll. */
>   	disable_irq_nosync(OCTEON_IRQ_WORKQ0 + pow_receive_group);
> +	cvm_irq_cpu = smp_processor_id();
>   	cvm_oct_enable_napi(NULL);
>
>   	return IRQ_HANDLED;
> @@ -547,8 +546,9 @@ void cvm_oct_rx_initialize(void)
>   	cvmx_write_csr(CVMX_POW_WQ_INT_PC, int_pc.u64);
>
>
> -	/* Scheduld NAPI now.  This will indirectly enable interrupts. */
> +	/* Schedule NAPI now. */
>   	cvm_oct_enable_one_cpu();
> +	enable_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group);

The fact that you have to manually enable irqs here indicates that the 
patch is not good.

Either the enable_irq() is unnecessary, or you broke the logic for 
enabling NAPI on more than one CPU.

I am not sure which is the case, but I think it would be best if you 
supplied a fixed patch set that corrects whichever happens to be the case.

David Daney



>   }
>
>   void cvm_oct_rx_shutdown(void)
>
