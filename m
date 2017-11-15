Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2017 20:30:35 +0100 (CET)
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com ([104.47.36.82]:25120
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992188AbdKOTa1XLBqF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Nov 2017 20:30:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eGKnNhi1k856Oq6qUyHpWSOYf/MJ7cNKao66TviM40E=;
 b=IVgtB85Hhk5cOalBlaQ9EacMF3PjCM7+C/ZAqZViXjXWQXuamWttzMgzl5Dc2IxhQq398U5j6qi+ItFoj95bXvLMWW3k1YhwoLCYsPgBlcuWe/IbUDWsEh5lOUgfc3iN9QEsVTNnjLPR8d9c6cM4+JESCyMbSyZwrKkPfycvco8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.239.5; Wed, 15 Nov 2017 19:30:15 +0000
Subject: Re: [PATCH v3 1/8] dt-bindings: Add Cavium Octeon Common Ethernet
 Interface.
To:     Rob Herring <robh@kernel.org>, David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
References: <20171109192915.11912-1-david.daney@cavium.com>
 <20171109192915.11912-2-david.daney@cavium.com>
 <20171115191857.podohd56knfd4hyh@rob-hp-laptop>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <93196fac-378f-4e59-d926-67e96817f60c@caviumnetworks.com>
Date:   Wed, 15 Nov 2017 11:30:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171115191857.podohd56knfd4hyh@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0051.namprd07.prod.outlook.com (10.163.126.19)
 To CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5445d14b-d0da-45fd-b527-08d52c5f4cdc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:y8NeQw/s67Bd6xQn+ze1XvVgxqVyXGc8B1CpEKNBKHjEB5bevRfgwm/Ch6wjyJKfaTVQ4vcNxWnHNWNwlercz3t322rDL2gWyuYJHyG0jdPnB0dQ5xJOmRMr/mHuOaJ0Hbb4yj7E9h3reev7s2rdAjewAzlvquqY6GHTqwWaCinhc5utkzPdrfLK4Q+/CtLJXyjKxsV35+rCXfY9/oe1+XAwxRP9b/wM7EYPRzC9e9/P+5Zu0h7M+fiUR0yBmNiM;25:oNtQJR11iU2DB1o1Dtlrv/LRhdBRLpcd9KXb3p8dprvpeNJPRmyZq3YpdhBttCRisS95QTIc4WKIObJKp2lLB1yG9a8ux8Da2Rj7bhs/mKenIKD+EbM8akvbx5KSNxOcfjHARrmR+9W2UlISZ1KbqWoTbJbSDWB5JCJzRIuXfZufjurdStEzbM7G+458gqWZDocQXYP6QqGsZx9JJaNV6H/+6rBXYtP3Xw/xUmzJZniBAVFHalovuBnqaZXfoKj09hknMhpADfqS1izlmcwYyqfpAUfle8jLPnuHSVSQb6aHEcvS45kWXxYm7tpljxHQSVQkl2F9oeYNjCHyvUP0dA==;31:TYYR/lcYLxBd7w2B9Olwzm0+WttN+e7dKyO5YYKh5BNJOOeyqfuB6kgfnSdSZWATS149Srg2Hbu29He5Smz0X2go2yYOs3auUQK9uZT1ee1snUuFcJ099Dnpqh4k4HWy4Hw509JBeVmkl/78FJD5sCjlQJlY2GFyOykTS61ME1/cN/G7DCVitgGONLhKl0Nulaopg+yxxBn+BG8pyaxpBI1NRdM1mezP+5DnCSJ+qpo=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:1QgsbIczOnPHo/qT9f4SC/mtaJo1gOPirmhKYkPR7xfkfjXbkJjCFHoF63WADknGaZo2qZiv3yWUs/+fFJh8zLv9Ulcjz65EzAMjcqFtGackG/L1I17QGL3W3WUZIBfKSflASBNJBjrYWpG06Xw5mW5qXGq/pMrQHQzgyNmSOqsQ3Nddnfjyc4QA+7Ye0JnZLKW1wuSH97A8vUTEn/BXEhNQpvx+lAFdMwKN40bPqIWxJaB9AKBWnMqHU1N56Zm7+L5u/6DyHs5R1EBS/A5JF16nAL6gYvfPX9CvLMcNuP2Y5oq2lljBfbFzOZYUqUVm3T6fbbG2e1iCtrxAhhDqgIGYaGyz0yBIcSRsMFPPqWznTlgx3RNM84JgCNpNY9McDzKJqsmpUF+a2er0/plOGuYT4/FxXWHZHWjOfFiLdVcfegmcreYoilXQse077FSe76cmfzCMC/El+ZVUKOFKFBILRW9SyjJ6igPRwq+d/4llUY16L8LRWySxobAJp02ql+awroMAc6UOmNMMzzPot5NibFkHGWqjvS8ZWthP0oVXNSczI5xbGIa2DN3TyW7Yka25ZpJRPc+gpU/ecwW8XJvhzc1kFrNe8kKwAO352rQ=;4:Yym//3PsTAXio8TxxUXnbsxtfLUYb6OLzhnv5Utd3Dp43nXbxJLtwuiYAs9R9ah2VZPvJgCJmMziXBqrsyJ6yzjFcfbN94K6v+K64gLUAOoFXM/jvVkcmQrldsJ5bvnEV0qzctrqauXCE5Fvb3GM8HF235vZlnofRr7qW84nm76lHt/R8SmxdFHCYiTROvk6+DNZwnJWeaQ1g6Ip78FpgNRFB6D6eXaeXDYnOrrr8tT7DwhNpv4mvjwBfuaVqUt/tbEzfu1TXrmSNRDS7JP0qA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB34940BEF975419642F6A21A297290@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231022)(93006095)(100000703101)(100105400095)(6041248)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 0492FD61DD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(24454002)(189002)(199003)(33646002)(106356001)(101416001)(76176999)(68736007)(83506002)(72206003)(47776003)(230700001)(42882006)(6506006)(2950100002)(6666003)(8676002)(69596002)(53546010)(36756003)(54356999)(2906002)(50986999)(53416004)(105586002)(16526018)(6116002)(65826007)(97736004)(189998001)(3846002)(39060400002)(6246003)(107886003)(110136005)(50466002)(54906003)(58126008)(64126003)(67846002)(31686004)(81166006)(81156014)(6486002)(8936002)(316002)(229853002)(4326008)(66066001)(305945005)(31696002)(25786009)(5660300001)(23676003)(65806001)(478600001)(7416002)(6512007)(65956001)(7736002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk0OzIzOkZKT0I4enBZL1dTdk90THROQW1zWjVsWVF5?=
 =?utf-8?B?OXBSdVUxeXRjbzdndDVHaEgxMXQwblRHdnNrdE5NWDBod2wwTDJlczN1SVdj?=
 =?utf-8?B?Vi9FaHRQa3htUCt0QjFmYTNvK0kwQ3pwdy9ETGZqSHZYNHRTM1MzdmdTaWZR?=
 =?utf-8?B?QlkrMisxQkpsQkhRWmk5cTJMcnE4OFdOZWhnZkxERWJTNTNIeHU1cVQ5RitR?=
 =?utf-8?B?VkJVTWlDcjlTbmN1bldWT0llVGhMcVdEcm5OdjB6VXRHM2NuejdOTTRwSFlu?=
 =?utf-8?B?L01DNWxtS0t5YmRiY3hycW5pQytTV2txUlF2UlVpQndGRXE3cEJ1aHB1WjRN?=
 =?utf-8?B?NkFZd0NURzhhVVZBVW4vWTVobngra2lUa2hJaUQxZVhsV3F1MmxGcndPazZi?=
 =?utf-8?B?WEZLR2hRc2FFTVVucnVIN1E5SU9oakhMQWcyMmowdDROT2R1Q2dYU2dNTVFx?=
 =?utf-8?B?WXIwNnZWM0gxWTM4clVObnRabHpaMU5ZTlliZ3ZqUXl1OEdhSXJ5ajRlMENs?=
 =?utf-8?B?VXJBLzZkNUhNVTJra2ZYU3Q1YWo4S0JYOSsvQUh6RnkzcFQvOHoxNGhKSTZ5?=
 =?utf-8?B?bnRGQzNaenZlNEdzS3ZndmFtOWRiOXRYQmtFZ0llVjY3L2VUSHdEL1NuNEE3?=
 =?utf-8?B?aWx6MG5pSDBjL2NtSVY1cDl0NXIwbXNxMmJKazZDN2V6ZXpIOUczVk1FdE1B?=
 =?utf-8?B?SUo1Zll4Zk41eEJMK0V4Q1FlMWVibW1XYndHVWlHMVJRVzVVVWlxcWU4MFcv?=
 =?utf-8?B?UkJvT1c1QzRjMUs5eFcyaDFzMHhGU3lzVXp6ZXNvQXJ5RjVzVlg4SHRqTlJq?=
 =?utf-8?B?TUpwZjBNNVlIUEJZYWc0UGg2QTA0NlVXcDIxTXJ0eXBoMDNOV3FyUzJUZzNs?=
 =?utf-8?B?U2lpYVl2Z2xSUnNlQmlLY0t4eUVlNzI3MnFCcDdWR05LSXBVZ2lzYkgyb1BI?=
 =?utf-8?B?Ym5JY0V5aENGaXl5bndNaDVtK2ZFbmFaRlpzR3Zrb0dhMk5YY1huZWNBY09q?=
 =?utf-8?B?VVFiQ0s1NHJScWM5cW9NeHIzMklLcC8zdXh4MXRKRnZYMEJEOGk0VzlWTzZt?=
 =?utf-8?B?UDBmbmxnQlhZdm9lVjhnandEQUFLRGNTdmtBY1lXR0dkbmhwcDArWW9PeElC?=
 =?utf-8?B?Ky9tSE5WQTNzUldWeVp2S1F2TXRkTmpGZUNqL1ZZSFUzdVl2M2hxVk5icWhN?=
 =?utf-8?B?ZTBoTFp6NkUxQVFEL3dIQUFrTllHemRpbmpodlRYSnBYalc2MXhLY2F2V2ln?=
 =?utf-8?B?cFFXUHI5a2ZxT1QvZ2l1SHNianMxeGw2OEZHRUFnN3EyRDhaYm0vcUptclQ4?=
 =?utf-8?B?VFhQTFVMZWlLZlc3cWlvL2MxU1NHWTRpUFBmV2pObWlKMTdnRUdGUFo1NTUy?=
 =?utf-8?B?TmhuYmFFQ3JTMWI1QzJqdnVEdCtBc0I3WjFXWUpCcVl3QmRDMTQ1czVwSGVD?=
 =?utf-8?B?Wm1uUE9QRDlnYTA1MjI5MVd0bGZSQmgzMmdWQlFIY2pxcXZBOWM0cExUYTNX?=
 =?utf-8?B?Q0wzdTlwSE9lR0JITHBZY0VHNkRFSm04eXhndmt5Q1k1TjhNajBLdWkySUFm?=
 =?utf-8?B?MUs2TUtnamVRZlF1TFRaZjJTTDFYV0lHYWJ1KzF6N1N5dWRmeG5BUDdsQ0Fx?=
 =?utf-8?B?M2NBM1kzSFRZMjVERUJMWUU2dUJvZ2RHdzZHTTU1bVY5YmV0dHNDakd6RzM0?=
 =?utf-8?B?QWJwQTJmbG5WZGVIVFBQMUpvZFRmNjdDMGdzNGJkV25xa2tBZTZJTk1UNnRC?=
 =?utf-8?B?L0w4NnNOMkJRclRqYkZxQ3RCQVZRdktWZUxDVXZCdkVCc1p2UmZPQm9Fc3pp?=
 =?utf-8?B?ZnR4d01jSTVTNVJtdjNPcTNkMklnWXRFbXlwTG1oeW1GQWpCTVVoMjhhUlho?=
 =?utf-8?B?U1JZSnlyZWdMSUJ4N25RTHJNRmxLWHRWNVlXcFVMZE5IT0VJYW9sSU51Z1Z5?=
 =?utf-8?B?UHRCektRVHU3dXNseCtCcHp4RnV3VW9BVnJJRzVvNzJ5TlpZeW9zbi9NdEty?=
 =?utf-8?Q?cKacla?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:B5zmCkc5TELiHyCBXIcw6s1zcS99sS25LtTxb8OKl/BvbcF65wqdg2bjWQmsr1ElQ8/HjVeODPcQkh6mc8ousUqymY1UqEnrDCBDR7AKhKGFq0f3VrN4m5brwXUD2YPIdWKc0kghvirwdgWKCEO0pCirqZOqNPTPFQy8KLTXqVF+qbatzLu5cdfe+LFUYI0qtstFwqNxiiZLsgDpBO8prf7644MZQAX/UwuGT4YCZl+mMZA+8XCeRvMMZll/SN/RFSUXQzL1asSCw3uPvxzaZNE3ylaKlT9bhgk1B67QkaqEJz0vVgmRgfJZVFDgxJofa/Q1sfV1neO3J5cGuTVsQ2sKU4fBC72QkWlvzlvhuts=;5:/D8mb1PZBXcHQmQLRS2MItXNRMDR49ixdim9h3UN9WmZ28p92sN0LR4Ecd2lQi7qVIMy3m8eP6yXyHuRYJbZcAyOrsL6s18fKEZk/phlo/sHCcYo1T8KdYNyiDrHtO/kmTeTwdGTnQk9nnN65t5k28btZZEYlfC6NkobjqzKAtg=;24:QggurnpDQDqSdG2na7ik55tx+rPxZQGTmv2410BOHYjFQ0Q0H44dg0pyT4nrRd/ikilq+4iD8qdX8gKu46Uz+6hQT8CSz+cQrfQSJVwdTG0=;7:c/gKy09JWeWbjAArrNj7R5M59IRBL6E25831CewdaZMD9eBihXfxye/hp5vBcUruHMlFsh6gBHqKT4Ug+5zW9cbNakTVjh6lgNfw4DAbtajnIG+ECKBXjuUGCLNtDYh9XoUqKtFrvHx61XXVDT97+tm851lYMTpf8/bUATMYDZMIde+EOAyQeZUaS+6MncNUZFbgsm+YWT8m1D8lQMzu/AQ3XQAM9WUAS//NdxBWa/iR/vnbJqvuMcCmhbmNdfzr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2017 19:30:15.2559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5445d14b-d0da-45fd-b527-08d52c5f4cdc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60962
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

On 11/15/2017 11:18 AM, Rob Herring wrote:
> On Thu, Nov 09, 2017 at 11:29:08AM -0800, David Daney wrote:
>> From: Carlos Munoz <cmunoz@cavium.com>
>>
>> Add bindings for Common Ethernet Interface (BGX) block.
>>
>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   .../devicetree/bindings/net/cavium-bgx.txt         | 61 ++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/cavium-bgx.txt b/Documentation/devicetree/bindings/net/cavium-bgx.txt
>> new file mode 100644
>> index 000000000000..6b1f8b994c20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/cavium-bgx.txt
>> @@ -0,0 +1,61 @@
>> +* Common Ethernet Interface (BGX) block
>> +
>> +Properties:
>> +
>> +- compatible: "cavium,octeon-7890-bgx": Compatibility with all cn7xxx SOCs.
>> +
>> +- reg: The base address of the BGX block.
>> +
>> +- #address-cells: Must be <1>.
>> +
>> +- #size-cells: Must be <0>.  BGX addresses have no size component.
>> +
>> +A BGX block has several children, each representing an Ethernet
>> +interface.
>> +
>> +
>> +* Ethernet Interface (BGX port) connects to PKI/PKO
>> +
>> +Properties:
>> +
>> +- compatible: "cavium,octeon-7890-bgx-port": Compatibility with all
>> +	      cn7xxx SOCs.
>> +
>> +	      "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs
>> +	      for RGMII.
>> +
>> +- reg: The index of the interface within the BGX block.
> 
> There's no memory mapped region associated with the sub-blocks?

No.  Many of the sub block control bits are co-located in the same 
registers.


> 
>> +
>> +Optional properties:
>> +
>> +- local-mac-address: Mac address for the interface.
>> +
>> +- phy-handle: phandle to the phy node connected to the interface.
>> +
>> +- phy-mode: described in ethernet.txt.
>> +
>> +- fixed-link: described in fixed-link.txt.
>> +
>> +Example:
>> +
>> +	ethernet-mac-nexus@11800e0000000 {
>> +		compatible = "cavium,octeon-7890-bgx";
>> +		reg = <0x00011800 0xe0000000 0x00000000 0x01000000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethernet-mac@0 {
> 
> ethernet@0


Good point.  I will fix that.


> 
>> +			compatible = "cavium,octeon-7360-xcv";
>> +			reg = <0>;
>> +			local-mac-address = [ 00 01 23 45 67 89 ];
>> +			phy-handle = <&phy3>;
>> +			phy-mode = "rgmii-rxid"
>> +		};
>> +		ethernet-mac@1 {
> 
> ditto.
> 
> Otherwise,
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,
David Daney
> 
>> +			compatible = "cavium,octeon-7890-bgx-port";
>> +			reg = <1>;
>> +			local-mac-address = [ 00 01 23 45 67 8a ];
>> +			phy-handle = <&phy4>;
>> +			phy-mode = "sgmii"
>> +		};
>> +	};
>> -- 
>> 2.13.6
>>
