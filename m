Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 22:50:07 +0100 (CET)
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:58272
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990412AbdK3Vt7cHrWW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 22:49:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=T4GCHGrJOXfdA5w65Y2/DYEb/6Xp+Q4nHeKevIhJu6k=;
 b=cOlzzB7iDasajraEQtH1NNdUcIUfemxnSCqrbIeXYkVVeZ8XyPFi7fx5Crha1Jf0+hVp5TdPkbr8ImXZ2MsdN9gcOF/aQ6eK/8Hep7HrnpbpN5KzHb31991rCKauEPlYo88vKyl/PCJSmyFMFY1eeYOJWzhlS8om1aUPCZXYM3o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Thu, 30 Nov 2017 21:49:46 +0000
Subject: Re: [PATCH v4 2/8] MIPS: Octeon: Enable LMTDMA/LMTST operations.
To:     James Hogan <james.hogan@mips.com>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-3-david.daney@cavium.com>
 <20171130213635.GH27409@jhogan-linux.mipstec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <54c83e6b-35e2-be38-e4f1-87eb420938cb@caviumnetworks.com>
Date:   Thu, 30 Nov 2017 13:49:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171130213635.GH27409@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0016.namprd07.prod.outlook.com (10.161.192.154)
 To MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bec625c3-277c-4a83-4bf0-08d5383c4705
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:Da1ySWvCIfjl0SQ+2yUhNSmvthnoYY4BaUQlPPoAbUba7GW6Q7Kh5g2X7TPctMGOHJZVC73udrOWycJxaxGdSHeNd+0NIH5VRxQE64x9fC+tVcInDf+a5LHjMnFyxdRQgjJrOcXzRQAGb6e9G+ZzCRMijY/ygZ7IfKK9CVJiyWR1I9jX1RYY+XWrBz35A50Yp/7rdBLZrZIWX1kfiCGyxXDthWBjDPrnxIG6Npf9BkliAzbavvkTl5iHSDjLlfDl;25:Nd2Yv/v4UHbtk7UjhYNmBqhA8IMT7WWFZAewVbudg1FvO9xCeyGAmk+d1Mj0SQsSmf8mx9E4Mh7hqvUHMhuHLxJZ7Rk1w1V4QdPr51HA3iEbWvX5fqaJIO4Vz5/HKENMLH6XFRQMCoULeLf51P2oj7mt70BOhCJM3UuxI+9kFrxxaQam3OkfL3GGpId3CyiFNHjDT+aSKAHdOE+V03FlkK0nme1Qg8nX6CSpio5gK7lB861nHQGhY2Ebozh/XiHKWqQxJbqpZRsijxNXpCXsksvlMmKdlF8K3vHQKN5+mgPIMWTAYFBzXW6lmuQc81E1tNpaBRUjZliqrEQodme8ew==;31:n9nN2U7RGu7JSr3qBdOdC/zmXbp7uwuvrEIM4nYr4p0KnjUFEkWPaJba1wgr/qGx8hJ36vXBzjsVF8zYTP8OhpFF7Y9RYC9N8f50za/UQoMs3IWVmdWrcccIOJiBVey6fplUiePKEsrY/3r7otTItiS3MoRyTi5lPwEKwcjnj5m1D5XJwDSHUzipl+wZH4O3BhaCrx+rjFOU648wTpzPup0el1F8CemXyc8TyYgJKJ8=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;20:+GI57aOLJ9htwo41Q1VxATGrB7HqwWbsVc2MgtSVMfLZxsaLKIzP2ZviOaRXxdUwqlgQfAOI9P10UQe36dUfSzU5G4mYECq+7AbLI3aYF8SppMd1yJjg/5kLT3b6D10JDbsynlSpL1oFQv0+VyssewO59UFy6vN66xDJe6bgDcMuI9+WocWenVyDRCNssW55xmjMIVWWfKWR19RN+15jj4A8TPetWKVfyvPaLv1XpB9YM6Ne5LU+saXlVjSgSG0ait3kONDBE87V9AWDEcPEoOBOBlslM/TGGjTUST6FoqTfcjPBLA107V6VLL9/nqcntGIoqPnlbrfcz/v1fdwXmjXjb5KGw5OcXWTBDPtIowKBLQnanvKsAT4DabwMKopx9oSgACk2brcoU298gG0krAdBXlHOJF1m6hBnndWa4IZ9foW7pm1mj1k636ztEypPmPCNQ1ksI+EX3yETM8okPru2g3SnHQFrcApLcdu45/xtUfv5Fpbae5NGd5jdr3+lBrDgHt0fAwZYbCzYY8po5MwZcCwz+Ep5F8oU2x0qG77qGiaFly/StdP73rf8uj6Hk1CPfxG673IPc0+ccddhssMmrZ2eXDF75aRLstQBG7A=;4:158KVc0ErrwiJzBtPzZTCPcmHhH4mcZz2PtdkDVVuDOsqDVZ28+OIEF6IWir5P4Rd5tDJc5Cdzyelu9nz4AeHvqsNMWm8PKk9HNBL1UMraSPqtSJIvdmaCY/IthV+Gp7S/7cCGewaMCtnsF/a2Z46ZBmKX5IRk4DJLAxfcKQRCRQpVq6wFL5NQgk6qryAtuJupHykeSX2Mja9hmDAF+HqDoxocUxPcs6pxzgsPFGXD9cZJeoojya5fKgFKqcJAkwrUsBe7qCwGRfg/80RPJaWQ==
X-Microsoft-Antispam-PRVS: <MWHPR07MB350101387441876B6CD1457497380@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231022)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123560025)(20161123562025)(20161123555025)(6072148)(201708071742011);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3501;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(366004)(346002)(376002)(189002)(199003)(24454002)(54534003)(54906003)(97736004)(65806001)(6116002)(25786009)(7416002)(52116002)(65956001)(83506002)(65826007)(58126008)(50466002)(47776003)(16526018)(52146003)(5660300001)(23676004)(2486003)(575784001)(72206003)(6486002)(31696002)(478600001)(101416001)(8936002)(7736002)(68736007)(3846002)(6506006)(2906002)(230700001)(305945005)(4326008)(69596002)(6246003)(6512007)(33646002)(53546010)(107886003)(81156014)(81166006)(105586002)(64126003)(8676002)(53936002)(189998001)(39060400002)(53416004)(67846002)(6666003)(110136005)(106356001)(42882006)(316002)(36756003)(66066001)(229853002)(2950100002)(31686004)(54356011)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAxOzIzOmE5ZWJTUFBSaHQrOWVrekIzc0g5SVMvRUYr?=
 =?utf-8?B?NVRmMm1tS1U1cmVZeUVTR2J5cmNDc0ZPc2lHcnZWK0prTk8rVVAzUnZwNWpZ?=
 =?utf-8?B?djhNOFpQelJrNGJPM2xpam9kYjhHNERaNUNYT2haQk1zbmZyZWJwdUpMNUgy?=
 =?utf-8?B?SHkzVUpaMnVQRnRoZFZBL2RWdEc2aHR4SElNQ0QydDhrUUNKMk1ibjZGSlYz?=
 =?utf-8?B?SS80TnFiZThUdVAwczR6VW1lSXcvcHJ0ZFF0ZXdPOGFLRUNPeHE3VFhOMnla?=
 =?utf-8?B?N2ZOdi91R1p2TWhyN21wWnpISmFZQXI0cXFoQS9jSHloUTdSdE9tZmFGVFQr?=
 =?utf-8?B?ZkpvZXZvQzI4YjErSExaa0ZSWjFmSkE4SHhHSjFPdnVENXVHNkVpUkpRWWdh?=
 =?utf-8?B?K01IOWtEbGlMWGV1VVMzY0c2WEJqcGxEemlmUjYvRmlvVk5DU0ZZeE1KalB2?=
 =?utf-8?B?a05DNlJVa3V3Z1B2SW1uYUZjT1U1UFM3a0F4RjBSRkk3eldBYjZjYnJmM0s5?=
 =?utf-8?B?aFRjRjQ3RGlldkJnSXpkMDg3NWthOGhjUGJWaDdwdFMxVElOMGhLYkZROWtX?=
 =?utf-8?B?cktpOXBaKzloODFJWWtidmZOMGk0U3VERk80U1V5RXlkcTFGZkp6K1h6UlVm?=
 =?utf-8?B?bnVMd1NVU3RwS1pmcE1IeUlveVJWODNKTDRLclduTzc3TFZyRXk2aC9LOWgz?=
 =?utf-8?B?YWF2NlBJdXhzU2V1d3Zadk1CVThRT1V3elNpZFhFSHAyc0w5N1ptWEV6bnZz?=
 =?utf-8?B?cmFJNHFPMEJybmhZYXRLUkZmSjFXZDE0QmpMbXFCK3g5TjZNZzZFMUNNQkpC?=
 =?utf-8?B?N0M0REt6MEFLMjJvWjhlYVUrZnNWbndMcS9tK2JzditKd0dDS2hiMzA2eDVO?=
 =?utf-8?B?TFJGWE9vdDZIZkRIQ0dmL2hzeitFTzV0bThMV0tmV1dOSEZtSkhOK0NCVVND?=
 =?utf-8?B?azdPUE9SU0xwSmcyVkd3T3BBWnd5YU5UaFp4bEJsc0ZCZVpkblBpTy9LODdR?=
 =?utf-8?B?YkI1SkFXVVRyRVZVL1M5OVd1UWxlWjgxa3NydHo4TnJ0S1RsZlRjNFkrRW52?=
 =?utf-8?B?UGJvekd2UWVXL25XOGtrVlBsT2ovZ25ld1RRVVlwOXF2Ynh1cGlVaHpTSFhi?=
 =?utf-8?B?SHdoWUFWc0I2VmFvcmc3blJsSGd6S21HSTNDMjViMmZVVHE0aFFmMEw5WWVu?=
 =?utf-8?B?aXBmc0dYTjJ0bnhydnEzSHV3eEJsSTM3bThYRHNLMnQxb3FFdDYxOGcrOXdh?=
 =?utf-8?B?NXExeUlUQ0t4UHJ5VVpXa0hia2V1QUJYTElYZnhXMGZuVC9wTkRFV05TcjJm?=
 =?utf-8?B?dEd0WFZUY2FENDQzTVRUS0MrVHBMVmc0UEVvcVE1Y3RRZkZtYllhRmY0Vkgr?=
 =?utf-8?B?WjZIdFVFOHgrNFZFWGZUamQ3eFJsQytwbUFCV3I5S0xTdzduckIyR0YxMXBS?=
 =?utf-8?B?Z2VldVdNSFdFdVlUd2ZCaDY0eUR4b1VFUjNrcTVnTmtxdFFUVlh6VG9HM2lz?=
 =?utf-8?B?RFVDaGVidWNuS29xY0pSQnpkamg4SjVVT3l2OGpkUnp6RmluWnhVWEg2cDls?=
 =?utf-8?B?NElINnhzeGEva0dPVUVtd3c3NGsyUGNpUFRMc2RKUXFVK1RGUXBiVStoOHZz?=
 =?utf-8?B?czRtMkVnWW5xRW5iK3ZFSnVXT0htVkpYUjZNVy9Jem5uTjUvVXhpNHhYV1Zh?=
 =?utf-8?B?dnhtTU02MHpnbHBicmlOMU5HdCtMaE1MeXBJa25QS1poZlZkY1ZHYUxMTDgv?=
 =?utf-8?B?ODJrTEZaZEhJaUdhT1ZvcmcrcitBRzNaakdQdEtydGp1NEF4TWJjNVZEblo1?=
 =?utf-8?B?QTh0UmNSN2NvNTFwdG9DeThFd0s1RWRydzNpbzdtL2MzSjh1Nk84U2RyV0xE?=
 =?utf-8?B?cjFxaXQxMzFFcXprVzl2VzEwS3RwK0F2R0hya3BjNy96U0RZNW1wUTlwT3VP?=
 =?utf-8?B?TytKdFpMVmI1RWl4bXJ5WGtCSE1Jam0vYTBzVi8zS2RxTExDMG5GUjQzZVZa?=
 =?utf-8?B?QlBJZ1FpcnM4cXNwQUtXTVh4bzdjNEszTjM3TTZoWUxFQVlkV3Z0cnl6c0Z5?=
 =?utf-8?B?YWwyNDZUMHoxY1VtZFV5QkVWQXQxbzA3QUltUUY4diswWHIwMTNNaW9BRWdj?=
 =?utf-8?Q?Ru3+lDoISWms5lgan0CqD9U=3D?=
