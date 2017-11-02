Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 02:26:58 +0100 (CET)
Received: from mail-sn1nam02on0046.outbound.protection.outlook.com ([104.47.36.46]:7840
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993095AbdKBB0sfpXIB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 02:26:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3AwJmb2A6KV6qiddyZORGHb8IdR1e5z8kbOsU154h7A=;
 b=hNK2pE0THsgbCxxjem7q3ZiRWWLGf7Ikwj9WS9+lJiKl1d7ktfFPyO6o0G1O23tktr19VY8qkRpc/bdJ+6kYSkpMhaAQVM5/jISYRFZlN4uhNojgR4fLPQ3T6LZ+bxCir7WG7LVA4HM7/FLhcMSV6YDxcaN24eDx9km/n/COKWs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 01:26:36 +0000
Subject: Re: [PATCH 1/7] dt-bindings: Add Cavium Octeon Common Ethernet
 Interface.
To:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Williams, Aaron" <Aaron.Williams@caviumnetworks.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-2-david.daney@cavium.com>
 <af0de889-a34b-8346-9eeb-171498cc61ca@gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <f1995841-126f-18c3-6e94-d7c854ec97f0@caviumnetworks.com>
Date:   Wed, 1 Nov 2017 18:26:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <af0de889-a34b-8346-9eeb-171498cc61ca@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0006.namprd07.prod.outlook.com (10.161.192.144)
 To DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8224f00-0e51-4051-d7f7-08d52190c35b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;3:JVSHBtGzcufxbpDzaH0qRQvM4dsKmcxmEXx7MTea0N5XSTo/hgG0na6CoRQ19gw6oolpPCotMmhtKUU76rEwbrpZz4aTHFdnuaLjMJk8WEFxAvvRu+qDg5ncBdoegQcNy86Pfyg8rKBgUR+G7q6MAvHy/vDYGayYZuu2i7eSrsTrvM0nizyET99eyiWJd8FWZClcTRy96W9Mirtdqo6lEbdii72XQT9zWRaWyXCOGa3ZPVAbLp/+80dzUX+pF3/P;25:La4G7eQGAWz4su6cw4OOGIXxVG2etgirfC+/YGOE7cCEJpu6jaLHGczHnE0bGZR9zZuofCflIewl0KqjUNlvhE8EAD6zm85L34D39tGZFyHXKOlQWawRdLcGABh8yhjgs4SqMxnebsDg1UBSlFyeVkX9vKDeiaUFTexOpXiPVY6Wq7K5kC/k+08n3eyDTkFpD/1KtJp9Qd4+X4AQD26dgkv8c9SjKA4/7qmQZBuuQYyOmXNBZiRPwLgEOXQk8FQhdeQAO/MCfrQi0HHzhd5mKDb2wGkJLAs+HoFLyhtQhNaDmM6zJQAA8irtzUzaLDf+bCQdCC8ck8utdYgI6UMLWQ==;31:mycOvgy04v4czmCw2Hh4tf2cjmx/rQlANCw72UydbsPrwMKa16If5OGIX478IbVYnkdpYMpM5po4+q4tw1EafAtsjltrTOz7Ouy/3kYXhPYfD8SGk4UFyrTPNYxz1+oyNBYcmF4S/OUPyqtf7rusZqFDcQij8BeVlAoabUjPcZ3p98rtipA2Cge8gty/n9A5/5OPvkAdt19yc/HwdLwywHsDd2Dq+1HB/Gs9dbuZcn8=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3497:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;20:3ugirFsvKXeUoKvWVh5kJ7ZpGD4SNBSM96hQJJzwL6BJdxXDVvwFIF4eY+7wcHT5merUiu5qJbrOR++FO7FtFYovoWe99ZflQEZIugLPjs+DVR/zlZVqSYtghYkehpl8IEWkJ8NFcrq3JDcaA8cWPfU0d6q4mDo5Y7FNiwHytXTt6vygjTJZOD0AdmTE+I+WuOBtp60ppIM/QYMq3sFHIqEIV2KUwQHnMrJ61L7aoILp+sm1NCcdfw5OdZFoEIrcCBxJNXrResV0b1RIzugu18HCxEVj9IlBD7LEiaS6xnWCe/Sux9TxMIiFNhFPVAkzHCVqoKNT+HAPiDzBCmkHhdPY0UB6tTxwKyW6pcrsFfKQXYUzKgktwIvcb5EM3uDLasVq2lnt8qCbRZDsCJBW8X76QVx1zB+tRNjdurHQlGjBUIxjKmYeidWWSvkCDqxmieqhb8HWu7sTqvEP4fjYdkwDdoc/2VP8emwF253iLxXO++BQ7zjcErqTPjW83wB+Xw40COa69bmiHx0yMSf6BgOxQoKu26helQv+3vArhJCEgFUGu/A9Wlq4tEOQ9v5iD7hxU/57GlqUc1j2bSIuuLTSytRESgCprlAtNU3b0Ko=;4:iDxMEQTKxXLpdYo8L9pqz3SFCrKn82ZhC1IeebnqwvnPkaVSMNB+TkvIbS1UUq3Uf6UE3HbDK3h/iDEDU3DepeE0MuXt7mqOnI/bvSVkHbgZPLnYjmI8dWe/fkpkesoqeuMJN7F7zcqv85Z68wZUiDJJ+p8IhTRpPsUaQZyaIkI2HYSckJyXwBiKcJfcwB5k5jeC1q3UOJ2BYZFMMqfUlgavxizOVFujD2OKNwT9AeNlru/GQEoHxNBI0kyYrNRe5Xo+WqVHxK78rZK54LlNwQ==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR07MB3497D88517E8B023F52421EC975C0@DM5PR07MB3497.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(93006095)(10201501046)(3231020)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(20161123555025)(20161123560025)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3497;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3497;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(189002)(24454002)(199003)(7416002)(54356999)(39060400002)(107886003)(66066001)(6512007)(65806001)(5660300001)(31696002)(6486002)(6116002)(33646002)(65956001)(229853002)(6506006)(2906002)(36756003)(76176999)(50986999)(101416001)(47776003)(65826007)(53936002)(6246003)(189998001)(50466002)(6636002)(42882006)(478600001)(2950100002)(53416004)(83506002)(316002)(68736007)(16526018)(64126003)(53546010)(7736002)(8936002)(305945005)(106356001)(72206003)(58126008)(25786009)(81156014)(8676002)(3846002)(105586002)(81166006)(54906003)(69596002)(23676003)(97736004)(4326008)(31686004)(67846002)(110136005)(230700001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3497;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk3OzIzOkxMZnprMW9XbVdFVnBMbzAyUXRLZ1JFRmlQ?=
 =?utf-8?B?K3NZdnNWK2g4U1pLTzI2bkJOWG1hOFdzU3lWRGE2aXZRZlZ2K2RCdkUzZHBV?=
 =?utf-8?B?dEUvelJYcnZyWFB6Vk1zeU9SVEI3Z1FTVy9hUXErS1VaOUdmS0l2dU54anNI?=
 =?utf-8?B?WHVZdTBhQlNZQ1dZdUZnSml4aU4zOXhjdW1OanByNjA0eTNxdFZNWENBdk05?=
 =?utf-8?B?c0R2OHllS3FnbjRyclJsejV1MnZqUXc3am9YMlFWeXdJaFR1SW9mMlBpbi9o?=
 =?utf-8?B?MmVodTROc2hYZUdWR1VXM1FPclRncC9XazdOTURTeXNlOVJWOGhWcVZ2R3BS?=
 =?utf-8?B?SDVBRGpWZ3lUbkpQek5qRkY2cWpBRUIrUDlDNm03d2VwVi9hVkpjYXhHTnlW?=
 =?utf-8?B?Mjl5UlBlTkRZT2FBSmc5OWNtaWx6Sk5INmZtS0NWbkZZakUwL1h3djNzTENG?=
 =?utf-8?B?M0l2Q1ZFZTZXU21WeXVMc3krd3hXZHc0TngxemJCZ21TRHB2bG1kbEhidVNQ?=
 =?utf-8?B?c0Vhb1l3aFNzS3IvSHh6Mm9QVVJGa0JFRGRUaTlkU3R2NlRvbXIzRjk3ODZr?=
 =?utf-8?B?V3ZmR1JOTHdpQ3M3SzB0eGE2NzhGYzJtTTlSSmRZYmJUM2pNVWNBbUxIT2wx?=
 =?utf-8?B?a1ljQTZPUElkZHF5K0QrMU5hMkZNSndhaEljWS9hbXFVMzJMbFMzd0FjYmls?=
 =?utf-8?B?TUJOajhkcENwczNtN1A2Q1pxZnY5SCs4NFgrQjI5cnRKbHh3MisvaUpjdm5w?=
 =?utf-8?B?c1dtUFlyS0l2WTkzRXhuT1FlR0xIRFdISVlLOFFZR0dZaDRic25mMlo5SlB5?=
 =?utf-8?B?NmpuZDFwUHNiR1F3MmlIUEV2OW9ueWsrWnBuSjkwR1M0bHpBaEZGNEUxc1VH?=
 =?utf-8?B?WmQ2cTlIWkw5RkhkZzVGWFBCaENGZTNqQXlDMVJGOTMyYklJVk8xOGxneWQr?=
 =?utf-8?B?MnB2ZW1rOVRPcWE4UTdnVUxObEQyU0ljcVRXeVMvQzFFNmxJWUxmbFJXaFk3?=
 =?utf-8?B?d1FiclRYRlFJbmN0bzJhMUd3VSsxdnkwYmNwekJ2ZThFWFBxUWJHb201VnBQ?=
 =?utf-8?B?WEZIaUNNaE9ydXZkR3JnVG9sR0NnYzhDRXhGa0JpQytzM2hXOU5NVVZEQ0xj?=
 =?utf-8?B?L0FsMk9RY0FySDIwT2MzUTlkL0habjhxWUhDSnBxQWxRcm9KNE5wNTNlRFNu?=
 =?utf-8?B?UDF4SzhJUU9JWWpENUFqZ0xOSHFjVmdPQ0xBWkRBZkgwSHBsNE9xcTE3dUd0?=
 =?utf-8?B?OEJ2SWNKTXFyVlFoMkM4d3UyaFRsNTk3VE5ZRklFdkg0dFZhSHJOSFRTd0Ez?=
 =?utf-8?B?R1QrZ000VXVWMnlZNDFXKzdSY1VQQ25CbFZhWDFEZUZGV3ExbTdCczgyZkY2?=
 =?utf-8?B?ejgvRkl2bWJDK2Jwa1lBQWk0eURUSWsxbU0vOCtZWDZPWlV1c0tlckNKVXdr?=
 =?utf-8?B?bjJ0bkhaK1d5VTdqMTdtUXhDZXlJYmZYcWZqcjVFbXJ1Yjhqd21md3hrZVFq?=
 =?utf-8?B?M3ZyMy9SVmhseUM2MzNtMFE5TWx1U2h5QnlUQUtJRU43SW1jR0pGR2J1WHNQ?=
 =?utf-8?B?YkYyV21oZFpEc1VuMjNPTmZCd01VZCtjYkVqQ3k4ZVlyOGlhVEFHaUc0dmdv?=
 =?utf-8?B?VExzTGhKWU9yZzlpbElhNElFUmlGdG5IYTdzNkxWYmxZSTdLUmNvcmd2bWJ4?=
 =?utf-8?B?emRiZFJ0bDRIWFFXY0UrZnZMalBUZ3FKNEVVSHdQTTcxNDd4eDd2RjE1anRJ?=
 =?utf-8?B?UTAzYU5ubE9LU1BQUzROZEN1bElPc1JMSVRRMVJjZVZYZXlPbStRUmtrQjRE?=
 =?utf-8?B?SXc0SVYveEdqaXdJeldvbmJQcVpFOGR1NmU1WFQyK0FNdElOamNrNFpyNlpX?=
 =?utf-8?B?K2ZVVWtZa1N3NFREcm1MbW4rTXBPOHdITmVrN2lYdjlac3ZlSVlhcFdzWUg1?=
 =?utf-8?B?QjNpTjhnRkJzRlplTmh1SENRdnVWTGRmWHpPeCs4aS9HaEwxY3locDBIcWNB?=
 =?utf-8?B?TnNSOUk2aVlDd3NPdUVDT1h1RzZFZTA0cy9iQkYzY1MrWXFHR0VkRXhuZHhH?=
 =?utf-8?Q?16ns=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;6:K6m9nbXsbFwzTq/jUPc9Js8MvImkW2rA+xn5kS9VTc6Vr3tMYXyoT7NNUjqdOK8v69y9nnA8qZ725Vr0XWyZtyn4kIfMF1BGKq1c4wks3bcjCTJMgghzE+z5eG9DL/gG+yP0l6SeJO37PhvPnUte+Phygba0WQhd9Ww8wSOB8E+Wwnpg/w5yl/Xk5aD5S+pQ1EcyeLnUwt37dbkGNvqezPcI8Kur0YvqidGHo1qmeZITvbhryXDQin1mv95G1o++HXollE5qZ8O/gLEh1SC+ZBPrwgHIn6WunmlZvTatN71IXLYJEfWrDD550H5ImZwA1TZjr4m7XpcaJgdC9BHZsVBSi7EYpcAn2bnCt2y4kcE=;5:4rbhkEsKYN7F/c4Od6kWAuQaJRHVEWYpeuqAzTLgOB9TPrbDblkxo6MayilUcP/KhUf1VcqwOh8nhTkHoG1H9as7w3Joy8KEeg5h5f2eVHkA4OCnSL5R/vRtICc7MRtjWqSMpqPU60oX+kP2PQgCjs3/gP+tMv1I48mDb6QY2Lw=;24:jgLLLpOqKRiupixWCzc45cnd2yreDrKP3rsbCAa5oXqy8yfqwXc9D6kRmkjMG3kueJ7Et+538GH35vnrDtsyXsq2MsBz+xae9Qoyxovuxzw=;7:ACuLuCuUd9iO3xJKRo7s0grqfzzElla6IVb8hnzSGd6IFs3JaIWjXQb7vJyKwywrdjnRdAVa/ITjqveRggbzoRSdCZgg12GvRNdX2Z7E2HfssGteBnCbcQDHnjro+tAZK2gx7eaBO0WKz0xZUt3Xyt2GwSx9Vzx7gfS7D3dETiRSdK7Oda/Qjmb0l7/PT8v6ZY6+QV5Nzqllp52K6E5UWfeKeNRAlttZ+dE09qvXWLiQUPpp8OPZ+6+GJSRMcJss
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 01:26:36.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8224f00-0e51-4051-d7f7-08d52190c35b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3497
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60654
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

On 11/01/2017 06:09 PM, Florian Fainelli wrote:
> On 11/01/2017 05:36 PM, David Daney wrote:
>> From: Carlos Munoz <cmunoz@cavium.com>
>>
>> Add bindings for Common Ethernet Interface (BGX) block.
>>
>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
> [snip]
>> +Properties:
>> +
>> +- compatible: "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs.
>> +
>> +- reg: The index of the interface within the BGX block.
>> +
>> +- local-mac-address: Mac address for the interface.
>> +
>> +- phy-handle: phandle to the phy node connected to the interface.
>> +
>> +- cavium,rx-clk-delay-bypass: Set to <1> to bypass the rx clock delay setting.
>> +  Needed by the Micrel PHY.
> 
> Is not that implied by an appropriate "phy-mode" property already?

I think you are correct.  That string never appears in the source code, 
so I am going to remove that property from the binding document for the 
next revision of the patch set.

Thanks,
David Daney
