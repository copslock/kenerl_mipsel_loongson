Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 18:59:09 +0200 (CEST)
Received: from mail-eopbgr700110.outbound.protection.outlook.com ([40.107.70.110]:13440
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994590AbeHaQ7Gih1zQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 18:59:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3URvkJoSR8qlAuxHCnB0vQOktC2LwwpFoXtzTjiMh2A=;
 b=f2VDgbAgvzUcTd4I8iYis/4KsRnbkhueAXzCMZilW9lXpfBdlLR5PYgZFHXuUTSqN8R8PS5y0DX03bp033ouAFGrywMI8wle1KPCvEL/I1INXnu107Nx73LmIgh7TYbKnHIdFCRLcz3EsMSTDCmuqIiplGwFhnXwq4CUhG+eu6c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from [10.20.2.221] (4.16.204.77) by
 BN3PR0801MB2146.namprd08.prod.outlook.com (2a01:111:e400:7bb5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 16:58:56 +0000
Message-ID: <5B8973BA.5050308@wavecomp.com>
Date:   Fri, 31 Aug 2018 09:58:34 -0700
From:   Dengcheng Zhu <dzhu@wavecomp.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@mips.com>
CC:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/6] MIPS: Make play_dead() work for kexec
References: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com> <1531358868-10101-2-git-send-email-dzhu@wavecomp.com> <20180830232053.3vptoq5koytuwxnn@pburton-laptop>
In-Reply-To: <20180830232053.3vptoq5koytuwxnn@pburton-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM6PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:5:80::28) To BN3PR0801MB2146.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d7d3330-e5d3-47e9-e972-08d60f630a26
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2146;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2146;3:sCKFtzEx8k8IBpEPBysW70LbcgOQ2Sfi8sFlPOh5bEb8QsIDlxdaKl3VePYxbp0DGn4sWph/OJbsQSYUMANd9hPVAjGBXjSmiNNMuY/YR9ACmRc0d+HVvnsVwx1Tj8nAjQXRDfZDrYoIgBtip3zQWJ9dgxgznnB7vcZhTqLrtseJpSoC9lSJqX4uu3eT0VSkHosKBCpEzDC7z7izyjOxrhgynjMlBlMWEOFAfpyivLwf0E/+uIvpKEDFg5VGkDtQ;25:26er+fjgYEn269/E59JcpUJfNnrF82WpX3OMAzcpxzx3q6pFPiVlp5Vrt+IoVz5YGrpaA6iZ9+rKADt15q/+sCClHoeNd+fdWe339KhZOnaKAOnrSq2WNM1ExHaRUl0GPSnqT2vtMAP+wi8uyS2SpEttrBdKWv8bQUBi3ct/If1QjQN1lNCBrvaXN1sIKkSEp3JgC/86HsrrG16uVnbziWI3SXqEEZkypQFu+fdz8JAbt6cnNo7WLuX+6VJeRR6jS6F2WRugdS4hbgK3cEpJ0OXc8hIZ1V5e6J3BNU1QxrNoCEMgcu6obwZD7cNb4bbvcj+cPQ3jp7Ta/cWd8/+mOA==;31:AA7KRD8sMKb2/o2vu/dETeC3Pm9WzmpMEu0G4ya+41VPOOeyjfuh+tiXB1PKKbJPOfYgMxzLoTHNuyNuw2nyphd/usrmxWXFcMKjBoBKfAnk4R/aUu9bjDROiBu1VKnqOjhnT9kPThI4mPMefQ/lcGXjnBBqYreflwqg7RD2n5wjifWsw7oMdaB5wcRmxERzIng2N6+cSHEamJC/ykI1xwMcQLmHta+4TM47gZ/cusI=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2146:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2146;20:sno8gFTEX37NgBWlBioJhgb+Fz4dnMlzmWQ0LGiH5Ie/pwTLwLYxLAIbjsQ1Gm9yRz1BxIr9QuDVKEk7gOXgCBakQrftwxF2OkydYmxWtnE8F5AgiW+1Bu4d0L27OjGOEWgr4Jm7dbNfmW1PRRg8v1IOhS7qH9BUmEW92crau5f+E3s/37ckDOl3tnlkFtPvn/vptLS5pI1RPqJaAkUPFl3yMH2uF9aec4nnKafV+JoJMbR3zOL1J1k599NuREtt;4:hOXnjWJeMLmQG/VhC4StNh6UGC4PFGv5yU7OFfqdJVXDqMdGBO2sfD2AzoJD/lDtwTigRQB+gT4OwBqhL19sXWv57TVVrK8lInN9mQg6EoAN9I1QW2rhUZ15Y8/zytRBtUN9+Eulh7zuQNsUy/TM8kpH68GlmbBBxVdWhWaA4m64plF17Pap3QRVNyy1znrsdnqeV2NrdJIXr7yf++0AISjCeXeVlvc5hxqQ6Xk60EG56GAIfP8AigsupHruid2uHVApR0Davs6q0CF4qHrfkw==
X-Microsoft-Antispam-PRVS: <BN3PR0801MB2146143A8D71EA3DA4A94155A20F0@BN3PR0801MB2146.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:BN3PR0801MB2146;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2146;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(346002)(376002)(396003)(39830400003)(366004)(199004)(189003)(36756003)(478600001)(97736004)(106356001)(80316001)(6666003)(47776003)(5660300001)(105586002)(25786009)(68736007)(305945005)(8936002)(8676002)(6862004)(65956001)(66066001)(4326008)(65806001)(6246003)(450100002)(81156014)(81166006)(7736002)(316002)(86362001)(64126003)(67846002)(53936002)(65816011)(58126008)(6486002)(16576012)(52116002)(76176011)(50466002)(6116002)(77096007)(3846002)(23756003)(33656002)(53546011)(386003)(16526019)(26005)(230700001)(2906002)(87266011)(229853002)(956004)(446003)(476003)(2616005)(11346002)(59896002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2146;H:[10.20.2.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN3PR0801MB2146;23:mYe7eOPbZaxPSgyzxm+JvwASUR2+915vZ3pnU?=
 =?iso-8859-1?Q?nLUSJKUu6qGGJH6NjSl5ClamwVEWo2/dugoIzXBQCR/ZsYrIS/kBAT1tk5?=
 =?iso-8859-1?Q?K3DhorNh/RD6IwzpvZCyzZA5j0j+WngHmDJWJMuWvwlFzPIgmF2AKc4RBL?=
 =?iso-8859-1?Q?ec+er0+JoI2BAykDeXsKUO0XzkPvekY0eiG5nzs1KpJtyoO0tyqYrmmar6?=
 =?iso-8859-1?Q?ma1LqBp+PabXZ1chpCZErHYW2h023W45noLyDrDg13RTz4hs9kJS1Ed74u?=
 =?iso-8859-1?Q?dGND9nKVjoHtWKFsdtkUFfIi5rF8eS8q93j+IxuJG/5M0jTvpLtqDg7lfg?=
 =?iso-8859-1?Q?9G7upmnGrio6MtigyDGdUqQxhUuND91LYH3cGnQO2JfBNUy0kn7OGFdCDI?=
 =?iso-8859-1?Q?6SiYSUaPGJbrIgWhwT0EiJ0NE9YmSV4e0mKiIUAiqcwoVtMoQsHkda26uX?=
 =?iso-8859-1?Q?/jZVBYF0THySSFt4kdyir5a/mqPMHCWS4p70DjqgVCHwDO3goQoB3vKPQa?=
 =?iso-8859-1?Q?r+dN65/3ehEE/lwcTmcSdeGSKmCFd2hsEdHRhg+UtqwoosLGcztBMXt337?=
 =?iso-8859-1?Q?QAc6zDNyJbcGCVxBFPP92R/5aHIXI0yVtsj3UOvbGb6U1qHgFlj2xzLWGY?=
 =?iso-8859-1?Q?mroPanAH12UQizh5/Qqg8+FhGVA2QcpAp6IbLEpZWoSmXOF9j06fgbcU46?=
 =?iso-8859-1?Q?T3c+7NDTMFQZ/GWIlOW0S6/PkbA77urn90L+wAEpA7P8f6dN1AKwb6ZeU8?=
 =?iso-8859-1?Q?OaYPXaq03RuxUvBDmGD/nP0JMZfYZZYQMgeHJ3v7nBJsaZ6XD9nZDqA4o9?=
 =?iso-8859-1?Q?Z7R50kk2lST4shT7m/oz0kwQ5o2mA0HoP+Kp1DmGsbketZEuQ/CnwwiNqa?=
 =?iso-8859-1?Q?6Mi3KBPWJ4j43nac8DpjAThJI30kwmATHK65ocZ9RelTL68+Z4mD3gziiN?=
 =?iso-8859-1?Q?xuXOgLL8ptvON/5s6sRHWLt5ft/SA/sDXRnBFscEfmq8lWDfMwWDSdcIvd?=
 =?iso-8859-1?Q?B7Kr3PCaqVLwzACzq+Tehv0KjRWBjGNo9K6273hyPN0iv0XBlLaJOve9yA?=
 =?iso-8859-1?Q?jdhn86WVfjPi0qBj2nioKosKlfl3e2jsaKp2DDFxz8gGuSlT2zz/BN99uJ?=
 =?iso-8859-1?Q?Oo/IqSHSyOF9W9vfLuW1/54dS4VnyaWa5n5NOcSB8Pgy4z/vfS5ejivl7h?=
 =?iso-8859-1?Q?Hd4+xYTNXUf4YdtZB5grkzQO6HME6DaZoDZ4U5JnX1npMO5vIZYWz3s2LM?=
 =?iso-8859-1?Q?f/Q8tfYpjBbU5LoUkHkCjlgms40yIWSdzfU1ovWiJS1MBIA6XcoOeSd13L?=
 =?iso-8859-1?Q?WEWbo1qPzEzDEtRN6ZA39u/G+f8soyzy9GaLnytDzzzYUUo40xviI7ZYU5?=
 =?iso-8859-1?Q?X2AlwMgfEUycpZWMEVZycDZE3b0pQdpuxucPA2vo6/GOnAU41QiCkyvdMf?=
 =?iso-8859-1?Q?RZyXfm6J4AFdroOaqqtcLUvBKiUouItXfNxNuohpmSF1X6gZYcRPELylYB?=
 =?iso-8859-1?Q?EJd2jrmG3cZOdxCWirWNIU=3D?=
X-Microsoft-Antispam-Message-Info: 87/78JtOMn0oi0xOLtlsjg/opqWCaGV3F1ZhrJA7GvsXcDn/2qMZ7FPjPXvu+KmvIRx2nDT9RvrYQzIapvricJypQKhP2irYtdQUKzjaOWeb0gO1IXphYs9DKkkPR72N7DR4zLfUaXzsm2wiInmaDBkFx3gN2DcIMN5/iT+psyQaWqK24sH+yIj+WHB+WJlePPFV/XeDYBMJZk8RZNIG9N9ykk8dIr/BF0DU2dISz5tI7usDKx2rpJ76MVgVIc5DlYMMXJR0s5h/w2bCyuuZP+kMZ0V9YqyfWljGQ9sZMGxgxL04lbgbnwQAPHGASqjSR2OdEtonl/jOoyUs/HxpVcsD8HCOwaGhgG7PE8JPc6Q=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2146;6:HOZg6ClzyZ0z4JRAF8cUyHZhN5FAulGHk6yIGn/eaDaNyooDQOuZq3wGNn/z45BkoG2lFnDpjElLUDSsfYvKP+NssABc1hIymNMIP7LDqn6VSgC5pJbd4kdzQwZdKeSrH85RhTyVu8uOCDB/LD9odvjh7S8TgXvTmKgC2faZvljg5K9JxrlG4Y7PIiu6rYTiTJuoVWQloNq+eCG/8LYBj2se4VflmiXJee9Q2/LuRtJOF2jXfcfGQ0mwywR47rrQghKUPeansCylP32y0j2NU/jjIQVEijinDG21My3QpdDoxu3t94Go0jeM92IilDHjDsvaeUUQlO4OKjHwPEhYHnf/qK2pB31VQtWk9Gwwc+0pzMv8OZh/LWmMtUMQ0YGBVvPu0zeiqgt+FLTPQMzb6o3axp+9N+y8xzDtk7QOvvNtUvnGnTrROvu8RDmADjmdnpZ/4/AjEcjmEa/Dt3IbYA==;5:RESoehPrvbmH0B/jB21Tq8Mj3empRQynCcMv0v0N+oGW+JLvlkj6X+2sTarEPAgVMQM/K3CSTwQeV2E44fzJ4EQ+Dq2p6aY3ZrbeIN6lBh5uy6B2CMuUr7rRthehdcB2wVKy0naWJkFv9lzeLSZ/ht+Qr7KHAmV7YMEGFpeR1Ow=;7:m045eVTBnso1dU9w+/nFZoCt3B+pATemfMBXVPh/q5l3ZOHGRQUVPKi8kdx5Vb1xuzhfXAgOIqhPL9llNkVEZIHL+UrczyVZo3ItUGMVyCgupuB35eZpGGk7t8OBPTNNGuEPGThrUDgwyNLOQZVRvq2tlTvMF5rmVQpysMpBA+eI3s6CfBROMiq2jOB0xh7tvo1EBmowPg9flPHin9AL1sVW0s069vLrCUZt7zgLciJySj+RGuxnRYSaR4/jA8kU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 16:58:56.1030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7d3330-e5d3-47e9-e972-08d60f630a26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2146
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Hi Paul,


On 08/30/2018 04:20 PM, Paul Burton wrote:
> Hi Dengcheng,
>
> On Wed, Jul 11, 2018 at 06:27:43PM -0700, Dengcheng Zhu wrote:
>> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
>> index 03f1026..4615702 100644
>> --- a/arch/mips/kernel/smp-cps.c
>> +++ b/arch/mips/kernel/smp-cps.c
>> @@ -426,12 +406,18 @@ static enum {
>>   	CPU_DEATH_POWER,
>>   } cpu_death;
>>   
>> -void play_dead(void)
>> +void play_dead(bool kexec)
>>   {
>>   	unsigned int cpu, core, vpe_id;
>>   
>>   	local_irq_disable();
>> -	idle_task_exit();
>> +	/*
>> +	 * Don't bother dealing with idle task's mm as we are executing the
>> +	 * new kernel.
>> +	 */
>> +	if (!kexec)
>> +		idle_task_exit();
>> +
>>   	cpu = smp_processor_id();
>>   	core = cpu_core(&cpu_data[cpu]);
>>   	cpu_death = CPU_DEATH_POWER;
>> @@ -454,7 +440,8 @@ void play_dead(void)
>>   	}
>>   
>>   	/* This CPU has chosen its way out */
>> -	(void)cpu_report_death();
>> +	if (!kexec)
>> +		(void)cpu_report_death();
> Is it a problem if we just call cpu_report_death() unconditionally? At a
> glance it looks like we'd just change cpu_hotplug_state for the CPU, but
> since it's going to either power down or hang anyway that seems fine.
>
> If we could do that, then the only other thing the added kexec argument
> is used for is preventing us from calling idle_task_exit(). We could
> instead move that to arch_cpu_idle_dead() and not need to add the extra
> argument to each implementation of play_dead(), which should make this
> patch a little cleaner.

Agreed. Thanks!



Dengcheng

---------------------------------------------------------------------------

*From:* Paul Burton <mailto:paul.burton@mips.com>
*Sent:* Thursday, August 30, 2018 4:20PM
*To:* Dengcheng Zhu <mailto:dzhu@wavecomp.com>
*Cc:* Pburton <mailto:pburton@wavecomp.com>, Ralf 
<mailto:ralf@linux-mips.org>, Linux-mips <mailto:linux-mips@linux-mips.org>
*Subject:* Re: [PATCH v2 1/6] MIPS: Make play_dead() work for kexec

Hi Dengcheng,

On Wed, Jul 11, 2018 at 06:27:43PM -0700, Dengcheng Zhu wrote:

> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index 03f1026..4615702 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -426,12 +406,18 @@ static enum {
>   	CPU_DEATH_POWER,
>   } cpu_death;
>   
> -void play_dead(void)
> +void play_dead(bool kexec)
>   {
>   	unsigned int cpu, core, vpe_id;
>   
>   	local_irq_disable();
> -	idle_task_exit();
> +	/*
> +	 * Don't bother dealing with idle task's mm as we are executing the
> +	 * new kernel.
> +	 */
> +	if (!kexec)
> +		idle_task_exit();
> +
>   	cpu = smp_processor_id();
>   	core = cpu_core(&cpu_data[cpu]);
>   	cpu_death = CPU_DEATH_POWER;
> @@ -454,7 +440,8 @@ void play_dead(void)
>   	}
>   
>   	/* This CPU has chosen its way out */
> -	(void)cpu_report_death();
> +	if (!kexec)
> +		(void)cpu_report_death();

Is it a problem if we just call cpu_report_death() unconditionally? At a
glance it looks like we'd just change cpu_hotplug_state for the CPU, but
since it's going to either power down or hang anyway that seems fine.

If we could do that, then the only other thing the added kexec argument
is used for is preventing us from calling idle_task_exit(). We could
instead move that to arch_cpu_idle_dead() and not need to add the extra
argument to each implementation of play_dead(), which should make this
patch a little cleaner.

Thanks,
     Paul
