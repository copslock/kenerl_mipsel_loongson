Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 17:07:06 +0100 (CET)
Received: from mail-bn3nam01on0609.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe41::609]:18671
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993543AbdKBQGzx2x0t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 17:06:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PlQvjpSsHDPdifsK9he+rySje9HXVruyiugAneeSr+w=;
 b=eIsNdptpqSb91MMpKDZvXA0Jsv86NLnB7D3ghViqx2G/HlpgxH9rXxMM160zVMCUqgzU19Nm3bIoGHvX6ht9E+1gqkLl+xc709DlL7szT7GLWbJlr5SKa0Asa+YvoKEvUFYZ1nYTbt10W1IR1Pl27gHWfBpk3aZ+G6KRH3G1ExQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.197.13; Thu, 2 Nov 2017 16:06:38 +0000
Subject: Re: [PATCH 1/7] dt-bindings: Add Cavium Octeon Common Ethernet
 Interface.
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-2-david.daney@cavium.com>
 <af0de889-a34b-8346-9eeb-171498cc61ca@gmail.com>
 <20171102124719.GG4772@lunn.ch>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <2ed0d20b-577e-9431-7a7a-34259b752e9e@caviumnetworks.com>
Date:   Thu, 2 Nov 2017 09:06:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102124719.GG4772@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0046.namprd07.prod.outlook.com (10.168.109.32) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c0174ec-d80a-4103-5cc1-08d5220bb3fb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:JB+l4EhicnhG4cbJyCnxz8GtOuB/YXgFldeBAI5v+xtjNsekflE3FqNaBcKbNWXe7QoMJXJAhVCTDPJBqM/wtp4FmnhsEzY9tWZj+TDAop2Zgj7EEdlBTZB6qxpGcWK5MLZAk/WKP0imm8MGzi9c7MQKYFwR6Kruqw2V14cv6KDrlrL86DxbP0+/3ZFMcKTbwLX3zI5h3kAsY4F8IGe1kEqupmITSBnTbP40w4hEX3/4AIOqQjIpyQ1u6UYWhr8R;25:kIm+42Z6cf6JXiCaF0h6iEQhY5zFa3PfYkkCtnNss/ryAXItNEQfVGK//Au6PjaDSLZsZaEldr5r/C9cd2d+96T/FyxloznYxL7psfZSDWSkayuE8sOCOks7mK22cfEFwBIgXrPlNwO8A3Oh4/nTf/5albvShTxgjfPo/eKlYPdYRJHlY5Gpf20b3iHKg9tCqJm+viM75ua4m+qkcy/gxP3LhTPI97u+43iw0bCT3LKssKkXIah+pFq+dFjgsrJA4DmoIgPHh/4avc3vYzY2XhmZddqAY+CKHbbA6REHvXhJsj+m1YlRnMTroRTlDhww4+bNORStKOFaDv2/tEFDtg==;31:dX3rZH3Q5uOXmLlhBwPZwPto8G4ojGGzgbwcydJEDMwnwrPwjGpWxqp+SjdNldCuP8WFhd3yNwLwLZaon4He0Ov6dnOIqANIXn9qw4NtqKmFKq76dslEb3T9D8JPAjGyWAMQNZjSp6LzCirknwejg6DVcrPVd582HhJM2y9lIi1BYnxMQtes8BJDPyetV7M1PAxTe7b2OIe1Dzp3oTJqQbu5DAeTNNOQQE3ZwitmfKo=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:9RkLP4IXX+6Wtw/aBgcaKTzZizDc24rLYgT5ID0vUY6nk/+dyn/LEFA5yVS8uP7jgpjwyBKE0+usF3dOW47cPPS272gODMoygUXABoZdVYBA61oclq1vMGaECSFpn43brsYMx0D/6YulfKtdci0ShKg/u9H5zT7BTfLeclNSruXwFnjCK8PjN9zXhzl+1SVwrMs3Xtwqf9BWykkqtors+SNyqwOADLnMV4PNJEfJLPFhN6aN53+xY2j0y2jItrbXbHmpA6pXp9z1kj3nHTpM/25fO6MtGD0nK+og/FpkadHhzObdFxTBJXR3w+shuSqLYwVdw3h+0HAQ+rrXs0fK8C8L2kNgeG1NBk7VOpV8FPNKwmXoRDO+0YHIvm2TP55e9rP/ZFQ0yTmRnUATOoZWPv9XdvEV6TeoWqNg7tKZjWV8sppqVexLhM8U9/QELQwU8Qk9uDhHKhueNuzQKVUtPcHVSzUdT/PKJgLlFCJ3xHzNUxTW6Qk0K/o/Vn0rB/0A79xy28I6fpQBB56g7kLZGNygbFEAE8cnyztfNDzeE9a8wkZlzEBicuBn7nu5l+JQ8auVTxGUxo6kFXPreVGzUKMKJ8V9ELqeRCIBgMhD6ys=;4:fCmkjsRVOmVokWiLY4u09QD0zHB3cP8QFvQdwyoYcTCTHQRGvNu/2JvPH9MbwxQ5ULzbidTDSnaCJqQhWqGGPfH8iENtJiNiuFcZ/4Yx6qX5qLyDm/tRi+J82PRAh5czsnB0oTvpfeTkdoMgQgQ1Pe9JTDfSS9iJWkx5h3dIY+/nT/SevfI56zUp46TqferRUoX5J5IckDfeVJx7I3uk2zAmmrNeUFJRuxa2tpegyyG6hH5U+XstlaxtXoEwblJVLr0glr5zbFUK+98z1Ty+TQ==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495019E4FECB74CCFF49DDD975C0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231020)(100000703101)(100105400095)(3002001)(6041248)(20161123560025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(24454002)(97736004)(67846002)(6512007)(53546010)(6486002)(23676003)(8936002)(2906002)(47776003)(39060400002)(478600001)(36756003)(31686004)(66066001)(65956001)(65806001)(72206003)(81166006)(50466002)(81156014)(83506002)(7736002)(8676002)(189998001)(68736007)(6506006)(229853002)(305945005)(101416001)(76176999)(54356999)(7416002)(93886005)(50986999)(54906003)(53936002)(6246003)(4326008)(107886003)(16526018)(316002)(58126008)(53416004)(6116002)(3846002)(31696002)(42882006)(2950100002)(64126003)(110136005)(33646002)(230700001)(105586002)(25786009)(5660300001)(106356001)(69596002)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk1OzIzOnJpRUtDZFh6SzI0eWtHUlNidDZYa1hzcG9h?=
 =?utf-8?B?d2ZPU01TaWY1a0JmaUtTTklURjU1dHVBaUo5ai9xK1JKRHEwSzdqRDNZd04y?=
 =?utf-8?B?U3ZzQ3ltTDE3dUppdEljR1cyTUVQVGJzNnlpekVJRGRIS2FMbEdKV0tJODFN?=
 =?utf-8?B?SFUzWUtlcVlDUTdycWJWVUhVTlhVKzhmY2VZL2JsMld3MnJncnQ5T0crYU5t?=
 =?utf-8?B?eTJrU2pmU3U1eDYwUVYreHYrM01RVEFveG91clo4V1BEV1hoZFNvZU9EZFhJ?=
 =?utf-8?B?VjZ6UHc1WGo1bmRSNDdVQTZvb2J6VHd6L3Y5ejZYYm1CNmdOL0g1ZjdFczRo?=
 =?utf-8?B?NEVabjJmOXhVcUcyUk9RV0VLSHZ5WU56dm0rSTBOTVdJZnlDS3IzWWplVDdz?=
 =?utf-8?B?K0xrajBhdUJoZmFTbElGR3ZYVHhjOG05UGN6Y1dJVU05Mi9oN0gvN2dpUXd5?=
 =?utf-8?B?SWVlWlVOUU9oWlBtZVpoakZyQXNGbHFqaCt4LzMrRnNwclEwV1BRNWRrV0dX?=
 =?utf-8?B?YklDbGJoWW5nK3c4R2VVeHIvSXlMa2FuNFBob3dBMDNqK0QwSzVQUU9CNmFT?=
 =?utf-8?B?aTZ5bnpyR1BZekJtQXpZWitPL2JReEZxUGlZazFEaTloWmxRV29EdXhMU2hk?=
 =?utf-8?B?WXp1VGUxTjVrbSs0eWh3dTJhUVY3aHlGSU1LaGtyeHo2Q1ROTGF0SVN5Zm94?=
 =?utf-8?B?SklLSTh2NmFIY0lsS1ZzWFhHdFcwbWR0ZVNsQzBQYnBzOFd4RkdRT3ZsVitn?=
 =?utf-8?B?VS9xUU1vSlNVSzdjL0dkSkZyTFRGalY1QWd2Q3FFaVQ2ZE1DQjFkYVF6RzJ1?=
 =?utf-8?B?Q1hldXpsS3BJWmltZmgvMnc1SXNnMXdWc3NSdDVEM0syQ3VLRmdCMitCblMr?=
 =?utf-8?B?VWtwSUZPMk4xNThUNCtMN2dtZkxGYjJNZUFEa2xxa3l0dTVJWUtjK01uazlF?=
 =?utf-8?B?QUpabzYvaFhNVzBDSVlKN0Z5ODdhSUo0RXJyQzlEL25YbGxvZ2Nlc0Vma2dl?=
 =?utf-8?B?NWdxbzVLemFXSzh3MVcrTWR0MXdVUkNhaUtINkNXelNXcUx1eGRsVXZCdVJX?=
 =?utf-8?B?eHRkZEF4RWxsamQxejU4UFhOTVEwclBXTTNESGowSkl2Y2REM0s0WTFyK000?=
 =?utf-8?B?eWFoanNHVktFOFN3YVJsTDA2ZUFrMFNFRUZjM01Zd3B0Mi9aa1hPbkxOTlVN?=
 =?utf-8?B?R25Mdk15ZmxkTUwyYzJGTkd2R0dkWW5QU0dRc1VBWFZLdGhoN1NtSGJaeG1z?=
 =?utf-8?B?alNrWUJnL2VMREY5SnRyWVBwYXA0NFpBVUkvSlppYzZyMnNSK2dZUnZNSHBj?=
 =?utf-8?B?Zm9YYkhScWFKSzZRMENUdDk1QllINkxDSVBuczBnZ1JpeEtGSVo3YXJPTDJr?=
 =?utf-8?B?ZC9uVk9YMWN4QTI1YjNoZ0tyS3dpZ0FjeGdSdzhHMk1NOTZScVdtNW1qOGRu?=
 =?utf-8?B?TURFV1l1NlNMRjRKZHlSZ052WnVGN1M3M2pTVlZFVm1RZWFqOHZ1SzV4OFZC?=
 =?utf-8?B?b1FmRGNqTWlybWViMnVOVER0Z21pNjdPUU1jNzFla00wN0p4MURWRmxxVVRk?=
 =?utf-8?B?NTVJdXlqb0V0cWhVWmIyK0FyM1FNMGE2QU1CVm1mYWVIdGhKWkhCRStjdUZP?=
 =?utf-8?B?emZiT1dkMS9wZEFWMzgxMjhSVVBWZUY0YnZla0R4bzcrMmpMa3k0UHdsYVk3?=
 =?utf-8?B?a0JkWERodmh5aHJ5bkxNY3JrcDZnMnZ2dm9CM25reFVEb0hoZ0xiQTUxUmli?=
 =?utf-8?B?L0tuZng2OERZaTZ0YUZmdlBncWk5UXdPVWVPc29ob282SlRnU21yUXFIQ0xa?=
 =?utf-8?B?eTFwRUMxL0d2RklXOEphQWxWc3RSd0djQVVVVHo1QWtjSDU3dFE2UHBRKzZq?=
 =?utf-8?B?VTZyNVcrUWdZWG9IUzc4ZHB3WlZycDlNbXZwN1pUY0R5WTRKOWFvcjFkUnUz?=
 =?utf-8?B?T2oxMTlmY1J4ZklSdm5hc0JLNC9UTllveHhvZ1lZb3dicnhtZWN2NTlyMGtw?=
 =?utf-8?Q?qzibEx?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:pTiVkNokSpQO7FFIvI5k+1hoQTKIYDSlVy/UMiKd9azOuy16q2ggYwRHhqA8UpIMTmzs7yxduGalsRym5XGEHI80wBdLgazg/01e7X3GtNAIBk37NqJMMmwLXOs8yPoeAbPAg1d//2GqE7u9Kz9XviwZ8LK2RA8iD47dfTZCYJVeymqukG/NMqvE84hqGS8eW5XGBfIL+FBHMTkUVqk2RrrT8ISef9kam8gM4gkHceO3B4ox4iFfnXoro29CDm/VmZvNPicWFZAYtSkL7ETyakJS4e03bX6BmINR3U2ShOldMGX6AHHg+MkVvBQZlVQA7BVb2tBbeS41FadniSN9ncBE5EzWH6MwpsKreALfyf4=;5:x7xy97tzLaW5H0yu4KEYiwHCNQJzv+AcTiEnrF8fLYryTRF+kJpFsGHrAWhuOCCshAlqdN2I1as9nAThKI7CixyOavJVgSKNQDN0jDbqN0mgWdKbO311KNcjgV3qFv85TyDbIyx2gGPAJAUogH+9ZFJAMzNI+rPp8MwMMAVMGNI=;24:G/lkXpdtoQ6TCoUCTJDbBU44GjzdZEuA0hFObQpoA/S3RI4/k4JdJJo1BLGkhytl9e9ea9Usnbvem59Sml2angc8tN+X0ZJT2rIkJ4JudKQ=;7:ioNcRgkzrM8V87kEvUHu0h68w6Au8dsKvsYccQWeqQKVG9+9j530TfPAb0X/gD0/CqO6s4J0mi8GlxWjvZpTfFk/nWXJl2iJSJRSxRYl5PTrKG3KqYEkEwvxWHR9n4Bgst4I7w0qSk0F619tf4mRwhgWeNoO0DKjML7gHw7R0UAsYCF3JriqnchgLOeo047P5MQIwzf7jR1gQ6BaTmc7GKuRbw8IjCAV5FKGwRoKd+ivz0og5+mc4hrjLe+NkGgD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 16:06:38.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0174ec-d80a-4103-5cc1-08d5220bb3fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60680
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

On 11/02/2017 05:47 AM, Andrew Lunn wrote:
> On Wed, Nov 01, 2017 at 06:09:17PM -0700, Florian Fainelli wrote:
>> On 11/01/2017 05:36 PM, David Daney wrote:
>>> From: Carlos Munoz <cmunoz@cavium.com>
>>>
>>> Add bindings for Common Ethernet Interface (BGX) block.
>>>
>>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> ---
>> [snip]
>>> +Properties:
>>> +
>>> +- compatible: "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs.
>>> +
>>> +- reg: The index of the interface within the BGX block.
>>> +
>>> +- local-mac-address: Mac address for the interface.
>>> +
>>> +- phy-handle: phandle to the phy node connected to the interface.
>>> +
>>> +- cavium,rx-clk-delay-bypass: Set to <1> to bypass the rx clock delay setting.
>>> +  Needed by the Micrel PHY.
>>
>> Is not that implied by an appropriate "phy-mode" property already?
> 
> Hi Florian
> 
> Looking at the driver patch, phy-mode is not used at
> all. of_phy_connect() passes a hard coded SGMII value!
> 
> David, you need to fix this.
> 

Yes, I think you are correct.

Thanks for reviewing this,

David Daney
