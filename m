Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 23:09:14 +0200 (CEST)
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:46240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991964AbcGYVJCMAXwo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jul 2016 23:09:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MZbBg691PmJRW/0idSTbqJMmbjLoUIbrS9KFP9cPJF0=;
 b=malzygkB6WrMbjqVnW/+zTdj1wJz7pnCzf16jQv6PI/LjvBAJCQwEHm0hXNHP/gDso26ByEXTS9KHQwZEzhdmbmQ9B/nTzBitbkwjyTqoFNFGa5C+bIoEyaGzfq6ZjuNJu5BEecQVeo51B9F1EjDAL5wqnwblPL7LPdQ0Tlf7N0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.158) by
 DM3PR07MB2137.namprd07.prod.outlook.com (10.164.4.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.544.10; Mon, 25 Jul 2016 21:08:53 +0000
Message-ID: <57967FE4.4000405@caviumnetworks.com>
Date:   Mon, 25 Jul 2016 14:08:52 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@bethel-hill.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Remove forced mappings of USB interrupts.
References: <57967A25.4080502@bethel-hill.org>
In-Reply-To: <57967A25.4080502@bethel-hill.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.158]
X-ClientProxiedBy: DM2PR07CA0017.namprd07.prod.outlook.com (10.141.52.145) To
 DM3PR07MB2137.namprd07.prod.outlook.com (10.164.4.143)
