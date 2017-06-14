Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 17:54:21 +0200 (CEST)
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:52915
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994630AbdFNPyN32-Jx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 17:54:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tbuElJnWSBEWB/GWinyZBE/SBLPS4/J1e9G5+VlSSyw=;
 b=mwhlZhguqhjAOZ9OK1Jkla9Z8i7nfYTvDaYg6MBYnb4dKi9OH5RILsflRSKLXt7+JqZix6ADD0tK/kwdWMYYYRA2w272NEGPJNMWuj9WvQxVFyENBTxjKPTtTFxQh9cbnCf7bDqSr3+l1QsOGY9cqmWGZc/0oC0dOjwfcnW9/IY=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1178.14; Wed, 14 Jun 2017 15:54:06 +0000
Subject: Re: [PATCH 0/4] bpf: Changes needed (or desired) for MIPS support
To:     Daniel Borkmann <daniel@iogearbox.net>,
        David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
References: <20170613234938.4823-1-david.daney@cavium.com>
 <594081CA.3060801@iogearbox.net>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <e17ffbca-f11f-5617-3188-a7eb82b03ed3@caviumnetworks.com>
Date:   Wed, 14 Jun 2017 08:54:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <594081CA.3060801@iogearbox.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0089.namprd07.prod.outlook.com (10.166.107.42) To
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15c1469d-f72d-4762-29d6-08d4b33d9678
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:QTm1zr8aI/xNcTGTn+WXBIVeLr8brLhbvbD69lOZ74Pa2e4HzIC5e/QIoJ9GZu3USCaYOt3NM0a174LYOleUmfCoSKOP1N41L1kzBmSet0cvO0osip5g+r40ykrPg/eVUaThb/HgMpY1rFDiIhgo5WT5UoAlIU3TkNIFks8LUrCeGYnxGT2s9QAxUs+MlX49b8L7cQZF4aafAw5u66kNkkhXRyXc3n57Ka3lf2SmM7kcFtN4NsI2tNoTHlwCkLQbcH9PLOT2DbcmLnWORGx3h5eLwvP7YoF/MZZfRe4XLoPEKe09VZQnc5yq91cZTRVyJDpZt9RTYRbqd9tFpoQDXg==;25:rPTDdhZcEM2jdj8ZtgUqPllIiGuUCIdqVV8wuSjvJZwoqQb8bHjto6MQWT73dZd1t40W+Xgsm8BZ+hdRjfTLERM1Lkzur6rqcZKVd7K20A9QlQ3D97Li0HgfWlmsJXHNDMScujW+CEzVnlY7bT+PjAUzZcx7/1Ow3rUMwSJpinUi321F+du2p4Fox+InAMwVbfbTaHEAJb3q3rMsjkycVBFGoEd63dPAeopclyzl3aAP/Br0H+SODRxTe8ehDh2kasAeHzrV2WnF7B5VpqQFt31stl14aJAz/1IKp/7b2yI/8JOUkgHAOvjHiTdulqp+3+zHXaJEF24g5baV4oVTe/MJS5R4sQ50BzYZFbMEEFamZoXh9xcaHzZKKHW3FTkrydI5vkWSNBic+gnOs9CO52mIu2548DWoI7/WyEzMjRZCWauavARlbuBnTyo+Cu10G2fySlAzuJGY42W/PqzYcXGpIV9gd+8AYb+kkNIV0yI=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;31:VIfFvf3zdbFFDvDSxelPzE0GxHjNfkzQ7ymGDoNcc2fHX2Ql8ylUMFSfXLsvjbPHGtzKAjGsVFB81WhapWx34HgqJZ2ggu1EfYxa/x2waE0WyrpAw1QDEsyGvgbIhtg6+vNXk/kQ2tY1pN1DYspC+N414hvxiW0jR+Hb4KgDAIRhzLwETs32IBF7VfIKK/iqHDOiwTs+jRLABSQYekB35/VNuVnaYZvwY1yRKynQG5KvUBscHt4uLMZ/O0tKTf9NTLGC0Hqsq+KXAed/tmhZag==;20:aAs9vAusZW994IUWbR0o/mSE63Kuf6Naf1cXAmj0Uriri4Hw+bGCWo/RPFmHQthQG9ycJH8sFSYTjyKdwd+YAQeKixOzQVXCACmc97CdDb82nQEWZ33/HI8Y+0eEN0drpEg1oEQUqqds7UGnwR7xmzUVfD+U6Mypa/uzsfTisz+lMi0qQ25XJvSDOqB8ivK0oTz3n/5lNoIxNULnrm7jTfcQy/Tr4A3EI5WY/W2DWxUzrev7CuQeA18jNpT2VfO7tHeOk7lFroSLfwvtr5KML6ymLBt186A4CxD1QC2bUc+4haaqAxa7lZzy5ilQfE+wGzw6B5RFdij+EwJ6CDNmHcvjkCn7ToYxIOXMnUdtxhjyv48aVcu88LkAqhkvyfMFl8lcT8/CbWlufwK5vW1RteCm3u2J/NBRhJR378KfEU5uLOqZCc1kyJRVrYvDKUO3Kmb71PNqGkxLzQIVqMV0ed/O++3VPQ1IDKr19CTtBmNxnn1hxkiqn83djRWCfR1+On8QxzmnI78eik/nIoTnZwiV/crNSTLelveSjEsDZhrRRDLnn75hNU0nttqhv1ZcQX+zek5OI/A2SVLv7JvUMEzcjkamca3GhhWFuScPP+o=
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494CCEFF71EBE6A2B5FA8F697C30@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(6041248)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123562025)(20161123564025)(20161123560025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR07MB3494;4:7eVLHlf3ji6a1iOZR7gfzfyCnfWgEpW6QG3bHt?=
 =?Windows-1252?Q?+eR8kB6RqDdrZVjZ83CEgbnNtvu0wgWnt8fcQz3ycfngRSJIiJYb2FNM?=
 =?Windows-1252?Q?bVMWpgom8bEs3gyaY6gAbmbZBFbn7m6Oz16xkMduPQwVchAFrLlJr+TM?=
 =?Windows-1252?Q?dJfOC32PdfRe4f0ZchUvt5vm3Scm2deI71f5doiXAOKUdksjB2PCqXGv?=
 =?Windows-1252?Q?n5jzREuxy+1lByy16lhhkzYFgU5bkY0oKko+umS7rFsKKV5BLqlA1N0Q?=
 =?Windows-1252?Q?tKROoe6WeCjfb92/f6bJ4OMiD6lHD//APLT1uU7qAOQDHhTbpL25s17q?=
 =?Windows-1252?Q?zWaBJPZaaMqGdZTZoU57SclD6HHCgxwyss6N2gjW/ygL8Zypk7Z2APBG?=
 =?Windows-1252?Q?WH58MpNuUQgqjiSNBOaAE6KzWwnFvQIBHdEs9ioxeso4Sa8PupeWN3p1?=
 =?Windows-1252?Q?nHbquwYyk0/w4q+UlsGy9JLm7cqAPnAnjE3JbpPUwNctVCkO2/rgpzoZ?=
 =?Windows-1252?Q?JyXMSlUVBeIrF3ErJ/Vum5PRgHiZi+lsRIwC5cXIBgXIb7cdi0Dc7bcF?=
 =?Windows-1252?Q?vTlPBwEwYlB7ehJC9W2QYitQu1+91wQ6UKQPLWXzbUMR5u666gxQM6c3?=
 =?Windows-1252?Q?FP1TKg4/PTEs2muYFBgEPYO+gVQCrQ68M48lKo3aqZA2kuDxEEhSIcKi?=
 =?Windows-1252?Q?G6Dwe0AHWJK/DOm1hQi3rheB9OJXNfAxqQ+R5EjShZQqpVyuk0uneavS?=
 =?Windows-1252?Q?a2UtjhH29mmoTY6SlCVR2JNq/AAwVD8qUcHRaB2Acyi4hf7oGglISh1V?=
 =?Windows-1252?Q?QGIDOaLtvLgA34TYJUYnKrXJgWP8GLns1yDHaJPH6w0DSsjli9LmxoxX?=
 =?Windows-1252?Q?I/Jsu8LIA1J8fXn0DzxWXDqZ/LPuti0WtX123WAd0DedMVsPDjFqFatz?=
 =?Windows-1252?Q?Y7MQR4yCTCrlLyPeK49cv4750eemJNw19vNxjuN7NyJuo48WVxn21Xxa?=
 =?Windows-1252?Q?hmnvAhdmiMoPnXjJ2Fc6yLaY/qCY3kxPyn2jPfDjFS+y+YMmP8w3+EJD?=
 =?Windows-1252?Q?G8byKsNidPeiA5o7Hv7mwoy1Zu/A9FchJLoKg+njjeg42i5286h3yuGO?=
 =?Windows-1252?Q?BLch/w0SG+G1AqvkvbCP8zlOnX3HV3z9WYqIPCApExGoVs3RV3ZZfnw6?=
 =?Windows-1252?Q?hjWCH70WhgNoXB10ueVus5pR6lIOI=3D?=
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(39850400002)(39840400002)(39410400002)(39400400002)(24454002)(377454003)(33646002)(25786009)(6506006)(4326008)(53546009)(31696002)(6246003)(5660300001)(65826007)(8676002)(6116002)(50466002)(3846002)(64126003)(81166006)(305945005)(72206003)(230700001)(42186005)(50986999)(478600001)(76176999)(36756003)(66066001)(31686004)(54356999)(189998001)(2906002)(2950100002)(229853002)(6666003)(47776003)(65806001)(53936002)(38730400002)(42882006)(6486002)(53416004)(7736002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR07MB3494;23:ExxO7zoKqOYGixQIXRlb5lv0WdhJXXOhx4atx?=
 =?Windows-1252?Q?N8/5K+5AvibIlxMsGV1USa9v0f5seHzbK8Msk+e8gwIlC50t1zQ8MeKL?=
 =?Windows-1252?Q?mA30QMAu79lqbz9l01ChWEKggJxBGZRHOBuFpU9zHNpj2ig8hh2R8Cq/?=
 =?Windows-1252?Q?w/R8uLRO0LsW0LH7q3XHZs1DbEduCYwPC0dgmhqRbfGh7WPzE/HAf5ui?=
 =?Windows-1252?Q?PmVUgMps9efmClq6//vAO/Vjtoy+sij/7NeW6KkYbndv6gbhZD+/YMaA?=
 =?Windows-1252?Q?bhtRfK7YckHf6FvRikXaibR4IRceiWF7+gITr71B5ac3BcqeW4cdaGLj?=
 =?Windows-1252?Q?3Gyv+bZVWiW69jXUsd7Rzd6PvMMcVRahdH6qeZxQuUOFTnuvuep5L1R4?=
 =?Windows-1252?Q?T2kz+0M4PW46P6lQzdQ0gQVfD+q8I+x4jecI/fu93IqRA/KHMXQRSgAb?=
 =?Windows-1252?Q?lvflIHRrAU1qde2lmlTATt4nnKazU+7Y9K2iPBuSyfVTehgaOnBuq7lY?=
 =?Windows-1252?Q?j4AylxrWDf6iCIZKmNQn9AjD+PszgOVyqywtMDlvAMaCwwQAZLObxicJ?=
 =?Windows-1252?Q?7JNicTrIsiye2kGMykvHrVTomLfAQUaAfQTUJ8NqEhOPGt8DFVOtva6l?=
 =?Windows-1252?Q?aoYKGVhrQEVekA2DtfYVTxpltMi6/4e0MtPdUcZ0CF269dZLW86FLdyn?=
 =?Windows-1252?Q?OSYFNJiLMtcR6fDgu8zBQ/FYdkLVdhCM7K9wX0+hiUQq0pJQQMinmiWT?=
 =?Windows-1252?Q?iLyq7E6HaF5zqsq1LJ5jgVU4JXli7uhPuoYSRzCGNVXS/gTozz97W+y6?=
 =?Windows-1252?Q?gLAholIZiLFcYNMpeufQ1TYoA00/v099G/+OAMN++0l2Ni/xZhbeFbZS?=
 =?Windows-1252?Q?Zzf3orBaDLm0vAmo+4lr+KOo2ZEy96bfL63cyRp4m9F2I6Q9szmoha17?=
 =?Windows-1252?Q?jXAzKujp33rwtxYPzuyy6nIxXEn3IV605wbsd/dNLtPN5mEVX3bLDsSR?=
 =?Windows-1252?Q?i5/Y7/l/zosRllGWSmhLR1Jnuwhvb2BdGYmPZ2KgWGXecQQbIirM1kFM?=
 =?Windows-1252?Q?4DtXMxQP4u3yTD6xqR2Ik2oZFssMfSH7Dpl2UJKJcIiwK2Eyzh7OKrqB?=
 =?Windows-1252?Q?vPVFdEsYuI4yoxRpHeu36xj3oDkN0K+jQRe6CkvE3cD8SOTcQpe/XSve?=
 =?Windows-1252?Q?ZA9h3YTmfL1p11Hjv8tfyhlY8DaaPQ9UEAXKvSX+eJSh9c53zgNQ8+hf?=
 =?Windows-1252?Q?IxD2lk1vdasIRClzm2hyVSzgfttsLe42TQ2EzVMl+CuAfEWXtLF0GN8W?=
 =?Windows-1252?Q?/ig?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:79MEagr7RwZjk5w9xQzz7C4I4qg+mDLJA+Ro+IlfYHd9bVZi7NieW2sh0txqFar29qMZx9Y3k5BGL7FIr99y0Afc0PS6xq/0B5Ro1rxuNjz5rKaLvaWFuPB+N0hDXxfB2rsQtLgKLQDBrzS1EDL3DHy2H68VivhvqwGqhh7GsFL5J3DI2I+5taKZcG9VGOET7QQiSYTqSov/ATyn4CPHhiaJPXKjaSp5MF4zh6wWfQrLN2YUvpg88eIJOK+agsEbEpnYHsWHGmfz1eWyWHkcWHBYi6f8CXs71XPA3lC2bvHOzjdBHdajd0jD095gnhndKM+uTOxJz76dGEN4gU3eNOiY3G3+x0EG//S/2W04j6hGMtWIUHll0EYUXWSqqpyC89rZoWToIArhmJBWjOHjlbzj0s88LVPmO1eOc6TwvUiAmm19a2YL9e7uKBek2HYl1OJEDiiyYOS59nUxdAjZLXfIl4YYo0M7I2cucO+mtf+2/nx0a/F0UkzGyv6ipOb9ww4EiPdSRyMVZWUEkT4nVA==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;5:KvEMvyJEWLRucjm3Iaf0GjYBB6zSDTTa+Op+hDRjUV1swBHI0elH9DX9UJNkN8L/H8wddUnvsVAQbwCDdfl87MktAK0SR834mg/CEup7ZpvYokehmXMoahgDt8IEUiV66qe/0oGVEpZOmce8AHBxuBx1CH+cbec6aIhaxkie17iyvBYL+5B55oMWzsO/ztFObNEPLPz8Nqk4/T3tCe+AoiRPrRc5GZN0jAUyBUrVOr2TfXO+KTrba409XuF2QGc9a00GQTEqrdck0av3T1ND2wZz7nLRrPzw9mhhN2/syvsk+JJRHnDpmpzRij4e/S5rKu7/IVgOBGyG5GDzWL3oQq9mHazUBG8wR9kDeq4jmp67Q3dQNB/Zwp3TuhuAG4vxyh0II1f1lmOxyRRvrJmdN4aZ1aze1+T5j31BNYFMcmRMSEIoLIqfsVQiv5djx5yiN3600SDEKqNii/xB4YzjNuB3fcVK188/Z33E2rUFla/TXvqtCSMFMj2W6qNrMqpE;24:YJjUY3SrYV1o2q64yWznCSOOAQMdPABLcrPTnHMcUcxzKDdnDzwqlo6EZJ+DlmTRRmNIDdsXZ7JKUxpW6Uk+cuWEypaeTI+cBG4/KLughvQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;7:BYb5/wFWFDzQSpHH4eKkVfUPox7V5QFKyS8xuowgy/S/VbOHhK7gJtB0BzJBVSi0WuNdgFIJyZ8h50HQ9/6HuMF7PDhNMxYPAndBm3XPgGEK5Cb/1hdE1hct+HP9oKWBYKj7xvT+fJcxhlimpIknI0QqRmpzSWDFZV6GL+OtbJrUjzhN0Cl2jFy5HkaHVrab9hvM1Zl6n1j0Yn0o6t8QtfntXxlzXxUGiGHcbSDo65LgicGPNttwhZBft3fOQVQj8VCg1c7lfIyvvUL7zkIR5zMUC7v40/HJad3ViKYIu5pdZGorHCFj3TYzzHIC9kwDPyHt775wxK5+ZlNgZqdGzA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2017 15:54:06.1524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58452
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

On 06/13/2017 05:22 PM, Daniel Borkmann wrote:
> On 06/14/2017 01:49 AM, David Daney wrote:
>> This is a grab bag of changes to the bpf testing infrastructure I
>> developed working on MIPS eBPF JIT support.  The change to
>> bpf_jit_disasm is probably universally beneficial, the others are more
>> MIPS specific.
> 
> I think these could go independently through net-next tree?

Yes, if davem is happy with them, I think that makes sense that he take 
them via net-next.

David Daney

> 
> Thanks,
> Daniel
> 
>> David Daney (4):
>>    tools: bpf_jit_disasm:  Handle large images.
>>    test_bpf: Add test to make conditional jump cross a large number of
>>      insns.
>>    bpf: Add MIPS support to samples/bpf.
>>    samples/bpf: Fix tracex5 to work with MIPS syscalls.
>>
>>   lib/test_bpf.c             | 32 ++++++++++++++++++++++++++++++++
>>   samples/bpf/Makefile       | 13 +++++++++++++
>>   samples/bpf/bpf_helpers.h  | 13 +++++++++++++
>>   samples/bpf/syscall_nrs.c  | 12 ++++++++++++
>>   samples/bpf/tracex5_kern.c | 11 ++++++++---
>>   tools/net/bpf_jit_disasm.c | 37 ++++++++++++++++++++++++++-----------
>>   6 files changed, 104 insertions(+), 14 deletions(-)
>>   create mode 100644 samples/bpf/syscall_nrs.c
>>
> 
