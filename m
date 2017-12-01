Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 18:43:10 +0100 (CET)
Received: from mail-bl2nam02on0089.outbound.protection.outlook.com ([104.47.38.89]:22665
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990754AbdLARnDG6PRL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Dec 2017 18:43:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oFSH+jtT75Pc8Vz8LyiFOXkCqvdFPxx8f7waiP7GDJA=;
 b=SoaMAjWxA3HK6zLaZvpxP4qECN/pDIS4uvdAJmuKrWPNxhmj02yUQhX/wqK+Osnp1c0+0/sJnDTyyR71E0tVbe8lZvXdhI7dKgjJMgLEMCk8BZqJ1x9BUmN+6QkDqepzRIcfz1wa/sqCFk6XlxRNqwuuQXaIdV6eAIbkwVWZMK0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Fri, 1 Dec 2017 17:42:50 +0000
Subject: Re: [PATCH v4 3/8] MIPS: Octeon: Add a global resource manager.
To:     Philippe Ombredanne <pombredanne@nexb.com>,
        Carlos Munoz <cmunoz@cavium.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <james.hogan@mips.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-4-david.daney@cavium.com>
 <20171130225333.GI27409@jhogan-linux.mipstec.com>
 <CAOFm3uGhRTTrvygBd0dMdzWZQC5kFi8yXuWQsnhDvDLtW2z7aA@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <99dd185d-6e5d-f474-90aa-ebee63045c42@caviumnetworks.com>
Date:   Fri, 1 Dec 2017 09:42:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAOFm3uGhRTTrvygBd0dMdzWZQC5kFi8yXuWQsnhDvDLtW2z7aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0014.namprd07.prod.outlook.com (10.162.96.24) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2e41c29-f68d-4702-4605-08d538e2f273
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:tRAI+STYVQLAfPTq1APy/gOlYh+gl7HnhkPaUN6QOL40WDne5ly7sH58PGgMG0lQwwov7dovhOd1Su8cOl/YsZLN8nxUxrrzIWv3g5hbk62jQhQsTgHeyaN2u9XAibpfqZO93W4EVwlCdGr3+n+b6W3Z/FX2T9JUSPYPvO0GIgCMMcuQa/tOKipQq+PK7XI2JSmqINdr/vW5nesg12AL0h1cfZ+wNNRbWKynjH2xNQSLSye35Q8uu8d5vUyyhdNy;25:MKrNOyfQsaMVGzwq8LkGHJLy83h0MAgA3hdVEcBUvEFc6mDhELTUnAM1sgvTgcI7grOqVRoXr4rK/5XH+um5wctvuv2SOeOBl0a3nOMWiUkylxElgib/ExRynazF0V1Jk+ySDBnalb2gTgjDBjrSGgPgxdbzfqaHV2mt4Ac38VYMKjZPNUhzP7iceXCAwsneIT7D5qALTL6Wlg076TvZMLWx9oR1JlGFUQl1SFgVyP+2aCfI/wap3ljQxmPBnulM8MGX355gP69nej8Cw07RRsbnOu/v0z7bAyJQyWiQ/vUod47ejnTh9ik7O0zkheXsUzh2HczKWc48b5lCk+OvNw==;31:etWX+dxg2hM0aWdnRKfGQN4OMcUVccu5Vu3j1FaSZRz4ie+8FwRGBSWRisk9LtMaMrYFZo78To26EvnBgIXaWELlsdf+wE3f94BBRRBt15GZC1DjDjtECLWvGWTv8Imz5Ubv9xU6FMivEA56cU9Hx8mNjLsxePZtw7QRVySp8obhridpD2iDuUnlY0aiPLmi0hiHNoxiPvGNmMPTKg+YNg/7cUYKtZ1P0xT1HpnUCXg=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:aHuzs6m+xmnUscwkU+pu+gMCMXqJP7KfDl7E5JSjQGtcdpLRehlXjc5sY7Q5FuqoHy3DVw7QbLy8HHLAv6JWaoDcE6lwtpxM9VLute7Bhnbnm6ZwlEv9vfTDGYAgw1bJkpIKElgJ6yTnXiSomxyX0sgB+dwmnb9ZXTWbueM0+egzUakmmROUp29kCy8zbXK9zn+bxrMi+KIQhEzbDfL+VOqKoy/0YiNjDX/DaFsNK5uDU2icpZa8dCWfzCvRGfZh50GKL6gfhJToHLfD8ihvMpvYCS6sFcm1gipa2RAm0nUomVrIkDUS/0LiOwSXGrERlGB3XHIZmrFjoFXTz4FCH4vbiSfOPSPHhCyNqOUxpv748HUK4Xcu7e3MhM1KVzAWxlLYK1e/hXgQxHXo3dX8L4vU0TgdT7mBy0QKKuZAqh3dYRkg9IZFcfvDO/2I8lG4VYlJwu5UObnBDjBJgi2RvoroRkrmRDzx1SghMLN3WZhmNEA2cJi33cR2qeJZUo/VgH5BkFFAbVvIUjYn5dVrK70HB0kuk5uJBJ7Et/JcivDp2CW0ONJFeTJxpsbRy57aw05kLm57qSYepp9/Jng12xFtjTRHuWTgej6rP/wOn/Q=;4:eCQEgEbYGe89VFzRs3ZqGOzepLvNumCvMmG0MIheNmseIfcMSzSW0EQp44U2IlMdmilqQ0ATsFmJJM1myM4RfCcxZFy2OR5Ad/E3k17KR/zsboT+SSnh2nLwdtp1VEaZciiWlWOSGZTYOLjD5ZkIOXCftttAUYv84P18LG8spqjl4T5WrvHNAvc/FE8qNm6IyvrbSw8Ys5xssXJd5XlKIZHkuLY3UYgPxssUCLege49gd2S/iMDjeeg6X9VE4+t1F11tBYgEHRirfazleeur/A==
X-Microsoft-Antispam-PRVS: <MWHPR07MB3503A810E7742484C6AEAB9597390@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(10201501046)(3002001)(93006095)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123558100)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(366004)(346002)(376002)(199003)(189002)(24454002)(6486002)(6512007)(6506006)(33646002)(3846002)(72206003)(189998001)(6246003)(4326008)(39060400002)(53936002)(83506002)(230700001)(93886005)(105586002)(6116002)(106356001)(101416001)(69596002)(65806001)(76176011)(66066001)(67846002)(65956001)(478600001)(68736007)(25786009)(47776003)(36756003)(31696002)(31686004)(50466002)(64126003)(5660300001)(229853002)(16526018)(54906003)(58126008)(110136005)(8936002)(7416002)(7736002)(305945005)(316002)(23676004)(52146003)(2486003)(54356011)(52116002)(65826007)(81166006)(53416004)(97736004)(6666003)(2950100002)(42882006)(2906002)(53546010)(8676002)(81156014)(43860200002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAzOzIzOkl2M1BKZ3JKQ2hrall6czkzdFprM2U5d3ZC?=
 =?utf-8?B?Sy9YU1R4V3IyVHFBanFKNmRjaHIrZ1pXUUcxc2xtVUtIai9hTTFvbkxTRnBa?=
 =?utf-8?B?MTB6Z3NPMzB4UUNOS2t4aE1RbzVhdzFyVzVpeTBBTkt6dkQ4eFhJQTVlR0l4?=
 =?utf-8?B?TnFtWTV6UW9PTFgrcHpBQkN5T3ZVWEVnQitaSFYrS2RYZjdJd1JlSUFmZ2pM?=
 =?utf-8?B?Sk1zWVdzZHJuNTI5RzBLb2t2eE80ZFRXLytSYWJKYUlJMUxybjAyaDVRWHdY?=
 =?utf-8?B?ZkQzQnhXT1Njblg4UWhRalYzSTZyRU1sTkdqMDQvUkdWb2htRTRRaWgrTjMv?=
 =?utf-8?B?RnhTU2ZIclVVNW10eEVsL0lYTU80QTMrSitWTHhuUkJseHB6NSs2bHg1TFUy?=
 =?utf-8?B?cXhpOWplMzlzUFRUTmV2aFd4cVFuOHN2V3loT0xDdEJCcjZEZGdEc2txWXpS?=
 =?utf-8?B?V2l5R2VNTDlQZ1FFNWU1QWl5cEtQQzh0Z1Q3SFhyTEtvOW1IakFiQmtBbWty?=
 =?utf-8?B?MExsZlVtNE1LNjlJdHNlTmtzZWFJVDMxS0pZRG00Zzc1SnpsZVE5SlFZQ2wv?=
 =?utf-8?B?ODBCbS8zdUEydk9MVW8raFhsNVA0bUt2T05UNVJUdVgyUHNVS09tOGN4cE1O?=
 =?utf-8?B?d2trUnJJcVlSNWdTTldrcUpid2pSM2NUUDVUakNOQTgyOWl5ZHJ4Z0ZXWnF6?=
 =?utf-8?B?eGo0WE9jeFFYYmsyNXY1Z005czA5dnAxbDFIL1dxVTBLSFQ4eTNhMU5CZlQw?=
 =?utf-8?B?NmVGZzRYVVhNMnFnOGNxTTM2QU9NbUQvTzh6UzZtVDllVGZzNllOeEx1cTBm?=
 =?utf-8?B?dlNzUEJIcEN2bmFNaEdSSG1iV05DaXFtTm9jRnVnYUlIeExBTjhrZzhZOTZC?=
 =?utf-8?B?UEFuM1Y3MnNPTUsxSW9RaVY2SXBEN0Y3clR6ZEdIaHBLYzB2d3BqcU9adzZv?=
 =?utf-8?B?dThCWjdOU1RLdUR2Yy8xakdvbnM0RVg1M3d6UmhlcEpQaGZ6dVpMYSt3cHhG?=
 =?utf-8?B?aWx0UXhZOWIwcHB1LzFvVVJqbG1rQ0JUWnlYODcxbEdEaUdJMmlvS2VSNkM1?=
 =?utf-8?B?SWRPQXQ4S29tc1VlWjhXN0xMeDEybzdGYVV4QnhZa2ovTWpaMXpwUVJ5REJY?=
 =?utf-8?B?RXhxdWhxUUpOWnkvMHJpMXZYZlRocld4TTRPU24xZUszQ0FkK1BHcW1KM0xY?=
 =?utf-8?B?K1A0SjdiaVpYS3NBRmptbkpUekZnNmlIdzBmZEZyR1NGVkJJb0d1NG8vb3pU?=
 =?utf-8?B?UkFwTnFuNUJ6bmJDQmxaRWVpWVdYQWJReHorTjBhanh6b1Y4SVdqNWFKOExw?=
 =?utf-8?B?cnRHMlFIK1ZBajdMcU1lcmpkbStPcHlGdmcxbWVyK042Slg1TG5xU200eTBp?=
 =?utf-8?B?VldiazNSRXVGTTVYZGVtaHl0ZjBSN2dNNkk4WDVJZVZqYWthbzJKN0d3dXpL?=
 =?utf-8?B?NmpJRk9aM0xWSThkRGNvUDZTTnpGTitmVThaa2JlZmpQaFpaRlB4SUVLT3Np?=
 =?utf-8?B?R09udjdkUzRwNDIrakF5T21sSVlocFRVTmZBaXNEWW9yTHhSblRxRVhHKzRa?=
 =?utf-8?B?RU5IV2ZmNXdseG5XaFBKOTFucVFRelNuNHJvWHRubDBjN0JldjVGODlYSXFM?=
 =?utf-8?B?QjRtck8rNzFrUHNpa055SktOUXpONVVqWFpoWDFORzFzNWEvdzMzOENxeXZC?=
 =?utf-8?B?RXphZzN2RzhlMWNrWTJUanZ5bUVwUnR3L2lJM1o4WGRlUzVRMENaTUxzQitX?=
 =?utf-8?B?YUtTRGJlYysxR1ZIWkpGWXF5Q3J0TWpybVF6T1hJN2c4RnN0M0FhdUkzaytJ?=
 =?utf-8?B?NlJkTlJNaU44VmJnT0U1Wk0wTHE4MW1PcEhsU2xxNDJPcHVMSDdHSVkzOTZR?=
 =?utf-8?B?N2hPQnRPemxHWHM1ZEpsSWhXN1QyaW45Z01mV1ZhOE9rMGMzazl5dlJTV2xk?=
 =?utf-8?B?amhMZ0pLU21OTVpuaHR6N044NVlkcGhTcDcwOXZQSGRBcWlqbzBHc0hCclh1?=
 =?utf-8?B?MEljbnA2aXN2c2d6Vm5sNTJDc2Z0MnRqV3RENEY4TzNaV3BhV2JHemtoR0hY?=
 =?utf-8?B?VVQ2VTdoOS9RMjF3eVo3TFBVeUVNR3dFOE1Ubmh3VUhHUVhzeUtBeDBhek9O?=
 =?utf-8?B?RWc9PQ==?=
X-Microsoft-Antispam-Message-Info: J785spvJGdmpQysWkh5tBIbuN+ES+P3ciWIBlJ67aZSeRenjN+0v8i0kcNu8YOlmZX4Sm2ayCvykfYtnIL2btg==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:Cr8ivu+WYaNmuZZUbQupbVpkQhfeOf4RmhQltaRQBMrntdNBu1KvR2v8aKL5Uh31p/Dd0ZJrfsoAV+drW6ByAkATL9EURJKOy0j5dkB91CdHxfeG8R3e8Qg4nl9GPIjA4WIvU4RrBHZyRYqU1vkEq07NsH0IaxGb2Seux4XMaSnkD0iOR/BaNqCuqclIPT1ncjd12kMNFJBO72wPFxAeUzytECEOLdHBYMuhpHxMcFiTn7HgHuMGQaLUAQnuOSnm2S4B8ZImDJUz6/8xfQyuugWyuJhW0PpcPMbiy7QoSfCV3HGH+puNAznDd7PLvajJNQEpYyoGDSROOPD9CK0YSVV2oKjpVqL+UW0Lb229Ocg=;5:dd/C4nrK73KYobtDMP/sfD1Po7sMhRADPImOxm+cHKhjZkVskwKcHFI0y9OSq18ovogsl6Peq0a7ZQc6WUcnMdLoGz4DuJpJrxJJ6LuZPIIv2m4c+hqTPY2Azo8SRxgctHcwJNmLd7GJGrTt6rzBZG9N7QYS7YQ9O/806PW6TK0=;24:uBw4GeL/Lh9YF2lNcjxTveC1xTw041F7sBIcF/nOIwJFGrH3qaCffrzLRVqeF4dQ79PpQAepzeF0FJiZRbfdIBamhzz0B6GARCmTXS0a4M0=;7:4d1hqzEIgzip9k2M9zAuD+q8YVWojtj0LJdcwz62jsUprhzZSZ9lUSOnmowC29gcOxnAYkSq9h5fykuIabJPEgt7syuF8+qe4aBuifx9qCLN+QmorkHFNcrxFXFe45QejXSqLpBUXwSQ7B0wiQH2b4EeCZrFkcPagvM3JmbVvs9D1DHwVxdmuGqao000u2l/PLTe+DBxPXpHIxSjZGu3rvxWjzQahyCfJnLtoUZbwuvibP2zgGdUyQSqgOTDaj6M
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 17:42:50.7015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e41c29-f68d-4702-4605-08d538e2f273
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61264
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

On 11/30/2017 11:53 PM, Philippe Ombredanne wrote:
> Carlos,
> 
> On Thu, Nov 30, 2017 at 11:53 PM, James Hogan <james.hogan@mips.com> wrote:
>> On Tue, Nov 28, 2017 at 04:55:35PM -0800, David Daney wrote:
>>> From: Carlos Munoz <cmunoz@cavium.com>
>>>
>>> Add a global resource manager to manage tagged pointers within
>>> bootmem allocated memory. This is used by various functional
>>> blocks in the Octeon core like the FPA, Ethernet nexus, etc.
>>>
>>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> ---
>>>   arch/mips/cavium-octeon/Makefile       |   3 +-
>>>   arch/mips/cavium-octeon/resource-mgr.c | 371 +++++++++++++++++++++++++++++++++
>>>   arch/mips/include/asm/octeon/octeon.h  |  18 ++
>>>   3 files changed, 391 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/mips/cavium-octeon/resource-mgr.c
>>>
>>> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
>>> index 7c02e542959a..0a299ab8719f 100644
>>> --- a/arch/mips/cavium-octeon/Makefile
>>> +++ b/arch/mips/cavium-octeon/Makefile
>>> @@ -9,7 +9,8 @@
>>>   # Copyright (C) 2005-2009 Cavium Networks
>>>   #
>>>
>>> -obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
>>> +obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o \
>>> +      resource-mgr.o
>>
>> Maybe put that on a separate line like below.
>>
>>>   obj-y += dma-octeon.o
>>>   obj-y += octeon-memcpy.o
>>>   obj-y += executive/
>>> diff --git a/arch/mips/cavium-octeon/resource-mgr.c b/arch/mips/cavium-octeon/resource-mgr.c
>>> new file mode 100644
>>> index 000000000000..ca25fa953402
>>> --- /dev/null
>>> +++ b/arch/mips/cavium-octeon/resource-mgr.c
>>> @@ -0,0 +1,371 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Resource manager for Octeon.
>>> + *
>>> + * This file is subject to the terms and conditions of the GNU General Public
>>> + * License.  See the file "COPYING" in the main directory of this archive
>>> + * for more details.
>>> + *
>>> + * Copyright (C) 2017 Cavium, Inc.
>>> + */
> 
> Since you nicely included an SPDX id, you would not need the
> boilerplate anymore. e.g. these can go alright?

They may not be strictly speaking necessary, but I don't think they hurt 
anything.  Unless there is a requirement to strip out the license text, 
we would stick with it as is.

> 
>>> + * This file is subject to the terms and conditions of the GNU General Public
>>> + * License.  See the file "COPYING" in the main directory of this archive
>>> + * for more details.
> 
