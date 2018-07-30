Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 22:58:32 +0200 (CEST)
Received: from mail-co1nam05on0707.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::707]:21737
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993047AbeG3U62quZmq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2018 22:58:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoFmtrDSkHftnTdDVUbC8ZtKmxlshp1K3WGurmM906o=;
 b=F2uvvCev0lGwezjuazRWHyiyV6jHTL5JzsvOgJ3/bhd/kOcujnC6OlwuYmtfTKA61L4TaUbYsW+ME+yhRRg+eqgEltUPMvswoByGC8e9zbsKjMe0fMr2phchoLNO2ygoWCJGpLSLR/5yuK17ASmH2IXmOmPmdSaL9qIu0YFqkWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from [10.20.2.221] (4.16.204.77) by
 BN3PR0801MB2147.namprd08.prod.outlook.com (2a01:111:e400:7bb5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Mon, 30 Jul
 2018 20:57:41 +0000
Message-ID: <5B5F7BC2.5070906@wavecomp.com>
Date:   Mon, 30 Jul 2018 13:57:38 -0700
From:   Dengcheng Zhu <dzhu@wavecomp.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@mips.com>
CC:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v3 6/6] MIPS: kexec: Use prepare method from generic platform
 as default option
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com> <1532357299-8063-7-git-send-email-dzhu@wavecomp.com> <20180724233653.lv3rkz7g33hqz53m@pburton-laptop>
In-Reply-To: <20180724233653.lv3rkz7g33hqz53m@pburton-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:5:80::17) To BN3PR0801MB2147.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a14a150-0ae0-4496-fbce-08d5f65f1772
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2147;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2147;3:Ywpapr9E6Dut2NSTH5v3/JHhYC/mgw/mQWP40j8Mpj303H25mttV4qgXlmJJEzoGphVkz0Pg3XEVCFTYL3SrpXn5OvRJbbIoyU9wbPdQL4OZCGYpo+FeuFAM6F2yTxe9mHTpr17jcFKkRFvPuYGbPES/mkynxDlnuWtjCztZYJ04SoPy7drxtvQK2hmPXXPcmsaHQLMIOchK3RJzHfXTxaJQ9LOlFrqz2CZGVNeR+PUwRsDYtcmnehm11lLQmmcJ;25:t9iiyze5fmDxbi1SSFY5kzB0BTYgLbcq1pMuh4u4AGukJLc4BhK0RgLEaNWd+Z21KBqC0NXIpPEu5btNCVERRsLIN1Fv4+PtDaxgDNoGG/uJROsn+HFlP6D1w/OPWaOERDfVfHg2jCHMIm/2fswl2DYHm2rWwbV+424YYIi9XvUeVat3w7v2PmWnU3s978gE2Z9dRwymOA9sja8X733I1eAQDtU1oK9/RB393UWUcPW028LmQqHmFIdGyHfkEAseMLvFNeShel/dAeEZKqJHueZ4p8o7BPK/WTYqao/1+wLTW0Curn/iukK1ih8exynJGCgjWAUh+RJszDeTJQr3GA==;31:7PDqHGMIK3cxccq1XxWuuK9YOozPEax8rkXtowlyEyEoCous3fV1/soC1FoeYDk/kcImtTPfROJdF3eL7Zlx4Mx9nV08xuX82eQ6NYFsXhtyzPDrLYDA/DCDV0XZSuvD+KpIxdHyt8h+YnBnypfdIRcI56Ytd2d1ST8h+ACGk7ZC+qYMKnJfDa9TU3kp3WKewxwE8reUA8BTHPAUHwsJELdMNl3NoLKGRe3ZRb2wuFo=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2147:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2147;20:GAD9VwdcGtHDSdkQJRsY4IwtOk3AMFORcng54UahjxuSqWuFgpWN+kHpsMkv2RYLX2nqIOHMSqxThXReYaqom1/I7mjB7UFVaQjsU+1LHUy+OXP60ZBSBzo5T03q29aScHjcFwX4Sf4+aqiLW/h1Cc0ITh4QF6Zj5zfclY6D/v+cnGUHH/q48ygLUxetSgWSuDpWBoyRuFUnYsgpYZuKXd02xZ/2rryZRO9oqAfR7KQhAUCyQIb5W79WU9sG+RI6;4:TVKx4FIVKbL+1qloneadcxzsH3ElUsi08tT9E8mkSCaf5+MLwKU5/Y8v5kV/L10z8FYIHyV9u+PgSTD9Pv7bdMDFxWpJj3O7zdAgMlisPOzd3AH1xqEdZzIaW2Sv4kAjSo4XvHIG4z6cwyTQfmGHHlSciipRqLn/UWAAPfHWb7JjYtySmWqAUnPQ83ZmJL5YI+A0lFDkh020TQNyE0GMndNg4V9N4aA+zk2ddzthhn2HO2NXizZpIz8evH5cmPUNRbNIIj+xYWHzqSDtDfJRKxqOZT86JzF0wcc3HB+oII/4zS4ZE80IX2GEf0Un6j32
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21474BF36BD0ADB13C147057A22F0@BN3PR0801MB2147.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN3PR0801MB2147;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2147;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(136003)(39840400004)(376002)(396003)(199004)(189003)(59896002)(25786009)(58126008)(53936002)(316002)(6306002)(68736007)(16576012)(7736002)(305945005)(6862004)(5660300001)(86362001)(229853002)(6116002)(3846002)(97736004)(65806001)(67846002)(6246003)(16526019)(956004)(2616005)(446003)(476003)(6486002)(11346002)(105586002)(386003)(53546011)(8936002)(106356001)(36756003)(230700001)(486006)(23756003)(2906002)(966005)(26005)(478600001)(81166006)(81156014)(8676002)(50466002)(65816011)(76176011)(77096007)(64126003)(80316001)(65956001)(66066001)(47776003)(52116002)(87266011)(4326008)(33656002)(6666003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2147;H:[10.20.2.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN3PR0801MB2147;23:Mr6zIqD+JA6+NRyghIeBYuU6zVQA6v3lujLI/?=
 =?iso-8859-1?Q?jKbohRGzRmtojtRwwSFw/0Gzh7P2AvHIIJA4YhX30zvJxAIJsBHQ9BoRo6?=
 =?iso-8859-1?Q?63GA//uQ2+oc22dKrqDkZ+sf7pPgmyBai0G1b9dksgwtVs0EnYZhxrTZk8?=
 =?iso-8859-1?Q?Pj/a8Xg/jGKEHaPArWytBNmJSDc1W9EdMPz/Ue32WG2lzYBPw7LLeYGpH9?=
 =?iso-8859-1?Q?NGCH9DFoQV1htQj25sTJiJEmS4vUmq6k4H7oQQLUWd3n8ozxEE2NWdfb9o?=
 =?iso-8859-1?Q?mHYGvLPzM2x1Is6MyvJ6Pn+8c5MG1TbB7NVWiQFfQHrp4My+vUwgkjXDuE?=
 =?iso-8859-1?Q?kEvgwv8xh4kjzJTDS03YDKdpKUO3zp4/c0OQZuPHMCA+QefByctSbrBksf?=
 =?iso-8859-1?Q?Ko80GpXdm3Qu3VoShf8kNvFMslWHdvod3WBz64NtqGru2XKD+W6quCNvoU?=
 =?iso-8859-1?Q?2UKpP9n9/mNquZKKn7lITx6Agkla8/uKmjYVJe0bfpgwF//rANsIhKO/wx?=
 =?iso-8859-1?Q?sapNOQZ1ARzaZJFPyqVjG/AEEr7UEcpKRznlIdZ+JjSDNCUaKB7X8neQq7?=
 =?iso-8859-1?Q?X4rOX0Bi/RwZeBB1DD16TlxYfmn6DOUa/WDB+aY/Ms3xamyNvp2JmcW2+o?=
 =?iso-8859-1?Q?IlGixckThfQ/R9mKn8tduWH5SvZTRyRhhdqO8aE72VVZiuqSsTbPrH2iho?=
 =?iso-8859-1?Q?g4QhNsfnMFsXGIEJpLTeq6ycZ5R76d/mAB9oDpkYrc00C5Ho9iy/Gskgn2?=
 =?iso-8859-1?Q?r0jeXNc9PMzg6VvgOL+rw9Pm/jwPGK/vfv5HDqqx+NHpM5U9EeMJlt/Xlw?=
 =?iso-8859-1?Q?seHhFcv+pTS4haH1IE42r0hqp9xuEtconKHGcgKjm9C3La2WFvrmOIbOPt?=
 =?iso-8859-1?Q?domlRDLr0aD46YxZi5dybFzOyz4XGPA44LpVxbTsi3/1h2284WVZzG3T6L?=
 =?iso-8859-1?Q?7qP8uUnhloepd5I0Q7PkgMQerhad41CSbunRZYKkmVsAefasKVUBzKN49P?=
 =?iso-8859-1?Q?tSO1rmMyHST3r4ceocIA+RwKwFIt8wEe1D7UZCWtjY2+IItBX2q/ayRvJK?=
 =?iso-8859-1?Q?5pNokn/LqDBTcWDyYHSdubOICCcI5593ht9NfzGFjQagN1qNHek2Jm70jt?=
 =?iso-8859-1?Q?jCbGjilSUH02ZJG3rvCa17xX7/Q1bPuPpiRRRDlkiXH9iO0ZJbAY3NSR8W?=
 =?iso-8859-1?Q?B6iamO3wxBVG1G3Gz18ONosT7XpeTQUNUy0DAtgqFTXS5IUbIXTsdCNaEB?=
 =?iso-8859-1?Q?6HEjrgVSYX5DU2fdJHLn5gkmVJodAz7tNjryl6Juo5kp3f3WOG/iJbtIHs?=
 =?iso-8859-1?Q?Ib72D9FrYPYpfHrwiUsUK4oH19PBOp98GDFf7R5Pb3RN2Kr+HDZhPX9yfn?=
 =?iso-8859-1?Q?iA8Pz/nLFSA8eZpt3gQOXDg5ob94ER3IcI5MRHi7por9q+Y3Zo/oN4tzwq?=
 =?iso-8859-1?Q?1nJeCooNLpbPuPHAyJHtHd5I2xKGq2kUVxwbne6ROEQE1d3oVZJgQ1NHIA?=
 =?iso-8859-1?Q?aArAB0M8r2w6AkrRp1EujzZzVREF9Zyqg6ldJuOV8Kp?=
X-Microsoft-Antispam-Message-Info: Sf9ooILHThoWlmx8h/DYAT/rRMf90rUtMhKa9s+akTFfhmZkdyKpt0qLl1BdYWWwt6qav6fNkuE0wSFn+heKzfLLQ6KT6AgeUFZXlWXVoYoetLJFzJqhBZISDIJXaUqeqvxNn1jSNz2t7mYsnLhZhan4mymCDmpi17rRhQE5r/wDvcNKli/iqyzYoFpNF5H2spSSUba1qOYuHAJ2Xv7Kt6mlRspbcwdmH2afINuVs3WvCpRh6gr6V71p10Ykg3fcgCIwrgpx8QGNlg6qZeNvkbkfvz+/xcnpVm8QMesq5n/N/3TCQqrKmFxqaif9sDqQhgAjT5nbEWyVcQ2yEc+UsTPHLX6a2hoA8VACDjT+Axk=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2147;6:H+cR1BLpAPz6bZIB4eLDRxJPuPPGIshfdA/3wZ/veZqj6DLNUd6jcTEfqEv8R9HZfglH2cX7+E677Aky6EkhmtjqGRuN4vtCo+xlq6vJgXib6AkIALgAmYvZ4fx7UGwn6UvzHUmPZfgre8vI9FlMZs2EBu+zyryPON5CWffMtGjbg7fbb/7mC8JDWHFHDVUJBU9vePN1Y0swVh6Xr5cW3cpgriC/SsvykA3KYLYokZlyQcGq2l+Tiy7Ex5wh2Ned1bjQvE6qsEHmibmyCK39w4Jo8k7nie82qOcNgPplLPqhDPWVJyi2get49jiF9Z+oqtBmUbgPfz8Q7GhPQ8pLXKXl3/jDLQd/ssPKnM/vYHgdwlB+OtcBy+2ufumc7xwiLM7abwrxo/xZEckdnCUo97m/fbm5Iw04I9wvOz9Dscg5lFgZLaFogsZKC93E2s4lVYsQT8eLN0GbjJ5l2/2BSA==;5:o8foPlsbc4dL5uu/GAMOI0/4UUcYRH749uvqPEQ/kSfothB5FeLnLPb+V2oayCAcnWAwbdgSb0LwsL6HP+QYiK0Qx7wGuDYeutJcsrAkLtXsWB732BOt4dc5jr+RfczE0EG2RxESYHwH/BEcqMaDWPcVQ8ASBBQEqXlzgcAcbw8=;7:GoGsAMeD+bRzZBnwobgQG88pitHT5XoaZrBlemCEWBgAQdk8PN90G9WzNoUtz/mBe8NV4OOyUxLbacEfNjDfjWE/XZ/rEMI6Y418Mg4SsUfnbP0e4fHHPevZ/59RKQKdK1LDzJSYXmXdE4405Wl2Uc6dljWFznF1dPSWwfr6wGKmwuzzOl2ICiJgULuKHAo0ixkt0u1KPqQTC76uivSOf1Et4dB/6jKCvQWz+0D0qjJ2TVb2tjFV6a0Ip9DKvs/7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 20:57:41.2666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a14a150-0ae0-4496-fbce-08d5f65f1772
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2147
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65261
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


On 07/24/2018 04:36 PM, Paul Burton wrote:
> Hi Dengcheng,
>
> On Mon, Jul 23, 2018 at 07:48:19AM -0700, Dengcheng Zhu wrote:
>> The kexec_prepare method for the generic platform should be applicable to
>> other platforms.
> ...only for platforms which use the UHI boot protocol, which is what
> generic_kexec_prepare() sets up kexec_args for. On any platforms which
> don't use this boot protocol the new kernel wound find unexpected
> arguments & in the worst case do something crazy with them.
>
>> For those otherwise, like Octeon, they will use their own
>> _machine_kexec_prepare().
>>
>> Without the default prepare work, platforms other than the generic one will
>> not be able to automatically set up command line correctly for the new
>> kernel.
> So even with this patch they still can't unless they happen to use the
> UHI boot protocol.
>
> If we ever have multiple in-tree platforms which make use of the UHI
> boot protocol & want to use kexec then I'd be fine with us moving
> generic_kexec_prepare() & renaming it something like uhi_kexec_prepare()
> but I prefer that we don't just presume the boot protocol for any
> platform that doesn't set _machine_kexec_prepare.

Thanks for pointing this out. How about something like the following in
kernel/machine_kexec.c?

--------------------------
#ifdef CONFIG_UHI_BOOT
static int uhi_machine_kexec_prepare(struct kimage *kimage)
{
     <the code of generic_kexec_prepare()>
}

int (*_machine_kexec_prepare)(struct kimage *) = uhi_machine_kexec_prepare;
#else
int (*_machine_kexec_prepare)(struct kimage *) = NULL;
#endif
--------------------------

In this way, any platform (config MIPS_GENERIC at this moment) can do
"select UHI_BOOT" if applicable. So this will be a one-line change to
UHI platforms that have not been upstreamed.



Regards,

Dengcheng

---------------------------------------------------------------------------

*From:* Paul Burton <mailto:paul.burton@mips.com>
*Sent:* Tuesday, July 24, 2018 4:36PM
*To:* Dengcheng Zhu <mailto:dzhu@wavecomp.com>
*Cc:* Pburton <mailto:pburton@wavecomp.com>, Ralf 
<mailto:ralf@linux-mips.org>, Linux-mips 
<mailto:linux-mips@linux-mips.org>, Rachel.mozes 
<mailto:rachel.mozes@intel.com>
*Subject:* Re: [PATCH v3 6/6] MIPS: kexec: Use prepare method from generic 
platform as default option

Hi Dengcheng,

On Mon, Jul 23, 2018 at 07:48:19AM -0700, Dengcheng Zhu wrote:

> The kexec_prepare method for the generic platform should be applicable to
> other platforms.

...only for platforms which use the UHI boot protocol, which is what
generic_kexec_prepare() sets up kexec_args for. On any platforms which
don't use this boot protocol the new kernel wound find unexpected
arguments & in the worst case do something crazy with them.

> For those otherwise, like Octeon, they will use their own
> _machine_kexec_prepare().
>
> Without the default prepare work, platforms other than the generic one will
> not be able to automatically set up command line correctly for the new
> kernel.

So even with this patch they still can't unless they happen to use the
UHI boot protocol.

If we ever have multiple in-tree platforms which make use of the UHI
boot protocol & want to use kexec then I'd be fine with us moving
generic_kexec_prepare() & renaming it something like uhi_kexec_prepare()
but I prefer that we don't just presume the boot protocol for any
platform that doesn't set _machine_kexec_prepare.

Hopefully anyone using the UHI boot protocol is doing so because they
want to fit in with the generic kernel platform so this won't happen
anyway (just need to get EVA supported by the generic platform & then
there'd be no reason at all not to use it).

Interestingly there's a patch in patchwork from last year which aimed at
making the default to pass arguments the current kernel was given to the
new kernel [1]. That would seem like a saner default since we'd be
making no presumptions about what those arguments should actually be,
but I don't think that's safe either because if any of those arguments
are pointers we have no guarantees that we haven't overwritten the
memory they're pointing at.

Thanks,
     Paul

[1] https://patchwork.linux-mips.org/patch/15397/