X-Microsoft-Antispam-Message-Info: HVhBZ40hmAdbcwWRKALy2Be++3pv+Q2Zf+q/ID1F9kc0ic7BUztJHLDhpy3qYMS8wHawxujHuOrZi6bsTIUFpA==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:myyFozk2U8cBONRWYYxSnUrtCjT7kplt8EaMzSIXdRXKJgkTISawKR6MDODdRPf8b2obBxUM6rQqWEWoVUoTCcf0+UAd7uF/GfkWmUaBI7TbowYfR8wO0P+AYLZLTCJ+qeuYkFxsN2zxjriv5873fnhv+p2JZWWmAErxI0b+j9M1ZjR731P9JZlMlfonYyY3AWfVbq/IN1XMVt94/NVdPPjLEHfOC1g9nt1QXxCix3qdC+eAjI5gGZvt4KKlUsT0iheB9bL3Z0p28wQBCZMv+wgFfaYWUqDT7FtQP1r71EnRPxvsWEvPUGIjTzJtns/Eu3E3ATdZMBUoENMfz1B1ZhNo+a4GNuIGHQAP8lTQv0Y=;5:0cSmMBfApVf5s8XaJknlvFj0aaYVnR4UgdzW7atLm+kQnl//DoOIuwFvvExpdRZVjppJsBwLLndNItH+zGtk7Y14faqyEdON60fzKZjPaFHZ8R+bLL6zWVS6NIYK5epTXuh1mxg21BNjmC8KEbXXMcaM8QPULnOrHlUuhwwho+k=;24:F6AVSbSUKd6Vtz3JgJu8w2sEZ529klJngQVAbK9tSdF609Xz72cXKRayokrcPUiMg4Fw0QYtc6pvssGpfo5vL2IW4p8jWyIe8Mgx90FcZtc=;7:iNILQFADo7jTWa3UaS19xyR1Rf2TCVdSniiiecxxQE9PFYL48MDjCefnotvMQ/7lXdpuA3dY3G0FUBC9+WmZdbgGUAW5DpLv09pUOpHvFFL8ndAfzm0t+zWm4dca1vXMghr1PEg5rBvJP+Mq+kmzKW02XDjl1gEPPxOqMx7jCtEJDkxPprbTsEjZCn2usu+7f08xvJaMzH/1FrlX8nW1XjlK33OmUysMiLTRmvFJ8BUvrqhcvZYXnuB0gUuJCGEI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 21:49:46.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec625c3-277c-4a83-4bf0-08d5383c4705
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61248
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

