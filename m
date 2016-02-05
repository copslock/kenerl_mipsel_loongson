Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 18:22:15 +0100 (CET)
Received: from mail-bn1bon0061.outbound.protection.outlook.com ([157.56.111.61]:64448
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011848AbcBERWOIAep- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Feb 2016 18:22:14 +0100
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 DM3PR07MB2137.namprd07.prod.outlook.com (10.164.4.143) with Microsoft SMTP
 Server (TLS) id 15.1.396.15; Fri, 5 Feb 2016 17:22:05 +0000
Message-ID: <56B4DA3B.40607@caviumnetworks.com>
Date:   Fri, 5 Feb 2016 09:22:03 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 6/7] [PATCH] MIPS: OCTEON: Add support for OCTEON III
 interrupt controller.
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com> <1454632974-7686-7-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.11.1602050954480.25254@nanos>
In-Reply-To: <alpine.DEB.2.11.1602050954480.25254@nanos>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0057.namprd07.prod.outlook.com (25.163.126.25)
 To DM3PR07MB2137.namprd07.prod.outlook.com (25.164.4.143)
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;2:l0gH6lGQhnWGfmzwMEtxIvvzOzSfAdYY+fPapAx/6SwEPxn25foFUShLYBu5fh7DZxrXjX1DrTQH/R5+VD4XiGDTvpLtQo26Un7n68YXf2+cY2aI2i+sMHnVUu/BQ5tmcquR4wzHrwfoOLYUR+OC/w==;3:5Fxetihz6S2bPcbiruZFZP96OM9qxe7PgNkRvIS+CRQ5gcGcMixTwWNBB+RY5iFrZhPTNEfdOxLZ7cWP9wpHxNgsRIUDS4slp1puCz0Ab5iSECFfzHXl2duGxmdpkddI;25:C99qXVikiRPIwboxbzgODEJsq+bwHFkomGbeLpB8u0KPTE9bGwiW4w7YiyPoaEHojoaMBstLITXRrG+/ujhsN9Gmzr+0ek3soyecb+dfWkaIg+91+22ATrIq2AFS7hCxRc9On/avWux0w6M8uoLMLQj546/mfG21XdQvM+nYhS9onNxFtEb4AS5MrVf4lIEFG8sY4G5ghPr6zSBkQonwhrhH29n8k/gGYO80NsOmCH1Cr7W276Vummt6hNbAoj9fTMZnTxfxcghpj6V8Ryq7q/Y6fkA1bjZMuAbZQn4+vX42AjWmCtkUmBe9cR+p/p2X
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-MS-Office365-Filtering-Correlation-Id: 597dcd3e-968a-4d93-666b-08d32e50df4e
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;20:XiD8lpH3HWyPRqRNHHUdipxVWaDeL0dIQDvvF9Z3V4FfuHWln/JjTUxPH6Q+8YtKvtvPMX6YXlRsjg7oY6e8zR9SKAjb4bI064m/3N7MtcvdvqKrvE6XmLjGtyxoQQrjQn1pdWcjyhLXTCPlE+vE9MJ0iHn2vEIDPQUhmXXIHR4HztE9O2M4BezN68YBih4vAgs/nWFEqxtA2Naxt/DTUvcthxHrO2VWNEMoO6/YAVMKjFuOy/veIfZGuDufIP3pI6scVV8FirkGN+mSxJsH1EdVDEA6TOHzsRdHhui7jdWp9yOCOL0jgfvhhp3QemxBd4RCUyV8u1Av+ZoaogA9QFaato1KoThu1rD9wpp0b2HdQSXtn3/Tma7RME0YjtlJLwoy2RnoeMw9xeFxDE+AcrvKIIM9GJ/wn6iRfe5nPfEZhRbZ3eOBCCBv+pud3BsqdMPxYtqJXTTgtmIGHKdhEYtuce2mfVcHpeDIlhY/qoxhfSxEjdeIiOKWiMmvZmk6IzQP/zBehz9Kx5VyUtutwpUnczYhSv6BSCOAbYlPzUizmpCTBd6/6NovgzFGkDJ2LD/nmgaXx7xhF/vD0qQb2f40qW11vY1cMpWsEmEHkxo=
X-Microsoft-Antispam-PRVS: <DM3PR07MB2137B1BA1BA48DF1301DD0F89AD20@DM3PR07MB2137.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:DM3PR07MB2137;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;4:ZjEvgqv7uVHWTKBJZesPWCwcJ9YHMl0AfVF3zKQ3hYRduQRO858ZFNNJ4qvxhMdvxfoleVjv19M5RxGjtaREslPkYK3GZaKrXD9tNrFTZPSunGu9082J/NdzQ2lroH+xFjFwcV6KK79A1EUYN4fjOkzma3XR/7ttQFReTQkzmUYfaxw+SOiZx1siqS0yvQVJTErMNNdGDNdYZXa7BfNxwHurvCC6Ht5ofHZ7siTftwPvkK4jV+wZ4wPXo5pcLW1YAaA+ido7jz8OnLxzgNUfaiQ7v0PQCFjEkLoWJ6l+ExCFt45Fr12NcqqWUPj81hhc/bqZOaZy7TnlyhMtZv1iWpiACjnWwKDAHfiQpr/qM2NSkUH/moLEsfRdLX6Rb+sj
X-Forefront-PRVS: 0843C17679
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(164054003)(24454002)(377454003)(76176999)(54356999)(65956001)(33656002)(36756003)(65816999)(65806001)(66066001)(92566002)(189998001)(2906002)(5008740100001)(50986999)(122386002)(3846002)(5001960100002)(40100003)(586003)(5004730100002)(6116002)(110136002)(4001350100001)(1096002)(23756003)(4326007)(53416004)(77096005)(47776003)(87976001)(230700001)(83506001)(2950100001)(42186005)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2137;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DM3PR07MB2137;23:33BEt7EArVaRniCTehvlqYNjF005dqVJrynlOq0?=
 =?iso-8859-1?Q?X8JpVf6dD6pS1x7UJVCSzgCr3U3FtwVUUZYT3zjDXVhUHVEy2chCqg96k0?=
 =?iso-8859-1?Q?VSUyTGEBKVGGvGLifNHeIC5cqlZhSq+GgMj9AhpfLb4rgkK1qzziZRpN11?=
 =?iso-8859-1?Q?3KlwwtwoglyogYW+XjN/Zmam8y6ZRV8xtGErowCrzkuVODmjIRryKgmOXu?=
 =?iso-8859-1?Q?Hgy8Jq6nn5YN++vx99sWOSvcvc4ajvIjQEKV2OEHf0aq51rDdNTgDk3uFC?=
 =?iso-8859-1?Q?idHWL+CKdSGcvTTrFlLkhBKW1d7cguJx+2734ZU1iM4Q3lAu+1Iz8k508M?=
 =?iso-8859-1?Q?BszeKOIdKAqGQMy6wsyIR3rZ2D797k+Nv/L2SEKDfMpE0+CCKASImMBMHZ?=
 =?iso-8859-1?Q?Ymrnnc7WSYlwLQsZyRnvA8kedzVOQv/L74KQPjacpgL/JHH/aNDEcgJ+IS?=
 =?iso-8859-1?Q?vls/1qT2HmEDpm1VAb3meODf/JeJajAcKrsFqhPZQGwyJIdF4TkaZbeRkF?=
 =?iso-8859-1?Q?IpkPhLTkIxKeIoPkAp47WpNYT2hyqBC3KsLSbXbYoQFUwZcGClrswt743L?=
 =?iso-8859-1?Q?5g5goEiWARycNtBLpfNxDKkOtS0H26C78AdCRRDd1uxgBtcYvolnupGYCo?=
 =?iso-8859-1?Q?NDewtYRWYd3q2ucQqv5G8LmUuN0t5SY85wIqbh+ihZkKRAE3409w+QBz4S?=
 =?iso-8859-1?Q?4tCa/jgROC9BYG9jvdPpm4crJciz3WvBqnrCS1oOfbPJO+MMGNHcje+M9Y?=
 =?iso-8859-1?Q?wwn44a1sdqv/0AtZhonATYvDcj5TVqxkN4VYwYHorxmXgyy0+XMbY2JjXk?=
 =?iso-8859-1?Q?F7O+YJ4Bjan++Xic+5v8LWDC2QQBzE5BfKh7zDrTuR2TZ2rB4NOyIkThLk?=
 =?iso-8859-1?Q?qWuF4zPtrie8K8oUvvqi1A0QFtPrhdGwF10mSMB9TPpBY8aVXRU4FkHLaI?=
 =?iso-8859-1?Q?PUr8bbPxGtE6/4ANySrxAbgv/ok2/NlFvNWA+AoXQJgkWyl8RQCT8uJQJ3?=
 =?iso-8859-1?Q?qx/FaUMUpV+6lHutcijoZrDAGl/NAMFfLerm/sjL0hcZnHKj9eqZJrGtYe?=
 =?iso-8859-1?Q?aHAxTSAxa9MmrXqjSYS+g=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;5:o0c7xr5kqOdWjo404tEf5X2TGTrMlnPE/4atuEeihjTdx56wzzGPczbgY0TPzBNVQyWddfn4jUvzD8SxReUS1UJ2HSGq2K+THV9uuB2TBo23nqJ9aTbpA3H+lXd/rgItyAQL7YRV2rqp8GxjCQlC0g==;24:mu4YE6tYjnz8uZnrhfUjPUjRhvsBtrqu/4OCabwYJIz2EfxCHAcKg3uXvt6p/LxEdi8jCMqpodzKQU/QIRRcDJ2z/8AGH+RwqdDn1mhSM2M=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2016 17:22:05.7933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2137
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51811
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