X-MS-Office365-Filtering-Correlation-Id: fe57b73d-747d-4ab5-f987-08d3b4cfe252
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;2:fStqmKTcjdPbUQeYsYnAhUDqT40VBXTmTqRSzD615k7FhBUxif7lTwiRrEwWv1kstCHLnQIspOruhD4pPMExOCrF3Z3fXlPvtP7OMrC9Fwpeu20SG32FkoAF7YcLD6Ef+0xctCHymRldr6slTLZJl7rr/npoVL8IfrCM9JEQyJihlmM5EN+zfzR/Oc99beNt;3:NGg5+nNdVlLulMe8wPNAYNK1NF78YlCf4wyOp5RfMio937MVsAYxDV1oM8C1/k0fUJ6601u/RxBCtpdmWwKMEmnX+3dyJcsI5vckq8FnwQlumFkC5L3FgcEw11FpxxJs;25:qdNqGz+NsXxn4JWeEBubFe4mon+9vTWSmYRAa2H+FK6OGz2k5V3CWH6zBeIS2SE9O88CBomVhvgwD4rB66vx/V++N35bRxt69taca14M/3hFJ9mghMFL7hoRf5Jx/ldZKWnElEVJfIcsPW3wdSKl5xTSb+4/LihTp50rVoo32VKaOun7+nGg76BFXiPs2qqlZiR8S5zzgtNJFfZJRhA11lu5DYv6KTNtcbGou8Ap/ps0QjZit62QtTHz0FKeqyxLKMtS5xYhL+uVnrWLC9Yh3uSDD/wcjhLNWld82NasOX496YewfpNc2CzjxIAkWvqs/hdCkJKEd5ZKWR44J5hFnyW6NTSv7Np3RNbDE8Auo8Uz9vY8b+EilNrLuYj/5vBgjiWBO09Z+PhfyzqhqWcsx+zeXXobwZBwt8dfV5ndEHU=;31:nnSxGCaF5MNF4oL4XaoghdEiqT4HEGSezHeO872B/X5v/TaqvmYFowMBO65rXvNLyg4OMVve8y9R0esVM93Z4zpE/c+Li5zqZ8Uw9zZWxNzDARilq5Vu75K/Wkinu7+ss9U4zzKoQCgqP47YJllxCd+20bKQ4DKsPRBmvgP0yPOMP3wHKDYrEWQceolpxKR9M1r69IkDuVnGMTtW1sW/lQ==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;20:Kj53cRUyJh9ZKaUUPhrzunb1GgVodjWRtxzkzbeqS8MnEBbR3HHwfiL3TwWz5C/7p4cQrL9Gr4+V1ZOYowowu34nBgArcoNA2QSh+plq2QIbRWf1jM6m6wVC3aBgMQP2ZSQ4O5vulNHF5omO7o16GcBdpJa33wWnDyBq6qAl7SXvbys3GhpxZdMTWH9iOV8yXmB4gzLFWXmRXOsXc1vdP338OyHFy9dLD3L21sV6sgAAAB6xkiE4j0aWMWLvjFGvIx5O6P1bn/xIVp6Wff0Rlr1+4W39qdC8nMQ6J+cYAWrrD4C6MOS+g5sSulQrabllKxZWQTGdFNp4pbDlE75v2bH4bvr+2JdFlzsjYaGHB0/o0jbi6BL4UkuWFwyArCN8eVJT79jSdNwCd+NRQ3AQobD+QpDjhBVTy86vTf1r6QGz2rOBudRC13dwWR8heKwGHek5I+QKD6QK1XfOAV0igPVVcB8+fh+eKotuBPf2sWOdo3omCxy3xX315o/8jRR0Qz6GIC7/P+VVGpX5sTCrHWFmnV1K0sfsLu1pQ7H1Na4CinVOYlwyE6NrSCHWFtLp6d1OF/4Nok6upowp7X0MtSzqhO2GPaKxVjXPw0e2nC0=
X-Microsoft-Antispam-PRVS: <DM3PR07MB213719567F33D30DAF3977E7970D0@DM3PR07MB2137.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:DM3PR07MB2137;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;4:3emQ2wRpxt45dPe0uxJeIrOOKMcjNZyGjX8xuDJCIvP/+L3T+hwbfrhE9N/0DPsmolMzIVae69wTVrtIfR5aXWOQw6tBzm3TMaSruliwd+P9sFK5TyRn221aWlO8bhrWoCXMUK12Zk5/AwnGr5dPeXGpRpqIli7K8mXzMdgFsCIDwGXeKBAPB+6G42gYmM859ymQxatKXm43D5ZytXbTPoK/BQwGZ509iX9kOQW4y2uWd6R9nDiBka9Rxgm12OWEaSOMdEUeVyv74/xUnbXiMoPe7Le2iWp1cVAuT40OAZVTVSJz34t3PXzhgl+Ky6Ec56pXLIJuE14VRYTYxpMwquZtFkeojB7UFipkm2y0urS7/gc285YLiOHEjPWAfZCG
X-Forefront-PRVS: 0014E2CF50
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(24454002)(189002)(377454003)(65956001)(42186005)(59896002)(66066001)(65806001)(47776003)(81156014)(81166006)(4001430100002)(64126003)(230700001)(4326007)(99136001)(2906002)(92566002)(36756003)(3846002)(77096005)(87266999)(50466002)(97736004)(4001350100001)(68736007)(101416001)(50986999)(54356999)(65816999)(586003)(23676002)(105586002)(305945005)(53416004)(83506001)(7736002)(6116002)(106356001)(107886002)(110136002)(7846002)(8676002)(33656002)(69596002)(19580395003)(80316001)(19580405001)(2950100001)(189998001)(76176999);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2137;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjA3TUIyMTM3OzIzOnZzaUlGVHpGeFk3Qmx1WVFZUDNFcVV4akhB?=
 =?utf-8?B?cTJqbWk2SVhjQUNRdVFDcS9WRWt2NklvNFZFUmpzbCtUMzVNTWhoZ0R3bWk3?=
 =?utf-8?B?UTJyTzZ5eEFDZ3NHcFphb2wyVVA3Q21PM1FueE1QWEpzTncwTWYxc2hNV1g2?=
 =?utf-8?B?bENLckRlNHgrK3NZY1hyK3BwZnBZcHpZUXpEKzZiQUZIcDdOWUxnKzV5WU8w?=
 =?utf-8?B?ZFRQU1hpRFdWeno2SXYwQnpOakdNemV2MEZCaktnV2NKMGNBcXdQY3VtOFRF?=
 =?utf-8?B?UmtIY2gxcklQM1FxOGF3ZFVqN0xNcm9McFlpR0lYTEp2aGZiQVF0ZVZSMHU2?=
 =?utf-8?B?NDljWlN2NldaeTJmYktGdWxrdCtiTFdSTTVLanZHWXhuaUZlYTNJWGZVbTJF?=
 =?utf-8?B?aXlHV01mdEhMRUJiK1EwZm5ZcjFkVXlQQk5VV3BZSHBLcGlyN3oxOUFqUytU?=
 =?utf-8?B?eG8rSkd4Mi9QNmxHUEdEQ0ZQQkJGaDdTUVlGWE9rU0FXVUduejU5cUtIMkw5?=
 =?utf-8?B?VG44Y3hLcFR3YnAvYWhTYktpcVBPcEE5U0h2bWtMTkNOU3hBa2ZwN09UU2lj?=
 =?utf-8?B?aEUvSHdwc3NINVFxa1NNbmwzN0dpVzd0SFlFaWVPRGpaVCtNNWVIRlFJQmpL?=
 =?utf-8?B?VVp2UkRtaDN1UGExNmYweGpCT0l0VmliQlNxbUx1MVN0VDVVUHcvemY5SWJE?=
 =?utf-8?B?N2ZzVDdBTUpIZmo2OTlZOFFEa0thRW44UHU5UXg1bm5acFNhbHdBcE9nc05O?=
 =?utf-8?B?VzA1VTNucnVUMWFwWFdzMnBIQWIxS3NBZG5tQVdmWWFJTk1CWUlGSGhUUTFu?=
 =?utf-8?B?Sm1qcUlZQWtnaTRwelBFbEszc3J2ZUFiVUpXMHdQd3ZxZkNWYWRmQmhqU1FD?=
 =?utf-8?B?VlMrVW5wVlJSMk1tRk5SekY5UFRHaGExWWdoVVN6S1RxVDdDWWc3NXljcW1G?=
 =?utf-8?B?em5lVDhoNjNUS2FSTnBDV203Ry9sYmpGWFB5eUJOa2YveGFsTTM2aHVhd2dI?=
 =?utf-8?B?YUVUclRLa2U2N3k0NUowTDBaVW9mampZOUZaZVVYUHV4WTlLbjJQSjF6MVBJ?=
 =?utf-8?B?ajlFMERXM1NSVnAyT3FwZE9sSlh3VzQxdUVsRjVGWkdJa0VPZThqblVXeERX?=
 =?utf-8?B?U200T0NmbDF3ejJUVXV3YkJNalpJMmdodUIvbW5aOGRieXFVbHQrQXF3TDQx?=
 =?utf-8?B?Um5HSitxK1lYZmdBVmdZTUhKVmExcmRhVWM4TkFJWSs5ODdLWkk5QVJNR1d1?=
 =?utf-8?B?eitFYUUrdUlpcFpwa3BjUTViaHdPMGZXQjRrWHhoT3I4SWxrb1RxeThTWWRD?=
 =?utf-8?B?NE5xNW9pRFc1WUdLb1pkWUtUc1YyUDVjRWsrTktVeDlWaE1vREdHTjl1QU1G?=
 =?utf-8?B?dEVFMWVFYURJWUkzaEpCeUJtTVZEWVJmQ0U3MmQxa1AwVmdxbnkwK2VqWFZr?=
 =?utf-8?B?UHFBb2xGdHVDdEI2OXpaZ0EvREZ5WlhBMVZkczhnQ0tUVmRqMmdiRzVBaDBY?=
 =?utf-8?B?TkxrSTkxaWRKai90QWdONlE1VC9iYWNjenEwV2hDbUVraDJGVGliNVRnaEow?=
 =?utf-8?B?N1dRRzQxenNRQlRLRmJreUhXSnJibkM1d21Dbm9LK00raFloekhHSHRxcU1P?=
 =?utf-8?B?Q1puNnpHVDZ3clEyWkdjcHNNVVRQaGRHNEFQMi9RU2YxU2xjUmtBUnJ6S3Y4?=
 =?utf-8?B?MUhnMlZVQ0t1Rm54dnJVUUt2blBVNzU0L21aZGRzU21OVWZXeWtOL2hLOTh3?=
 =?utf-8?B?L255dU9tRVdQbVNWaUtTYnJxTjhJQzJUWEZ1RVl1V2JMWHZoT0pISUVURlUr?=
 =?utf-8?B?NmNRQkJDYXQ5T1lFWGJCdmJDTC9SN3p3OVRnNUhRMDhIZHc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;6:F9+bj/xg9iHwG0hUcCJxCGGyTuxGV9jLagX7fnHrFGTYDEpOsjnvG9XrGWmWGx/ajvw3O3xTLfbR8cItOfUt8dGIj/HUq8ReBZHYLEsJAy8PR8FplQd8k5xVSksbzTDdyr79WMRz+VD6N1r9lVjhtJxn/3e4J9uH/V+/yeZwNF19PUGbIY0UTCSWu34259naZtOa3ffaNBy5gCiwTYXhWfdNyDIks2M7j7D0xn7or0rezeciInKNUTH9XI7obNRbOTaI6qlsXSY9NHiv1DPJeDQ05Sfj9mSf/B6W/2q0km8=;5:6h+rwsm8I3Wr3o2y/QRLyIwtcBJD7ZJTU6kFwt0qyPENw7S8ymDpVFRpzGwOEYOh0TvrqNukb8SFz7M4yAz/6YcOTzemDAXnqgO3eWLinnrpwufwuKuXILLiVlPwYFTGtW0mjNLCkWkaUy9sIITbgQ==;24:DIZRZGWsHTtre9sGrbvyOaT9i3lUBl7bcJ6NKjO/q1HRtpevS/Fdm7MuLs5mykCJ7g9C07KStQbvKKoKSB7ldt8k3gBm5l05cV1sCbV1asA=;7:uf5xiofOG20E7U9t/x4ZEVn3h8xi/HeDy68ezPq4GZ2OYezsC7RNejYHrtaQjLo9vP4dLNbUJvxpHTKx6KaKUw0HR4b1NozR4E6R+th75Mz4QKuqJm0+6KSw0clgi294azngvF5GGoSpWVXa780/L+IewWlmdD6gYxEpXS1WGRQpmtxGgHXHRgwmo8i+UWXAzuikFOjTD05xVXz8/gas//4TLSCDs75q4Y7qTvp13GR2V4Czm3icni2hhU/63d1R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2016 21:08:53.4367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2137
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54373
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

On 07/25/2016 01:44 PM, Steven J. Hill wrote:
> Get rid of unnecessary forced interrupt mappings for
> the USB host controller on OCTEON II.
>

What makes the mappings unnecessary, is that the corresponding symbols 
are unused.  This is essentially an exercise in dead code removal.

David.

> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> ---
>   arch/mips/cavium-octeon/octeon-irq.c           | 12 ------------
>   arch/mips/include/asm/mach-cavium-octeon/irq.h |  2 --
>   2 files changed, 14 deletions(-)
>
[...]
