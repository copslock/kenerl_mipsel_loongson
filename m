Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 18:52:57 +0100 (CET)
Received: from mail-by2nam01on0085.outbound.protection.outlook.com ([104.47.34.85]:6043
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992240AbdKGRwuZTohx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Nov 2017 18:52:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8Ynh3o8/8r85gfyM4a8zJi1ry/H0QBVxAmXnqy4v+bU=;
 b=Gb6Fen64bxFYCB4IE2vbGUIYCwD/W3IBr+DF3oUERfUP2srU9/Zbolo22IdCVFKuNDQPEDa7mhn0TM/Bl/H4sZhZtf3+so7JGQkPPNSsI1oygSxHK1LPjF+n1dtnV0Z9reYFSJSb0Hegi87MlexFpkYF8TbTioZyLatXiPN646I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.197.13; Tue, 7 Nov 2017 17:52:38 +0000
Subject: Re: next/master build: 214 builds: 26 failed, 188 passed, 28 errors,
 6333 warnings (next-20171107)
To:     Arnd Bergmann <arnd@arndb.de>,
        "kernelci.org bot" <bot@kernelci.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        James Hogan <james.hogan@mips.com>
Cc:     Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
References: <5a0159b6.08bc500a.ebe4b.25c6@mx.google.com>
 <CAK8P3a3QKkGv6eSjX7wH6LpOY0-1XUPFoX0ntog5-ZSHPab6iA@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <2a051ef8-d383-ffd9-e79b-34a2701e44c9@caviumnetworks.com>
Date:   Tue, 7 Nov 2017 09:52:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3QKkGv6eSjX7wH6LpOY0-1XUPFoX0ntog5-ZSHPab6iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0090.namprd07.prod.outlook.com (10.166.107.43) To
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d51f35de-2d96-47ac-ae0e-08d52608565c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;3:YGYfSZ3oNmR4mYy4UqKoUOrS7ZYxHMiuyo6/Zv8o063QQ7SOOW/2ZrORodznk6jWPtZ2SJr6+gL52nnzjkIAHdiBaH/4kMSC08Q/H2Lm9bXtum3D37qnfocJVG0OQCaqqoH9bRURd38f7oSXUXSbqz3JnkblYDsLWB0wxgZkpixCCcTXtNt4p6N09EyeptMXoKxbaT7fQXtYbNqPba0uuRAJc1BPgmk6RZEsL5Jw5RmHTXNT55eORmOtOnabvUCS;25:emL8O9QlGCGsrYfNlek85+4mZJJdchBfMw8fa5w1yY2O05VRwEufiBEYJm8kX+uPMR3n7mzTON5HiYt8OVSZKA0aKG014x7lm2iFIe/UWbV/oJnB9661hWLCIzmY/linFxxRyQU5rsuA0R7fqFiKTp/Nml6GUIVPCXeB9vYkJK1vLh6DMK3beGUeRK7Zp1k8y6RKTXvWEkuMvdq2HpwnA+DeUBH9puDflQGZpv4IoerMQO5vMzgLY4x1OAUUjKInl9oPsrKw1zikDnI2c9oKW2TUOMQViXxDeexRw+kc11KsWCcncv4hJbpO7ccE3o3WNFwe4ynuiCYckUH2NyM//Q==;31:ey9dYUQv5C2pOjd41JzhZ2OmPPPYByHv9KN98h2ka4CMuKwEvaivVz7tj+K5m/LKajiCt9igpOFhzEEzDYmuz3BUQ3UQeJuKKVw7vEdnmsXtKny73xhECqHw14ERDdIJhz3685vCMgRrcRMulVLItVmpsp6KoI9zGrR1epk3gZKtsaFHvv5BR8lw5AuK2RPPIfN0kABQdYXfbyw8VBnDv8g06EGi4JjszcsZe+vVLN0=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3497:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;20:cfi9I2WRGQO98RC53UgChkbhkys7GZ9mjqxIBoAqzyGH0ZrD37to/hOZvFo6W17CMGriZzyfehxmhFxPqjkgBmW6cSUcoxdpxeOfcQYVwe43mljHpGZzUEiHyGhedru/qUHeEGKmr58o5lvZn/38wW7Xgu4xI6Qs9kiOlkAo8zkEYA0FdCb63Kq75OX40BsobhLmubMrvfb+7CMeHV4EklckJUhqgxT+47Fvvr0S/gVDYkOlZDouWIHKQcVQAk3V/4TgHa1zjHXEU6+4MD2IKx+k+Aek2yqNw5IPiQrCKJk/NeFNDQDSuDdR6A9/UIO3VvjaPgFIVBTYfjF9yiuBkOtRSTFbuXxxyAVNQ/GxT1p/ZMqVYA/JYwxZr0jSDX21Sc/iho9nBhLbBWnrXilqg47+nPd7iTUmV0ltXaSvrvltMYWCsHAf53tQ2twbLW5IlCum8AqZVU14kiG//JuKmj1wZyL6K7+p/8fDaST/IzX1j95QdNElc61dicJBPUlbbokKFWe3qzrb1RE0M+lr2LU1ZFgLkZwhzlN2NV0YgALh7r7GIaiPq7b/DD+riM6XXqZK0PLohgRSsRyRHqDByVHgGctMEmMLrPdcczVKXEE=;4:7npaOmiTlJxKuMGOC1FsSZTubwPZxAjNLdEfj0Akt3mf9UejMeji03RoysT4hPy4h3GGEumKqbVc3nFB4bw7zt6GOaro9a/Qi4n2xcGmuz6i2G4n+tVOPfkWetlZabllIgGRYHyf10hJOdj+zlHgHJHuytU/5jJNZhWb37LrsqpAciD+93jH4lvNGlq3nWnMMVUN7TcfdeyyiU9qHLmrQ1koxuMc+u2A+fVloAKpgBfwbpvj7NWa1xl/k45tgGoDiiPe3db/4eTm7zHVjmj2FA==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR07MB349726EC7ACFDACE82C1E68B97510@DM5PR07MB3497.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(100000703101)(100105400095)(10201501046)(3231021)(3002001)(6041248)(20161123564025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3497;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3497;
X-Forefront-PRVS: 0484063412
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(189002)(24454002)(199003)(50466002)(72206003)(36756003)(6246003)(229853002)(31686004)(6512007)(6306002)(53936002)(101416001)(6506006)(6486002)(31696002)(54356999)(76176999)(230700001)(25786009)(68736007)(8676002)(97736004)(50986999)(4326008)(478600001)(81156014)(65956001)(8936002)(81166006)(67846002)(189998001)(66066001)(65806001)(3846002)(6116002)(47776003)(105586002)(58126008)(54906003)(106356001)(110136005)(23676003)(33646002)(316002)(2950100002)(42882006)(53416004)(16526018)(966005)(7736002)(65826007)(69596002)(2906002)(83506002)(5660300001)(305945005)(64126003)(7416002)(53546010);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3497;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk3OzIzOmsweURrQXFnalhKOCs3MkdZaGw4MVBaUnVw?=
 =?utf-8?B?bWZDcjF0OGkzWEg0V1Z4MkFxSjE5OTgyYXZmSVdmSVhFQWpFUzQxUHI4ZG5n?=
 =?utf-8?B?TGpyUWZGK2t4ZVZFUkdsOGJaTFVzVkNVb3lBUWtnSVNJdHFyU0JJTkNEeWJQ?=
 =?utf-8?B?UlFwQXl2OVQ0ZTZTYWZRTm9HNmhEUUxTc3llRFdFQUNsdlBwaFZOYU4wQ2g0?=
 =?utf-8?B?WHYwT0FnbTBRTkU0MXpjSEZ5aXllQkd2V3VXQ21HaVhKS1NPd3RNM1NrQjlj?=
 =?utf-8?B?MlJtTmJrZFVDOCtRZjRMTHZ2azZIQnlwM2ZkZnRFYko5UWE5WmRlcmVxcjFx?=
 =?utf-8?B?T2RPN1o4TDNPQ1E5UVk2RDZEckUzOUQ2ZkZEMVBuUlkrL3ZYSDhqUzB4SThr?=
 =?utf-8?B?Z0RaSjVxWlVjV2Yzem5VeGxySHExSks0cHNvdklWTm5zVHBXc2xER3pWbHBo?=
 =?utf-8?B?UlFLNk0yYzQ5Tmxjd2dydFhFS1VJQVZ3RnlFWE01aFVWVFlsQ2hpVmRvZStY?=
 =?utf-8?B?a203WWlPOWxGYWNCUHNrK0VGVmJpWmYyQWJKUkQ3Y2Jsa3ZkWitrUjRtaGVl?=
 =?utf-8?B?VGVPN2IzejBWakM4Q0RnZWsrWFRFeWFySGtRMlFMait4dC9xaG13Z0ZGZGIw?=
 =?utf-8?B?MUxHTWxNUGlEV0xWVzZyTVYxNzhKUDNFOWhOb0FaYm1kbDlvVFJubW1Temxh?=
 =?utf-8?B?RXRRZ1hMZk02c1lCek8zOEFqcEZRMWJBL3hPSTJlMlhUUllRSHdPbnpIditC?=
 =?utf-8?B?QlFENUNiRTJKU2c0dVVuZndEQkExa3RQcFZLS3FlMUVCQ3plLyttNFBNaWpD?=
 =?utf-8?B?QTFVT0N2MjQxcDRna21rMlZOL2QxTGxmTC9wK1dFbFQ4NnVHZXVyVXZrdS9v?=
 =?utf-8?B?czY1eHRjc0trblpxSis3T1JlVTRNVFRoRmNuSzdLMTRVRmJlV3BQNXliejd1?=
 =?utf-8?B?UG5SRUladGF5YTRGMHFydHZ1Qmd2SWZlZndqTlFUY2FhRUFqeWgrNVlZTkFo?=
 =?utf-8?B?T3lMQWhrS2FaWmFTVGdtQWwxcVYxcDNwZFRlRERVaFNPbTJlMGd1TVlaeHc1?=
 =?utf-8?B?L05vOWVXV3h3blhMS2RlMVliMys1VDJieml3dlZMQzNrdGRjckZvUnh2dFFI?=
 =?utf-8?B?UU1mdGR5OG9PQTk2RE1ab1Nrd3ovancrUlFmTnZsb0NUb3ZvQy9UQnI0ZVNl?=
 =?utf-8?B?NmluL1QzSlJUMlc1Qzh2Nk55eXYyczBORm5GZlJRNklGazFIVml4OXJYUU5Q?=
 =?utf-8?B?WHYvbktYZytTNXBqKzk2U0dRaHJYSjkrWTdiWXl3dUJITWZXSDlCdGNjOC9Y?=
 =?utf-8?B?Wmp5TktDYzB5Wnk2LzN0RXZNZmlrVUU0ZDVpRTVDYnA3Y09EUU91SkozU2p6?=
 =?utf-8?B?dm5QVExscDE5amh4UGszMTBtYmFkZHovUmlWaFMxdi9rRGh5TTJ6SzY3b2kr?=
 =?utf-8?B?eDFBUnJncHBqRzErRk5aYTNiVjhMQUhQLzh2VHNmekVLaERpbkxkYXFnNnBH?=
 =?utf-8?B?dXBqaGlXcXlTQ21BeE9YRHRWYUZwaHlDWVM0cUJndDl4am04SStUbXpPT3dL?=
 =?utf-8?B?RjJkOHJ0UTBpTVJjV2ZSUTJxeW9DUmtWbUdYbjVpQnJCaXpQOENwUUEvSWlM?=
 =?utf-8?B?RTIxeHFiUDk3d0RWeTN2M3ErQWl5Y2NNZEE5QUdLSG1XSEZUQm9hdko2UG1y?=
 =?utf-8?B?eGJJM2M3bGpXSmpRdzR2dUZ1SVdaUkhkYm9uWE93b3k1WXVVR0xyVVZpc2o5?=
 =?utf-8?B?T1Jtbityb21rQ3A1bGFabkdmenNCUzF4MFFteWpLWHRCSDRYaTl0UXg1STNV?=
 =?utf-8?B?K1phSkdZZTZHenIyZEd1akE5UUd0RTBIajhub2pmSjlDejlVQ1ZhbmxlV0RV?=
 =?utf-8?B?bTlJSThaVVlrdHcwbnFPMkNnWDNBWHk0MnJXbDg5RlN4aWpRL2pjZmJadUM2?=
 =?utf-8?Q?EACokeyRgOUEGHrN9neOn+w2jWTyfo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;6:OAQ9FmhMFF5FzlUkHWbSZkoftrAZJac63MyZ448z0HqbcOtOaQI1OCrnwwookWr+gl+WPzk5HylVYdC/N+TuHOtipA3ppY/R5AhIozTx3FyQu6uhIwZXlN+QQd1tumhYHY/hmcjarD8BPDPK3qypisnxvpAlDtYLri3bVz0FPAg2R9X7bpz8dr0IQKVNwuL/D/e3yildnduOsHB1mbix+w+/v7bt2i3GO0SYe92YjaMGz9QV5G6Nm/KNWRlG8OAG8f/c/pYHnN0Fw/kE4Y3gWXPu7YD3QRzDEPqPMhzoSDJ9kVSkI6R1XV95/lKeBNOsbodVpIGUDX0pJzX//ZcSBO6vDFD9uTuNBI+bxyeKyQk=;5:0vBPqvIUcRLp7sTnqWoHVeyMB+vH93dDDIonIqDtC6jJniAObro74X5/UJjSU775A01s/nN2cfVLT/f7n4RECUAVZkvGZ+3x/JhK4vvHDFNRkXDTp5FQ4MYAeiesJxVGuqv8e4KuilrQ8kgYn+4TFLe12Z/foQtcCCQ9czsxCWM=;24:KajydWy2la5g2XtO8KJ9zvNhFX6jvfrNPSRZL8zdSCuqcgEjlXRcgw1uN0UKDKf+vFfLlzr2FHJfY7V4vBRpGCsDrXOYWNTiyJ8/fBxMBc4=;7:fvoWlxAM/u9xTyjPtMpKFFqfTQzgdFtFt0ds3LFH1AVAkamv+02CuRBUQVr8BRlr5QfKLAngvgBCPIshedhjnI7rAbwkLPpdsqnoMxYrnuE/e8tfQ0wyru4EjtnvpifhB2MhUiBwdMHcppVScNlTEfCzLALoVhKAoCqHNBUmi5nBHK1FbdJ9x/WT7bset5hJwiHetRh+y5UHL4ug+Dnkb6rM4OpM9c5fieBI2gk7wD7e7vYFznxqJy1+kd9rjyXV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2017 17:52:38.6486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51f35de-2d96-47ac-ae0e-08d52608565c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3497
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60749
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

On 11/07/2017 04:15 AM, Arnd Bergmann wrote:
> On Tue, Nov 7, 2017 at 7:59 AM, kernelci.org bot <bot@kernelci.org> wrote:
> 
>> Errors summary:
>> 20 arch/mips/include/asm/smp.h:32:29: error: 'CONFIG_MIPS_NR_CPU_NR_MAP' undeclared here (not in a function)
> 
> I have reported this before, as did 0day, but I don't know if anyone
> is fixing this:
> 
>

Yes, Steven sent a patch to fix this back on Oct. 2:

https://patchwork.linux-mips.org/patch/17400/

Ralf seems AWOL with respect to this issue.

Perhaps the alternate MIPS maintainer James Hogan can try to get the fix 
merged.

David Daney