On 11/30/2017 01:36 PM, James Hogan wrote:
> On Tue, Nov 28, 2017 at 04:55:34PM -0800, David Daney wrote:
>> From: Carlos Munoz <cmunoz@cavium.com>
>>
>> LMTDMA/LMTST operations move data between cores and I/O devices:
>>
>> * LMTST operations can send an address and a variable length
>>    (up to 128 bytes) of data to an I/O device.
>> * LMTDMA operations can send an address and a variable length
>>    (up to 128) of data to the I/O device and then return a
>>    variable length (up to 128 bytes) response from the IOI device.
> 
> Should that be "I/O"?

Yes, I will fix the changelog.


> 
>>
>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/mips/cavium-octeon/setup.c       |  6 ++++++
>>   arch/mips/include/asm/octeon/octeon.h | 12 ++++++++++--
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
>> index a8034d0dcade..99e6a68bc652 100644
>> --- a/arch/mips/cavium-octeon/setup.c
>> +++ b/arch/mips/cavium-octeon/setup.c
>> @@ -609,6 +609,12 @@ void octeon_user_io_init(void)
>>   #else
>>   	cvmmemctl.s.cvmsegenak = 0;
>>   #endif
>> +	if (OCTEON_IS_OCTEON3()) {
>> +		/* Enable LMTDMA */
>> +		cvmmemctl.s.lmtena = 1;
>> +		/* Scratch line to use for LMT operation */
>> +		cvmmemctl.s.lmtline = 2;
> 
> Out of curiosity, is there significance to the value 2 and associated
> virtual address 0xffffffffffff8100, or is it pretty arbitrary?

Yes, there is significance.

CPU local memory starts at 0xffffffffffff8000, each line is 0x80 bytes. 
so the 2nd line starts at 0xffffffffffff8100


> 
>> +	}
>>   	/* R/W If set, CVMSEG is available for loads/stores in
>>   	 * supervisor mode. */
>>   	cvmmemctl.s.cvmsegenas = 0;
>> diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
>> index c99c4b6a79f4..92a17d67c1fa 100644
>> --- a/arch/mips/include/asm/octeon/octeon.h
>> +++ b/arch/mips/include/asm/octeon/octeon.h
>> @@ -179,7 +179,15 @@ union octeon_cvmemctl {
>>   		/* RO 1 = BIST fail, 0 = BIST pass */
>>   		__BITFIELD_FIELD(uint64_t wbfbist:1,
>>   		/* Reserved */
>> -		__BITFIELD_FIELD(uint64_t reserved:17,
>> +		__BITFIELD_FIELD(uint64_t reserved_52_57:6,
>> +		/* When set, LMTDMA/LMTST operations are permitted */
>> +		__BITFIELD_FIELD(uint64_t lmtena:1,
>> +		/* Selects the CVMSEG LM cacheline used by LMTDMA
>> +		 * LMTST and wide atomic store operations.
>> +		 */
>> +		__BITFIELD_FIELD(uint64_t lmtline:6,
>> +		/* Reserved */
>> +		__BITFIELD_FIELD(uint64_t reserved_41_44:4,
>>   		/* OCTEON II - TLB replacement policy: 0 = bitmask LRU; 1 = NLU.
>>   		 * This field selects between the TLB replacement policies:
>>   		 * bitmask LRU or NLU. Bitmask LRU maintains a mask of
>> @@ -275,7 +283,7 @@ union octeon_cvmemctl {
>>   		/* R/W Size of local memory in cache blocks, 54 (6912
>>   		 * bytes) is max legal value. */
>>   		__BITFIELD_FIELD(uint64_t lmemsz:6,
>> -		;)))))))))))))))))))))))))))))))))
>> +		;))))))))))))))))))))))))))))))))))))
>>   	} s;
>>   };
> 
> Regardless, the patch looks good to me.
> 
> Reviewed-by: James Hogan <jhogan@kernel.org>
> 
> Cheers
> James
> 
