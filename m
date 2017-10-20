Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Oct 2017 01:57:24 +0200 (CEST)
Received: from mail-dm3nam03on0051.outbound.protection.outlook.com ([104.47.41.51]:59328
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992181AbdJTX5OGw4OV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Oct 2017 01:57:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0++s7nIZqSr8VHnJpajuaIKeYJltDqBo12FRAI/F3Ic=;
 b=RQ8S0a5FmTlOD1BbDzBCKnFikt34Vf3SLJDhK84Av4SJ+3NZxyqyVMTAd8VvOy9VyS9d7i+P7wUkt98D38hjgIrksSkXIQ4silRZibCI06zikwOrLVWnVykyl9crf4cAVQxWs7pwAMrJMI75RH3qbbwh9j8CYhzlEEkuGAPjxDg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 20 Oct 2017 23:57:00 +0000
Subject: Re: [PATCH] MIPS: kernel: proc: Remove spurious white space in
 cpuinfo
To:     "Maciej W. Rozycki" <macro@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Dragan Cecavac <dragan.cecavac@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <alpine.DEB.2.00.1710202129250.3886@tp.orcam.me.uk>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <601ab9f9-5092-7e44-acf1-ba5a9f0c1962@caviumnetworks.com>
Date:   Fri, 20 Oct 2017 16:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1710202129250.3886@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0025.namprd07.prod.outlook.com (10.162.96.35) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 326ce9b4-ed53-479a-48d5-08d518164287
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627075)(201703031133081)(201702281549075)(2017052603199);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:8WADNfER+c+rUS5xRFqo1DbKyCAladUtGq7xlfTeBQIx3Bsw/TsYYrk9xQmlcCV5fpkAnfJcrn9aIsn2XgZmlQjJXGLhNRG7xPeTEesiw/edHZYFSSUxrvXQ43tzGs4N96n2EsUOtrVWvwYwlkIJ+AklzQBrddfRVE9DB1iWEwZASWGCppaN6aXTg1+1cMzq3T5Y3snS+9VPnfwwaXSZYW7UboVQuh5Ez92gLte7ndocdJliGzrEqx9SwtbJO/Q6;25:8tPAWY8EsGOEB1pOIQJGRFko1A3IQtCi1J+z2bJwJvrygE5DJsgrs0qmPmVigKGJJr2gNxM6Or1veby5gTEqTHhuIVR6C3Oiuocn2uEfAWrhIsnhccrnC+A+O39THw8IgOmZ9FbCv32wlP+5X/wq8x5NFoFD6Sc9hqxFUjTMkIWKaltV1e/cpgZ/uin28R0+GLmHbzHkJQ9vA7Y/qbdkWCEw+UrNcRgXDvOZmqrMD9hKaJ567f07empuhg9sDjxTLZKS5HPzTlMG6ASHxQcIMYlVI/cvO6YvH0D6s6WaD7FZejTNad8fWmYMsW9wUKG8H0atGh+hr/aG390rfPO5dg==;31:R8f97gcPUAIh721fYuVRLKQR8pNpV3zG8XLOLtIffOzThMLfdxHkiSQVRyFdbSGwpMiNikBa8UIvyNc9rkQ+gHDbTRKcHlXIK2xee+o61tQmG0x+Me3600LFvVZDBLEg8+R1mwbkfymbZ7Ej5Sxk2xd4DtfshQDiOuQbfSTwtJaAbRCMeyWbKnVxnLII2BsPsHVvt80HPvjRXS/y0ahVFJyOvLedI3PWWFt01RX5lgc=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:emcRJT+GyyeDZTEbRvHvD4h/ueQSr4pqY8I5wJxdOm/jLpmU3pDABqBGv0paT/HQd1NHnPIS7a6ztc/rDAVRUhNsMCLlIoXvVGwOzUVIXx/lFJg472a3h3GoWsr9TYyDirfVHNGBI5OJXg9w+WeALRrxse34Uw0vBE40ylDzTpzBR8mCza+hWZZP1pmNTgS57Fl/+DYfscmCyQO4a1g+4NVwmjxNgcc+8PKrDdmdIns1PYKTFPlhO0/LhFyLy3CG+OPNy9XBxT4nkuUoClKvvzDGGvjKYU9tijcvIMaVwG2s/VH49CttZeiLyWoATk43TIIA/4k4A73QwwEd86bVg77Cpfs43BvcnUSyFS+PccTZBYYHGD4vjea7XrZwX1zoclyi6aOrXSqNcvWrSmp8YuQink/iBeqMV80me0a8yyZ8GkWmwtuJgn6pE1YWtY9GsoFFXnzcRAMWOamVG8DtzmEct/IxAvySZ8isSUehfNWywRSL7zLFTSMP3WGJVq4MSJEdZvUAXWc0AQgo/4ewETQ43N/w1MgcHAyP6Impok9jAd0aLcx3z4x2nxq9Qf2YTFc5Dga6eZ8OCKb7JGO5VDT0QGTUW8e7AzAfgF3CWBg=;4:IaFEyczCFRb/EfQf1TcG3uiYvaKDEXjAAYz7oh7bmDdHzIEyuXuDklJvvU2maGipYJhhpFSlbPl5iRC91wRfit0B+F2HhUwleAnH3KS0I/jQP2nhFP6TfSO0ulThuKeil0clTEWe4VjDLANziAo7c9dfbRKpqGAXYXG5xm/y4J61JRo5KVYbqF73dWFnGsa2I59IoOv5QWy+m0OiuHzH7VGIbgd0dqB4/fqClsRiM24H5DdJ6TTPObL7a/p/fv9E
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB35042CA7F5849A85C5388CC497430@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(3002001)(100000703101)(100105400095)(3231020)(93006095)(10201501046)(6041248)(20161123564025)(20161123558100)(20161123555025)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0466CA5A45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(24454002)(189002)(6666003)(6246003)(2906002)(76176999)(54356999)(69596002)(64126003)(8936002)(68736007)(6116002)(53936002)(50466002)(3846002)(189998001)(81166006)(25786009)(81156014)(229853002)(33646002)(83506002)(8676002)(53546010)(31696002)(23676002)(50986999)(4326008)(42882006)(7736002)(53416004)(54906003)(6486002)(97736004)(31686004)(36756003)(72206003)(478600001)(105586002)(305945005)(106356001)(7416002)(47776003)(65956001)(2950100002)(6506006)(65806001)(316002)(16526018)(66066001)(5660300001)(230700001)(58126008)(65826007)(110136005)(6512007)(101416001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTA0OzIzOlJWZEhsRWJwR3AwVUQxWVNPQVlCUWM4Vkpr?=
 =?utf-8?B?c1F2Vm16U1Y1OXRscW9oWjgxR1hhRUxSdCtXcUFjQ21VeTJSa2M3bVZQRFYw?=
 =?utf-8?B?NFZSMEduWWk4bTVzbjU1WFAwR21tN2pPR3pOQ2tYZVV5MlFVVlExSjg1ZUZZ?=
 =?utf-8?B?WG1CMkRtS0trN0UwOFB3OTQvR3FlVHhUaWpNeEtiOVFJaXROUzdxZEVVK0FZ?=
 =?utf-8?B?UFVuS2JoSGMvRGJmVUJJNWNpQXNma0JFRnBGR0V2K3NvSGg1Q1JMQktsOU1B?=
 =?utf-8?B?VUV3U2VTaGFZays0Q1ZYRVZ6WXdqT1FWZWFKUm9lTFlHTU9TcEZVUU5zRFg3?=
 =?utf-8?B?QzdFN1RGaDE3M1liNTdwQTFlRlN3VW9xeENnb1NnQlFVN2NYeExhSHFKZCts?=
 =?utf-8?B?RWJoN3h5Y0lZZEdUY0IxZkhMNFhackF6dDBWVGNHS1N5Nm9zMlo4SEI0eEpo?=
 =?utf-8?B?UWViT3ovVGFjVkY2bkE4RmVhd0xZSVpEZ1QxUUpQNGkvdFlnb3RpVy80eTk4?=
 =?utf-8?B?cUtIZi9hT2RWazd2b3R0TndRYXRVdmIrT0JCODFTQjR5dDFuMVhFQUZSWDN3?=
 =?utf-8?B?TkN2RmtDSkp0ZWFnMy95M2Q2R0F6TDhFdlVmeno0L2ZRYmM2dU5hYjNoY0JS?=
 =?utf-8?B?ZkJnK0hBempRZ3ZlMzlMNzczY0RTaXZGbHBoLzhWYUR3OXR3dlVnaHZjZkRV?=
 =?utf-8?B?anpqYlQ2RmFnMWZwNjhHSGJFcTZGQmFKWUpWRWFBY1FSSHdycmFkdUJtM0hk?=
 =?utf-8?B?ZGRXY0gzQ0xhcnZNaGE4TTdXK1BsSGM0L1hhZDdVaWtCTUs5Q3o3VHcwR2RP?=
 =?utf-8?B?VjF3cjR6RG50cGtRWlQ4bEpmMWFWZEtEL2xhZWN1R0ExbUttbW5CYytQdmtH?=
 =?utf-8?B?aWZDL1lzYk82cnRwNVdaemxDNnF0SDh4MUt6SGUrSGJORlpuZlIvZGR2OUpp?=
 =?utf-8?B?ekpFZGl0RkMyRmhBTlJOSHVrSjhrSGNDS1d6WGpkTGhPL1RLK2tVak1iNFVG?=
 =?utf-8?B?ZDNsT1hmYnpXUDBqZ2ZlUkRTK1lwZ0lmeElIWGt1RGxkREVNS3VxOUtPVnB2?=
 =?utf-8?B?Q21pZ2lNOElacm1QVWo1dEppU0hUcTJLc0JxTDBqajRwSkduNUx2cm5TNjl0?=
 =?utf-8?B?K1JYYVZ3bFQ3Z1AyMFAwZ0tRTUF2SUJDbC9zUFZrU3REazN4SWdYd3U5ZkVr?=
 =?utf-8?B?VE5zVUVuSDJsNDJacWFiK25HbXdoK0Q5c3RpaEZMZFEwcEh6ZmlXQWRaSmdu?=
 =?utf-8?B?ZmF2K2lranpDOHY4UnBwQnVEZ2RHdVBmU1hhaEl2T1dQeDYvVjdsczZpOWsx?=
 =?utf-8?B?RDZ1QW93VXdCcERsbFllcDdLeGZyMGNOM0RvUm04NWc2Y2ZDR2U3TUFIWm14?=
 =?utf-8?B?ZzlkeFVWQ1dSeGtqRFJNNnZjci8xTzBTNGNKR0hBY0FkTXRqbm85YVNBTUdY?=
 =?utf-8?B?aEJRc3JBMVZqb21aTm0yRmJ5ZHhrVGFMSFNZaUsxWU5OaDJzWVRPcW8yTDJ6?=
 =?utf-8?B?cU5xUThNcTVUbTFaUjh4VmMvWnVWbHN4dzQvaWVKNi93aUJUUTVoaFJBTFZh?=
 =?utf-8?B?YTVCVEF2bGxpS1JTbmlYK1h1MHJMWEZ1Ym9ycHB4eWk4UEVqS0VVdzRRWVRU?=
 =?utf-8?B?S1JFRE5QZzd4SU5LS3BkTDdsMzZ4cHUrR0orcUpmQ3F5eEY5MGdFRm9uYjZp?=
 =?utf-8?B?R00zQm9ZazBDSVhxZDcra29mbGprWDVWM2ZITWxFL2Fmc0xlRUpVUFZ5NWJh?=
 =?utf-8?B?YnBTcy9VUzBYdTAzNjJSbzZFZmZKUno0N0RtSlZ4K1hQK0E3NzMvdEFNU1Vh?=
 =?utf-8?B?SDllc1k4QUwxQVo4eWxmak1TbXluVURlUEwyaUdza2RKb0Q2Zkx5dTh5anZV?=
 =?utf-8?Q?W5oVPvPPbmOZwnst6qZPiVVimvVPYnhg?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:9DqlUfriTlgLSuPDkT/7OsxHSKrfbphkaBUXmd+90i/DPD1lNmiE2GkRroAHRwPo9dXA3yTKDFPeSoOoCO/cecJd4ha0eU33RHZy6/VFnTomAMwus4HlFosPoG+klQgEw+gZbGVBO/9TjxwAXksp4G1PDEJC8fhZb9lr5VR81GZAa1v5njvxAkcc88In1QCGlBFYkes2lU0yvYIEcttdIgggnh8ueTwymo5TpttegH4akyr36D3yrOIUGuCW8/bSsSeRTqi+VSyV6Xfs36d7LD45+IsZtzt2cBcyJCsNWH3PJpVAIHztlX4UCviXDqLULxaX4w/bafm5bKMrKeFOCw==;5:5HdkZkp5GF0krT9dCQI8MthvSckK0jnA/RbGpOmP9PegnkRK0BX7Ks1kUayZWPzqWzxu2N48eu5KwLzYPtRscU7e0cMRSU6waCtu6rVvBzzPh8CnPigadDXcI9EjFUkqOtI5NXwbvp5tShEcR7LVFA==;24:icgfqgr7qeS3N/MPIwj50tgYzAyaeg3pgaVRqxbnDkSKWkCrDh5HVvJUxhJnLMsNmydsrq0tEQe7qzECmz86F66DG0GicSa+pZQmr5Jmhgg=;7:KSBK8VfZ8liBEiIvd0ryYegv7L6MehgKSPKijGUzWhfS1WB510VFSxxKoTFleV85TqdHCZNFpdPnKFq16I82hLneupdpCNCX3fwJLs788dfQ6QuWGD4M0WNoTC3swCcM9FYSmbp+G1No5Nhx2b2TNjdRuU+7RNzAO9Gpz3SjKXyWUOe/5lMxcaxc2dZu0Mtur63UdYNU9mUYGI8tHghaKHPqNozrKF9HJccvYoOzcn0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2017 23:57:00.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60518
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

On 10/20/2017 01:47 PM, Maciej W. Rozycki wrote:
> On Fri, 20 Oct 2017, Aleksandar Markovic wrote:
> 
>> Remove unnecessary space from FPU info segment of /proc/cpuinfo.
> 
>   NAK.  As I recall back in Nov 2001 I placed the extra space there to
> visually separate the CPU part from the FPU part, e.g.:
> 
> cpu model		: R3000A V3.0  FPU V4.0
> cpu model		: SiByte SB1 V0.2  FPU V0.2
> 
> etc.  And the motivation behind it still stands.  Please remember that
> /proc/cpuinfo is there for live humans to parse and grouping all these
> pieces together would make it harder.  Which means your change adds no
> value I'm afraid.

I think it is even riskier than that.  This is part of the 
kernel-userspace ABI, many programs parse this file, any gratuitous 
changes risk breaking something.

I don't really have an opinion about the various *printf functions being 
used, but think the resultant change in what is visible to userspace 
should not be done.

> 
>   NB regrettably back in those days much of the patch traffic happened off
> any mailing list, however I have quickly tracked down my archival copy of
> the original submission of the change introducing this piece of code and
> I'll be happy to share it with anyone upon request.
> 
>    Maciej
> 
