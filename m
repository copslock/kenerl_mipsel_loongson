Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 18:20:04 +0200 (CEST)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:14336
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993948AbdGGQTzqQVc- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Jul 2017 18:19:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=M1gOImNsXjdcGAKIzgp84WP8aY7raS6mll3Tilfucfc=;
 b=NHENNVbFvnwR+hRxqnXp7IbCVALHLS3odcUMZaxPVCXnoLDlXXW4jdnKm5QJWiB65e0uUsYEhJZOejgFIqwlX/WWM55S56Q/STkUglIVhv6L1Tq35Am86//4XZWQPc9sTRE9Zcd0m72cVtFOJu5F7mevUPvOEAmEw2BCZdgZRaY=
Authentication-Results: cavium.com; dkim=none (message not signed)
 header.d=none;cavium.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN6PR07MB3492.namprd07.prod.outlook.com (10.161.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1220.11; Fri, 7 Jul 2017 16:19:41 +0000
Subject: Re: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
To:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@rt-rk.com>,
        ralf@linux-mips.org
Cc:     'Petar Jovanovic' <Petar.Jovanovic@imgtec.com>,
        linux-mips@linux-mips.org, david.daney@cavium.com
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com>
 <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org>
 <002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org>
 <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk>
 <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com>
 <alpine.DEB.2.00.1705221846340.2590@tp.orcam.me.uk>
 <000a01d2e6a4$38a8fe70$a9fafb50$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D065C1B@BADAG02.ba.imgtec.org>
 <alpine.DEB.2.00.1707062139020.3339@tp.orcam.me.uk>
 <000b01d2f715$6bb602f0$432208d0$@rt-rk.com>
 <alpine.DEB.2.00.1707071538030.3339@tp.orcam.me.uk>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <4e2cf7f4-a44c-3beb-290f-ecd483368d67@caviumnetworks.com>
Date:   Fri, 7 Jul 2017 09:19:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1707071538030.3339@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0033.namprd07.prod.outlook.com (10.166.107.28) To
 BN6PR07MB3492.namprd07.prod.outlook.com (10.161.153.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f151c1f1-f4fa-4cfe-f43a-08d4c553f947
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(300000503095)(300135400095)(201703131423075)(201703031133081)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR07MB3492;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;3:3H2sxeqXQRL3PZVfAQiy7Io1LhpY3RBdYI0wk8DF+Bm8JArFkKjK1lHuxSqQnaSsAf/7SFEfyvp1+a1g5X7t4eMva3pTWGSxsEpcoI6j/mJmqoBKt+8cGZUDvt+zh6pB6fOmF6wV+peMotuh1I0rTzSJ8ZSYo4b9iJRRBRTz6WZizG2SAkaf3DQxAVttXy9ONvz+WIAIlWO0OysRG+7bvAT4pMqPAJvKjV7LW8q9/EZK8kAl2+hb8iYY/0UScaN3kwfSTLkHJDjcaha4Hp1ywgBNUjIfMLNEH2yDR/GetRtJup3qPFowFD1yd+TMG7RwSoj2Tm7gZ0GUp7oc3M6BgylAuODATKN2JeOKtHDO+NTAMHY+PzjcBGDa7zKZ8QBcMuOVauhLHO6Sb5apfYTlocFJaANxZ8PTp78gsDjWoLqA6vfeJcSDD5GiNBIn0e0qaww0OdZahCQCcygb+4ottqFqO+eSppfoB6CExAu59GtP11uDR2X8EnLw8eWqveRmuEbAWPC3NFPPnqcxX/5fie0qaPF6S2wguiz0X+PhdHWiyrCqfNenQCINpfUT2vCVy4qyDvETNODrVuJf4+lhItXFoGrqptGumlrXDB9PCWtdsy9KNC65deMpnf5Rqk+X8shgZsZm5RiWgJv0th905IN+P7u8A8c2MtpYMEPUoG4U9d1stwAHkkhAZ28kzLKEQFaC5xFZYYOBX1HdpBfEqGjNTzbzZKt9cq9ayDU0ZlbdzrAvAYllMu2Is8pui+Rw
X-MS-TrafficTypeDiagnostic: BN6PR07MB3492:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;25:cELMSkKowY6CZQDehSHc775M/4HIugIEldc4OcIAr/gdmL/eht7u4+6SCGPux5pwjuYut+syD3b9TTc200Xb057DQe3BRvna/1R/DuCzyEbs8ciGrAwoEBU+c5QRWZxtNuPjHkVOJ/MHIYpwgzZxnZfAByEuTN+H/KZP9GovQ9Q7s69WZYotwK25GIcLK1P+x9nnK6FWna7+NkE02l+3ZYTNcCjLz2JkR0ZL2aFFmmXIjn1DoMbIgOqSw6ANO8ujSmk/GApRa/7uJl7Nn24pnTP4DGpZOM+op0c6wxqBiQNjmicYgcDe1xpB7/QIhkf3w4PFEbB2Qk4+GAgisHesAgUT+gyuil2gi9OAP97sLT1YblaNgH25o4T1nbZsvB87qH9rbB9KaokntMJ39wvhcZfHnUundvBIy0oLuYUWTFxdMPq58LxNjnio0lHXml5rorFcDs0KdaQvfUNQlNjRJ/u82aeI3A+5nyBTcE0ZJ8L7+omwHFEumETGdGaQjRgIGkHJPQsC8/ce/5chOEIrtKAEjn0cnm3tZBa7YCW6pbdhFqvi3WtKBpgTyeSgFAdfwtMQzNQ69O6N54gbmX8F91RCgoPtgr0mUWUXEiiu+zFhzsYtWzORlYjM37q6eNE4SADcAXByJnOOTZh1wIMXBKHyEhD/nGIT2HaJgqEmKAfLgWZfKXdPUcbOgytOk6I/sKNG3V6wffx5rsuYSPIg21dRdc+PdGXQdvWA5ceyuWYcUv8vxiFL3o0jMuPn/U0WH0jzo1YmRcMoq2O04ngLywyNtdBcol48JjNcBkQsVaYgO0ycpyHrQuWCzvc/+ISaiM2z4FMvLkvJY9XKil2RuOJx4OIZcGgA2An1A/NmqoHwSrCdZOxQsjBqG6TRgVJsy8NPB/RzSPbw82fUcy94MDcallQroHQtP37G+a0MabY=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;31:9xd1JsuE2AYQ9YBvnVfuRcMR44AwESD6nfZoHfaVGzQ2hH4zdl0gfvSP0DCEj9kNWN0xXY8w94km9uC+V1uynuW+QHuNbT/laYmwOTXywXamf1YScLpezPX0sKfc9PomHO+qfGQlYYRq7BhYG/dKawMatEMV7GZ7wOiV2TjVKSZJ1xNQjMIbg+aYgSm/JpDIq8q/mSSvwhdVML1q/Cg80mxfAn5wvHku4LVSPZuCkUmUQlHOWm8aYpgXEVp/WFhDpOJqVoGbcjDU2v5SvbgL9svCrWYD7yVZgFS8CAHUAzEC1qNO8Z8iIkXHRlVF6EaMAK0RtnsFtyvtP7CRg1k4Z4xgIoEAIfJ3mYmBlERefF7atukHFsE0Ey2YE/wQzoUv9tcJ98tCLEBA12AM78Lwm62KHox8XIJbF0KOTXZ3yUhVnuS+rT7QPhb7hq6BvIgjz89IOpJG0q1DHaHzut0J/ehDyXJv3rdANYSchiGuQ7M7ol1TuBy4eNwkTx6RAekSO1Pl/YW38h9QDTN07sWJKPEwwnqVSP48em7akVk5nmE3AOSKqmrGiPd95IdrjGttC2DJ2DjwJmIcEZ89bF+J3vixksVqYQFD+yKwrSsGzodfnCf/Yhc39EFNeZWJ0NUCyJpBDunRhGOTo5P056ynfaPMqP5y9Dn3f8w9pjj4RBs=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;20:mLPzAEI0Gqf7YXkd1NTfVkKXNux1VllWhGXOWq/1NuAYZasgwMZWQiM6khEiUCpNBK6QA3qydE/adNUkhuf2vaX3yO9BfBjeM6U6P0mB4AZsddP43Uuuo2oTVrk3s4zIJCh5r2AergzsICbZstXxAlHHftsTgqgIyMDwDtL0klLzcMGR/yjSaTStpWP0u9nmyNuJCADBrbjIiL3t1H7pd0alnZAybTGUTFBhoT887xefcwfnelYQ7t4zOiJw/mZlLNw9v3BhK+lQky5yeS2KL1FB2WPnUSBvhQOz6RS6qEy1hRR2+2Tb9g0XxKZlGguC+cT0zhY+1gm3uqwOnmVlmMFPDMMwosoeK3XvW/u17wOW5Vhh328APD+6cDDaGYA3btHa66sJA4DfCORa10mS+1oZHY0Q8YhPRUat/7Lw4W9ca0nYWXRbjptpC/Ew5ZrkMiohWKyePxioDJ/kvdmr6zgAJg/Q6B0SQNVfjhT6F739b8IwPZIYloDbNf6OobvgQLEYZjuEUrfEVZU+Q7yn2T+ZqxDIDUY7bLxfHMzg2HpQJFq8pXbHdiJ5P7J9IsXZ4si70FA5tY7utrHqgHDS4vR+Z+aYk17X0mnBB3i4RaM=
X-Microsoft-Antispam-PRVS: <BN6PR07MB3492F3D81B24B894F15E587B97AA0@BN6PR07MB3492.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(133145235818549)(236129657087228)(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(2017060910065)(8121501046)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(6041248)(20161123562025)(20161123558100)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR07MB3492;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR07MB3492;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDkyOzQ6akJ5N1BkalBjbS9xNlhpc20vZi90S0tkOTdx?=
 =?utf-8?B?V1VIbmdWcW9Ua1JoQ3JHV3NkeUpVRTF1c0lBMGpGa1BrR3JYQmY2Z3d6d3hy?=
 =?utf-8?B?d1pHT3ZGZjNmTU5zMWdGWXppMWVjL0lmOVhScytRZnhtdHhWaUJIWTNkZnov?=
 =?utf-8?B?c3JDdEZydTZ4ZGpzSVR6WVAwYVoyR2swb1ZtWHIzZVpYRVZQNnBjcHFnRk1B?=
 =?utf-8?B?K2dEQWpFTW9BL3BzSCtTS0xPMkF5SUs1bDgwUFptU0dNR2FvbkFZeDJVbVFn?=
 =?utf-8?B?UVdHRU9jaFdPZHBlSEZUdVp1VVhRd2Q0YndDcVNQU3FobUpDcENKNTRQSGpU?=
 =?utf-8?B?RTRjY1RuRXRPbDgwYXVaVjR1dng5WElUNFFMUmgveHkrME9MdXhOWENjWDg1?=
 =?utf-8?B?OEhKNzc1OHl1Q0I1aElhc050M3laQzFCQ2Z0QlhTczA4K3hJbzB2QVRUOFdJ?=
 =?utf-8?B?WkhqS0paaHRXMXRBWkVRbS8zUVdudDRuOXJSdmNxZHkyREJUbi93L3VqYjJt?=
 =?utf-8?B?QnlsdU1UQUNWaFJhSmVvbFU2OVdISmRZazFkdW8xdjVtNE5OVVlEVWEvSWMr?=
 =?utf-8?B?MW5QWExjYldXYS9NekJQckFCODdDVFIra2t4NUhXbndwT3JybXFJTTloUmZr?=
 =?utf-8?B?d1dpYnBsdlhKbVFiWW1ZUXZyTGlwZUJUekJObTMwNHd3S0gxWWZrdDZ2Zis5?=
 =?utf-8?B?L2NpZUJER3h4Zmh4eElWdElkZzQ5TGNXU2tpelZ5MjQvMExxSVI5RkFNNGt1?=
 =?utf-8?B?ckthYmJreGcydDlpQU5vR1NJTUhicFdZTWMwbmdsbUVDVDZiYzdhL1BWcXlI?=
 =?utf-8?B?akdXWCtBTkMrQ3l1QloybGRUbzBmc2pWdEEyUXpuQTFRY05BSytua1JxUVZU?=
 =?utf-8?B?YUtPTld6NDBVNEEwcVRKTFJWa0tYbVJXekMrZVpoWDR4T1JsTms5dHZjRmU2?=
 =?utf-8?B?SG9YUHU5RWkwcW9KdU51WjF4M1JyOG9ES1kyOElxQ0krbGE4VnJuR1VHUWlS?=
 =?utf-8?B?QjBBdmd4cEx4Y0gyZEVjUEM2T1VGWk9WZUtnVFFPMGVhbjg1OVBPTmJYdDNE?=
 =?utf-8?B?Ty9Ra214UHhlZnBxL09Edmt6d2VCSkpPUmlOV2tnTTA0clFWd3ZHS01jT1V0?=
 =?utf-8?B?aURlMVk3ZUNCQ3h0d1BEMGZxUkY3cGt6aDdIUHZheTUxYVJsUlVpZ1djNW5R?=
 =?utf-8?B?UzNuRUVVVlh5a3h2ZUJEeHAyVkZETkFKaWdXMG4zRW45eGhkNTRzZUZmZ2xk?=
 =?utf-8?B?RVJITWpPTGwxb0FCVWM5U3k0Q2lsc3BzUDJzeUZFYU1QNDhqVU5uQkhwTGVk?=
 =?utf-8?B?NjNRZFJtSWlXMWRUd3IvQVdmM3kvOHcxTGE4ZFQxbXJtYlVHVWFtU1dwVVh1?=
 =?utf-8?B?cmpBMXdzaHMwOUUzbm0yVUZHN0F6R1R5T0tvSjhkRWttR01UbnJQOXhIeFVi?=
 =?utf-8?B?dU0wKzEwZmVxMzE0Ni80UmZxcXlRSUVlK1luV2w1c2diUjR2ckd3dktPeTVp?=
 =?utf-8?B?c25tb1V1K1BodWVUKzVmQnAvaEowdG5KZ2owU0kyakxSNG5aSXJSMUF3T1ZY?=
 =?utf-8?B?RlhUT2NUK256ZG1ubEJ5S0tKaTY2MXp2dTVVeXFSZm5abytMTnhEWnFDTVJu?=
 =?utf-8?B?NHNtOEt2bVBmMDkxTnVzWmw3QXFYVk5GVEZqYm1uSDlmRXU4Q1ZFUEgwVlph?=
 =?utf-8?Q?zWiEo/unrnTzh/eJYNdCifAKpeIynAVR/cfPj5?=
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39450400003)(39400400002)(39850400002)(39410400002)(377454003)(24454002)(51914003)(72206003)(65826007)(36756003)(478600001)(23676002)(76176999)(66066001)(54356999)(6116002)(2906002)(4001350100001)(50466002)(6512007)(230700001)(47776003)(83506001)(50986999)(53416004)(4326008)(6666003)(107886003)(38730400002)(53936002)(3846002)(81166006)(53546010)(2950100002)(5660300001)(189998001)(42882006)(42186005)(31686004)(7736002)(305945005)(93886004)(8676002)(33646002)(31696002)(6506006)(6246003)(6486002)(25786009)(229853002)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3492;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDkyOzIzOmYvMDBYOEZJTDJFM0hGQ1BzOGJmL0lWb3hV?=
 =?utf-8?B?S2lVc01MbVIrYmg5dklYL0FSZ3h0TGVNa3Z3bW9qWS9OcjZveldCUkJGNlRt?=
 =?utf-8?B?Tm1OcU5ad0taYXNDZVFOay9FcHo0VjQ3dmtRVWNpOXNIUUtlSFB6Q0FiNlhP?=
 =?utf-8?B?MXBJR2NZeTNtM3VKRFZOTTYxMStvTlJMY3M3ZXB3R1hrR0FQSG5NcklrSVla?=
 =?utf-8?B?RUNuaUhoSW9TQTE4a3REWjdaYTh3Tkh4K21RQkZPMFViTVBGNHQ3bEZwZk9h?=
 =?utf-8?B?b2lkR2E0QVY1bWdGZ1k0bmZ5RUZlMWwvaWEyWW1KNjBpZ3huUmR5ZjJkR1Nw?=
 =?utf-8?B?dWkvc2J6cTl5QWI5WHdhRU9uOTdTbFRJTXkzWDNiR01mSFlxMjE2bGFVUHFk?=
 =?utf-8?B?dlB0K2RFYUFFM3ViK0RqZnllelVFZXNVdDRHV1J0T0YwTUVpVENEWEx2dWhx?=
 =?utf-8?B?RjVtell4VzNmU08wclFSbm1ZZXd6S3NDYTZkaUl1TFFWU1JlblRyQUpwRTFV?=
 =?utf-8?B?R0RNeFZtOE5mQWJ6WDFyTkRsSkx3ckxMYnQ5WUJxUEZ4U2pqQll0OTh2RnlW?=
 =?utf-8?B?QmdCUExMQmtuZ2VMN0N2akZ0K3NNaHBQN095VHpad0thd1Z0R1pHQ1cweTJ6?=
 =?utf-8?B?c1QrL1pUQUlnUWhaUFgyZmErSzRZRERvbVoyTjJzM1dVU0piK2VYQ2E1Y0VY?=
 =?utf-8?B?ai96NzU2K2ZxU0d1dm1FS21RcTE0c3duRHBGckZoWDNzM0oxcGIrRkpxejRX?=
 =?utf-8?B?OURVVGlsWkhFNkdsY3IzS3BIRVRML1VUdkpaSngrTWkrSkhxb29SMTJTbng0?=
 =?utf-8?B?b25MaEZnNjlpUVgreUFWVlQ0N3FzNFFxZnVjakIzL3Vvd0hka1B5dGlINWJm?=
 =?utf-8?B?eXVhU0hpYzhhRTcvNm94d3p5bHJ1WklmSEVwdVhGOHR4eVFSb1FUVkxNMVhu?=
 =?utf-8?B?QjQ3dXNkOGpsRHU1QUZSSVpDQStNVDJIdDJwYlE0NEZydEFob3Q5VkRjQ2t2?=
 =?utf-8?B?b0RBWmEvMzJxUG1hNzBSMDNYWjhkV29aRXU4TEg4SjNvR2JDY0hYcjlKM1Nj?=
 =?utf-8?B?eG14MXluMkRkaDc3YXdidDhpTWJpeFp6U2p6Nkt4V3M4Z1Era0RSSTBHQnVU?=
 =?utf-8?B?ajRxWDBURFdGaDl3OHFPaERpcE56YUtieTJqd2x2NTlzL2NweCtTZ1RmL0l5?=
 =?utf-8?B?dEYzYTQ0RVg4SmVoYmFDYWgxMFJ4Rm05YTFCLzg1U29ZbjNldFNvNXV4ZVVT?=
 =?utf-8?B?UU5UUWROUW1WeG1ZNFY3SUF4RzlyNmhhSzRkK1p2TmJ6RjlxSTREUGJFRmJu?=
 =?utf-8?B?V0NWWE91bUZBME03eUZFRkdlcWJmczk4R2Z0aGVkVXdLOWZqMkd3SEhtUTJi?=
 =?utf-8?B?S2dyMWpKQ0lJazFCVzg4dFNhbVNIbHBkTnczZDRSNzkzaG15VDMra2dwYnZh?=
 =?utf-8?B?dFZDbW4yNEhPdFJldXovOGFDVm9hMXQ4ZVlwdXdHUFMyOEd1dXplMUZkVkxq?=
 =?utf-8?B?a2c4R2RVd3dPMThUYmppaHdPZmllSEdhU2J3MjEzSFduVi8wUUxnR1FMSVBi?=
 =?utf-8?B?cGRpR0Z3M0R2d2ZSVXN2bTc1d3ZEYVNTc29JbVFFcTkvQW1kL2dydU96ZDRq?=
 =?utf-8?B?WkhyelNMRUFMYldzeDVhbTRDUmhWaHNQeGJWdTZTelB1dnJLSi9jWGluZzFa?=
 =?utf-8?B?SFVpOGU1ajNacGdMODh6dlpyVXVab0pESk1ONkRxTFl3clJSUGFFMFc4T1NF?=
 =?utf-8?B?WnpKWjhod04wUXdMSzZVNU5oOEpPbjBBTlVQak1XSW41RnN3MXNJaXBZWjdO?=
 =?utf-8?Q?6hs9w0SatqKRY?=
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDkyOzY6RGRIZ0NFVzZHamg3NjlFdTdtMXVHQStmTk5y?=
 =?utf-8?B?WlVYQXFINWtBOXhmREt2RWQrSHVTVG9yYzY5RHFwS2VDbGtUd1QyRTRQM0hq?=
 =?utf-8?B?MEM2Wks0QWZ5MTJsWlZBL2xBaXk3dWxDakpKekFHN1ZWSGNyQkpYODBXNmdS?=
 =?utf-8?B?RmFFNWdvNHdRSXFZQ2tSK1FHSGRyS3RPbTNSa2RXSG8vbVdsWmpDTnZVREVi?=
 =?utf-8?B?bFBDaWdyRkd2MHZrOU5VbzBIUTBMeGg2Y3hnVVpYT09JSGpQTzZRNEhMYjFo?=
 =?utf-8?B?Y1QwT1VjcmlMblhVWjBmWlV5VERnS1ZSbmJweFFLMlpMN0JXS3drZ2dpUDdm?=
 =?utf-8?B?UEQzZ29TajUyQUIxRk5Gc2gyQlMyRmZaTEE1eG1XbWJlWHZwNldjL09SQ2RY?=
 =?utf-8?B?M3JGVVJ0cHBYV3o0aVlwV0hUWmdxbmVuTXQralJqVFhkOGtnYnFRbUVkalBt?=
 =?utf-8?B?dVd4Snh3eFZ4aGFrSXhRYkk4RFpHN1RpUmtucmhkTXJnRm94T2N2NEhocGV4?=
 =?utf-8?B?Tlo5MWYrZm1xRHZrQXZCVkpoLzJwVVo0bUYxSkZOWVhCMForeUtmUTExekpv?=
 =?utf-8?B?Vm52QWc2Rk9wSzVZQUIyaGJzMWtRZi9BL1M5anlqLy9JQnVlTncrZ0Z5YXRq?=
 =?utf-8?B?SXFVczViUndvTlMxVXFRQ3dtM0tOYXpFOHNmNW8zWFpPWWt6WDNzZjdMbjR4?=
 =?utf-8?B?NUVySndGWFRyNXZNOWt4REhsZFlQYm1tUnFLSDRkWW8xbUR6dUIxWENZd2V6?=
 =?utf-8?B?ZytVZmpyOWU1YWEvN1VycVY3aVlQMkVzdGVjbkpXSEdsd1FDT25tY250cGww?=
 =?utf-8?B?enlDMU15b2QxTVU2SlJmaW5NSWhlVE5ZaVZxSEJrSlBFbXBDZUdwdTllNkMv?=
 =?utf-8?B?WW9nZWhxYncvd203eHN2SmNRdWx6dHRBcjc2N1k0QjRoOHFRQ2lYVXRsM21F?=
 =?utf-8?B?ZmZzOCt0Y1N5UG53UkI5Wk0rS2E4MFZScnEwWFRucStDMkFtSC9yQkFCVFlz?=
 =?utf-8?B?ZG1hMWZPTXIrRDF2VTMwTElvcmk2YmlBQWoyVGlDWUdScjlUU0hsVE5IdWRj?=
 =?utf-8?B?SjQ2dDV6UVJhdXo4MVQ3bDdUMkZGKzk0bGovT2huR01xM2MxRWs4OFo3UDNX?=
 =?utf-8?B?Q0ErMDFpcEZrUmFsWkdQQ1pjeFF5eS85TmxKY3I2ZzgvMmVqZ1IvUWtTWFhz?=
 =?utf-8?B?QnliL3NlektLZE1UeTdHY21sbDhoaDNPNUtxZ1VFQTNhTTlmaUlPbG55cFJ5?=
 =?utf-8?B?aGlLT0liQUlobExFY3RlbGRCemZQUHRURnowTkRheHpwTXUvZ3FlRWZDL3V5?=
 =?utf-8?Q?53aR0LIcflExKBnSdopEDuRLaqthFbA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;5:LIMZFku46yChq2lOuUTg6IIhsbFAVYnaYmzHCGFLDU3jH35a5j2aBB1o6pHWsPAWMoVH5nTEu2RAF+iQ+EKy0IVMaENxM1j+GvXa6BxjEJMwLIYURh8tlaQDRQPMBmzYMOTpzUYuUBlwMxubZRYWqQbmdIu0tnm2/ft+AK2equKWNQ6yDCuWJwTbFABDB160MGuJVln+TAusIX41u0sc5UbSTeawY5fdpTIIny6Eg8afaJ1lSrDdg+ccsXP7PJjW+9dfitvDl93tSCHuA9QYQRifjjxvvWsy4uDUXKVOGF083N4OVDRNmqfcWRdvSlsTfxOE2vKXS18GenXgR/DPWMLPbdp3v825z05C3UUG9aFRsU4sgIJgqrXiQRHstD+JTpsFN4VTCuwOJW1dAkr7DIGSklw7T1QeA0WhXmnTdvGqHobiTzZm6nSE11kilmsah6nIUCC8lR9v9KGWOALtFp3/TEuiErneUXwdFzyO6duVtn0gu/2T9XNcTt2s6LB7;24:5Qpi+H0zxHLqnPu+xt/nVaeqsCAwswAaedmCxvbdGBZkH2WhgOhPUjVyDaKjZywhK3BWIMLw6CEfAYQR52QDSJpiNvP/pWb692OdKeN/WBM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;7:V3qbhpnoO9Nv1V7xZTem+dXGg5h+0z1AFIe8qeOH4vkyXkVZopEZihkZLVM4cZSoRtT5zbZsykuXm3hsHhgtxvTaknTUpRMzEwX2uP66USNI/RgTudkKISqZJHhW9ebtmp7mJ4d90czz4kn+aSVtoPnpv090HgR4uxsHQeDh0reoah2/OnhzPGH3GUxFoijnSj7BFVRlv+K6HjeOHX78LR3cs4rHOx+O2ZYIg/5uk1BlcK8xxA97nSjwL1ftvtVy/uClxk9h6rl52aR6z4P5CGtcuGC9quS2Hv4/8damMtdPc3clCqhY+sWXaDNRtpTyjxzvANQp9LEVosNQNKevTv2gqz6qPVj0Hgc4ysPAsEGJ4Dj2AqW8/k8Z/N3EMiTGKazOVBjJjG3c9AAQdbHw0VtyqXJZ+rePVMEmTBm3/7eQZobjxy65CFM5Sk2RQ+aMtqzgvBfaPWefu2TPlt35ycaZYK5+n4cK8VqB8co9rVC49vNjYmU5j4d7d1nBPVT2dRgRgnEuelVNukdw1M0JHxTsbXTYaRCF/HXYk1Xz2n/hoYfbXeBvNwaBxtyUTTSgyzuWwi5bOr39DCVHVlvgVFaknHnJxIL1Anr1LApg+sXyyfWQvav3L5N5XaKHkefTDG/x6LCPJsRt7gGsDrXxUoeEWQghaIu5469dtYtfMCuMKiXhzhcVUz1JEqvrsrOmeDFUf/bK3UXVPAeVe7Sa7F2a2jedvMaV5L9ymXllyjUWOQzycPc0oo6NvJgy54j30uyu+ydYSfF/Oa/ilTc3uYBj8IxCXy/uQEAwKMTCCMM=
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2017 16:19:41.5978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3492
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59057
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

On 07/07/2017 08:04 AM, Maciej W. Rozycki wrote:
> On Fri, 7 Jul 2017, Petar Jovanovic wrote:
> 
>> As I said earlier in the thread, "in the current ToT, I have not seen
>> where this change would affect apart from show_cpuinfo()"[1]. So, if
>> someone implements Octeon-specific controls, where this should be used?
> 
>   Right, `egrep -r 'cpu_has_(mips_r1|mips32r1|mips64r1|mips32r2)' arch/mips'
> does not show anything else indeed.  Please make it unambiguous in the
> patch description then, i.e. that there is no functional change beyond
> reporting in `show_cpuinfo'.
> 
>> I am not aware of the places where Octeon (ab)uses it in the current
>> kernel code. David says he "cannot recall exactly what the issues
>> were" [2].
> 

In my recent review of the code while working the the eBPF JIT, I tried 
to audit the use of cpu_has_* as it relates to OCTEON.  My current 
thoughts are that there is no reason not to merge Petar's patch.

Ralf, please add ...

Acked-by: David Daney <david.daney@cavium.com>

Sorry for the pain here.



>   Thanks for the pointer as this message has not been recorded in
> patchwork due to its changed `Subject'.
> 
>   I disagree with David there.  The intended use for generic ISA level
> controls is the same between userland and the kernel.  That is say
> `cpu_has_mips_r2' can be used to conditionally turn on a piece of code
> that uses a MIPSr2 mandatory architectural feature, such as the ROTR
> instruction or the CP0.EBase register.
> 
>   Anything that is allowed to vary between implementations, be it the
> availability of a feature or a choice made between possible solutions
> for optimisation reasons, has to use a separate control, either the CPU
> identifier or a dedicated `cpu_<foo>' setting, like we do with cache
> controls for example.
> 
>    Maciej
> 
