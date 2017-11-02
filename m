Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 17:37:43 +0100 (CET)
Received: from mail-co1nam03on0063.outbound.protection.outlook.com ([104.47.40.63]:58176
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993373AbdKBQhfcoP-B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 17:37:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QfXJfeVko32lo1cXkISZmZIESQPwWA9eP9DCLFNg8T0=;
 b=nhex3jeg0+gdB/XXUHEe6fdi0AOGeNRCds3+lPv0sqLs6AdHZyW0NUkaqtVSuLLWq20wxH7CWy9Q/oSvuZHsbAb+TEmoQFkdH3p8mpTCD8Z+7zsgV7wUE4mIwAwqt+0BvhPwUgTB4rhO2yb0l2ba34Z5N/MCnw6Oj44TbR5sXBs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 16:37:20 +0000
Subject: Re: [PATCH 6/7] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-7-david.daney@cavium.com>
 <20171102124339.GF4772@lunn.ch>
 <521d6b21-b7f0-66e0-4b49-cf95d83452d1@caviumnetworks.com>
 <20171102161016.GH24320@lunn.ch>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <0f39046d-dc99-5c05-d918-10952cd20e1b@caviumnetworks.com>
Date:   Thu, 2 Nov 2017 09:37:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102161016.GH24320@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0035.namprd07.prod.outlook.com (10.168.109.21) To
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 925bb96a-2e26-4d6e-3efd-08d5220ffd45
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;3:31aIW0gpsdUJ33rSwQNLzNaAXeilQS4Z4IWRm1bmAHJVsaOHAfVIVhrBu4WluBkv+Q5RdlXKYv61XKce2K7JxLa76NeWvPrRSVqRhVMxZIxDz7UbY1H0Nlg91gRZSOUKEcAkioDBPSaTTKNh4w5RS20+MzU9DJ/9t80N3KCoAT1uQ5d3z/s2ZcKSIViC9edjz9xQCeYr5IWpVdmKcDc7lFF4g7A6YUdFt6eTorCIQEgReLXiv/mbU6by6zPFiuyd;25:J5fdaXDmKaebeehp8D6bXUx5dNUZ61RKJV0qh+zMxtOxpThYWQ6AU8QjCNLkFpWubEisiwfUc6HQiYu7cSRadl8XJnvAQcoJEJpDJTTTZ1Gl3nAwNOGeTlg5YEuIKsykjzM+SSvLMDBzPQNFyh4TyaneFV4Rgybwr52G56LJNNTYLzShiYK1iCjHfLbDbpgwScDwthkmphOu5000SU/9ZrIwuNx3RG3WLKN5Bl3fxnX+QZaZlfw1n8aFgKkmbjNiEfBT2ey97I70rAzcK51W9MuXpTO9gYBqnjCAd7d8CxthwIM5oQs/zgxkKdpowIS6fPa3+TIvJwLhen1jLohQJg==;31:quqjdvyVJDNKuSc3lOT59bsrwlnNIs7BYlKQ3Ffkqihov2uiPS8V16EJDZxzbdCMmMxCoRS2krUNUzXRtKsdqFD0Ww4/tsg03uKElAgJa94xNTiQG8fyHbQN3vGoOn/cQ+bttugfbe1JiQYi7wb5CrFyR5hKuYiwdddEgv09vJpter5BPnoH2cgLchXUADN8dFDb5IZ3hENoMNx5WM3sd0OxCScTtOgBcZ15c1Wi/sE=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3497:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;20:XS53L6UyjGbeh8Yogi+tgUCib0ga3bwcZRSPEmpBgbGzCK1oVPD0Wq1/9bsRIHhdc5Sewn1U9zeXk0sHg6VqH5e6BzekMvpxhVZW7dNvO+ST2pUzz4txPyh5xjxczHEawAeT2rl+yZK/JMc2RP4C5MIdsi3dpn79oTw8gm5SRRJfNrjd3z5c/EdLmC+mqSx3bTiwuAtcvcsjLORsAO763hYIyQTV+Mvbs/QXY0JJceTcsDio0AD9y5q5u46t2xPRLVEoVsysOiAYxRXH/BEIoXS75E3zLZ4wnDJ7myqpQvhFN9p4UTiUjUPQz9RJArHZlZJxwmUVoc2IJHEcXSFKk0Q+SLSqSDbc09lpqnaqraKJYFiTQe8LzakMVcPpNAjlEgpXvO0ZjPchaQ3jvalBS5V9OACv69FOXuLxRN+tyZbFBaeu75Maw/M9Vxyu3zNP1GXYYYbyAjpGODhrT0bkLdKrRwnUMbe4WqNlvDmj6iVvO311tOFpHaXEy1JWeRmi7k/rOFTlcjECicypkfVj0mzV1c9h3Q3JVOr9dwsz4pAVi0efTGrzDx1C0qxDObwXpBP0IEh6RT4+TJpR0XgrCdI0E8GFIt15lzXkq3sjjrw=
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(21532816269658);
X-Microsoft-Antispam-PRVS: <DM5PR07MB3497A4434DC40974E1C05926975C0@DM5PR07MB3497.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(93006095)(10201501046)(3231020)(6041248)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3497;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;4:z6UWxWE6as/H6LZm67dsxmpvCjiYkWwyd4fxSgnJ/o6ARV+jBU6sgRt9TwgNWBRxpK1yihXfQJ1lsub1Z/IO2c57EgWKSqdiqlHB3iJOf0vtfEGH2PuCN3ZmavXuUk9/AhoEyZICO60N2COSDiOpGYgBiA5QxlUUcJgdyjrZc5w4Od4VAFe4TALCjAkf9NAiQecJA9KnH4PXHq5j+9fniw5fUhoXZvBbKc7T0HY5gOu+n/v3cuAxNjrpkwctimnPy8/oLg1T9XMh9US/7aemBcrijUjdwwcWvOcOTsKCsSlwXXDFaoACrQCvhG33G4zeGtrI/kb9p0wglmgLpAsU6atcbcVovlwjlFE7dyT3Hp8=
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(189002)(24454002)(199003)(36756003)(93886005)(54906003)(33646002)(316002)(58126008)(31686004)(53416004)(106356001)(105586002)(65956001)(31696002)(47776003)(66066001)(65806001)(50986999)(54356999)(76176999)(966005)(6512007)(229853002)(6506006)(6486002)(101416001)(2906002)(6306002)(72206003)(478600001)(97736004)(69596002)(81166006)(25786009)(68736007)(4326008)(230700001)(6246003)(8676002)(189998001)(8936002)(107886003)(6116002)(50466002)(3846002)(23676003)(67846002)(5660300001)(65826007)(83506002)(42882006)(2950100002)(305945005)(6916009)(64126003)(7416002)(7736002)(16526018)(53546010)(81156014)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3497;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk3OzIzOlJXZlRyNmJHV3Zjdnpmd2ZUOVpQVlpVM3FW?=
 =?utf-8?B?amNES054UnRBT2xMaTJ1Uzg5YlBRcFNjaHA4amhPUFJOb084WXZIWHN3dThO?=
 =?utf-8?B?SmE4cjIyN1p3Z05GRFd1SE5xaUdKWTRuWUV4ZWhQSlZLd1BKc2VtcTFSUzdY?=
 =?utf-8?B?eVVLL0ZLS2lnelk0dlVNc2hXVm45a2FHQzYwYWhkeWliU1dsZVdERnZVV1dB?=
 =?utf-8?B?TDRxdnlicXFtY3dvQkM1YVpQeTNSbDR3SVlrMzlKWXJhVis4K1BZaCtjOUJa?=
 =?utf-8?B?RXVrUU5veGFYWFFhenhrZUc5N2xoNk9FZ1VVSW9rdTIybnVLNWkrU2piV2Fm?=
 =?utf-8?B?RTdMUG52ZGlZSXIzT21ldk8rN3lCQ1JHdjZrbzBrZ0wrQ1lGNDI3TVJxUHFj?=
 =?utf-8?B?NHZXZEY4TFZXWk9yb2ZSYjJyajBUT09lcmVUVkNpWWRxeGpNZjJPcUEzalEr?=
 =?utf-8?B?TFVSNldTdy92VjFyZ2d0NmF2ZzlqQVVaWEkxSCtQamVmSXZMS1JFUlBEYm5E?=
 =?utf-8?B?aWdiL3orenRUK04yeDFYdHVxRXNSd0I1UUFEb1V0OFJQR2Q5elNjOUdXYlFS?=
 =?utf-8?B?WDdSR1J1ZkhaZUxVNWxQLzVYcldlWFMyNEdtTWVSVGRGQ3drSERRWlY4d2Fm?=
 =?utf-8?B?ZkFUYktjdnk3YlVRbmVVVy8xWjBSbnYyY3R1U3J2Y0xoQ2xZOUI0b2E0RG9O?=
 =?utf-8?B?Smg2UlI1OFJEbGVsako5MFNzeUgwUVlRaHJUQi9wNUpmbXZwTmMzOTZ4MGNY?=
 =?utf-8?B?Y04vcFRWTERGSmNXOSt1bDV4emlvdXhaN2U3WHRmRGR6V3A0NittM3BsUVlI?=
 =?utf-8?B?dDNqdWJUSGNCM0pTZXRTVjZaNjI1aFk2NVFna1N5QnZoNG5TdlFmY1FGc3d3?=
 =?utf-8?B?NEFhRUl2akE4RFdTT0cxaUpkTjBLRWZWU2QwUjBnZGhhZmJjM1c3YVlXMlpi?=
 =?utf-8?B?UDhMM0E3KzdzMEtRT2w5MnhrSVp3R2svRWcrS3BwQkJ4a0hIcU5HdmdhU1k0?=
 =?utf-8?B?SVo3ZWFCUzdmdE1DcktTRVJheGp4cGpPZVpoamFYbWgxaFBBRHRxVXhTclNo?=
 =?utf-8?B?a0ZQc084S0c3M0d3U0swV0l3SUg0TnhyMWxSem5QNXRRbFFuQVV4T3RGT0RZ?=
 =?utf-8?B?am5oVThBdUhOTXgvS0p1eFRFaU13enNzNlhrTGtISlNLdDNld1dBU0RDWFdI?=
 =?utf-8?B?SVUvWWFPUXUvZEFEKzNPSDVsTlRyM1Z4TmVGNnlYMVVNS0FnYWRua3ZXaHAy?=
 =?utf-8?B?MWFiNTBqeWRXTFkvSjJNOERVL1ZJYVlsVW1NNlBWdC9JOTQ5U3hPMVFMZ1BH?=
 =?utf-8?B?TmtTUjgxYWE1Z1N6V1JYTVB2bzhId1c1YXNuQWZMd21KLzA5dGRzTWhnZndH?=
 =?utf-8?B?ZEh4eVV1ZWZVcE9tbm1tOWczdlZ1ZXI1M0UvNTd1V1hlRjhzMmx5RHNSdFV4?=
 =?utf-8?B?a2xKOXhwdGgyMXVjQzk5am8yRTJmN0ZHbEJ3blQ1RDhmN1hFYjVLL2JmbWFX?=
 =?utf-8?B?VEhVa1JnVElKblFyRHF0WlV5U0N4UG9hVGg3b2dYU1FWNFVzYW93QTkzc05B?=
 =?utf-8?B?bkhKeUsyZEIwaXBrTGs3WVE0dkppOE5VVUdVdDdQeGE5cnJZcnJSbXRxanNH?=
 =?utf-8?B?UzFmMnM3d2ZNVHZwTUlJenVLOTUwVFlueG1UaHFUdmx3TDV4SXJodTMzaG5w?=
 =?utf-8?B?ejNYRlJab2pETkdXODl0dmJzOHFPYkh0Y3dwVnBWYTNSZ3BFV3M3VFRnS3ZH?=
 =?utf-8?B?T3U0Q1NwaTloMHlQSXR5c3lqQ0o2WnFUYzV0UkdaakFvZ0NTQjAxdTRQNjZG?=
 =?utf-8?B?eVRFVmk4QVlRUW1FRUtRc1JhMi9lYzRIdUJtMzRmMWlVUytjRzJmZnNNSDZi?=
 =?utf-8?B?anlIc3FlUTZiVUdvRVM2a1dJWk0wM2l6SW5HdVFBZHp5SGRSQkl1dDFYVTJG?=
 =?utf-8?B?NnRHUUF4VTk5ek9uOEQ5SDZIYUF5aFJzNExLbW9oa3Z0TnhvV0F0QWdFT0Zp?=
 =?utf-8?B?NTd3OUtaQ2wxeXVYbXNCSFhlMUQ1SXR3Z05KUT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;6:vV1jtIHaD5Z7R764e9QUV3A0d7V/wws4Uc0sWsnTr6D8jchHWG57z6uxu/xn+KrTCaxTzPFBKRNf9myqHvbu5PhT3263+BA+fMenTTKEYOWq6Xmtzfvf8HnVbrt2lby3TnX49P0/UJBsbVKxE4+LoNAT3o4XW7CmgoKSWlaRUZnKbIEAMI9K8CxdIeKbNlLSWMQ6SrFzdmoxdmOUqlLhEPSdQFpeaZVuIVb5R4ZyhptEjpdfSpN3l6l/b3MfBB7G5AtTKO/K684TnF4tfGYxcyT3EtBGNdEi0FuuMx8+XjSMknpmOwmVNecQISuqZXDqGr9zCpk1ek2Hlr1pSZ0fhUF2K034l07XViEkSGDZoCg=;5:qjyTmv6cU0t/v1bZzmM/JIN4Z5qhldCrLJPiLkcIsS7x3Sj6FFqdEHZc2LLptm6QiA5tIuRMG2IQLIS/Mk3F3duXx6h0EdXofsfXj+b51uk1YZ4rrOOjKfj/km7o+Ou+bSNgPSMpyNczH0NrRlxnTtKxQNzsuU233huhaOVg9Vc=;24:76C159HtEMIjVMPmEW7nkgu80iboIck92ZRY0+JEJlwOqAVnTxevm+KTdvVDdpg4tllERENr4wPwFAH8zqA64H9AzL7OmY5hQMSDi6shiwM=;7:QjGP2L8YoZQs1/e8VQ8kN8hTuYK/t1+WE6cV69THc2MkBT4LUA93ipYdvtps129RsPqhBndw6z7/04FdhZWE30CD7dHiac1fv3l018phTMjUpRbk2Ogak3Dr+V/nC/L11Kp/w0JRjIPgSCVtUU95CFKw1I/Ft+8+i7Whrfuov/8Nb2NGwxsE5sGgn8DnlrS7tMhalCW0oge0+Q99sXCTG9rzXVxB8aUa5HtZdJlsTxgTDz8NRpU1XV0BLhS9GxWz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 16:37:20.4320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925bb96a-2e26-4d6e-3efd-08d5220ffd45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3497
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60690
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

On 11/02/2017 09:10 AM, Andrew Lunn wrote:
> On Thu, Nov 02, 2017 at 08:55:33AM -0700, David Daney wrote:
>> On 11/02/2017 05:43 AM, Andrew Lunn wrote:
>> [...]
>>>> +
>>>> +		i = atomic_inc_return(&pki_id);
>>>> +		pki_dev = platform_device_register_data(&new_dev->dev,
>>>> +							is_mix ? "octeon_mgmt" : "ethernet-mac-pki",
>>>> +							i, &platform_data, sizeof(platform_data));
>>>> +		dev_info(&pdev->dev, "Created %s %u: %p\n",
>>>> +			 is_mix ? "MIX" : "PKI", pki_dev->id, pki_dev);
>>>
>>> Is there any change of these ethernet ports being used to connect to
>>> an Ethernet switch. We have had issues in the past with these sort of
>>> platform devices combined with DSA.
>>>
>>
>> There are only two possibilities.  The BGX MACs have a multiplexer that
>> allows them to be connected to either the "octeon_mgmt" MIX packet
>> processor, or to the "ethernet-mac-pki" PKI/PKO packet processor.  The SoCs
>> supported by these drivers do not contain any hardware that would be
>> considered an "Ethernet switch".
> 
> Hi David
> 
> I was thinking of an external Ethernet switch. You generally connect
> via RGMII to a port of the switch.
> 

OK, now I think I understand.  Yes, the MAC can be hardwired to a 
switch.  In fact, there are system designs that do exactly that.

We try to handle this case by not having a "phy-handle" property in the 
device tree.  The link to the remote device (switch IC in this case) is 
brought up on ndo_open()

There may be opportunities to improve how this works in the future, but 
the current code is serviceable.

> http://elixir.free-electrons.com/linux/v4.9.60/source/Documentation/networking/dsa/dsa.txt
> 
> 	Andrew
> 
