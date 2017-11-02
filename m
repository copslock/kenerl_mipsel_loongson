Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 17:27:21 +0100 (CET)
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com ([104.47.41.54]:28064
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991960AbdKBQ1OIjHLB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 17:27:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kDPp8KIralN+JOIKlCykPFrlcwqHApl/4uaClfq1AlI=;
 b=BV37vOXin62PlsqSuv4cSKtqV4td9H1YB9vJoaCFNbHJ3iIqKr1Ep8kztV77ss/4nCLKNjDsPWhQGJechrzxjDgbjpRDVKmoV+3lbxXqW8Ur11d4OoVBkC7OGrIGTUbCxaY/hlaEVlDiLsSnP5IzyB6vuH59dlRljnxt+qWU1XU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 16:27:03 +0000
Subject: Re: [PATCH 4/7] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
To:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-5-david.daney@cavium.com>
 <d473b10c-ae5d-efa1-7329-de7b68152725@gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <fc2d71e2-cdd4-1cf8-13b0-ea462b5e7e75@caviumnetworks.com>
Date:   Thu, 2 Nov 2017 09:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <d473b10c-ae5d-efa1-7329-de7b68152725@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0041.namprd07.prod.outlook.com (10.168.109.27) To
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 188a71c3-7683-45c3-0aa6-08d5220e8d74
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:5V2RUh16puk51ekrNS2rwxQ6SNSpiUgfsGFVkUgl8kc/ga0cLzC2/YamD53bt8EM3g4LQhx8HgIJUAOjNtda8w6awxlJE91Y3Jk+Vg7CxkNTwG5mvn7NrHbId8vTyvGj+CGoIWxdKhysuLj+xx8n1xlS2N8hQfTCPlx12Wm3SQzg+wriXIRGVmk5Gznz1Xudx5Hb6SLnnitkve8NyzpoVx1QTOvH3lyDBIsA/Jzbrp8WjTJ9EQ8IvdXiK+rA1pIy;25:yO6Q+66yYMx3cQRpcKw7ziRmEAe+POAK6deXvmNB8c4NXRb8PAHRx64RCQ7hz+evISKUxUW1FVbGHZnpJ0DvENRrMhG26kRgzBOBHkOvsSTAGLBsu1+zjCkqfr3ZcosIhstVthSE7U+MUhAmz+Rv0BwuAnSps7xwQ7QVwn2jmWYqBd2rEzxRuN9Sv/Uq4Z39uI9CLAiDCgAH3bOCYiFeBXs70VCHGDWT3LQzUnRaZH+K7iebMcpoD+L2d6ZigJW8wfTmAow74e6M1/6QG3df3PCPFnhrMBWOfnrnbXqNk+7uonGQeYc8sGs1lv6Bhjt34ZFx2I3rGXf2xuj4hNs3rA==;31:5TGSlhgWO0GQQ/oQkrM5DK+QGQJTC6rCFWmJO19dv66vOKecg86z/Kjx8fPZxvd30fypRTlANLbhp8mkB5k7+Q7NugUSYk/FmuaO6GuSsGS5913HIK6+bS3lqhJY/0Q/g+PYqZeKxb9DFEk1BOCaDXFTooU4q/aKV1ngNe2qh+Lx6AlpZq3KKoZtZoqSUJkzbIClRdz+fjfj37+jYPy1aNlBs79sGXlfhWcmNqwNv+s=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3500:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;20:eNWb2X8VGuu6BDb1HJTJvweq5N1ufChaYdcGU+8mBFGXOOLjuvmghUELb/kCX/vWiVUqP4neRftHqdUM/Wh1WyOW9s5cVwU1waCbZlygxJtR/t2Jss897UwvwngUa2607JtMOMjM3BWj2OffncIaUm9ci+6Q2lEIsUabCbu1T4go7qEwytnLtivu7LsZLevqCgBGLf0ymY9m9R20g0Jn75LRW/K8oVwUfCZhmyUN3YcrP9soJz8YDrIi+C2hf6NreFSBPVNR3DzbbIds6kE0AEN80JdSQwO6RvcSUsfH6Mrsmd6TZ1XU85jOE5OQbLa77NVhXRSTOKnCtMHY3BAWomaE/jmnzqU7UD780m5DvBudbxWekRbtLmTHakfc1F3TRXvmxp/G41oZ6kBbqH83xB3lXFqvbn9bZo+RUIqYPPf7cZzJo4e4+IDlVOmbd8IZ4hjQaoN8gd5kUmputpHfb5pqEBZ8GSDaRWUI/Z+eLhTgmiKM4xGS5L2PN/xVEjN5+q782W3DLvN8Cikaemf/z7+ez9AavDUvKXpY6945BYHjHk3+leCu5JWBWL6bAPM1/3G0fdeNxltxrt8X36+2bV866klu/wRm67n07ufmLjg=;4:GHXWs7KDj/0R8v6FJ6xB9/EHJnaf0y+fS9y8tiinHBXemr27alqWCWlfP9h7cRsWrgB5vS3F0rVoTzxDLQJJFKika/FD2PapsMNiHRCwnp8L9/XK9+EMfUhX77TzJkc4G80Z5HPytA0ymhFXfCMMDXf3SmIQeo6ql0CMDS7cgwFN2hmFK91bOiVkbddGiJiiO+ZkC21hwOPBv5pd55nKK8f8EjchvgJHmAmYrXAjWt4GSxPaD5s4nHIxF/g3YmJb/YB8578FUxuRS3fEiJk1XA==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR07MB3500A8B4F1FB2455DDC4DBD7975C0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231020)(100000703101)(100105400095)(3002001)(6041248)(20161123560025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3500;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6009001)(376002)(346002)(189002)(199003)(24454002)(3846002)(2870700001)(65826007)(5660300001)(6116002)(83506002)(8676002)(7736002)(31686004)(305945005)(7416002)(101416001)(6506006)(47776003)(65806001)(50986999)(66066001)(65956001)(76176999)(229853002)(54356999)(6486002)(107886003)(6246003)(6512007)(42882006)(53416004)(189998001)(105586002)(2950100002)(106356001)(53936002)(50466002)(2906002)(64126003)(81156014)(81166006)(8936002)(16526018)(4326008)(31696002)(68736007)(33646002)(25786009)(316002)(72206003)(54906003)(58126008)(110136005)(67846002)(23676003)(53546010)(36756003)(478600001)(97736004)(69596002)(39060400002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNTAwOzIzOmxxNWNNaFFCc1NvRW90ZDlLdnI4YWgzMWUx?=
 =?utf-8?B?UnZ5V2xhWTkyTFZPNHF3eUJCeEtZeE1QWUZ6bmgrY3J6Rm8rUy9QeVczVktz?=
 =?utf-8?B?QWkxVThPSnZxRU5vWVFOaXVHZEptVDZBM1lTSEs1czcvcENNRVBMdkpMZkZP?=
 =?utf-8?B?V3JhUDBaOFBQN1prMEEwaXAzaFIzOTVWdHJvN0VubEZweWhRTEtGb3VRdVNw?=
 =?utf-8?B?YzVBUXVlcXRkZ2k2RWpTak1icHVLTXgxNFdjSnYxOHZWM29NRXcyVUJnK2dH?=
 =?utf-8?B?TzlzK0JmMHhNTnByY0FoYm0xSTdsZDUrN3Nwa25PODhyZjZIVDRPWW1RdmVR?=
 =?utf-8?B?UFhNdlJNRVFtTWRjR05ZQ0NzaHkybVhlaER4UU9EQkxHRERnd1FKNmhxLzdX?=
 =?utf-8?B?UWRTTWFDd0oyWVRQcWFINXhkc1Y2bmJoRkRSb3NSK1N1TGNaa0kwTUxuaFE2?=
 =?utf-8?B?a1doZm12eCtLd2dOcUNjTUNST3JXQ1lmUEFlLzFxWmovNmkwOEZZaDRYbDRS?=
 =?utf-8?B?ZEJiOHBXUVZqSmRkanE0MVZyczVFQVRFK25GakNGLzZmcWFUQUNtUklxb3R2?=
 =?utf-8?B?WitxNVRqa2sySlZsK081ajNRUFp2SW9vWVhhS1MxVllJYlFsSlpSNW1jOEQz?=
 =?utf-8?B?bUtZWVBXdzh6YlBrY01GV0ZSOTlaUlRhVm9ZZDZUYjMrQnJyVnRPS0szN3lB?=
 =?utf-8?B?aE1ObGF4UWtvRXJ3amhJYUg4KzVKb1FhMHg0Ym5uYklwKy83VHBodk9HaHgw?=
 =?utf-8?B?YjJSWjVjK3VsNUJ2MGFPS1ZKeVZwZ0VucEpWRldvelVIcE9XZGRYN01TbGV5?=
 =?utf-8?B?eDZsV0FnV2NYMksvN3ZVSmNTSCtkYnprTkthZGY1blVrOStBbmc5UVkxa0ZR?=
 =?utf-8?B?RjZkbE9EN21sY3JTK3U3a1VrbDBJNkZWWFN1UkhGNm1yM3pHc2JlTzFGc1B6?=
 =?utf-8?B?QW5FNWd5Skl2MGd5ZVVHbGlSNTMyZi94eTlsVGpCSUVKS3BwNnk1TnJuNXRw?=
 =?utf-8?B?bGVJNjRkTy94SE5oc2NEak5nZVduQkhYYVJ0ZW9SYmk0SlVZa2taWW4yejZk?=
 =?utf-8?B?bWFDVHh6Uk1tZ0trbjNUZ0IzR2lIa21UWTRSM2tocFlURlRvWGNjWERkeWY2?=
 =?utf-8?B?WWc5aFAwMGdqTVo2S3BUOEQ1VmhjR0Qxc1lkbkk5bGhNc0M0OHdUVS9PSE8v?=
 =?utf-8?B?anFUMWlBWFN1WnlzSG1TVDlhTnczWTRiclJldTBrMkpya1BtYTZhcitQRURV?=
 =?utf-8?B?a002S0J0ZEk4YUgzMGtvUEwrM0xDTVpSZW4xWkJ3NHNEbDFEMkFMK1FXNzU4?=
 =?utf-8?B?UXdSSFFaRWUyNDJnczF1NjRJZXMwaFNsQzlGSUluWDVvN0VEaGliT2NyN2Fu?=
 =?utf-8?B?MmVRaUtzSVp6Tmp0ejlCeTJZbXhWRXpyR0ZyanY4NFlWK2t3dHRsYnFWREdh?=
 =?utf-8?B?RDlkbUdDZWk1TjRPWmc1NjQzYWQrUzRoNG5vTENUQjduYjM4di84Tm9pVnYx?=
 =?utf-8?B?UVllSndQZTVya1g2aVdSR3RYYitLRU91R0NaWU1hNEZxUWMyWUNJVnhvNDVy?=
 =?utf-8?B?SjVlRkZkZk9pWmhFckppVTFnZFhLaytiVk1keGYzTFNCdWNVcnU5UjBVY205?=
 =?utf-8?B?UTRlQ1RFZTJpRnNHcTljOWNucm9TWjFPVm9FcXBJMDVjcXloRDNzV1Fya1hr?=
 =?utf-8?B?R0xsTU9oU2lMYVNucVdtVDczbUM3bXczUElJK2hEYUVFRkptTEFpeCtGM016?=
 =?utf-8?B?SW42bjdhazIwNTRIVHB1UU5jcVFOSmNEay93VS96SzRnQW16M0ZjZG1SODdv?=
 =?utf-8?B?TExqYXpXbHN1TGxnUENVTmsyZTV2NU12SjFkWjZLZXczVTdLRHdERVFvT00w?=
 =?utf-8?B?blBwa043SkhEb2xuQzNLUjRNaGVqSFhsQVpvTWI5VVZHWXhPUnUyRm9NRlpM?=
 =?utf-8?B?aTBFdDkvZmR1RnBzZ3p6QlN3UCtCaUpCVGNnSktabWtIQXJpNXBzdTZMY3BW?=
 =?utf-8?B?N0RLTklGaDMyWHlTSjNiYW9YTmxLUkxqeDRvdkpnNnZIRkRFc1UrczZlcmto?=
 =?utf-8?B?S3hlSG9sMTdha2IreDJuQ1FqZWxJSk5kVW43Q2hGRnBNU3dVZnVCWUx6Q2pO?=
 =?utf-8?B?OHc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:VipRhTKsjjKll/dhOQItaHN0tTxg0Ak5RKN0j4nss41CSaJYO9lb6mgn0pJW4d/8tPIdQ0F4AviaFW4bHrRCVUyu0ZrTe+9TcEvUw5I4Xmar9Bms49kJfvZHtWKMJdvMy2MwdydGeIh4nQ9kx00/3CFIVINNOyj7qP/JedSohsQ3euvIiTvzgEi6cfjLAIJ2dE8xzIGdUqaZOGg55AvipF8qmDs0Aln0JWoOpP2za7BG+khyRAg0e3aiiHu7viqE77NIMHpqIrmwZV+ytRN/7euYRW7vLQ3rZyWkOm7+ghQTqXeJyo034Xz2kGjqrBdFtNG83XRs6UARgatG0ylUzF2GhccQF3hgstza5EIXClk=;5:u1QCwqJ4gH2P9kkkocKn+gXyiWx1UDXTD6sDw7eszWcwPf/AzmmPZWJCVwPPnycKvHzP90OiFnOZ7s7GPUXkToS+mVAPorJ86egRy8abRORcCnRQbD0ihSBQHJgqC5eHafc4HHANR1ad1tJ0R6+9C32sFQgenyXGCSmu1KGKclk=;24:+6LS4n7++JVTchF4AN6ZjuKzyTf2v+scb+WgK2EnI5becour0HX2glyB0DXKHMho0QJudUd1kTjl31G9kNyzKQdZYgG+ybsMVt6lwT6n1k8=;7:1h50sqLcr0FjU82x0MnmNHpJpyGmFaCWE78+OJ+nIh8pUKor7AA+IL8nuAh9CeNhC5I6hxp0CMt42nQlob1g34Qg4BAiK66LZTsp0i+Q1C0QlDe1r8Zo4vmC01Y0/4fzHm2LEjEvKdR/UoIxHeeSthrXzBPnF6QZnhJJhMI0PoEBMjdFIRKHXRC7sOQf9+Lw1qr0eKnCNBBosx6iC5n7HVO6k+Idzn5SmHYYFH31WjGIDEvJf/bP88F9GxSBn6u0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 16:27:03.3528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188a71c3-7683-45c3-0aa6-08d5220e8d74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60688
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

On 11/01/2017 08:29 PM, Florian Fainelli wrote:
> Le 11/01/17 à 17:36, David Daney a écrit :
>> From: Carlos Munoz <cmunoz@cavium.com>
>>
>>  From the hardware user manual: "The FPA is a unit that maintains
>> pools of pointers to free L2/DRAM memory. To provide QoS, the pools
>> are referenced indirectly through 1024 auras. Both core software
>> and hardware units allocate and free pointers."
> 
> This looks like a possibly similar implement to what
> drivers/net/ethernet/marvell/mvneta_bm.c, can you see if you can make
> any use of genpool_* and include/net/hwbm.h here as well?

Yikes!  Is it permitted to put function definitions that are not "static 
inline" in header files?

The driver currently doesn't use page fragments, so I don't think that 
the hwbm thing can be used.

Also the FPA unit is used to control RED and back pressure in the PKI 
(packet input processor), which are features that are features not 
considered in hwbm.

The OCTEON-III hardware also uses the FPA for non-packet-buffer memory 
allocations.  So for those, it seems that hwbm is also not a good fit.

David Daney
