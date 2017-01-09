Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 19:54:15 +0100 (CET)
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:27238
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993085AbdAISyHaZwUg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jan 2017 19:54:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RWWdgd25bKrp6/3NvYUrT+1Xbe4l4YehSun2CH0PXfI=;
 b=aSD5tKT1f3Qu7sLP/chQmV5Yx0FutFWnTyQQYyjMa+snhTFfxpK0qSoD6ppIcfEBmluf3JrfjPFSva5htFBSUFwBZD8we6Ru4qvtB1xisnfX0IJd3n/ck7NBNM4OlTZXjaD4t/lmZLUPRNbr+jl8ZEbzs13rRrsAqiyExk9MwnA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM3PR07MB2139.namprd07.prod.outlook.com (10.164.4.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.817.10; Mon, 9 Jan 2017 18:54:00 +0000
Subject: Re: [PATCH] MIPS: OCTEON: Fix copy_from_user fault handling for large
 buffers
To:     James Cowgill <James.Cowgill@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
References: <ede411ad-ee19-e4e4-e6a2-585a85c640db@imgtec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <5cda2d81-6372-f3a6-6f71-1d659515ffb0@caviumnetworks.com>
Date:   Mon, 9 Jan 2017 10:53:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <ede411ad-ee19-e4e4-e6a2-585a85c640db@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM2PR07CA0025.namprd07.prod.outlook.com (10.141.52.153) To
 DM3PR07MB2139.namprd07.prod.outlook.com (10.164.4.145)
X-MS-Office365-Filtering-Correlation-Id: 7da4a3aa-6fae-40fa-871b-08d438c0dfe4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM3PR07MB2139;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;3:Z6134zHVHZ/hp2cLnxoeBwR8Is2kwWBhBVs954J8iCB2tpYtJpLqcQrIdzBjvfx+5fJkrziA0yiv8VAk1qDD+eZegehfTdO9PByNq2IaDleg1ItP9hmgesg9OsBvSZaTEwKifpbr68dWA38AFk4KDGUx5XpW5kwwJkUbiSQp4vsul5Bjoi/SApSj6Kux7z5ZjNKd1lHjeNWtWtTJVn1mVcu3r3FLQAOf9MfmLLLVdr6XklG0LyZwr+6NNj4MO1Ac8m8Xlz1dcO4OoArzxc/4Fg==
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;25:6Doh5M1dN253Hss8AC7XbDgZkf7/zkKF1pZ72uiqQEtWhHWGtmw+GoeXmyYs3fLQMh3KqUkZKK07iMl7kadFw0B/qrWo7CCgCYnuL4UI8aV5PPPUNQx2C8Mbop7jrEFdlxvsb9zKP4S4im08s2SZXJD0YlHNEckesyyXADZ98kym6urFpWDH3qbQuPjeI2z66Da4Am8ayI9rlEm/OUdFim9T2Iru03ZKZkA+skD5zA9L2kZzab7I/sLyQm1XEaqYG4qtuyw6tUXqkNgrvvDHIEiPbJ4Fp2j2/6Y43AA1oNfm57KBdC9xlTdcp7ntNlN5FvevCDi1WkqLd3FJyCjcDjesDv5sfYns7yS4zLgAogkf+zdfffAs6w3FZRmeA1sspkw9pxooDvM7Ny3J2HyN5m0QUs4pKQmvCTCMC6AuUMy5xmVZ78S85cyPN8r6P5bhNowhFzgjj+u6I+Mbh0DlCNVN/W492bPMhWpH26GwHIF9cvn2xuCSCKYDeGlQrJeX8Jrgw5INjRCtBCOUxfECar6Of9apQes2waW/Vj9/wECTmqoF70UFO9q/st5Dpi1dxV8IMvLmCP0Aaap1NyGF/PrCLO+ygRdwerfGDB6pLESDL8gXKw8yM521ftXjBwHpzr1TNw0tdo+pXgrH4Xsz6lqA+zihFj1JCYf/2gmBxBlTnz+mi8FS054D15r6kdPIABcTa+Bulz9OMKF1W50fJbqLcgJMbpcEdsQxylm2DyidFIJNyz4n9oY1c5Bwt936
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;31:96P8NnPtd0f4gpFKY2PW6sY0EMMJOl/0Z8pNCFig+rLsQ+bxvU5/WRgIFKegjpvMLUL0KyryU7mip63PiprNOKNUsewVa+HPb3pfy5K3chsaQn/geDv5OLnYTT3oHa21xInAzioGhhjK2pFM9JU7XqogvF1JcW98vDNgOknQqYJ24rk/1FHpbHqvDa3lZSQpQtzrTmPAL5i4Yl/29LYy3ExZosqB8FT3LGbmz3Fs+EkE+2PLm2g1ONGNJ5tEN/R7A8l7U6bd3dmENuv2xrA6wYB0kK4YoB2RpxGN2RD5eN8=;20:vKOk/cFjMmxrPQ3SNi6R+g8HXylNYdf8RJO3J7pR21MwryjgC/PYk2GBV/Pi3CAM/bR3e2KTnm7UuTvk6Lfk3v/FBUlzYZJBK2j3lAV0DmhXN8m5EekhFkaYaOJ09mOF/NghywRH4NrJd2WzXOQgJuuMzvqcxfU1rxzwdVD3p4wGwIeaEfDdkH53qxEC2pNK5HS+VUDf0TgUUzx79Qrq9UZJnnWtjmQYYSU55h+GLmVeuU+8QMkl8PeQquogn0GF9YDrA1hF8bP0KKkLChRnUv0scPjpR8TR/Nw5UCmZNs/a6fO9Lq19prSKPkhJbHShLyqIBLDc31nFrVP3ii0MxhSzbsMfrrjiRWOCYDo8fjNHIz5f655Pr/jgwyzHeZ2Z/tUk7JUrEr7muaWvP4AbUIwdumG7N0MIE1W8wLUImuRoUkVEVDlkkkcAqKVydTznthQvJqumaDQC/dXdLPn56Sy5b/zOiHJgSH5l/8h8fmahcLmLiKM3NrrKe4/AJg8l0dPPKVF6rJY1LcvILSA2fJDHVao6vjtFkYDDeFe9xseHQVNIJ5UkIeHA8gXtcwZBz3xduj6Butx4xejFrZo6sdfFxgO5j9EBWxTf4qTdyhs=
X-Microsoft-Antispam-PRVS: <DM3PR07MB213988C1FA74A27E9BDD9A4B97640@DM3PR07MB2139.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123560025)(20161123558021)(20161123555025)(20161123562025)(20161123564025)(6072148);SRVR:DM3PR07MB2139;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2139;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;4:BcgsqgxdFiHnLr+PRT2db5n2cqDVK22oUdvE0MsVGV75PZtWBdswt1WWIkoJzBY/CEGLOal+mn5Kl+JDswS8/RWOJqr6wWV8hqEHaOzO1nyu+FT6bCUe0T0gk/G48CMye6gtOmW/N4sPrs5YP9seQxHk1i0w5eTOSg11lNqPVjZ6lNw1zshphHDpViWSqMSAmms8uzhTXnG6pWbXU+oRmUxxuk9dpZBgayUpU/wUOgRVL9RATcuFMh/2EuL1O4JLCGdmqJJYfr4gouQc/SOERLy4ztGEJkHL5uxO1+96pSZOiL0zRM8ddtn312QgNlkAOrPc/2uYlGuaEc9l5Vloq7io/dG0whICknxk7qnENZXOu+I4pdOmIDvUvKZx37HphXTrkq0yiC2rwH7rjjYwpP42iJOoYoZ2d/qmssrYHRL7rxVhFZjWdXsDI3zWD+p5YPeIvpkHt7m5TT8pkYCAypV3qynPLMuzADUGvirkP6mJ/IAVibuL0kHT5uYMKJyQCHBIh3zPfXt7avScKdhod1uUIOY42hsfBC/kFNMijxtSd5MVyeNXwSsRoQ/4a2CBBYXMblg/kAD4aE61gdOLQeW7LZqbtfQhtJ7yiOxtBo4FReRanXqIUWLgnIQ8EC/Oue6Sle85ZtqN8jbXMW5ihw==
X-Forefront-PRVS: 0182DBBB05
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(199003)(24454002)(189002)(377454003)(83506001)(2950100002)(5001770100001)(2906002)(50466002)(4001350100001)(230700001)(97736004)(64126003)(107886002)(69596002)(68736007)(189998001)(5660300001)(31686004)(23676002)(36756003)(42186005)(38730400001)(3846002)(105586002)(65826007)(33646002)(106356001)(6116002)(47776003)(6486002)(54356999)(6506006)(50986999)(25786008)(65956001)(65806001)(66066001)(8676002)(53416004)(42882006)(81166006)(6666003)(7736002)(305945005)(229853002)(6512007)(101416001)(92566002)(76176999)(31696002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2139;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjA3TUIyMTM5OzIzOmxtMjd4dUFPSXpjR0srVXlHSjRyV1R6UUlw?=
 =?utf-8?B?Tzg2a0hkNVFuQjVzQnk1WGRVS096aU9GOUZiSFBTZ3Y0dHljekJwRnNYSWZt?=
 =?utf-8?B?ZGgxQldPTFM3a1VwSVZ3K1VKcGVFc2xQbnFpYW9NSDhLUnJnUmpacWN4Z1RT?=
 =?utf-8?B?VlNnZi9GTE5MYWNta3ErTTB6dStZU2JydzBHK0Z6bHFVM3JmZHdmaDQ4Mzcw?=
 =?utf-8?B?N0RxdVBQaWpIbUpaNmg5RXRTSFFXVnNxVjlnS0RXcTNFYkZNK3JvUWFFZ0JP?=
 =?utf-8?B?TlRTZUgrckNySERqUmwwY0dpbWxWVkp3aTJQQ0NQUHlDakMxZ1VCb2s4Z3Fn?=
 =?utf-8?B?UWR1b0tnYVJwYTV2S1MxMlZvYXkrMmdpb0Uvd0RNWklxTjFkSkxYdTFqNVov?=
 =?utf-8?B?cUplM3dweTNDemwzRlFpa3dyazRadGJPbVN4M2hTM1NRdkR1NU1lUEhlbUta?=
 =?utf-8?B?RDlLV29sQjBBQ3FhQVFCTDVwRk9NWWJmWEwxNUMyeDl1bzFmU3Nlc1BGclhC?=
 =?utf-8?B?R2IvUElzVVovQm1xZzRyRURxZHRlUGdmbFNYYm14bHdYbHlMYVAwRDlwTjlF?=
 =?utf-8?B?c1ErOXdpOStFaTBIQWZQQ0dsYUE1dGlUbWxZcFl0Y2ZaM25CWkJRTVdJeEUx?=
 =?utf-8?B?V09NWjJ0ak0zdzhDNWVaVUhWNDEyVnFCOVFyT3ZoTituS0l2eEd6akl6bnMy?=
 =?utf-8?B?QkdhbVVFRzRkZnE1WEhOcnNsS3ZQOWFqLzNKWXUxODAzdk9kU1ZqS09ab3F3?=
 =?utf-8?B?cHVKN0xnOVROcXcvY0tITVh0NE5lWjQ1SFNUbUtXTUdrelUvM1hBZVhvbWV1?=
 =?utf-8?B?L0M5VVYvei83d0R1TS9OQmxoNlJVcDFReGpHclYxMmdFSjRNZnZVVk1GRXRS?=
 =?utf-8?B?amhJV284cmRZZjhrR2tGclZZUmtQM2RSS0JheXp6RlBRRzY5ZUprcFY2M0JV?=
 =?utf-8?B?bGVsOWl0RjB3Q0dNc3BYR0JqaTZ2VkVkU2tmNHpvaGthS2M2ODV6WnBBL0Qy?=
 =?utf-8?B?ejN2dVlIQ0Z3STMrVDJFVTg3U2ZkV3lqRXA3QWdGMHpCKzRzRCszU01uUmVZ?=
 =?utf-8?B?KzJxV2hEK2wwbGtISDBwd2NaWG9GY1ZJQjRGaWQxZzBvZWZWdkNMTW5EbWZX?=
 =?utf-8?B?aFRwRjZ6NlR2NzZCanlvRmxHYnhna1B6WEpyT1EvZ2VxNjVpZDBtdnk2UVJQ?=
 =?utf-8?B?QjZQa0o1Um5LLzdZQ1dNMkRiWFFzWmxrOWhrbU8vc3NqakRjSUQrdzZjOVRH?=
 =?utf-8?B?a2Yzb29saHI1aXpYWjlLRFFNelJNS25wT1FrNmdDZUc4cjVXTDVwZU9FVkVB?=
 =?utf-8?B?eTU0dmczdEQ5Z0RPT29ZZ3JFU2lBTHVzemxnRWtZWUV5YlZZajI4a1lGSU40?=
 =?utf-8?B?NmxvZHZYbE9PWFJ2M1dZQ1BnYkRtdXJSd0NGNk9OVkxPdVZUZnZTUWtHMThD?=
 =?utf-8?B?bk1qS1NKblZQQ2V4eHlZUHJiNHJwaGZSYys4bUxMY01OMTlXeTJWenMraHFn?=
 =?utf-8?B?SFgxRHVBVUtzMEo5aEdVUHNDSEFqYXdhQ3M0RG5RdjVRZmlXVjU1T1FIUGdN?=
 =?utf-8?B?cktnTDAxYitxWUlkRS95dGhGdFdZS1BLb09TRmVpUm9GcnJtZTRoMG1INGUw?=
 =?utf-8?B?c05QVlhvYUowSktVSkpVWmc4U3IyS2IvdjR5dzJpUVRHbTJGMWlBRUJJRWZ1?=
 =?utf-8?B?blNsdXY1aUdFUDlSWkF0QnUyWkhFQ1pJeExQL05aNVhnZnBydVdlQUttVVla?=
 =?utf-8?B?dnFUVE1yeGI2SGV2M2RHT0QzVm5CWDVMdEVuRHZCejF1Y1pSd0Q0YTBUbXAy?=
 =?utf-8?B?amxLTnZXNnpaOUhlY0tVaTBGTHg1b2NRMm9MRW5kZkpYT2c9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;6:9rqksh2fJK6P7Ot5dWfgZD1ct8wJdjjTmAcYti1Gv446IceBdM+pxsx6Kxmd0PH1tAD332CzEsAL9Fi7D5O1QdMHLElEd9hF8wAN/kS11fHMnbkbWpTy+ri0qhM7h51Txz9xJnpPNRngM/gzcVkTdcayC1zN1/RQSDAraMuK39zE1jw2ZYT2UdzbHdhuF6sknxKyPhhdV4jWuwEUwZRFmexxU7rlsdhncJpoWEBdN6O1lgz/ANyRNobxQKs+VFkIW+P93eQ8K2UP4c4L1q52dP0eWV/1FzAyLvPEiP4DV6psb0qY7P7t/qNSkdYQ0ew8FSteRP+glIgdqBnd0EijylAMNzGu/GFtMimJUb4xMWNodvgZb5kOay119uuroIZfEWguhfjWDbHALuHsNEE6IxosTwDVKBq4QM8HibZxdBc=;5:F2lSgzIV2tLGJ93LAM640ovu8cBmytDsRfZO4doWP56tR9PPA1PhCq2wvDl9m9q73RwoTHY22NXpcR9OqIuMU/QcSIQz2+hzVGW5FHPjeVksHsiM5QEzgLAvcICMSwgkERfrwURb/xo7bKyaGW4tZHnJzzMehuPDXL2UM88Iemc=;24:WjTl3ucIIOszzZ/Sqxpi3UOjHoxYqZSckDeXNErQv7QQtIW6IrMcarzmr2AZeAH283+nm1ViSHL4uON3LnLygmVHLXZF4kFS3kU7znE/Hbc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;7:31AAtRV28RV8Cb4suypIZmWOmifQLPfcv0rrwGdm+1AUl8sBbQ9893HtWi9bznlLheioijIiNK2ovrUXqeCwdhSVFdMGPlao4SlfIuvIwyGdKNM3CBE/hKrgvhQYaODPEk2WGOqkm0L/pzKkiWj5ZOROdDLGsczEvNN2yaa4k0WhiSof7A+GKIxmkVYtoMkefbYa/0MBvLdK397kUdrgQ+x5vr9DMorc0In/6bUAV1F0MEZiOVVtFCXWfioP/o0LcBCnGVQKnTOfomSNq7SEDDicbT7Ut9fKcZrPFlLf4ODSHJ1S4+ow9pqphnD32hhDfnf8Q+h/ymodqiBOSFQNyGGSgBjPPacdGwvFKflJw/N9rrAVMPmAYL7+9F8L8sHWt0P3rEq8OGwWl3xnZIhBFz8kZ84tdP632d/3XcN4Wk7diGuaojSZRiB205s2nV61TNpAEqEcVOQYCToCAgxqkg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2017 18:54:00.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2139
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56233
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

On 01/09/2017 08:52 AM, James Cowgill wrote:
> If copy_from_user is called with a large buffer (>= 128 bytes) and the
> userspace buffer refers partially to unreadable memory, then it is
> possible for Octeon's copy_from_user to report the wrong number of bytes
> have been copied. In the case where the buffer size is an exact multiple
> of 128 and the fault occurs in the last 64 bytes, copy_from_user will
> report that all the bytes were copied successfully but leave some
> garbage in the destination buffer.

Yikes!

>
> The bug is in the main __copy_user_common loop in octeon-memcpy.S where
> in the middle of the loop, src and dst are incremented by 128 bytes. The
> l_exc_copy fault handler is used after this but that assumes that
> "src < THREAD_BUADDR($28)". This is not the case if src has already been
> incremented.
>
> Fix by adding an extra fault handler which rewinds the src and dst
> pointers 128 bytes before falling though to l_exc_copy.
>
> Thanks to the pwritev test from the strace test suite for originally
> highlighting this bug!
>
> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>

Good catch,
Acked-by: David Daney <david.daney@cavium.com>

> Cc: stable@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/cavium-octeon/octeon-memcpy.S | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
> index 64e08df51d65..4668537b09c2 100644
> --- a/arch/mips/cavium-octeon/octeon-memcpy.S
> +++ b/arch/mips/cavium-octeon/octeon-memcpy.S
> @@ -208,18 +208,18 @@ EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p10u)
>  	ADD	src, src, 16*NBYTES
>  EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p9u)
>  	ADD	dst, dst, 16*NBYTES
> -EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy)
> -EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy)
> -EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy)
> -EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy)
> +EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy_rewind16)
>  EXC(	STORE	t0, UNIT(-8)(dst),	s_exc_p8u)
>  EXC(	STORE	t1, UNIT(-7)(dst),	s_exc_p7u)
>  EXC(	STORE	t2, UNIT(-6)(dst),	s_exc_p6u)
>  EXC(	STORE	t3, UNIT(-5)(dst),	s_exc_p5u)
> -EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy)
> -EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy)
> -EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy)
> -EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy)
> +EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy_rewind16)
> +EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy_rewind16)
>  EXC(	STORE	t0, UNIT(-4)(dst),	s_exc_p4u)
>  EXC(	STORE	t1, UNIT(-3)(dst),	s_exc_p3u)
>  EXC(	STORE	t2, UNIT(-2)(dst),	s_exc_p2u)
> @@ -383,6 +383,10 @@ done:
>  	 nop
>  	END(memcpy)
>
> +l_exc_copy_rewind16:
> +	/* Rewind src and dst by 16*NBYTES for l_exc_copy */
> +	SUB	src, src, 16*NBYTES
> +	SUB	dst, dst, 16*NBYTES
>  l_exc_copy:
>  	/*
>  	 * Copy bytes from src until faulting load address (or until a
>