On 02/05/2016 01:06 AM, Thomas Gleixner wrote:
> On Thu, 4 Feb 2016, David Daney wrote:
>> +static int octeon_irq_ciu_set_type(struct irq_data *data, unsigned int t)
>> +{
>> +	irqd_set_trigger_type(data, t);
>> +
>> +	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
>> +		irq_set_handler_locked(data, handle_edge_irq);
>> +	else
>> +		irq_set_handler_locked(data, handle_level_irq);
>> +
>> +	return IRQ_SET_MASK_OK;
>
> That doesn't make any sense. First you store the type 't' in irq data, then
> you query irq data for the type and at the end you tell the core to set the
> type in irq data.
>
>       if (t & IRQ_TYPE_EDGE_BOTH)
>       	...
>       else
>          ...
>       return IRQ_SET_MASK_OK;
>
> does the same, right?

Yes, clearly that is better.  I don't know what we were thinking there.


>
>> +int octeon_irq_ciu3_xlat(struct irq_domain *d,
>
> static ?

To be used in follow-on patch for MSI-X irq_chip driver residing in a 
separate file.

The idea was to not be changing the to/from static multiple times as the 
new patches were merged.  If you think it preferable, I can make them 
all static and then remove the static later, when needed.

>
>> +			 struct device_node *node,
>> +			 const u32 *intspec,
>> +			 unsigned int intsize,
>> +			 unsigned long *out_hwirq,
>> +			 unsigned int *out_type)
>> +{
>> +
>> +void octeon_irq_ciu3_enable(struct irq_data *data)
>
> static
>
>> +void octeon_irq_ciu3_disable(struct irq_data *data)
>> +void octeon_irq_ciu3_ack(struct irq_data *data)
>> +void octeon_irq_ciu3_mask(struct irq_data *data)
>> +void octeon_irq_ciu3_mask_ack(struct irq_data *data)
>> +int octeon_irq_ciu3_set_affinity(struct irq_data *data,
>> +				 const struct cpumask *dest, bool force)
>
> ditto

Same, see above.


>
>> +int octeon_irq_ciu3_mapx(struct irq_domain *d, unsigned int virq,
>> +			 irq_hw_number_t hw, struct irq_chip *chip)
>
> ....

Yep.

>
>> +void octeon_ciu3_mbox_send(int cpu, unsigned int mbox)
>> +{
>> +	struct octeon_ciu3_info *ciu3_info;
>> +	unsigned int intsn;
>> +	union cvmx_ciu3_iscx_w1s isc_w1s;
>> +	u64 isc_w1s_addr;
>> +
>> +	if (WARN_ON_ONCE(mbox >= CIU3_MBOX_PER_CORE))
>> +		return;
>> +
>> +	intsn = octeon_irq_ciu3_mbox_intsn_for_cpu(cpu, mbox);
>> +	ciu3_info = per_cpu(octeon_ciu3_info, cpu);
>> +	isc_w1s_addr = ciu3_info->ciu3_addr + CIU3_ISC_W1S(intsn);
>> +
>> +	isc_w1s.u64 = 0;
>> +	isc_w1s.s.raw = 1;
>> +
>> +	cvmx_write_csr(isc_w1s_addr, isc_w1s.u64);
>> +	cvmx_read_csr(isc_w1s_addr);
>> +}
>> +EXPORT_SYMBOL(octeon_ciu3_mbox_send);
>
> Why need modules that function?

Similar to the MSI-X irq_chip thing, but this time for follow-on 
kexec/kdump patches which may be implemented as a module.

I will remove the EXPORT_SYMBOL().

>
> Thanks,
>
> 	tglx
>
