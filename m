Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 19:53:07 +0100 (CET)
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:9315
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992240AbdKGSw7jlKOM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Nov 2017 19:52:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=f06cLih2yAFmuS8kRn45xj/YrHNMrDVYyZ2bjm7LhH4=;
 b=b/kVN0OEq4CuCn1PDpEJKaiCZhGUQn2kBctpBEcNb6hQTv7g9jWXMz0MgIwYPcNqEwDuHRYQNxHR90QMIIz+p8OdJw+6z9du0AAwVTLYxb6mVfCH5xqEtjSL9F5ye6lbMm25njauqSkIVQ/8r9LRtacnbQ5hN41A0y9LcfVgX+w=
Received: from [10.0.0.4] (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.178.6; Tue, 7 Nov
 2017 18:52:48 +0000
Subject: Re: [PATCH v2 05/12] MIPS: Octeon: Header and file cleaning.
To:     James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
 <1506620053-2557-6-git-send-email-steven.hill@cavium.com>
 <20171107161157.GI15260@jhogan-linux>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <cdc8fe3d-7f43-876d-b879-59b3edc5499f@cavium.com>
Date:   Tue, 7 Nov 2017 12:52:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171107161157.GI15260@jhogan-linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: DM5PR19CA0034.namprd19.prod.outlook.com
 (2603:10b6:3:9a::20) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcdeb668-49d3-44e1-0dd6-08d52610bdba
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603249);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:coQLJSp3dsAuPqH1jyxAWTNPX5GkeVLYRsvrqwjgWag4iTqFDwBzxbsbWcTz6svk1+aosXku6S9csmi5CeFgh8HlGiLOUFG9s6BjYINquIyR57Kt09+2sfeVLNXO8dmOAEaEMuh7DNmtUIEX9+8sdsjJWvn+9tZxnarrOFUHajgdopDkMW2+HQ6SAVsI7yGVYA/T6Z9CD+i0q5Co7VJCXIYKmiSouZpzwTJIy3iuRgzJv1eWCA39y2o5YvBnJGw3;25:JH9QHaWITKneYIG07UnO0+gDkXSHVlzGfOuVRLptesBmrhymlifxb/FedWEDJL5BKU3cm9Ag4amyHC3pa6LExObXeENRuhzqfXmjWNrSMvsSlz9H/ZjbJ/1btpR+cKIwUgj+xVKj/E5W5QZOg3vDGpDsxWZiZ/R3ggTog3zifHllLJbW6X5T2GxvgH1eGzsx4uyXdGcXYIC+dy/jz6zS2z7b3cwEJvLjhZ97oO5Yd8w0EhWd08UKwGdN5QBGoSOrgT4Yaa8RZ61Jzo3qqPNXBr8rjkIv/+LWaVOHjCLWlUQWhRuCANERx3fgnp/rljvhwYi80jCBe7xUVLhLctceZQ==;31:xGlg3vIvWHH5X+5bVc2iEe9I2RZ8DiPQDvulR3NiaTLXpSZ9TLXU/243gLnmWJLk0SXxQZ6rRVtJUG7NKCR5/hbIKCEkEWgUcL4m7F717B08mIkk07PJvhg/KHvGzkPSw2xr6TFtR/UMMVC5td/yaTWxmsjbRknVdEHj8AcVD6n3umX6+crYqvKXADGpNzDOHWFsQpP/OmgZR2cbTuUgGQDxsKLySR56AmqbI3WUVeI=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:KDYzWLGqcbF8EwOySkhtmFaaY/SBOpZdgNdYviJkKBfj3cnnQj933astN76F8htcR8HdnNxnA8pSMBqQUff9sQW6r8IBpk/4j1IAeE2jCi4bGNRpxPfihwB8Q6hDcqe7ynFjculOetP70GqmA0gKgOewrRgBqV/xABHuMZbSE1yQywLjIknJo18ICDVWCsCIaWX5WjXwF1prOdOHFhBfnsP/GCAuNg9ubIRpNwsjvFBdIecS5uPpkkTh+xmiVqesQSxZ7CPG5nCR/bmWrD2rCqB/af2Nv/kmk9TuV9zj43/wY1TlxY80ELBxfgZMprDDhIPneU146HWFyP6He9eNfqtn/GsTOMX5YftwR8KDyZ6WOlFIPQIYbXnjW13cOW3rJXD7oNmGGv2HxA1wo6dm8y0KoHnlqUy61sjcKTfBUgYxU1H+cDLaqPgTZW2wepZU4OL6nMHk+ADWq8QBh43kd7maTWF2nDezRVAgqoZ6Gs0HsmH6S9V/0/e+3XzA1Pth;4:uAyU/0m0+5FDrfsLVWFf/xk4DmWLFjUWm+7vdv2R5NUPOJ/pU+1a39fkLnVdmaS5FjJGisFwPAwCxXdLJyDPp8IiY60Hux8eAoqcvgPmlm1fj6XLTeSsBnrfdGHzr0s2/36lFybQmbAhcIDSCnx8q0edzYzsdjbFyEcJkTtw+ri41W/LkSmpw6Q89gwGRBCLy2B/1ef9+xwth+WNHSpKRcR3K8Nf0rp/ed1MQSf1PnvyCMo4BahKOGLJJvtjfa8z/A/U3VklvLd1IYR34qcJHw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3806514C5CDA8E7A96BD8C0F80510@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(100000703101)(100105400095)(3231021)(6041248)(20161123562025)(20161123558100)(20161123560025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 0484063412
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(6049001)(376002)(346002)(24454002)(189002)(199003)(189998001)(6916009)(23676003)(50986999)(101416001)(8936002)(6246003)(86362001)(76176999)(6666003)(66066001)(54356999)(478600001)(65956001)(6486002)(65826007)(65806001)(31696002)(97736004)(2906002)(77096006)(2950100002)(83506002)(5660300001)(47776003)(50466002)(305945005)(53546010)(105586002)(106356001)(53936002)(8676002)(31686004)(72206003)(6116002)(16576012)(316002)(16526018)(25786009)(3846002)(58126008)(229853002)(81166006)(230700001)(33646002)(81156014)(4326008)(68736007)(64126003)(36756003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjRQUjA3MDFNQjM4MDY7MjM6OHZ1NnZoVld4V2RwcktrbVBSODhPbTNt?=
 =?utf-8?B?S0ZUdFlhZHI2dDZxTmV5cktLRms0czFrUHN6cVZTbXJEV3FvRWZCL2Fycnk1?=
 =?utf-8?B?UEVhOVpZVklZdWxkazNHL25xbHNzWWdyeXBOR0NxLy9HSUhVUy9pQlJ5aElS?=
 =?utf-8?B?MW5Hdkd0N1ZldEhFOUsrTW9ERHdlVXA2UUQ5djg3SVc2ZDNhcklXMVh5UTRx?=
 =?utf-8?B?N1gvVVRIaUtOdkVmeE9ncDhxZUw2dExSZlB2TUtrRlBBeXc3QWVWT3EyclRO?=
 =?utf-8?B?R1NwSDQ3cnBreTYvNE1PVE1JUjlZYk82czkycS9GVHN6cXVrRXpNcUVlSCtG?=
 =?utf-8?B?ZW9hNDQ5R2czTGFGRStSY0crdlNTUXNURlZIa2U4MW1oZWtVdVYyd0lZN0RP?=
 =?utf-8?B?Z2JPVlQ1Mm53cWtyVkVPNTd1bTcySEFCSGdFb0h4YVFBQjlCUHFoQ1p5TklD?=
 =?utf-8?B?VExWcEFXTmw5N0t3djlIVXhlVHZGNzM4T0F5TUJ1N1lwemR6VStwU0Zqc3V6?=
 =?utf-8?B?TlEyWlU5cUtJaUQrZk5jQzVodk9raG5rNHptWWd5M0t4NEpVWFovOC8rRFlL?=
 =?utf-8?B?eDVXVEhJUGxETjh4Ym4raHdxV0grN1dDWlRLcXl6WDNlZ3ZuYWVtMnZoK01S?=
 =?utf-8?B?NXNsdkRDV2syd25EYzh6UWRNYTErdnpvV2NKY0s4MFVJSkZnWWVaQld4Zngx?=
 =?utf-8?B?Z0hFUWdQV09WNUF4clpRRlRheUlwekc2SjJyWGxvN3BQM01rVkZLNjJ5SnpR?=
 =?utf-8?B?Y1psQ2t4TWtobHhRU2VJSjJXRy84bUlSejdpcFMwT3cxMVh5RnRma3czWGxL?=
 =?utf-8?B?WkppWFdYdDN1Qmpsc0RONi9xTnQwMTQyeGtQS3A1a0x4a093RzRkVXZIRzhq?=
 =?utf-8?B?ZWRiY0I0TmdjbnROaFhPbVNKTmZxbThYWUkvbzZ1NER6OEkwcEp1OW1DU1ZG?=
 =?utf-8?B?OGFjNi9GN01KUHZDR2J2UDBJYUJrTEFBLzBEZHVwUFRRVHEvUEpTQ1Fic1ZO?=
 =?utf-8?B?VnRTaWRBVFZJRWxNUEM3bnJUM3ArNko3UXdIVGxyWjZXVTJScHBMVGFMVUov?=
 =?utf-8?B?QzBNSS8zb0hJditBNmg2YlNYcXljbjcwbUZEUVVIRm9TVUQxRGUzRjFwODJM?=
 =?utf-8?B?a0UzUWNTcXFOT1RsWUk0Nng0MVRLdFkvTVRQOXVZQ2kzM2VMdUpkYnhJb0Zk?=
 =?utf-8?B?Sm02TFZWOVVnL2ZoZ2p1M05KT2hOTVVBQlgvaXFMQlNzblNRSHE3bHZIMjRX?=
 =?utf-8?B?UEhScnNwTHd2T0pPMkNITzJuT3VKTkY2WC9INVNkbWh0dDBQcTUySXlqVksw?=
 =?utf-8?B?VlBwZ0tkVHEvNW4zRzA5OCsxRnNtaDJ0L042ZFlwZDZ5YzN1MmNKd1FOMGlL?=
 =?utf-8?B?K2xmWWNWUnFIYmNTdm5mbjh6ckVaSGFVWHZ4TWFTMWtmS1oweU1WWUNyd3Uv?=
 =?utf-8?B?enpxbitmb3JJRkVEVVFjVUE2a1hNZjlDRUlMT2pmR1V2NXd2YWdBSXFZL2tW?=
 =?utf-8?B?V3U5WTdVNEtRdnlFaXp1QjNzdlB5dHdKUFB1RUhrZEJkLzAzYkV6d2c5OWY0?=
 =?utf-8?B?QUlPdXJnWkIxK1paME5FWWpwVnhaRUw3eDN4b0dvMnBMRW84VjNjejZWVngr?=
 =?utf-8?B?SFJqSytnbTlvM2J3OTV3SUFYWDhDNVZzZVhWaEJVMy9zMU9hSmRQa2g4SnhX?=
 =?utf-8?B?Y29aTng4MnJObnU5dEhJMVZzT2JsRTA0V0ZEODZJL1gvVStWQWdmS1A4MUVH?=
 =?utf-8?B?WWQ1MDdtWkR0cW9JTHJBVUZNcmszWHArSUs2K0xLTGppbmFNa0ZQYzF0OHFw?=
 =?utf-8?Q?ZuH2dlPUmZBxsju?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:Mk4oVUl5csLry4jDHxbuyGEtBtQYIZ5Lz/r3CYlpCkbpfoIIBrncWydg1+ThSbj5nEfffwb3DnBzT228O5+3U/pBGygs+I0kuEiwRoOnE//7MyASJDLX6t7KkAhOy7tVmDRKEEqhAUraTKKUGDRlYDxiV6xT7iUWhxfjrXTr2g0vv8fyUj9gGx/cdDJFhNXexkz3YY6vEf/TDhCX4QLhO6Dk8UlaewfFbJCaxQTSAC9CSBDMSZctxb8970a5+mTULsdkuWN0Mxblzb+F9WHxmh0WiIznYseLX4er5BXFBSU3ZOaE3DqDCHxQpbDIwSA+cxY0B5nkLdNGqY+sRhCYBdZVzxf4ki/VjITJ3Ce+jek=;5:PeX/P7cAohqR/6lfGhmTKISnZY3136qQPtxDKR364wCv9WmRbQh3VLhgRhNCVUT+jv2i6EXhfiudGHE0oMq6nLLSHYVSGCQRqk8BbSF0Qrn/tlM9iDI6b0O07HWepeLoovHWRiLaS8GR14uZfOYgg2KtIo9s07fGYLJ/h/m3g3k=;24:HdQtYuacnE2zxUpdYQenI4DGOqjVQJD4JPzaWApuylegZPfEK7HHr5G4OLhFimoECSO+cqqPavgm7HZXcflSO4/VG2qjmvG3uEkJTMC8zFI=;7:Gg6lKjxesvI3cMoVR64uiSMw/wngwQKXsrLiccuWkr0+mGcQCeEHunIcoHfzTN5R7ACIUN/Dbnld26qHZtuM+66TAbpN9O2T2RT46VxiaNgbMNL0ZNtm/DTXjcF4mCmzC1XNiM4cmM8lCrFVDIqpLexC0hUDyyTF670YnHYgi/yZvBJHDgx6rZLS+zeHmacp1vPReQcENUOXKchbkWXTd/iqiAAg9iBr4qXzS5Gu5VXWWYMZZ91F8+wDQ1OL7uoY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2017 18:52:48.2681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdeb668-49d3-44e1-0dd6-08d52610bdba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 11/07/2017 10:11 AM, James Hogan wrote:
> Hi Steven,
> 
> On Thu, Sep 28, 2017 at 12:34:06PM -0500, Steven J. Hill wrote:
>> From: "Steven J. Hill" <Steven.Hill@cavium.com>
>>
>> In preparation for new hotplug CPU, some housekeeping:
>>
>> * Clean-up header file dependencies, specifically move inclusion
>>   of some headers to only the files that need them.
>> * Remove usage of arch/mips/cavium-octeon/octeon_boot.h
>> * Clean-ups from checkpatch in arch/mips/cavium-octeon/setup.c
>> * Add defining of NR_IRQS_LEGACY for completeness.
>> * Move CVMX_TMP_STR macros from top level to cvmx-asm.h
>> * Update some copyright dates.
>> * Add some missing register include files to top level.
>>
>> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
>> Acked-by: David Daney <david.daney@cavium.com>
> 
> This causes a whole pile of build errors. First this, the include of
> which is visible in the context of your patch:
> 
> arch/mips/cavium-octeon/smp.c:25:25: fatal error: octeon_boot.h: No such file or directory
>  #include "octeon_boot.h"
>   
The removal of this header file is in patch 12/12. When the complete
patchset is applied, there are not any build errors. Looking at the
first version of the patchset, the removal of the header file from
smp.c was in the last patch as well. Test builds for bisect-ablity
were missed....again. I have no excuse. *sigh* Hold for v3...
