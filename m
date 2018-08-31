Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 19:04:29 +0200 (CEST)
Received: from mail-by2nam01on0121.outbound.protection.outlook.com ([104.47.34.121]:22432
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994590AbeHaREXCOaFQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 19:04:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S3ukGgWaX7bh5nTfjgaT57VvncuJ4y1lvc6e0+/3XM=;
 b=Mpk7JtT0jyNHxHljDOLiBpdbBY4A1tbKZ9Wi58ni3rP2o2WOe8QbmGSfn5w3b8ndQK/kc7JowY1QSq/HaZhit0QRNlvbtkV8ekgpWd5IibmsvU/47vj4upNmyPERJfN4FQxq266MAAPmvm8pty6+zSRx+KbQF5oWRuctuAbWcTc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from [10.20.2.221] (4.16.204.77) by
 SN2PR0801MB2157.namprd08.prod.outlook.com (2603:10b6:804:16::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.18; Fri, 31 Aug
 2018 17:04:11 +0000
Message-ID: <5B897508.2090808@wavecomp.com>
Date:   Fri, 31 Aug 2018 10:04:08 -0700
From:   Dengcheng Zhu <dzhu@wavecomp.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@mips.com>
CC:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v3 1/6] MIPS: Make play_dead() work for kexec
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com> <1532357299-8063-2-git-send-email-dzhu@wavecomp.com> <20180724232355.z6j2wvs6srigr7kx@pburton-laptop> <5B5F5DFE.9090702@wavecomp.com> <20180830233201.3uufivhypcnrzyek@pburton-laptop>
In-Reply-To: <20180830233201.3uufivhypcnrzyek@pburton-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM6PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:5:80::32) To SN2PR0801MB2157.namprd08.prod.outlook.com
 (2603:10b6:804:16::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1e6f8da-9251-47bc-ca09-08d60f63c5f6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN2PR0801MB2157;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR0801MB2157;3:JndwlmUUnFj8Ut1W+KwBOweXuWG8SawyE3/lTonB9zON3c6CI9a0aHQIXUWsNYa0uYfAynG03o05YEuK4I8pStmbKYTEQ1X9h4Ec8EWU5w/JK8cIYrgN5cMUN1LWGyxqIj72CFGZBwHxO/mUQumjZzKl0mkz1dIUyVDvPHf/2tWD4CfyN69cmKVRo8CRASxkt8NUL2oB5LUSxuf765RtGs68jyt9FJCfJ13llhZhoAkalq9OtC6HTd4oT9PaHyZc;25:lV/p+fpHO0AT5yzWOsAnD0ZBpHon9xJXSceFMoLJCQey3I6YZ+aZ1Ex0LxdnaEZG1MKiGjP/gEo95K7ufeWR2WGE08zhE7MqYydxlLlhyY9u9qvPzGl0eDEccrCCRtI5BBVpVu6rYce+KXYDi/GyJWXxCE/khKlkjJuvLg2R4UvOKVpDcgDl8s+qwsnhqD1sAe8uinztsDC8hLFfUl0ieswlFtMV39ssCz3B0YAbz9TnXFDF8RO6JzIRH5N0K6qBwR2KashZPtRvHxAkGwlKFoT8Fy/MK/JuNpTO0MY+KTfdfwZ6FeiCljGjbBARPSoYsos+liBpQQp7BU2RR5zfLw==;31:aqQzbGkAFlXJU8COgGmzQSmD8VAjEmhgK8pYSdweHdTvwG7dvl5enwZEtY06PB4aNBHPEyyMjtXpi5Ta8sVtK5NKr3GDKnsjDJVGMl/8MAuvCfK2zqu2e/sXpLnpkXTGy9B1IVKMD3Jw0l2DJZkdVZ+0iZACjwY4w1qhB9QK16eBh0Fj9EmF+xwLgd6iF/sH7FjHe06bZCA1o1oSMm2QHH0tMj0BNmJD0SqSeB5ROsQ=
X-MS-TrafficTypeDiagnostic: SN2PR0801MB2157:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR0801MB2157;20:blyJ07N7NEWe2R9wb+V+4neOZlXGTNX1lXJZ9RcwcWahtkBnEeXxYffJqIx1bMrnrSszOduqivrd6zMmzxOu6Hwa36VQC/+Cf0BVhaL7lQa37xu2VTDKo9OepxztfldV9l4yPwUXGdicvF3uRNUsfrEucTpytkE28UOV/p8y/HJ4JRGUnb9i4IyDkchfMf64bWonL4SdYZzBv9vFzrEulFn/Rg8+BRrbaR1MgpGyGmuncQRDx/CdZCndbk6iAdu8;4:0zlsNWOsYRrtvJIGh1En2j2slqFT41E7xHM9x//SXrabb5RDnVHufg02PQCqxZ2BGUK+aPnISaecnOg7gY+Uc15PA12aoy1nH9nj4SnN39YYGv65WjDue/ri8QTFYLulT1+ZBh8WJClrHaQOwjHEwiOB/7p0QQf8O63HHo7glq8iop1NAomJq8tNgOH0J84x+5Mz2F6vUXzkV/MTqxxQUjcQb4eQfq7CY4a4FDvBGjW5XJ56uSHk1NJbnRHk/hOaxOr+SUtTY8lLGkA5jmYYVRw5fzQU4tJcncpevBkduiNPDT6NgVByQqds7BkLluqH
X-Microsoft-Antispam-PRVS: <SN2PR0801MB2157650CCD74A323A64AAFF4A20F0@SN2PR0801MB2157.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:SN2PR0801MB2157;BCL:0;PCL:0;RULEID:;SRVR:SN2PR0801MB2157;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(51444003)(33656002)(6862004)(4326008)(50466002)(67846002)(2906002)(6666003)(93886005)(59896002)(5660300001)(8936002)(6246003)(230700001)(81166006)(81156014)(316002)(58126008)(16576012)(106356001)(486006)(36756003)(105586002)(2616005)(956004)(53936002)(476003)(11346002)(478600001)(446003)(80316001)(76176011)(66066001)(229853002)(65956001)(65806001)(23756003)(53546011)(386003)(305945005)(97736004)(25786009)(68736007)(86362001)(65816011)(64126003)(87266011)(8676002)(52116002)(7736002)(26005)(3846002)(77096007)(6116002)(47776003)(6486002)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR0801MB2157;H:[10.20.2.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;SN2PR0801MB2157;23:0X2W+TuCIsjrHYNmwxdRqzaebRNaZa3ROPMwE?=
 =?iso-8859-1?Q?rgxUjJg9XzZG7qNxm39nZ9GAYyO0Q54LWDHRb/qkvLaYvE6JDhqmDePmf4?=
 =?iso-8859-1?Q?5AfdKrveMFmd+xJQaAKM7gb1+zaoU5GiVTejdOFruqU0E5YYafLDA4cDO+?=
 =?iso-8859-1?Q?ZCJ6uKzjAWam2wfcPuD7meX6qwI8N8KIykV+SmT7BRl8IgsyMJ84zyWPYJ?=
 =?iso-8859-1?Q?iMiat3o2AegfM/QAq25pQg7/9PnjdYUICyAz8XSfmHF4xtQTlqwiFcxjeH?=
 =?iso-8859-1?Q?I3ZoUXPs8RKlwXaKsITrjYR+CgB1WNozugvXnAKt7/A/OJgWavS0sYKi7J?=
 =?iso-8859-1?Q?hQivmEJpPadY+/2/8VJojMOZcu++HDtvzKBSKlPJVIHTMPdIsqBt5uEQMx?=
 =?iso-8859-1?Q?XXKDZ08SmPRhC5vve8S7JBNFduC1gz3j+hKawjpOhxNLSsjwBj4gFgca8/?=
 =?iso-8859-1?Q?gBBx3nEWJt3JGwF/pdVkN3qvuRHvaqYY7G6haV7+W4ed55xh8UFN4SzBxU?=
 =?iso-8859-1?Q?o8nX8CH/MfDA2qFsXiFsQpg6ww5pBrvVoMXTjyZDVDi9TEcZtisN7ytNQN?=
 =?iso-8859-1?Q?MszlQl4UBj4WiU0HDV4/CBRPhOiqn/GI/cDTYlnpfT6XIfth3i8SvRYZia?=
 =?iso-8859-1?Q?6nPNUGupC6MGh6FtdNc0ByB9KFnFJecd3gOqbyk7B6io/0wMoT+9BTxWVj?=
 =?iso-8859-1?Q?4qHv4QuAI1Ot3GrQxpqViuWSbdtm90tBStupAvz19GhqBlr86NzlNbyFAz?=
 =?iso-8859-1?Q?X3U62bVVCqajy6ti7LVDILLbr0hbJjymeoG0ReJRn3yrMAyjrju7hKyi2N?=
 =?iso-8859-1?Q?U5IFgzq6LsmbhuyLFrQzPabAvvnEV3SyxF0Jp94i9MIragwgKrLip/G03e?=
 =?iso-8859-1?Q?Z6FhMV7mzdtuL9CrzeGnbXteqeQoD3tia6Rv9R65iz32a/Ws1d5Tbh8xss?=
 =?iso-8859-1?Q?Ib78SzuY+Ly2ar7POiQcHongacZJAdUwTSbT1rOeJSE6EnoHp5+yyzt3o6?=
 =?iso-8859-1?Q?EDxbf436YcRl0vw2ETT0VIKKcj//akRKGSvm4Ydr/EhA+kuuSQapDFE2mV?=
 =?iso-8859-1?Q?R0nc1kPwsFqzTK1Ett/lguV9HuPsd5XQKo3HgteteSQ1r5W5uF6G6rurpE?=
 =?iso-8859-1?Q?ZSaliUokpwzaYFXhG4tMjQYKvwVGZHS8EppTiVFGbwYaKIjD4cVTJ1g2bv?=
 =?iso-8859-1?Q?ULbuqHTH9eXb5/AQ15B+ZcJKeIzie5bg22zQkMqUFM2nN6DGNY4Ob3k67P?=
 =?iso-8859-1?Q?kvvFzIN8M1HI2NhO9YJjpRQOV++77AaXa5ZuNHdL/PkiyV44LhfGYDLwVr?=
 =?iso-8859-1?Q?by4zPoZXBaTQvI5T+Wmh/gGdMGPnBpWEL1AuxmLQvW8zv4DjTf2HWmm9D4?=
 =?iso-8859-1?Q?iw37nqqTshD2TLZSbd6nglPf2sOpodBBn0noqe6sh1vRwb8B+9TEHWctoZ?=
 =?iso-8859-1?Q?LZDhX2RoOGNDgnZG6x3U6+YEMckaeYT9JlJuftMcI2SzZ8qxebqiOGopMp?=
 =?iso-8859-1?Q?hUZX45lkyeLpkZ7XVAvpIT9wpYxuoFcCqiKIHTm+wv4?=
X-Microsoft-Antispam-Message-Info: xmfn3C1Iq94105r4fR8iE80nwUJ3prkDlpCeQtSyseWtUTJOLbiS94M4o10HxCBoVU2bMmHg1Nfib6dENpiJmko4/hOWkduF1Izunywx3097pcUGrKqvOhXTiLGo7kvCnGWYaC4z47XUt3TdAeixw/2c8yTRFUeTr0nobbsUfWQ2ieGbxSqMABNMMnHYQ860Z1xyLZjhodSxFPq4BLmC4D7hKVun1XbWe1horhXExyTz/QEpXlaEAtjGR67JbH5Iq2GpL4b3sod2URYzcM3AOXt9vYuzd7XhSXAjh0Xbh/o9WVE7sWGkxUCnH3X8EuR6to+nwTkPvC93O4+x5grT9NcBOm6HwhffnnPQlZiSauk=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR0801MB2157;6:YZJJfoLlc+7+7RCnFqV+PCMLHkDyH6OtwYpC2hL9OWfq35ioeWhZ8j3zfk2gTQ0GC9IGU7YjpOlE5YxM7/g27dUCD1Uzg1c88WXi6J5RcGTGpYVCTnyQX72GUuEHgL7DiYKGT7Qi8NHPeAXWDaf6dYCPa4R78M5kEaH+rvGp5ZScLvW3y7dX1SZgNk+bm7vyt4D/QN3Q9jjiZ1aL4jBfBpTaD2kEP7FGk/TN+g/XrPgDIxUZaWGvdThQL35hvdO4a7M2Uai8mXtEpnGNZExjQZVw5Dppz2m4yFIQH9cl+56CxZfRzIK6vRjpFIT1+LJCBwrodqndc6XYa/ZkG+PS9vuTc5Swns5TPWbiyxxFleOHMwrh/+SXDBuyRkzPuFoVhMwk6kIcp9ErEoasLdR5xL+8OYE4oif2NGegRUxukms3gG3RwYdwC9k+ixjXVM2OD1qlG+XjSCLRlDNyb8J5rw==;5:G+BNwMz/pqS4y996CBiFDoR8MhHhEsf4CZTCKV8dlria5IskGg9N3XrmgPgKaIb+LM2IDIdNhNJ4DeMdrc0inRr2e50V5UgMC34IPcSCGGNtdgtpM5IN9NWJxJMwpkFvHuMtzNUy5wZGe+x2tdj3wSWnh7+FGIcXYPi1UCkbA9U=;7:EXheNRGRGu48K+OPF8VyAwwoJ8ju+UTFMDBKlW67gNz4wacZzFY8/SmMitKC6KOTmk7oxgdHIYQJDXiPu+kz0lwzfwXtddTEnmg08dc7PmpZ8yreXQzxDYkR93nlxdfieZmiWD0eKmIq7uNvgHGPo9PwmKFislltbeOnkRROt1GaI6+0dsquhc+jgHmHEUj/TIwoLzmq5J+kvKPzqe1pZbJ2ApCx6OGTHfj8vIiQTnUlsLvbOkrC84luH2bPNAi1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 17:04:11.1967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e6f8da-9251-47bc-ca09-08d60f63c5f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0801MB2157
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65826
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


On 08/30/2018 04:32 PM, Paul Burton wrote:
> Hi Dengcheng,
>
> On Mon, Jul 30, 2018 at 11:50:38AM -0700, Dengcheng Zhu wrote:
>> On 07/24/2018 04:23 PM, Paul Burton wrote:
>>> On Mon, Jul 23, 2018 at 07:48:14AM -0700, Dengcheng Zhu wrote:
>>>> Extract play_dead() from CONFIG_HOTPLUG_CPU and share with CONFIG_KEXEC.
>>>> Also, add one parameter to it to avoid doing unnecessary things in the case
>>>> of kexec.
>>> I'd prefer that we use a separate function to play_dead() for this, for
>>> example we could provide an implementation of crash_smp_send_stop() much
>>> like ARM's which invokes a machine_crash_nonpanic_core() function on all
>>> CPUs other than the crash CPU.
>> %
>>> This would prevent the kexec/kdump functionality from depending on the
>>> board/platform specific play_dead(), and wouldn't need these changes to
>>> all of the implementations of play_dead().
>> The revised play_dead() is JUST to make sure we are turning off CPUs cleanly.
>> This function itself already hides board/platform details. So it seems a good
>> candidate for turning off CPUs for the target platform.
>>
>> This function is called only in the newly created kexec_smp_reboot(), before
>> which cpu states have been saved.
> I can see the appeal, but please see my reply from just now (which is
> accidentally in response to v2, but still applies to v3) about cleaning
> up the changes to play_dead() a little. I think that would help it feel
> "nicer" to me.
>
>>> We should also be calling crash_save_cpu() on each CPU, which is a
>>> further difference from play_dead().
>> crash_save_cpu() is already called in machine_crash_shutdown(), which is
>> prior to machine_kexec().
> But that only happens on one CPU, right? See the comment in
> crash_kexec(). So aren't we missing the register state for all the other
> CPUs?

No, we are not missing the state for other CPUs. They do crash_save_cpu() in
crash_shutdown_secondary().


Thanks,

Dengcheng

---------------------------------------------------------------------------

*From:* Paul Burton <mailto:paul.burton@mips.com>
*Sent:* Thursday, August 30, 2018 4:32PM
*To:* Dengcheng Zhu <mailto:dzhu@wavecomp.com>
*Cc:* Pburton <mailto:pburton@wavecomp.com>, Ralf 
<mailto:ralf@linux-mips.org>, Linux-mips 
<mailto:linux-mips@linux-mips.org>, Rachel.mozes 
<mailto:rachel.mozes@intel.com>
*Subject:* Re: [PATCH v3 1/6] MIPS: Make play_dead() work for kexec

Hi Dengcheng,

On Mon, Jul 30, 2018 at 11:50:38AM -0700, Dengcheng Zhu wrote:

> On 07/24/2018 04:23 PM, Paul Burton wrote:
>> On Mon, Jul 23, 2018 at 07:48:14AM -0700, Dengcheng Zhu wrote:
>>> Extract play_dead() from CONFIG_HOTPLUG_CPU and share with CONFIG_KEXEC.
>>> Also, add one parameter to it to avoid doing unnecessary things in the case
>>> of kexec.
>> I'd prefer that we use a separate function to play_dead() for this, for
>> example we could provide an implementation of crash_smp_send_stop() much
>> like ARM's which invokes a machine_crash_nonpanic_core() function on all
>> CPUs other than the crash CPU.
> %
>> This would prevent the kexec/kdump functionality from depending on the
>> board/platform specific play_dead(), and wouldn't need these changes to
>> all of the implementations of play_dead().
> The revised play_dead() is JUST to make sure we are turning off CPUs cleanly.
> This function itself already hides board/platform details. So it seems a good
> candidate for turning off CPUs for the target platform.
>
> This function is called only in the newly created kexec_smp_reboot(), before
> which cpu states have been saved.

I can see the appeal, but please see my reply from just now (which is
accidentally in response to v2, but still applies to v3) about cleaning
up the changes to play_dead() a little. I think that would help it feel
"nicer" to me.

>> We should also be calling crash_save_cpu() on each CPU, which is a
>> further difference from play_dead().
> crash_save_cpu() is already called in machine_crash_shutdown(), which is
> prior to machine_kexec().

But that only happens on one CPU, right? See the comment in
crash_kexec(). So aren't we missing the register state for all the other
CPUs?

Thanks,
     Paul
