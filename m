Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 20:13:00 +0100 (CET)
Received: from mail-sn1nam02on0058.outbound.protection.outlook.com ([104.47.36.58]:13184
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991986AbdKBTMu39tWp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 20:12:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3IouRRur4OGS60BceFDc0w6iVPwuNWLAYhs6xr7GPXM=;
 b=C7lU6Itnmv3C2EnFk02ghFflXty18keB27PJxDT5p+MxvT3kkTqKrvLHtBhQKCyV/txQVLeHqN+fiIyoCc/Yy9u5sSvI8PrIyd1Trd3z51Zb7WJSjuPdKfSuckzdYwXnmIVqv/n0GbqUq5tX8FK5+R1ib/D99BUKRmq3siNO2mk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 19:12:36 +0000
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
 <fc2d71e2-cdd4-1cf8-13b0-ea462b5e7e75@caviumnetworks.com>
 <70fa7ec2-3e6d-e420-ff57-b34dc7ec311e@gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <5bb88fc9-5acd-0997-15c8-a9164c789738@caviumnetworks.com>
Date:   Thu, 2 Nov 2017 12:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <70fa7ec2-3e6d-e420-ff57-b34dc7ec311e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0019.namprd07.prod.outlook.com (10.161.192.157)
 To DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4de10ffd-b05d-4e8d-2ace-08d52225ae70
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:28a5X+1N0uU+gtvXMFUZAzzdkzUukM2heVEMH1hVcd6y73upgth5u6NcQEQbL55tr3CyDATM4LzQPNG5BVVaQibzB3B6W4Z4nJiJHmM2LX8i/mJGy+x/db8Wk8TGB2f1KbAB1dnirkfwKAUlJtaSAMx1lNzWbO36pbh5X/AukYNngQgWS58QYScgCMSdvaBaUF2OQI083qGmJ7pL5S9mrn045ApkGx0EOK1dco76UWbwkvl8aT1L3XK9UcLx8Xbf;25:IbbzelLKNNJUxjb2R6pcwSf6RdILIyE0o1XezjZHc629BkEetG9uvsygCh3Lmf6JQTrrDHk/BuvRqo1Pt8T6YgDMex/eW6UsqPrVgFFlIvoQHH6Qc56BN5lKpOtIRfKzHcyzfCVugK+19sYSK2o8JppfvtmXRnKGkvpsvSPY8LJUIcECMFTG2vifstL6iUoPv7CXAPOqAoE7MkJ3naFjYRN2vWeOeJvtpr9eDopGG6Ojk73wcj3qZTX5Ey5CbUCaBzt2kE4qn3hAOw6DTTs0Gs3MhTwT57aX1B2VH0eeLiZWz8/gVzQlLYm/yn/vgXLv2nJQ39giOQ7OuEJOIhF73A==;31:vtCJ0PE2MdmYS6uLjpURP1L6/cjbC7DReYsBqHJkSwljKK2el5ac6Pa8uJINGanhD9jLme2uuUGugzxI64WJCBE88/YrX2USneW5CPJGo9ZO2wznfD0sYjJXtDcItVWwlTUsA8Iqg0vurD3EjDHeHAOyUx59gCsf2EpFu8aBC9QeWjSuSZxz+AVOG+gcm8TECJzgQNROAoKzPFYvGweC5VqFjgduqwtBMqKgJLiQrz8=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:xXTDLKGl7vSuQ5+yICLEeo1UDP9GPqQXqkPCQ0Nu2r52VHbHcztqf0gZT50izNLlp1qlcE+esVnVaMERmrOKCchOy0ADCn1wFDJ/nvQ2dPKTm7wGV7Us93AeaQT/WVhQZr6doE3MzcjC65kXKaerStt6BCcqBc5Fnajblu+3qrVMqlTZN7+EQy8zbSwdeNmy4+fPbd6EuGtFQNZlYg1v1OXbPCykkRBIdq1LIZ5JeYqoyK5pE1Mnkrb5lGKWjLOQEXCuJ77hxlDmwQwe36OVV7YAUKXtoJii10RT3mCkUegNOwl+wB32qkFOCHMIMgU2/DF6a0VAaPfjfl46QUQ5nVtN69DehMBhzzrNGtCLXAWLXq1Ll3B59x5mbztMfQ5SQwXls+mL9k310ORrQENghLf/7h8CJby4RwabjlzYgnaeAAUwW9PERNxyCSUl7z0N/gfCJYDsSqHqC0y3aLP1qNQbk4cZd6o6zKFD/Fes9QZK4zO04y1cefFgmLtp+tJMGT+dY2eBKFRhAt+cwij6NOTLcz4dibovq37BDvCdWOczAmSV+9YGlrEBvoCDDZXn3xz4X+vQJje022FKTl4SJcSbL+sRUclJ3rLqU8HaOt0=;4:I0qFV/6YWfZE2k19Zmfkq+CKXY84cWlLWOhhnbn6Y/Ilg9XxSAr1OKbXGkNsmgvw/QiSU05jilxNq/4mpGuF2ge8BZCeVLWZAq2EqGiFTDRXQ0/XfNUjGyc7/49KxTlhIahYjlEOuMbv+aerPGAbKim/IZLGv9yZLeQ+0xxCvA/vcm1tB3aGtUezpyXM8XxtsUTRDjxsBb6ZKIpZSCYZJRUsktAl9Go6s6xJXM70oZOEgKHgEG8fDskuoIqaW5hqaH4BKu4Wre/xg1DPgk3oqw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR07MB34995B7D09DA590647E3603E975C0@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231020)(3002001)(100000703101)(100105400095)(6041248)(20161123564025)(20161123555025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(24454002)(105586002)(36756003)(33646002)(4326008)(31696002)(53416004)(305945005)(7736002)(106356001)(81166006)(8936002)(65806001)(65956001)(66066001)(31686004)(8676002)(189998001)(25786009)(6512007)(81156014)(47776003)(7416002)(68736007)(16526018)(83506002)(39060400002)(6246003)(53936002)(478600001)(107886003)(72206003)(42882006)(6666003)(69596002)(2950100002)(6116002)(2870700001)(3846002)(2906002)(64126003)(97736004)(65826007)(50466002)(5660300001)(110136005)(50986999)(6486002)(6506006)(76176999)(229853002)(54356999)(53546010)(67846002)(58126008)(54906003)(316002)(93886005)(23676003)(101416001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk5OzIzOk5QLzZydjVDcUV5eGFVc1QrME9hYVVsSkRk?=
 =?utf-8?B?aCs0QktBS1d6em1QdXowOVR1YUgrZkw5bHE2NE05WTBUNTljNis2bVQ4Q3Uw?=
 =?utf-8?B?NkZhV3JPOTR2STNpWWI3b2YyZE9hQmViQUNTek54Y1R2dUFMME5sdEc3YSs4?=
 =?utf-8?B?NVpKWGpLdDJWUTNVQ0VLWDR2b0tkL2wzK1JjTGZmeGtyNHp6SlJTMW82MmZr?=
 =?utf-8?B?M3czckl1Z2Jkalc2K3A4Si9hS1ExRERPUVI5V1U2N0ZuYjF2MEJ6OHUvRGdB?=
 =?utf-8?B?QlRlcVhHQ1RXT254KzUxNzJjRXhXRmMvcUpYSnowbXVVSVlCYVRKbllMaTFC?=
 =?utf-8?B?R2FDQml0czJkVnFmR3lCZUFsc2VDZ3JvOEEzWVNCMlEzK0F5VjhoeXBEZG8y?=
 =?utf-8?B?QzFuTlExZVNpK05WalY0TmkwcHk5S1ZHazFKOXBKNlBuZWYvWHQ0Z2FnYTF1?=
 =?utf-8?B?UzZvN3lSeVRwRWJGb05TYTkxbDVJUER0aG9EalJ5R2lJVFZreVl2K2U0S2J4?=
 =?utf-8?B?d2RkVmY3aE4wZ3ZUTHJ0Q1lJRUxpbHZDZFp5MXFkMkd5Zm01MVB0VlVnNHFJ?=
 =?utf-8?B?dG0vampuU3ExaldIQ1huZ1NPZUJTM0o5Q0hsZzdBSlBHcXlId09MczJnQVhl?=
 =?utf-8?B?Ujd1N3dGc2h0WFNHNDVqR1NqRnBmQ0hpMHJsMWxhWStPV3hpQ0FIcm9nditp?=
 =?utf-8?B?WkdNUjNzcjRCWDRmVHcxdmtMektLdy9abmVQZEc2TkVKNnd6czdKNzEwemFx?=
 =?utf-8?B?bGVxekRNOG9rUmhiVFVMSW93L1hwQVZ5OUtXMTcyWjZ1UjJkbW9UNVBaU1lV?=
 =?utf-8?B?NENsbGYrOE1QS1Vib0JZZmtZbWZQVFRjMkc1WnBNc1cxRzA1a3QzQ1NtSm81?=
 =?utf-8?B?MU5FVmluQ3RYVXNKbWxrYzBPa1ExT1E4cE5YVTdBNjNlQklpdHhPNzZoSUNL?=
 =?utf-8?B?UEpEUkpTc3dlQjIvU204L21OL1dqWExMZFp5aGhKY3dZNExCQWxUb1NkUGRp?=
 =?utf-8?B?WVZSeFFPSU1PUHcrU2U4WEFWQmF2eVI2aEppcEVZRytic1VTcTIrdTBvM1Rx?=
 =?utf-8?B?WndvWnR2OFNXT0xjRWZlVjE2QmdoZm4rM0grRDdIcEltMWc2MU1NRGY4ekRq?=
 =?utf-8?B?bzNmTjFqYjBwMkVoMk5NRjBiaTZBVHFiQ001d2d6aXlBTklvNWVCcFkyN3c2?=
 =?utf-8?B?Rk5aYkxhUFMxaUI4RDRMdWs4d0F2bk02VGFRRHh1VjBTSUxqL293WkhiWjhi?=
 =?utf-8?B?V1lKLytCNE0wb3pMM3hJZHpKSFBpL0xBK1Rtd2hTcnUxZW9ET1VqbHcxOEh4?=
 =?utf-8?B?U0NwellaVThiTnhHb2pzdWd4V1loN05Fall2UVBhRnJXU0tOcGhGZ3VLS1A0?=
 =?utf-8?B?SUVnNjJrWkwveDVLV2htZmVnRDFyUnR6U0ViZkVzaFhqcWYyWHhnWDBRcHVE?=
 =?utf-8?B?M1RZaWhsdlJQZHN4bkQrUVdlZ2ZtcXMxZlN5anY3ZUowdGU5U3V3bTIwSVNY?=
 =?utf-8?B?bW5FRm1GckJNMUY4Zk5mblVoV0FuVlBKOXNhTWtGWk1sNDdyZENIRysxQkVM?=
 =?utf-8?B?ZEdaZnp3aU9Wb3NLMUxiRm1KTzM3S2lUUTVuc1dveTlKRitmRFhGVG5OaVg3?=
 =?utf-8?B?RURXWkY5WkNPY2Ixbkh6WGFPQzBucVNwOGVOYWM1VVFHK2lqRU9GaEtZc291?=
 =?utf-8?B?dWJnWWdiOXBHUW8zdGhXOXY1aTc5emVqdWlnQ0NEZHlFYmIydytBMGVoYkN3?=
 =?utf-8?B?WUdCVzJtZzk4M2pMSURGK0ZJai9KYXhYOC9vQ1QzNmpyS1I4emRPc2F1VDFu?=
 =?utf-8?B?M2ZzaHlCb1dtbWlnNTc4SHQ2L0JrMnFoM2dCV2JUanVNVkVySnNydVdMRW5J?=
 =?utf-8?B?Rmc5M1RCdGU3TnFhdGx4Z0dCK0xJOEpuemI2cnpPd01LbkdZWU1hOG1ZUm83?=
 =?utf-8?B?M1FxMGFhNWVtZnM4VWUrVU5meVlyaENDSnI1ZGNEcnNJRHg0MWkwWm5KUE5v?=
 =?utf-8?B?bThqdGlUZ1JLODcvbmVMenJKbFFtZGl2T1J0QT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:9d3OsJqMbLdjmA2R1YYUuk4XmSDK6B0e866gIXLYsEF3rO751IXsuagUBSzbvfwA/1mxkSVega7KlEBOAa8cd60GL8by9Q/L0ijjcTK3nAXeliOmmfqkMslyopQ2kpIRub9JQI72HT5RNKdEPxFeNCkW3vQWknDjBoRsyKuEEXg2MUUlXm2se+yKKXaShkzFJG2ciJVd5V0Nugue30dDXBerUdkBZ/c113rbJuJ0FkmlwaYrsQ3PwCTL67LQ5o13Xzp9+WbsAoXKZZR4FwZifoL+FocQuXYYJBGbhm5XGJchytRMwY3YaoLs+CWfXfmCmZVTuO6Sd6j639VoRq+IdXLI21A9XHXD63Akn9weWvE=;5:uZ4tTDVqwjDWCauou2KN3udfzkUEU8iAFs/104Z3u6oIjD1/5TQUmlPc/eR5AFbuZRmZ/LOmafn5I3Xhn9HsxPt8hSlDRicEAprzRS1tVLYNIR1HZp3jr8gTUPtK6IXS0iJCM0uanICE/m2LO2UudSxu+yQ01HzU/w5JKfe0gTs=;24:2On9dOj9UcClG2LAVk/HBPbfY1iFgqyrVraiaqroFXwK/sX//5Pmx9WU63l8MJj9rpc/G8ykZm+Rwer3NC+kDEHP7kNFhTVhJ+tVUbxiBww=;7:nP1lj2JL+akH8pL+AZWRw5mRqHm5+/uFDNJR2uMkexzi6zKLuP0VhEVVJbaYTWN8OFZJfAbHdeU5vheFIFPiNWm1vMy2f0Qn1we4oulqgNLXTk3S2D4GrysLkix3USo8vGkzyQf5TfTUjLKDhXBOlCqp2/DbYYAPYXOhmWuoXs8HJzX/jx2TpLDPRAAaBp0Z496ILbs2QmO6zkG48Dt39MB28Tw18OrGo5rsNbHG+OjwCM/NrmILiPI1ojXwkqDM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 19:12:36.8201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de10ffd-b05d-4e8d-2ace-08d52225ae70
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60696
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

On 11/02/2017 11:04 AM, Florian Fainelli wrote:
> On 11/02/2017 09:27 AM, David Daney wrote:
>> On 11/01/2017 08:29 PM, Florian Fainelli wrote:
>>> Le 11/01/17 à 17:36, David Daney a écrit :
>>>> From: Carlos Munoz <cmunoz@cavium.com>
>>>>
>>>>   From the hardware user manual: "The FPA is a unit that maintains
>>>> pools of pointers to free L2/DRAM memory. To provide QoS, the pools
>>>> are referenced indirectly through 1024 auras. Both core software
>>>> and hardware units allocate and free pointers."
>>>
>>> This looks like a possibly similar implement to what
>>> drivers/net/ethernet/marvell/mvneta_bm.c, can you see if you can make
>>> any use of genpool_* and include/net/hwbm.h here as well?
>>
>> Yikes!  Is it permitted to put function definitions that are not "static
>> inline" in header files?
> 
> Meh well, this is not even ressembling what we initially discussed, so I
> was hoping we could build more interesting features on top of this.
> 
>>
>> The driver currently doesn't use page fragments, so I don't think that
>> the hwbm thing can be used.
>>
>> Also the FPA unit is used to control RED and back pressure in the PKI
>> (packet input processor), which are features that are features not
>> considered in hwbm.
>>
>> The OCTEON-III hardware also uses the FPA for non-packet-buffer memory
>> allocations.  So for those, it seems that hwbm is also not a good fit.
> 
> OK, let me see if I understand how FPA works, can we say that this is
> more or less a buffer tokenizer in that, you give it a buffer physical
> address and it returns an unique identifier that the FPA uses for actual
> packet passing, transmission and other manipulations?


At a high level, think of the FPA as a FIFO containing DMA addresses 
used by hardware.  The FIFO property is not guaranteed, so it is best to 
consider it as a pool of buffer addresses.

Software pushes pointers into the FPA, and the hardware RX unit (PKI) 
pops them off when it needs an RX buffer.  The TX unit (PKO) and input 
queue (SSO) also use memory obtained from the FPA as backing store for 
their internal queues.

In addition to obtaining buffers, the PKI uses the number of entries in 
an FPA pool to control RED and back pressure.

There are other features not used by the driver like threshold 
interrupts, and pointer alignment so you don't have to calculate the 
buffer address from a pointer to the middle of the buffer when freeing.


> 
> There were a few funky things in the network driver, I will comment there.
> --
> Florian
> 
