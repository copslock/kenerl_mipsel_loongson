Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 02:15:18 +0200 (CEST)
Received: from mail-by2on0071.outbound.protection.outlook.com ([207.46.100.71]:32944
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012460AbbHFAPMd5Rr1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Aug 2015 02:15:12 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR0701MB1726.namprd07.prod.outlook.com (10.163.21.140) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Thu, 6 Aug 2015 00:14:59 +0000
Message-ID: <55C2A6FE.1020003@caviumnetworks.com>
Date:   Wed, 5 Aug 2015 17:14:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Paul Burton <paul.burton@imgtec.com>, <daniel.sanders@imgtec.com>,
        <linux-mips@linux-mips.org>, <cernekee@gmail.com>,
        <Zubair.Kakakhel@imgtec.com>, <geert+renesas@glider.be>,
        <david.daney@cavium.com>, <peterz@infradead.org>,
        <heiko.carstens@de.ibm.com>, <paul.gortmaker@windriver.com>,
        <behanw@converseincode.com>, <macro@linux-mips.org>,
        <cl@linux.com>, <pkarat@mvista.com>, <linux@roeck-us.net>,
        <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <luto@amacapital.net>,
        <dahi@linux.vnet.ibm.com>, <markos.chandras@imgtec.com>,
        <eunb.song@samsung.com>, <kumba@gentoo.org>
Subject: Re: [PATCH v4 3/3] MIPS: set stack/data protection as non-executable
References: <20150805234348.20722.71740.stgit@ubuntu-yegoshin> <20150805234936.20722.60927.stgit@ubuntu-yegoshin> <20150805235543.GG2057@NP-P-BURTON> <55C2A50A.50805@imgtec.com>
In-Reply-To: <55C2A50A.50805@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA095.namprd07.prod.outlook.com (25.160.24.50) To
 CY1PR0701MB1726.namprd07.prod.outlook.com (25.163.21.140)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1726;2:VLzzErugXpOzRU0qjfWuFLK17jVilkAms5n8KeIajLk/pMcaAKVSJGq2fnV6HzFMG6cKFqN1LLJVmMJmwylPs3bqm5StNTXRuIvWjcB8NM80WeVvpfAof7OGKrtNU0kZIkarB3KLSDfeRZ1e+RMN2QFAi2tY1fDmsqzR0YHqL6U=;3:8slx6q0rwGGi2dKkTY0GgJ6OxY4DDZzQiY6hgDW9fQyCOOq8CkDsm3ZB6fzYhWPwjBV18j9VhJuwa0He+/TMS6PVqTq43ruq8GheCuZHerbZ49t9i920JPpN5nhbdnK35IDwgolORKGEKexuiRkBHw==;25:gdtjIymOxyttdQG2XXEb2wZ9LAcLevUg6ScuoyTidpxmALQpiXOBneNgEepfmiScBLQHi1PSEOsrzPEV4oDGrqjas584xYKloTum7+4cKfvH270Ht+QoYXE7XrBsCL8kJDuwRgaxbrW4ddsEC5R+T8XfBjL49KY9o6nPhUnprm+IwLw9B89L2mvIqfygXlRsuMfQOXcB3x8YEI3SUcR06W5SVfJWD4XSScMVsSqMbTr8F6AVNZm9mhR/v0RLTo7dx7I5QBssv1dq7oSxim+8/Q==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1726;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1726;20:a+PDUPgrvECjGYOmA4Xe8gaUuA688i9DdgmDu8C/28EfChqD1fErpXpWKZPn/5/fErL5mQZwTAz/0pVkANrlofszYomux1AselsF/RELqgjuI89wRN/AGx5Sy83goU7oUpDPx9Dvbz+eiWNDkw7uMbJYjGpQ0bzt4LTfGgn1iob6MK/C3zanDlSN2UTRtveJFmfkgRWaojGKdoLAjGocZ3f4mPSlrfiQzu26Od8n0+NzNbVnO8E5JhAnxnFjhbzcgLVm+XP1igNOongBRrfjHE8wT/k8WtD6lpQUBlru+Sgj78k+WQPWLbWFmdiJ43ZpyTHYbYjTlln45l1XiXPgYl18O0chl8rHZr9eQDwYq7ImqbI93/aAR5HPK/OieCJivjELXC23EneYJIpCr6RNP4FCFKHwB9lBAw64zwtSE0vdWR+Ns6E+GdYUBIqMshyKTk9/+3C+dI5tU2a3K9p38GtK1ddWpNflqaSKUKeNUIkDN4Oek3P1vk6syWrfYfRqiFqeuPCMea+PJvntOgJYYZZZLIJ+UmL4xx/aMZ9RLgxdxlTyYiO3MMjN1hCDnDmaXQ//uSYvjFtrbgwdxpSmO3e/I2VviDMymC20RaGmEXQ=;4:9mD/LP1YDRzkA8ue1YO57QhnYZJQkhtv2n8VCJSjQCAdQXkzC7ZSdTC6OE/N7SGpu3j12gzDVTxxXSDz16CyeEk3+T6BrxpzRj/5/RqS0yVrTduCV4w6MDopB104IVbxNBfYIc5i6edLNWDcotRbr93O5jxefZ3SZuaWMbchfFGtPhh583DgDJniZKMwuOhLGNYXB8fpeoVx2RdcJIFymUWXFv4wU/kOGchoZzNsQ/qLo6vhw70EqPAZpk21o9xMJAy53rp2t3HQnaF20DM4S3t2TI+DG03pR4uHFHvNVo0=
X-Microsoft-Antispam-PRVS: <CY1PR0701MB17268BD4741C4DD2EED7DE0C9A740@CY1PR0701MB1726.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:CY1PR0701MB1726;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1726;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(189002)(377454003)(199003)(24454002)(479174004)(93886004)(50466002)(189998001)(23676002)(33656002)(83506001)(80316001)(65806001)(66066001)(77156002)(59896002)(64706001)(64126003)(46102003)(47776003)(68736005)(77096005)(40100003)(62966003)(81156007)(53416004)(92566002)(42186005)(5001860100001)(5001830100001)(97736004)(87976001)(65956001)(4001540100001)(110136002)(2950100001)(76176999)(122386002)(5001960100002)(65816999)(106356001)(101416001)(4001350100001)(105586002)(50986999)(36756003)(69596002)(54356999)(87266999);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1726;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3MDFNQjE3MjY7MjM6WTk2emFkZC93MlpSZTFIWjlXbDcwdlVD?=
 =?utf-8?B?UGlNcE1XN1pCc2VXd2REM2lRdVlyWlBjdlFIWERSMldCdG5KWi8vTW5IS0Vl?=
 =?utf-8?B?WE5GWC9ySUlGYzRrdFNnWG81SUxlaW5jMTJWa29UdVVOODVkR2hCUEk2cStK?=
 =?utf-8?B?WlZ3VHRXQXh3MU54azJERUVZWDFpbXpQQmdSZzNVSFBwTEg0aDlSL1lxRTJR?=
 =?utf-8?B?TUhoVStjMi90TzRreXpPSU9QU2QreWZvdEZuYURmcTF1OHh2MG1DemZ2NFpD?=
 =?utf-8?B?TXpacWpidEJpeGUzcEtOdFdxNXdLcWxWSWhBdm9OQ2JqVFlkU3h1YWFnbGlV?=
 =?utf-8?B?Z3FpMm1nQVIwaVAyNFhSTCs1enVuTmM4VHhkTUpHTlE3UGJQMUR2aHBzZ0p4?=
 =?utf-8?B?TVhGVFJyVm1rMkdCTkY5cjlRVC9mV0FFQ3hXYzVJMTBZZ3VPaEJyaG56dDBR?=
 =?utf-8?B?YktnQlpjWmQvYXhUcGZvOWJUc3N5TTN2SkN6SkRwWXkwOUxsL3Y4UjlXNUhW?=
 =?utf-8?B?YmRsUkdpYnhieEJsaitEbnd4RjhER2VYbFlMaVp5RWdtQXVicXpzWTFXNXZV?=
 =?utf-8?B?MVgrYnZtaTVsZ3k2bU5BbFZ3MVpyWEhRUGY2Sjg2c2FMaHlrSXhkMlo1QXh2?=
 =?utf-8?B?c21XcUgrSEVsTEt4QmxqN1dwbFlqK2xnSTI3U2x3eWhIcWZHZXlrVVgrVmQ3?=
 =?utf-8?B?SFpEVVE3NnlRalVYODNXYVc3NjhyRkIxdlBIaDFCM2VJTURMSExXVlNWNlNo?=
 =?utf-8?B?VWp1Mk5YazNLNXQxdkczdUhaTzgvamdwYldZcWYvUjVpR0pQYWZENFRVbnpj?=
 =?utf-8?B?RzFPZHBLcUg0bFY3VnRnRkl2UFNLRHYyUWlMbWtDVFlwc0d4cFUvc2ZTNjR0?=
 =?utf-8?B?UGxxS3RqbzFyMHgzZlJmU3BiQ0pBSGFpRjFiMVBJZlh2VDZiVmRHSW5zbmxH?=
 =?utf-8?B?QTVYdnk5S1hodjhFSjNiWVpQUE0wRElXK2NZVUVXZXRlRjhjL3pscFBtZWlM?=
 =?utf-8?B?ZTYzd0tVSElQTlZCT2lWQUFteVVFZlhsaVRXdjdpd1gwVG1GL0dQV0liRFVP?=
 =?utf-8?B?REt2SkxjRVdzMStiUFFFbis5bHAxblNUUjIzT2ZxRlRHVkpEck5yUUlURXN4?=
 =?utf-8?B?WDFJbzdxVUhpdUxDeFF4VXlrVkhrMHVhYjR5SDh0ekl4ZnFvZ3dMMVJjNGZH?=
 =?utf-8?B?bjlReWRWcTRxK2hDOUlvNDh1NDFOWGx5b1pOVnVjQ3BWeHNQL21OQU9IY255?=
 =?utf-8?B?cE5yK2xyZkJaVDZYcmtnRFU5NmdjdEtNSXFUMmI5T0NYaG5UZTB6Z3kyL29Z?=
 =?utf-8?B?cENYTy9XMm02ZE53dGdBczE2clJSK3RBSkd0bklFK2lEd3RveERVNm5zN3Uv?=
 =?utf-8?B?cmRtb2hpNGNrejByVzNnS1l1NnU4UVVwckpRVStZNXZTeGJ3NUdQY1FRWVQ0?=
 =?utf-8?B?Y0NTL2VvajhIZFo0TW9rRkI5RUovOC8zcnJOUEFCajlQWFdDaStYK0tkaTBt?=
 =?utf-8?B?OVRZK1E4akdzc0xTM2kxOXdZQTYvTC9reHluN2tIditOYWRCZmgyeUNVbERI?=
 =?utf-8?B?bEo0Q1B0K3lOckpMb0ZkblQ3UnVxQ2VGR2dxMVlyZjB5Q0sxSHl5cFhFTG54?=
 =?utf-8?B?VU1ib3J0WUtUK2x4N05NYm9KOFY1YVJ6UWJwVkVHNEUwd3lwMEhwT3EraEJB?=
 =?utf-8?B?VHlVSmM0dE1ydlA0YVZxb2FzN3kzV1NnbDZZUWtObXQ5VHVqSUQ5cWJNTDZ0?=
 =?utf-8?B?UEtBZDh6aTk4RUtQb2VwQUJBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1726;5:t/LAWkbBi+aRz6kvKM4pYV3VMd3Ye/bJ+T3+TV9dPqJ2KZJ98lDnNa6rNs4cH9N6WuZ5z9AC8vKcclLg58TJO+pbaO31q1c3rtU2dORfKDIe9WPm95Bp+u0+FMvuZ9orfS/Ve5pmZhz0Yr4CotmcGw==;24:K7oATzd+SUITdOlC3r5ZXd55no1rvAWQtgK+Ak8cfRRiqazgcnETGvJxCQLkpYpfH53SYxbK3WDdxh+nfrQ5m7y2jzfG0UhzDwPVynV3jPM=;20:b1ESCqSMy+8nlmgWZm7ELYqD0yqVZUnl/uPBCLfWydNiI0Dj76iO5y4ZOelUwxDDWsR+5WFUEJDtcjeY6qlqoQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2015 00:14:59.0523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1726
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48638
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

On 08/05/2015 05:06 PM, Leonid Yegoshin wrote:
> On 08/05/2015 04:55 PM, Paul Burton wrote:
>>
>>
>> As was pointed out last time you posted this, it breaks backwards
>> compatibility with userland & thus cannot be applied.
>
> Never observed since first version.
>
> In other side, the problem with apps like ssh_keygen is observed in
> absence of executable stack protection.

You cannot change the default.

If your ssh_keygen is broken, get a working version.

I have never had a problem running ssh_keygen (on platforms requiring 
emulation).

>
> - Leonid.
