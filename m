Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 21:15:28 +0100 (CET)
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:50951
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993869AbdB1UPUVSjvr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 21:15:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qeuud18Wuj2agM1S6TnXS9UMy4lkl30tLN+jqseEkzg=;
 b=UmWQkSy+Sk1MhJz3NLG0wLh3dXAVilG2DnR3tqa7nL+Mji0OrvZgGxgdqfGWwYvQIaOxaLosDDYNKh6NpWUy+k/4lOQl5KqaAYuynOYdS4KOKan3H1FdpqRhK+6onamEnDoQZWHs4bD+ISiL4q0b/leXMmqSlZCTE/qf7o8q6EA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BY2PR07MB2422.namprd07.prod.outlook.com (10.166.115.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Tue, 28 Feb 2017 20:15:11 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Jason Baron <jbaron@akamai.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
 <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
 <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
 <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com>
 <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
Cc:     linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <912fa97a-aa1d-c0e4-dc83-fc5c745db1c1@caviumnetworks.com>
Date:   Tue, 28 Feb 2017 12:15:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
Content-Type: multipart/mixed;
 boundary="------------2F06A5F2FED84D3DFBAD5183"
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: MWHPR07CA0044.namprd07.prod.outlook.com (10.169.230.30) To
 BY2PR07MB2422.namprd07.prod.outlook.com (10.166.115.14)
X-MS-Office365-Filtering-Correlation-Id: cd2ef268-e43b-4f48-ba07-08d46016806f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BY2PR07MB2422;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2422;3:X3+ug+6ty8MuU6plMmb8PQDcruM/xF1rI446jmqvgSu+MLCAbld1fn9ug++/yoMTmy7wZfbD0l+D0TJ1qmQSvAiIV1Fi4tdWeBc/U9cMGZ2Ac2FyNyY+mfMoHpOD9b/QOcBmnGX3bkuu1Oi/Nxtaen05LGszICwCKlAUQzCRcZ6Eafbj1+tWvrQ/8WWUMRpJIr0qj8Q1LJBr3gUQIDPnSi4T1xwpZLYHc4d59igUXZFvWEvyk/JjYqB/QkOi8Rj5+7NGTi6MQZmFYhtBfNeMNA==;25:7MqzTDWaE5ILFDL/0ufY3JG3bgA4lJa8VFH7C/Iqw4vy2bLL587d+gmhYE/jXfzwTHRegQnKKeAt7znibNSmT3eMfRArKbpsdH6eUG5/xdT5f+vPCxyDid3HQW4TqwvduNHbKuIt1Z4QVvvwn8YvlPEQ7wYuKz8yghwfRaUVaVA0Ipvt1Z8zpgBbRn/THTO8R/4kTo1PQn1JMudxK3jbE3ELtJjltBbuGnLcduSxqtHtlSxkQmRgXpUD08FlWLdNFMQogqazS7h8N7/29+2hYKR3rLUkPl1qc0OYQqNnSwnMABD5UdHcZCARWU9J4ommo3c5p3X6NJsHy1FGAtsCgu/QdX6YskvXkApgD3eu9iRekGNW0mTq5qLXy91k4O61e9zKTosCeSG9QCpJ5Bhx9JIpZyPyI6NFoxYkcJyROloUe0Lwb5J8m36kGQSp7LdAOqkZVUJ3ydLbuf/yWV+gbkvGYvi81JLoVrtaa/e5q9CVWGYRR9x8+saagRG+NUFZ
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2422;31:lZPyI35ax3JZfRYxvBbWzCJ6e3SabEE80QH18e38vZhXTDwvcjYLv9QzKV6urugAxVfaISp/Ifm3kvJsRIMS4GQ4z2ngo3gS2+AjaF2zg1k75Xm6Ny2clKuAyMmXBR7oeZXHV/mh0AutxtxrTFmFwNL8fYSrAJ29onWT2TQ1Exx9/jRHlxOz24LFfCPWSgRZigvurDz5N817G7U5Prucpvabpc32i7I40+W3KTZeqCdE10/rmvqJEO31Ip8AXz12fvWRjXBQqCp49f8NGjlNDg==;20:JLlC0zZuF1HhdyxwMtIxua4SDKz5+8zGA6LXnmSlRyesovcwdb80Vp0sotjJbb4XbWwg7COkAGeVcp86+BT1HEhDtYaH9ih+ek2/2fhmkWW2dfvLEEjgcTO+riKqWvm40+c0E9AvnvGU3eBjo+LGPwzqzhPOkdcz8xMTIX80/deoCTqGN7E8dPZCLPiAnTIZlp9vE9TOPNKFXuLCLzN5U8Qwv9hNBqQQs06QN55sbNhA3vC7P1s+Xq6Q6vIwqTNihoR4b7A1wRX0v+/h0NL8YIbj6N0YZX40L/riXqjkXR8T93q5NmFFx8qNMVlJSIAG/+4OUdymozl/XznN7235XB+Q6QloNRGWtwcv2SVAOZUjp1fCW+H2RfVh47gy4IX1DV+d4ubstw5zegj6xkE/1ZUe23hqrSIrltN1xJFSMgCtCz3WRsPqzZJ4H9AahtibNqzf26ouEcIfGytfbq/YuJeMS9D107yYl7t9T5kRO3oER8amNjx6qdXG9aqtEYcWihRT49EOkuZwU69GoOMFc1auT+yvpMJiWac1yENHo8Ma4y8gMRHtJ9SVsm/X8VlPIMhFJ9SsIQrg21DFEqU2r1QkAt4hABTN8PzhA8g4OwE=
X-Microsoft-Antispam-PRVS: <BY2PR07MB2422E4C727B46B399779D50B97560@BY2PR07MB2422.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:BY2PR07MB2422;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2422;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2422;4:oEl6g9yIy3yDlKlfYUMfD9VIKs9jEx0Sg2tXMRaoyaJU5Xr9M+M6tPBXba9+cSlMWvjTGmV1CTzxH9Kid1lhHhvdscG0kGJ7DAfipyvx6PPXY4f+l2bqTP/IHezTrm7ctyd/EGVp2ONPEb7j63xfr+XkD7PfiAF6xgA9trWqtiQvVwz3u9UKGyXMHXdQsK+zRFBagj2fEMh3MiKEqkDDcoy8RdjnupMRIHY6xobK9dEeDSu+dZZtshAE6XbKCAPP6dFsXUYhlG6135tFXKU3ICJ9aNAgM7oXT0kaJLoEGqW5tjWY1EelE2qKmRwq+g4I6HWhCmsKV9dk//40QcgR40dJ2yjovMqthz7rEIIwEndyTOyEAjeDAFwHi+wcrhCytk+qZ51ldnot90OrsBFsSgXbcUY/twjbk2FMi71nt5j/8e3UVEdUKHbrycb380BEFhXnKnBs0KiWC8vMBcxlgHzOG8LGPjOMjuLUMdl1tq3eiOslWQYl1YIhv46rki9Jv9hfgyubDNF06Nug7zcFUElIiaxp9ix+rdENyEc10EsRjLc5e2vS/RkFAdI/f2GJAJlpGzlCnoPM+xGe7P3cLfSJOLWh0DBgrH5ICUOfDmMcpW89H6yHtE5hnWeSr8Ez
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(189002)(377454003)(199003)(24454002)(305945005)(106356001)(105586002)(7736002)(68736007)(65806001)(7416002)(53416004)(42186005)(54356999)(568964002)(81156014)(8676002)(31696002)(65826007)(4326008)(69596002)(81166006)(25786008)(2950100002)(93886004)(42882006)(33646002)(5660300001)(229853002)(83506001)(38730400002)(3846002)(76176999)(6116002)(53936002)(84326002)(6506006)(53546006)(6246003)(64126003)(31686004)(5890100001)(270700001)(92566002)(6512007)(66066001)(54906002)(36756003)(65956001)(4610100001)(4001350100001)(2906002)(6486002)(50986999)(189998001)(97736004)(2476003)(101416001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2422;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2422;23:wfuWtL4m5437KxZiHgkpCZf3L9Zh4+813hXliSNSU?=
 =?us-ascii?Q?YN3wb3oGQ2NUH5Fz4quAIFtmLVEDew5gTUa5WJJczQfBdpC3nOWpiPAnLVK2?=
 =?us-ascii?Q?TosDG1UeNkkWhPDl98tXcSvLYQSAQuNvDPTH/8PT8kld3AuzLsVrWSuvNRUm?=
 =?us-ascii?Q?AirwZE/AnINtLDZkm+zjyBgZjzj5jLf8QgXWBq37o/967jjFtU2lvSKE842l?=
 =?us-ascii?Q?KCLn1HDBAoYGZUz84CpdXifheGjJ7Q4A0Q+dOW3PPLWkE2R5MYlJoBZLXN/q?=
 =?us-ascii?Q?S9/fCLJoQnLSOi5SzY126nqGSu1dP936VZsce+CIFj8brHMf4Hs7qU296moT?=
 =?us-ascii?Q?K8y5a+onJB7ORsElCetGyx2w2sr61s2jmCCaXa0JtlRL0aYIFt9j2/2yRokL?=
 =?us-ascii?Q?DYn/T9Zx0CTCJtPoHWI039wbUCPY9QmUfrb+foDoHHGtsQ3uyQ7WyoXNSUP+?=
 =?us-ascii?Q?k0XwJAFocmSIenhJZDz5iEuHhKCLpXM3FxgAGaOwakbxB5eAW/w2+TNjxCsR?=
 =?us-ascii?Q?z9EEzJJCUEEQrKrEDvb2qwi6tPiAlc1fpcflXHuHD94NzZzxotv1JQlhVN8f?=
 =?us-ascii?Q?EQjCmfX23sRfDkfFstCSe8pqDZyROjirgG+AgYav2JCNpdJSJGN1afzm3fiV?=
 =?us-ascii?Q?U3iDs5pHfV834viTmGwhHJBAteYFQNpFch2S+t4Pe1CYs71AnbgXkZoFCA0V?=
 =?us-ascii?Q?OSHBlaqeEhdLQGj6J2jjrq1uhWVK/n7123TtHZGYYzdyMlB+B0ZSAnzcUL01?=
 =?us-ascii?Q?b/ObJ+vZIL29OMih71TtdaPNmA7hHLVDdJJGFn71z+CUBA0bJj25DQTOt2Lo?=
 =?us-ascii?Q?Oya1YJsCSDY0nqVBU2zztiNEd9Ssz/JdLHKwVYE8PsgeBru19IiUwS2EPjgi?=
 =?us-ascii?Q?yRrkowffXXASQXdgOKkydfX0N6IywoUx5b468JBNUwu2HbPozCWYU+NpAvNJ?=
 =?us-ascii?Q?L3dZyA21u5bGmP2YgTlUACAYPDSrrvqJtZkI+JsHJv5lrneqVf9U26jFBffL?=
 =?us-ascii?Q?HYUk5WIwGj7qX09IWIN91YpGoVEuRqqMs3cRkNhkoQ10BgZSAzJ1qKRIQD2l?=
 =?us-ascii?Q?r44Lc5W+92y9GBq9zYSj7CAUbhtmGK/or1DAgAJiW9WLU/4D4idxNpJe+DCw?=
 =?us-ascii?Q?AjpuJADhXhaI6LhCGS/PX8Kr1qwGZqK1UvmqheVhMNy01QgS4N8dxc19LVaY?=
 =?us-ascii?Q?4dGib7UFbsYJaE3qcxvzv07ppZt2a6a1ANV0o7wIan3y4+IzTrK4mRVsnT2n?=
 =?us-ascii?Q?SeFZEZv1PpZRoHFOpv1QwC7BBKfqlv/Qfk47ObJApXI9dIbcgMPWywuwqJfn?=
 =?us-ascii?Q?qG/KKl8LFkYmQtNS64YjGxrRG+LpkL8Vj7gj/7jmRpDGWteinbldcPg9qJSp?=
 =?us-ascii?Q?+xXr3x0S4bt0u9/3WFhKYcJ58JD24BWupYN4oxFf5SUj3brH5VFJQh5QuApq?=
 =?us-ascii?Q?gCxEOO2jMhnnz9SYC3GuB3Zo+hkGwrHIvRgpQBsnAiA4DbffYiUBnk7FOCsH?=
 =?us-ascii?Q?dzjEPzUYkLUSw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2422;6:Dd4KCSpi+j99w0lZGgqQoqgThv+T73GiiaeSZimYLby+FdCPuaW1pK2w/4anZvMZAUYC0wD82inNEc4dVQv8R8af5qAxn73RsaFXnGdGv9DC4nYv+HAAZ/6+ntwJ7fWM+zbuYLjw2gVWJxQylDH+MeUJjl2J7LE5AnMc+0RV7qzoC05mlZ+JTG4Bym/0mZxcYRpA1KSx0ESSD2v9EkAbhRBvtEogD4lQDNquyEZQpgAxPavaJRmCUm8C4Ca0DItjrrM9KtQd0eUkF02JFxHFULsjYsFTERQh7Lns08RUy483fzH8UZJ2tXFG5DY/D2xz2fMQiCF4tsVGmAAQAD/EvMJNy6bals6E5BdfFhu4ynTb6VQoJtn1i4+LKxDn2sxNx3tbj0q0bvEfsrXcTuMUYQ==;5:3x89/QxkcI7VKB6C95n2TXg13q+yjzB53y3fXGI/bgexJbfgbj1UTJP7XB0udBW+tdYFm9vCz4blPDcnrB8bGUS4JzSrh1w8NkITTtFb0G+2H+tRUG9mAF6M1bT0Mfp3Tgezqc09EV4dXJ6TJcMS6uXLwQOt7iZMqj6pqg3tR7M=;24:A9UTMD1E10lXqtjKTRPMWhAVHVCAHVJlSqdtclcONyNiC8hq4WUkUQsyEne8h6WHIOsOwX2tX4ylnY8Llpvc4MtwkX7hAothXwJcD6wVr7U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2422;7:Bfn7r1LH/ufF4jI5H5Js8lW4SCXM+EzHyZitzhxkpLH283QYKarAOwoD+Zf/9fEt+BDe/vL/OGJbnTlENCX6nmwcSPE4/AdvKJmZX4Pwxa2G4EcR9YK3fv8Egymfj0IeXVaZfVM+xE6aEa8uesi3Ljqw4xQR2VF6YiG0dxTEG/WiOSjthbzxK6eup0leJwfxycEDjmgPAw/POhbfvUpsMICh48wvm4zyl7smD8W4aAzy/TZftk1R27Mf+b04GlDe7uiXTD6mwE9aoDFT+1XZQj2BQd2LsuHSmb+ibDFppZH6MYUanqn/LgafhLlSyqJv7Fk0uWYrjFAJZuF+DjIjYQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2017 20:15:11.6903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2422
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56932
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

--------------2F06A5F2FED84D3DFBAD5183
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/28/2017 11:34 AM, Jason Baron wrote:
>
>
> On 02/28/2017 02:22 PM, David Daney wrote:
>> On 02/28/2017 11:05 AM, David Daney wrote:
>>> On 02/28/2017 10:39 AM, Jason Baron wrote:
>>>>
>> [...]
>>>>> I suspect that the alignment of the __jump_table section in the .ko
>>>>> files is not correct, and you are seeing some sort of problem due to
>>>>> that.
>>>>>
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> Yes, if you look at the trace that Sachin sent the module being loaded
>>>> that does the WARN_ON() is nfsd.ko.
>>>>
>>>> That module from Sachin's trace has:
>>>>
>>>>   [31] __jump_table      PROGBITS        0000000000000000 03fd77 0000c0
>>>> 18 WAM  0   0  1
>>>
>>> The problem is then the section alignment (last column) for power.
>>>
>>> On mips with no patches applied, we get:
>>>
>>>   [17] __jump_table      PROGBITS        0000000000000000 00d2c0 000048
>>> 00  WA  0   0  8
>>>
>>> Look, proper alignment!
>>>
>>> The question I have is why do the power ".llong" and ".long" assembler
>>> directives not force section alignment?  Is there an alternative that
>>> could be used that would result in the proper alignment?  Would ".word"
>>> work?
>>>
>>> If not, then I would say patch only power with your balign thing. 8-byte
>>> alignment for 64-bit kernel, 4-byte alignment for 32-bit kernel
>>>
>>
>> I think the proper fix is either:
>>
>> A) Modify scripts/module-common.lds to force __jump_table alignment for
>> all architectures.
>>
>> B) Add arch/powerpc/kernel/module.lds to force __jump_table alignment
>> for powerpc only.
>>
>> David.
>>
>>
>
> Ok, I can try adding it to the linger script.
>
> FWIW, here is my before and after with the .balign thing for the nfsd.ko
> module on powperc (using a cross-compiler):
>
> before:
>
>   [31] __jump_table      PROGBITS        0000000000000000 03ee3e 0000f0
> 00  WA  0   0  1
>
> after:
>
>  [31] __jump_table      PROGBITS        0000000000000000 03ee40 0000f0
> 00  WA  0   0  4
>

Try the (lightly tested) attached.

If it works and Steven likes it, perhaps someone can merge it.

David.






--------------2F06A5F2FED84D3DFBAD5183
Content-Type: text/x-patch;
 name="0001-module-set-__jump_table-alignment-to-8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-module-set-__jump_table-alignment-to-8.patch"
