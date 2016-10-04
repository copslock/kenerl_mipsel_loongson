Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 03:19:20 +0200 (CEST)
Received: from mail-co1nam03on0089.outbound.protection.outlook.com ([104.47.40.89]:19648
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991172AbcJDBTMzDmmD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Oct 2016 03:19:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UuhBOBY8VTm7NBC7XW6ZOup1LqLYPJRwd5xem8cmlcc=;
 b=NfBLEE05Np9w1ZwEwWSfIGBB00z7t+rUz+X4Aefg65Ktr2mWbPX+3Q3VCoRInIxFpySrQPI0rr4GuSNIrGmh92XfAgqgR/Lg7wMP2oXFx9m9fCTOhq9hXJX9O7L0mVPojMfcuJcwvYytfmYQo2qfJofaPAoloR/zO+f3gW3IZms=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 DM5PR07MB3210.namprd07.prod.outlook.com (10.172.85.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Tue, 4 Oct 2016 01:19:04 +0000
Subject: Re: [PATCH v9] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
To:     <linux-mips@linux-mips.org>, <linux-mmc@vger.kernel.org>
References: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <c1d0ccad-10e2-9d5d-8192-2bbd7d7357b3@cavium.com>
Date:   Mon, 3 Oct 2016 20:18:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CY1PR05CA0023.namprd05.prod.outlook.com (10.166.186.161) To
 DM5PR07MB3210.namprd07.prod.outlook.com (10.172.85.148)
X-MS-Office365-Filtering-Correlation-Id: ca7c37db-38fb-4189-eac8-08d3ebf46e9f
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3210;2:3wQIQwMHK6a7Lf1Ewk2UhCCNgZGnL6aTb4fz5DUrZQuWlJA2sDughdXzbDjolFkxUn8i2SPiuqB6JcEHvrdpr5F4Pa+xRYtrWJ8lX8YScO2fOVluBZQnzsFvhGHOZVMk021U/9U97a61zNAlkfraLBkP9sCIsGQ6jNoXqYxak2ikZbFv0r5Pm0ieKqi3FZ0S+by32dyG9bkkOJpEVTKPGA==;3:IyCcR1VieHgdjAEy43pxg3dOd+IFyGRY2MOZqf10PRdb7MljmnDRmlbafXSeJhrP/nzFVvGtcyORcqF/otdo1Fqt5F4QD/9WrRl2hOBhp/SWWTptkHtROy1FY2NnKpTyKPUyeTs9wfFGrB6St/bHbA==;25:4DxBz3s4zTVt9ulwq01slQglP0Z5pGgbOTJ8eur/DwCfVmonITVXQKAXI714S2zL3LrNvz264cEkymyDLJIb9182WvNnbGs2qtIlmqpdEAz8NARROsYn3iRJu0vTGji4FeFaZa3b4t7Cy8HYk8n0cW6PjB0inDXSru95VyoCrT8jCTPW+dXiU/VW7mk3xch3k9apru+eK7h7FJeVgQf2b0eXD+cfZy18CGiyO5aAIiOzKWsmu962o5DoxVgkP3muDdI20t2NH1IGK1gRpygt/e4+MlU4lSftsIM8Nl0Eu1NCukfuinR/vgq3BW1oAimKK+s+js9oGW804CXcR6zPoqlLWWc96vbpy9g2mYKuzp+RGdpquIQp43BUB2VLaHnhAuoa/pDe6F3SqjhQzhpkxKziDD8UmwKYfp/2OK8TJeFF8JP2NCipNMuB8JkCuoku
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3210;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3210;31:W/u6k1DNNxHpEUVsWiqXAE/ZlGUy90JVuysDmNKCqKABv31ZD8BVG9RHROeQv8DcxN/f7RZb8NcqlQ0WyFvdG6LHJcYh8fymbGlQc8d1YxBaw3t9jRsrQvGxv1tqh6WFgYBzgzn4kw3FIYNOdJs+gZHpFI9sc/RV755YqWsbjC+q2PRsHpda+VSG9hJ7vsW/Mhfp4FN8SD1dQBkgnWXoehsrU1SOO0jYxGZa2lRu1gg9c06/htJBczAvsGhHNU/0;20:mRTfi36KTOyua3YBJfZhhttl5KDQjRFVfskVWn0BwYlE0ZM6bllzGsXGWotK0/vLdduxcRpXRbavnICEKnaYqaw6ruVg4YlX5YF3osN3vjM7sv0kLBGJtKwOe4a7OlhgN67kCLLo2c4eXDje0Y7SjIFaeIWJX5xCkHLC4t+jgaYFMSzNLXE8AzFUdnGBAMfkbFjYVKx8NH8g2YCbaKGxpbZwZTl+kw9spcRFUQJmPj+Mdvwch7RDM0uN00tMyA5BXCdAnjaKluGHp0buM4NWxyPE6y6yuYfgUqjtN/F5eovXvu46RO6JSokZKcVeY/Ms+GQMspNd/5lzRn8XfZ2WfHnt3dy8p9pscLnXjdg16/PhN0eb3YJ5nyuUenHIooIxPIA63aw1UnL3MEs6HRQ2ZNZ1t0MCbOHzBwa1BV9TaIcwWMRWrpw23rXeDi6dhgwb6cNgt4v3+yel/nlraQgLLqWVUpI2UKWbp4i5R1YTjiiHd2nBINwMQsQprlEWfHz0
X-Microsoft-Antispam-PRVS: <DM5PR07MB32105C09B292BCB788E8055B80C50@DM5PR07MB3210.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:DM5PR07MB3210;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3210;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3210;4:Y2PK1+0DWOXusIw4PXk2Jl8fZN6zgPb4b7fQLicUbLFGGx4MLb8nOk6WTJHiK8kCimI+xJVDc6D0GlBbXWwFrN1dgEun76/gTvcKiGAkIPq3PVvA7Q4oO5+QhNJMOmezX165MzC1UhAcjtI8lDrsEL0vnFiUVohshSm+sBT+OXtfwn4aXfLRkRdn3vG+sm2l89xkM82wtMTnOvGTLTDjF/VRjjjKylGjMr0YluZDL89nAjCpUu/24lpWJtZ2gWOwPa8VJkO3vFW1dY3cpfZShajrEUunDWmYK6elkQaWGGHeatI6h+yWXbupyWiMTFBuQAtY2J/CEkrzaUuuZakzrgMh1sAgai4vP0pt+qqs2tPwoiuNwwcPNPekQc6SGxmf6qn9j6emTD1yBIpu184xKA==
X-Forefront-PRVS: 00851CA28B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(377454003)(24454002)(199003)(189002)(36756003)(77096005)(4326007)(5660300001)(2950100002)(83506001)(4001430100002)(6666003)(7846002)(7736002)(33646002)(81166006)(8676002)(19580405001)(305945005)(19580395003)(81156014)(31686004)(2906002)(101416001)(586003)(65826007)(6116002)(47776003)(105586002)(106356001)(50986999)(50466002)(54356999)(76176999)(3846002)(92566002)(4001350100001)(189998001)(31696002)(5001770100001)(64126003)(42186005)(65956001)(65806001)(66066001)(23676002)(86362001)(230700001)(107886002)(97736004)(68736007)(217873001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3210;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzMjEwOzIzOm1RcHduM3IzaXZLZnovMWM3ZS9BUVJKMU5C?=
 =?utf-8?B?S0liRzNhWk84bk5XOVp4blZsYXZ1VTRDS3RvOC80M0xER1E3eERmRWNFRWxS?=
 =?utf-8?B?S21XcmY0ZUtJVWlOdGltR2ZoMXNMdHBYSGRZU2lDR0RPeTl6RjhqRlRLMy9U?=
 =?utf-8?B?ZVNMV2ZyWE9CNURoWUszQjFjZ3BrNGRlUmtBRVdzOG94MDgvVDhVenFCRUc4?=
 =?utf-8?B?S3pXSWhTUEhwVEZPL1c0N0drN0w4NUlOMEFQTThpZ1pZaVRiUHBGejZLOVl0?=
 =?utf-8?B?RE54WDltaUV2OUJPam5DVlpWTjl2V0ExWWZZV0pla1dFVUFLSkg4N0NNWWpa?=
 =?utf-8?B?UExRMkZ6TndaN0xpKzErNkFnRjBoN2cvY3YzSGx1U1dhY1dLODg3Y21KWFNG?=
 =?utf-8?B?WFJhSEhabkI1Rk9PQWs2T1ZYSU1pc3ZaTFNucHJSdFJ1b00vdFZwWFdydGM5?=
 =?utf-8?B?UW9DOVcyczFldllJYjNHTE5kbFJSMGsxN2xoRjQwOEliYVVMRnB1cjhKY0hz?=
 =?utf-8?B?WUt5NVdDcmV0MEJDRDdaai9nbTR3My9VVFFKaTVxVEF2N1NDTEZNRDBBQXNy?=
 =?utf-8?B?eC9EeGxFUzBNc2dWY2daS1VKaU9aR1NITXBXdFh6UFdxdFl6aXJNUUNTSVBH?=
 =?utf-8?B?Vlk4R1NTSlNzTjdFRjZmcWhuVkE4dU1OWUluUUYvN3ZMZThrVXlvbTBkUy9a?=
 =?utf-8?B?VmI0MXE3a0l2ZFowU3FlR01ZcDkrNEc2QWZwdzROZlpQdTQ3S3BNSDZRbXE2?=
 =?utf-8?B?TDVxWHhsV3Q0dXlNOHpZaUp2azU5WXphYks4d2JqZkRkSTBHbTllSjVJK3Bp?=
 =?utf-8?B?b0lDYlV3ejFVb0kzQXJUNWQ5b2Z3WlFicWtTNzdTUkpJN3hpNTVFWU8vOVJS?=
 =?utf-8?B?b3RIRURHOTBjbk5hekZLTWpiZzhCQmRGeU56MXNickxKbGJOVHdqWlJvdDZG?=
 =?utf-8?B?ZG9OeFVOMjBFb0NRQS9KZFlLdC92cmYxR1ZuU2dUWWlUUnA1RzBSVkMyOHZN?=
 =?utf-8?B?T1l0UWk0cVo0eDh4OTJvRW56L0x6T3VaUndvcE1GQ2UydmE2ZUErSnJuK2hS?=
 =?utf-8?B?ZVduYjZYbkQzOTBqWm1SUU9NbXZzckpaT2RFL1lZNSs4dWN2YW9FVzVJdzhY?=
 =?utf-8?B?T05WSWtRU200MVBKdG1kaUJmbWtEK2d5bVM2M3RMMnJiOGpWa3pGdVp3YU9M?=
 =?utf-8?B?NnMrbTRBckh3T3NMRG9sKzErQjdMaWY1dFN5QXpmaWp3b0N4czRHemNMMm1S?=
 =?utf-8?B?WTZ2VHNnN1VwT3pwSUtPb3gvb2pJSUZXVmJWVnVqbFFJZzRYQlNHRWkxZXNy?=
 =?utf-8?B?cjA5cHlPanNIa1FrRVd5eHBaZjdCNHQxSmJrQ3U3S2VNaHVJbmlYUTFmaGFw?=
 =?utf-8?B?UXBIb2tFK1I4YXRUTjZWNGJ3NXFOaTZ5RCtFam1seFViVXVBYWNjL2ZpOE5B?=
 =?utf-8?B?ZlZaK3hrODVobjcybjBwNHNNenFYVmc0bDNuVGcxR0xvdmpiclp6SGRCdytL?=
 =?utf-8?B?RzhjTzdNOGdSbitScW5LVlh6dHQrL0ZpV3UvVW5oK2l3eU91bzl4d1VjL3Q3?=
 =?utf-8?B?N2VCTDUzUTJJNFBqMnRMRS9xRE5sdHVQVjJ0WmFNeGtOM08rUGxXMEVkQ0o2?=
 =?utf-8?B?ZE1Dc2hVMEg1NjJ3RUR0R0pQdmhnaW9ScFgzYzNuM0FsUVMwWjUxWEJJaERa?=
 =?utf-8?B?Q0RpcGZITmRud1RaQmM1U2JrOXJqd2dkb3pWdEZPQ2Y5Mko4bUJ1eDFzS1U1?=
 =?utf-8?B?eDB6NGVqOGpVQk1DR3pDZzZ5U0EreTU2VkkzSHJBejdYY1VYbnJnRTE2bkhv?=
 =?utf-8?B?R0NwZFlUeU1BbnlmeE9CVHBQeGNyVzV6d3VORCtQMkY0TU1BUVI1d1BYUW1t?=
 =?utf-8?B?VE1FN3d4MVVrZ3kyc0RyRTAyRzMweng1QTlRdEdwTXNkbkorM09iYXZEa2po?=
 =?utf-8?B?TkRiSUJGcWp3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3210;6:+/m97mgAX4SJ/zcYRvwIDoEoz1qukPrj7DUgSgYm+PGOdx3sBqFTLpWdowJ2pJt3TCB3w1p/jfYoLySt3SU9oxKK8KRV0pi8yYJymlTKkeMcDsVXOu5TzRILrLbkM5koXCpHceIOEGlDTYHoV65NlUvU0+wvIYHNePnp3MwTKLtmwClaozdpSki03qe4Y1xQ5FZaWFsY8Ur5XNNpA10hVjxDgdFy8OEeN6fh4DBJeNYD4zDs9qd0AFIHzTKgmkQF9XyUZHvL0GMOk/QPF2awvAuyd00jTZxk+WbQyzcLIOe61iu9roaTkn7MDW7VaMoX;5:zMHPZpss/oyc4G4Fg+4JCpJ3HedtGba9Nwb78r1liNGmLkcgGRNG09VFIVAaklpB/bqifgp/ARq0nRd/TvFnLsJnBGb4tKaekqUxDvpwUBiom5iWkhxPYw5kHfL93MK8akhf6/Ejshx3KBQmGdmSXpFNFEuQn5eNWy/q52Hj03U=;24:2q3NCAKFqCKshcl2Mt5/AVPYCozjlQWZXauJkJZYXiSwmUVuEniBOQh70jgKN5IpYVMFl/hRW58RiFzEHUpDm1iSpKQb0XCWS9Gs1IGvvSM=;7:oze5mgE4KR28XmZzCS9+JIH37fTqrCgEKBWXoeT7RURUtz8k+MYQKWTHsY/U8P/Gvsw6oXYuQsxrv8Ald8IF0SXOBEL/jjSDabBvnJs9aydp4i5Xb/zQayy+xsV58CH4v4ePeL59dhGPlBtr+SkNYjoY9791dp/c0IJwbTsDP1GtO+nY+H2CoDCYhrzR1o5ubippW58syEYyvc6UK1WX5wioRWyyHQ6oCNRR22vwtbloSLGgnwRnLnbw9lAsAuUFB6w/WDLqP4dpVkdAMSh2D7xxx6+qyj1b0HAKerg4FLwn1VBd7lCaUBOlmugTqEZammDBfAn/WuIkYj3T2sYrPg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2016 01:19:04.1686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3210
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55314
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

On 09/19/2016 03:24 PM, Steven J. Hill wrote:
> The OCTEON MMC controller is currently found on cn61XX and cn71XX
> devices. Device parameters are configured from device tree data.
> eMMC, MMC and SD devices are supported. Tested on Cavium CN7130.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
> 
Hello.

Have any MMC maintainers gotten a chance to review our driver now
that v4.8 is out? Thanks.

Steve
