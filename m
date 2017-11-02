Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 17:04:03 +0100 (CET)
Received: from mail-by2nam03on0049.outbound.protection.outlook.com ([104.47.42.49]:46240
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993373AbdKBQDzqpuFt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 17:03:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3JFEQNqXrf9ZSX3K5ROzV0FT/TDbpWabBNT/uH/EX2s=;
 b=nl8EZZvoe6wSrIrSMPsTXEGTI4pg1SvVUU4E8isURe3casl1euhKWimJ5c4GjTk1F5OZe3IzqPQG6u/DspZvdgVDeGUHO+gj/euY1tHKhTXD7JGoApx39EBrKDqRLLIIkqXLu6K68gYqHDL/Q9DtaspFQveYmq1hKsBLwPn/q+8=
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3498.namprd07.prod.outlook.com (10.164.153.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 16:03:44 +0000
Subject: Re: [PATCH 3/7] MIPS: Octeon: Add a global resource manager.
To:     Andrew Lunn <andrew@lunn.ch>, David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-4-david.daney@cavium.com>
 <20171102122327.GE4772@lunn.ch>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <caeae680-915a-d08c-d220-899db0970328@caviumnetworks.com>
Date:   Thu, 2 Nov 2017 09:03:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102122327.GE4772@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0043.namprd07.prod.outlook.com (10.168.109.29) To
 DM5PR07MB3498.namprd07.prod.outlook.com (10.164.153.29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13537de9-0e37-4ee4-89fa-08d5220b4ba5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603238);SRVR:DM5PR07MB3498;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;3:F23d+XpKO37/PQGGaVTn9XByh3K/5oHr4aQS0iQCXMhhXyaCh5E+ggao2oTmZC2KkP8dEAOcQJYeKCO9+H8Or8izU5Wo7JMorw00TWXtZuQdqMUXNXL/WJKahrRcgyO5OWEMCLJfTNta3MT/04Vdrcm1iImqY3aY9H72kzxMB2IaVT4+T8KYbGrzRpNNYAk8Cvde3jmtS4GTwNGex/W+6o3yKR3Wsnb+elA1s3SmycJ+s11uYlDam3JVTYxq1aBj;25:QKGmt2GO4OvwYSX74iUocfOpANIDEU2380GZbx4deb7Be9Nd1esqObiVFLlkOIobRwrAUdsMWOGHK9qOkCCSYo1xQVjnXHsFDr+84LFTJN+rdy8irQRjvQ0Hll9lR6wcf3yj6Hre3CzApE3vXeX6nXDKGr/pDFl2VqMrqlOStqA55/wYz0T4jG+oC16oqmPGF2dK9liz12fqrFuKG4pRVP3aeDJNuaHb1frNr4YJdFeDsQum6Q7s1Bw+A7XlE/hl4oW53pRb4BvB3RfMpF6KhVFlotFR5VkJAeyfxJ4QRZ6hovUwu+Ocf6YZ4/glYIJQ3iG9I0yAcizUyLWiu7e3Ig==;31:yP5n6HfxT6e0YBBSLvWzlJlSF8iBE3lOBjxCNRrQQOzuXSbMViXHyDLvZXVAqeTHTOO1tHMHLHRLvdGe4ateVku7i0rl3myMcRK1YPU5C/tuDh0e8Mxj9R2iteV1YaFxdMOfV+ntIL9Gr0jrAeGfymnbQQqj2xAILsCRkKU4XyuY5N6DVSyhBROZdxzcvag6TuDmjsqlcXk4208ZgEw56UHNGjLwar5u/oFUX3cmFhg=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3498:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;20:Kz6wrmIgkkf9tKxL4LQTPBdZn+qf1ELvIL/P1fTfwr45BgxF0bnnE92X685m8Q4IkQzFgbV8e3vT8efLTHIopsx4eQFnASP8GjhIxt3hvH+tcSj705cuL6MM1FENQIl8KwPC50R0e/f15garMoaTn8lIhLcwTuSdQ7afkXNaZ8fA46r3TWh5lk8+CXxfO7HQQRaINEXgkUVwHwg9UX1dECTYs5HTNXOXxFvUgkMzBb+sRgO8mmHP1HOlYU/5j+HsCyKTaa2foaJqvMV5wNMmQizcGAV0D9gbwDLB3+YDlZj3zqjMcXkIrfHMMYxXOa3zHPB7DFW1KX50VAioatd3HkIaHqw1HaVrQ6zDuesEvv9butAOONcYFo0eV1ZvhHvC2JZjVpCptTar7zwmUVluSczUbU3eVq4Jj/GyEgz14p5k15KuAMovHjdDxTOCD6G2fIeFRNrxBbp/wCNkZlJ4r+cyh2IbI1EN7AVnQgJtGfs+DxopO/LPOMmVvxchQMc/BFatjCO/+um1DzgrMx+fISXjIIOxsRNUQLCnq3tf5FfLFXH7H6jl2fKsS6PVB7WZkIw9mg/q5O1SZlpaZaVTABfoc9/MELYLdd7zHAscnIQ=;4:vmalK0Jh2avaAwSLNzrP2gD7lZDMvLSlILDmfY4uj2kmXgzK/1llT7HRXYovhw7JdB+DSFxlieBj3XYRjDMyDmIxPNOo1HTtyBbDTsXN7CU5efaypE7gIMqtijAiktt4KPDLz0ztV/Qqnf3L1lTNukyqQ5cuYadC51xblc18VH+EqapM8reap0lEkoH1WSEycjArNOSJObaEPZURQBuy6YRJxSOa9ePjZsXRMpyMXQFlgtQN4X4s9kobSCO1ruynYm8Zyv09wIhISFc4OcUtMg==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR07MB3498D3AE99B3DEEA9E07251F975C0@DM5PR07MB3498.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3231020)(100000703101)(100105400095)(10201501046)(93006095)(3002001)(6041248)(20161123555025)(20161123562025)(20161123560025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3498;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3498;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(189002)(199003)(24454002)(83506002)(72206003)(229853002)(47776003)(107886003)(305945005)(6246003)(53546010)(7736002)(64126003)(16526018)(65806001)(81156014)(110136005)(478600001)(58126008)(66066001)(81166006)(54906003)(65956001)(8676002)(53936002)(316002)(69596002)(6506006)(6486002)(68736007)(2906002)(31696002)(33646002)(31686004)(7416002)(4326008)(42882006)(230700001)(97736004)(106356001)(8936002)(25786009)(5660300001)(50986999)(54356999)(65826007)(76176999)(2950100002)(53416004)(36756003)(105586002)(50466002)(3846002)(6512007)(6116002)(189998001)(23676003)(67846002)(101416001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3498;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk4OzIzOnNkd1Q3WHBZcGNwSnlPbGZYR0JHQW1BdDVi?=
 =?utf-8?B?MzJkbk5YWGpSVnNhSXB6RlJoT1FIaWRKU1lVc1JSQmtXQldGRGhMdENwWklo?=
 =?utf-8?B?Mk5rKzVVQncyeGZ2bC9TeDRTRjFJbW0yaWJyQmg0cWpVWjFIYy8yUUprSmpV?=
 =?utf-8?B?dG9DYXJpSVBVWnd3YlJmWVV2Y3pQSHFydGRURS9Nc3ZWTUdFN3g3ODJVbjNy?=
 =?utf-8?B?R29FMDhtbkF1VUxSTnE0akN1MHFyaTJwUUtqajFyVmhVWVkrbTRqTWxJdWpM?=
 =?utf-8?B?Y2FVcWhaR2ZnWTZyT0U4dEkxTWdiemlFdTFuOTRFQ0h4dVcxZysrbmY5dDRu?=
 =?utf-8?B?SkF2ZzJyTTdIVXJZejJncHR0cE1CMGp4a2xjbURoODhxV0xjeW44bVpJZ1Fj?=
 =?utf-8?B?bVhkNzhZTGUrd3BFdW96RFNmbWxIV1NzYVFCUTlKQVg5L29PcW9lZjNuU3l2?=
 =?utf-8?B?TzVmT1BjN0FGWTZwL2pGMGIvNi9Bc09qM2dmb2E4WGk1ejlkM3p5Wkd1eWtL?=
 =?utf-8?B?WFVnZkV6NEdWQklvVGlkcWRlR204bmZ2RS94dXhvZVN4SFI1Ti9YRzRvREJ1?=
 =?utf-8?B?b0xiT29tRzVZL1k5L284QmRqNENvZnZ2d2NBNXlFeFd0aXNjUEVldlFIekpQ?=
 =?utf-8?B?U0t4bXltU2hGRUtra2xqSVJPNkZlK0xJdHE5ZHRKeVJGY2hOMXFhUGRGS3FV?=
 =?utf-8?B?bHY1ZzJNOCt6MStjcXFxZXVWS1IxT29zdk15ZXdlejNGOGRPbWJhZmVVQzdV?=
 =?utf-8?B?MnBWYXhEQWNXTk54Wmp0bzFrbjliMktqeTFrSGp1M0kxdW9tTW5vRHNhZHlJ?=
 =?utf-8?B?WnVTbkgzNGJydTdaMjdNQmRaQ2VySFNYcXgzNWc5K2hGREFoODdvS1lKcnNO?=
 =?utf-8?B?emhBdW5uSnBkQnVBZUZTaENMeUdJdEhHYTdBQ2FYeDlxQUZmakRqTVNNQnNH?=
 =?utf-8?B?Z21uMHJhTWdwdjMyZmo1elByWlJxcitCZUF3YmVtaW9kaDU0Rm9TTko2bktK?=
 =?utf-8?B?WUVjTFNva2FIWUZzNDdzZXlCV2ZYRm5EMDljVm1aT0hPNEJCY2ZhU3V5VnI5?=
 =?utf-8?B?Z0o2SldSMzlMNHpIYi9IMEp5RXA4R2piRXB3M2VqZ21seFFQY1ZFcGhpblJw?=
 =?utf-8?B?N1pYRjF2dWxDRVFlb29UcG5FcUFGYS9WMmw3ZGZQUGE5R1l2Z09aWityejF4?=
 =?utf-8?B?UGoxbUZ4ZFluTlEzM2VTZGpIT1loWXdKeW5RcTVUSXpMRmVFeHhiVS9NS1d4?=
 =?utf-8?B?UE1lYXZvRXVlQUdWNld2RVRmMjZjekxZU3lnRmZZbE5UVHRZMTJrSXgzaCtl?=
 =?utf-8?B?SzRudEN6OWZZMElOc0QwNUQwSTVSOWtyYXJHd1RMUHU5Vm84NlhlMkJJOUZ2?=
 =?utf-8?B?SkxiOStWZHRwbmZuTVRhQkE5cGdRNHhqOVBLaFJyRW9OMjN5NUxtcWIxMU1i?=
 =?utf-8?B?SHM4bXlXakFHUGtBOFQ2QVRNSU0xYzFYVmFTNjJieWRPNG9NNHhRR090NmF6?=
 =?utf-8?B?WWtnZXBKTkdmNFBkRnNkcDVydzdmWmc5ek0yN3l0V1BkTUp1Rm0zMmx1T1hD?=
 =?utf-8?B?UjNKY0JBNE85U2VpV3pJeGplVUpNS3BDQy9MUWZqUHhhbWxjNENweFFVaG0w?=
 =?utf-8?B?TDBwNjVVUldxWDNIb0RHMnlQL2dHUDZzWW50QzdxVXhuL0xwQXh6TXFBdldh?=
 =?utf-8?B?OEpFcldibWpQOXoyS2ZYUENJTHlEbUNuanB5RDZRMEp4Rmk4TGcxT3E4STEx?=
 =?utf-8?B?bXNMaEd4dTVQRy9Ia3hpMVZ5Qk5DT3pESEUwUm5yMUsrbVNQSVdyQ29HcjNW?=
 =?utf-8?B?blhldGJLL2VSWjFFT0ZBZWRMNFFYNXZPYUpQQ1IzOE9JSUJDRlNuc0o0WWdO?=
 =?utf-8?B?a3cxbHZEQUVYUFd6NGRlRWhrWXMrT0FLbTZWUkJrMWlZVU1DL25RZHBPRVRa?=
 =?utf-8?B?TXR5MHg1MUlBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;6:miJ7T1d5jQYtk1pAxmoLFykcitmh2wu67I9HIIUYL/MloOR51U5xVymthNrmggC1wG2t+S0iqKyrwsE0u/p9J4Nwon+SP5/Plc+7BjMKXp54s8dpZwJQbU+KeXaxLdm4hGIEouL4lknyVmffP8/fXFI0Jza+jztTvXGXQ8AGt/7ocEu8snVwU/8JwO8YyRVXC0codylJecW91wWjrHhFDV1yRl7UH+CmsqHRBKmU1iTMO3RCXFNldt/sY7xjaIcMv4wFkn8q/Ra6Zo8f22MU7ck5pNmMqYzoKxBrVRDQiG8Rk0X8bJWIz0m+IYbAwA0s/f6D6I84vJb0/Zu/mg+5d6/+Hp7hDpixVHhJ1/40Efk=;5:HG1ea/N+i5CSgmnDBoiT6BhplI/yYBZmFFgRRn9WktJNjyCc21PKNIf7QDpitN1gm6r0yYaVVQg0TyQFfotfwr458bky5BSmnsGr1u8GL6LdHe6a7QrAjhc8efdWqCNeQJOqdgKwZvZeoIEefHH+NmkJ/UHCQtLuCPyweI+i7DM=;24:RVGMROrz66Wg7h0fCWS+jVLdlAZxrWyREnI3UUXWayXZ45BdTZa24qbYnHt/SO7PIuZSozWkDPG1ZTYxPe+F0xRcUdCBcK0PfMyFzLtw8M0=;7:egSUdrtEJj6Vhhp0P0aApda+h6fZnuqOxQPo3Fy26R7BGr44kDYcVNMFA7balqcjKk8PAlGZZJyZLbImqwxs7eUt+JlgBkcu3HZgt6zcklT8cIYKYNV4zviGH/97T+RbLZ8LX22/2myYYHDztiCODKirnhxMDuwstbBQOGgGr9wKOY2BDPSp/awJk8SJiQadqMNLb/zdqOYhdPsIYnJqqcsCxJKrOKR6+jLAw8CgNzHQoy1ZkOKzQZce+EY+OmJh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 16:03:44.4573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13537de9-0e37-4ee4-89fa-08d5220b4ba5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3498
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60679
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

On 11/02/2017 05:23 AM, Andrew Lunn wrote:
>> +static void res_mgr_lock(void)
>> +{
>> +	unsigned int tmp;
>> +	u64 lock = (u64)&res_mgr_info->rlock;
>> +
>> +	__asm__ __volatile__(
>> +		".set noreorder\n"
>> +		"1: ll   %[tmp], 0(%[addr])\n"
>> +		"   bnez %[tmp], 1b\n"
>> +		"   li   %[tmp], 1\n"
>> +		"   sc   %[tmp], 0(%[addr])\n"
>> +		"   beqz %[tmp], 1b\n"
>> +		"   nop\n"
>> +		".set reorder\n" :
>> +		[tmp] "=&r"(tmp) :
>> +		[addr] "r"(lock) :
>> +		"memory");
>> +}
>> +
>> +static void res_mgr_unlock(void)
>> +{
>> +	u64 lock = (u64)&res_mgr_info->rlock;
>> +
>> +	/* Wait until all resource operations finish before unlocking. */
>> +	mb();
>> +	__asm__ __volatile__(
>> +		"sw $0, 0(%[addr])\n" : :
>> +		[addr] "r"(lock) :
>> +		"memory");
>> +
>> +	/* Force a write buffer flush. */
>> +	mb();
>> +}
> 
> It would be good to add some justification for using your own locks,
> rather than standard linux locks.

Yes, I will add that.


> 
> Is there anything specific to your hardware in this resource manager?
> I'm just wondering if this should be generic, put somewhere in lib. Or
> maybe there is already something generic, and you should be using it,
> not re-inventing the wheel again.

The systems built around this hardware may have other software running 
on CPUs that are not running the Linux kernel.  The data structures used 
to arbitrate usage of shared system hardware resources use exactly these 
locking primitives, so they cannot be changed to use the Linux locking 
implementation de jour.
