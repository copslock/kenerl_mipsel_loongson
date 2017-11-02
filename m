Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 19:32:08 +0100 (CET)
Received: from mail-dm3nam03on0084.outbound.protection.outlook.com ([104.47.41.84]:18548
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993373AbdKBScAi9uhp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 19:32:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AaGxfUhDRQ930fANYt7/WYscyx3j10KS5aq0tiiFFrI=;
 b=o5+vaxxrA3GyEpRHU0lU9cCvsQsoALz80/Hng5zCfwWco15/PfcBsoudIfQkT7yqvj//USnUaPE60ZA2MHY7+0q5Q0qC75qfkEs/FyMq8c14TY1lqpQp6XLOiO9jqBae4fKZAfHjLZT3GHfMUrM5NOeSlfnWbJZNM3WZaiKTVFI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN6PR07MB3491.namprd07.prod.outlook.com (10.161.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.197.13; Thu, 2 Nov 2017 18:31:48 +0000
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
 <0f39046d-dc99-5c05-d918-10952cd20e1b@caviumnetworks.com>
 <20171102165605.GJ24320@lunn.ch>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <0168761e-cb18-e489-4689-8c9062aa316b@caviumnetworks.com>
Date:   Thu, 2 Nov 2017 11:31:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102165605.GJ24320@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com (10.161.192.146)
 To BN6PR07MB3491.namprd07.prod.outlook.com (10.161.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0da9a5b2-10a7-449d-d409-08d5221ffb0e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603238);SRVR:BN6PR07MB3491;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3491;3:iCVDuqbsUUn8qwGLKi/ba7V7e5yrn48trYC27DzMQI69Ar/DaBhroEouEXhO9vgzlWEmDVm06MGEv1XRcIq6fdFQEGdPJUQS076wkUw3ql6u4cL4o2HjFdzpojXn8CM2XpMvMThAqYMLkMDwIvL+UFqOgWN14Hxj3jidjbh2MIYuWaSWr/QHZD3wwkHrW0d+dgFolChOh645SReeA9gvzLTMHxhjuWkv/7KfctXFTwyyuROWFNAI7RwATAIDNhdN;25:ZYl6BOrqFL+RzAuzzOkjp4JfYpgRCh4rnQlnJrnVVRLl4ER1VS8ZZDlAdke0TYAm6tMlN1Qo59jGp5I1JTVtFYLhCzTL0ELgOl3QePpJcNnYy3ZdCyQjNL/UHQYEpXlddrfMpQQTlz08kFpNQf0WxC8qmLMbTHZpij4DcjxoBmWEW5TPGPOnzau40cwvJYmtwll8ZQb82M9PsnBekYx1N7GpOWZlKlO5Jl3ELo+ReOmjd832aWtv5vN732KiQiqovDmmT9rtXZ6DBTsroWKjClH4nVMHS6EVO1nqyi3Wj3V6JTVathDNf1pwa9vKhmebIEY1A4lbW3DpBnZrGmnl7g==;31:g8M972Z3dpvwzDEAUP0pJZa4ePiH5mHQ8w0tJvXCjyCMfmkvud8t0Oyg2sK94KdHs2jm/KbaDzSv53TZrAzjZyJ/s+p7yeo1gEc+HNdE4f+pyf87z1xhTEqXsqhmH78WEVbqcNAfD4gXzb5IWKechZdyREX47ndXP2OFnC9MMuwcV3zFlPTrYFWaD9ZwemXEZQwMprs20H0asVyboJ5ZC80pCxxG/unjYTZikpKoccM=
X-MS-TrafficTypeDiagnostic: BN6PR07MB3491:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3491;20:vG4IF8J/XlKBZnVLDq5wSrcufOo2eGws+tc/jutvC8EYeZz7c/oQkMPITg6lFQEI9rjONrASo99rPVZfu0jH5fMX3g6T5t1x2msOfyQrDHW/NiJ0tHnxI/R0j6MCocK4D/JlAu5i+zF9F8/kn8ux8O006zBy61iMcBncYSsOVvsUHrkx5n1dVIWzxC41oZ9Zcd1iqJe6j6WtgbukBsZO44G4Eo30qmDtQbiB02eK5r1nrCTXf0DMI7KiBYsBo7w0OKL/MnB4jHF/iClQAISmxXNUFoGMLDrOMOFbRPM7lZ5Y8dq1HCMNDMjUcrX3rYx911OdqRTAy8+6TP31ezGcFdxYIqEK+el06l/gCzjCdEqHQMyckTMMdUxTiEiKEJmxQWVKNmH/6WlXNi6fecq1j847eiOgcunk4qOV2IKw/EBuX87iV4Q3n+lpX13i7M7ExAAbpHUn3RwYZXMxVjWxtnck8PKFfuUsImuRh2oy4CdgXxlW7W37/wIAlUQiaFm3okVcutKmSPKQvLlJmF/sZelZwtgsMiqhp5VLp9lhr+xlK9QNfsiQIqsRAFqr490v5MJQAEsdORtmnmef0LvkpB46Ps9XRJYFJgMmRCBBWjc=;4:ywQzcIw9FytovCQOSBnajzzs/SF8BjngaEeOnbrv4orSlZs/H7eS/1Cu8UkLWUs7SBCnKwVfZSfEjHD7Z3mE4LsBY/Sa3oofd8bLRJXDAYjHkBSP5qQi8lioGvAXiqIKrPy8z4hM6FNByzi75i+wrIyvdB+y6b9BupFpW7rzStmm7eYVjYQBT42aemrWJqqJtSNVZ/syHkpl7j0h2R6dhbx4GXLBXGSzReUEfM8iiKDqKx4ju5wMmpJkdS4zCA84P+FPSpYctzsClU1/CVfG+JgOCx0yk1bEtVFoEFV0T7EGbFtBoWyQwXbq+qjrsVld
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218);
X-Microsoft-Antispam-PRVS: <BN6PR07MB34915ABF3F2B6694137B21D3975C0@BN6PR07MB3491.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3231020)(93006095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123555025)(20161123562025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR07MB3491;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR07MB3491;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(24454002)(199003)(189002)(6666003)(478600001)(72206003)(7416002)(42882006)(53546010)(2950100002)(6916009)(6506006)(6512007)(6306002)(50986999)(93886005)(316002)(8936002)(6246003)(107886003)(58126008)(54906003)(64126003)(81166006)(54356999)(76176999)(81156014)(53936002)(966005)(69596002)(8676002)(229853002)(6116002)(3846002)(36756003)(33646002)(106356001)(53416004)(305945005)(7736002)(83506002)(230700001)(97736004)(189998001)(25786009)(105586002)(2906002)(47776003)(5660300001)(50466002)(23676003)(67846002)(101416001)(31696002)(31686004)(16526018)(66066001)(68736007)(4326008)(6486002)(65806001)(65956001)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3491;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDkxOzIzOlpRMzExSlhSUVFyNUQ2ekFSVWNPWHlFdXlu?=
 =?utf-8?B?OUlMWVppa0lDMkp1NjhrWlFVaFlMMkd5eW5HWWgvVUNCNkN1T2RGM3V6dHVP?=
 =?utf-8?B?V0dUQlN3akRRWDVFdld3RVRMaE9KVUVJY2loUXVlY2Z4ZDBRRGJtTlJJZTEy?=
 =?utf-8?B?eE03RVl4YjNzNnd4QUc3Tm1EcnRXZng1cklsZXBtSHVuTGNYVURQM05ndFk1?=
 =?utf-8?B?WlJvK3NFeTQ5VHVRT2RIc3hpallmQUE3cTFybTlmYUVEQjJraTBIczY0d2lK?=
 =?utf-8?B?em5kcmxpREplaE82MkovSk5ZenBFS0E1Mi80bUFMVGxHeG5JYmppZ1hxTnpH?=
 =?utf-8?B?K0Q1Y3RQY2F5bWJEVmxBZGVkSTVXYjQzMmo1VjhWaXUyNjc3bEpRZVBNVEJi?=
 =?utf-8?B?QUJZdTRuQlhWQUEraTBKblA5VHpYb3ozZmVoRjZIaGR6YzJkazVLcDVKajJH?=
 =?utf-8?B?bUhtMExjSDZOOXlRZ0hYdy9DT3Q2M2R0Z0NJa0N5bWoybGZNMVBnNWJEQ05j?=
 =?utf-8?B?SE1xMGhhWmxIaWV6Ymp5VDhLYWJHZTR3emlDYjNLb0NaOWVjYjErZ0dpNmp6?=
 =?utf-8?B?Mk45WkJlU0V6TEhqUEFCTUwxQ0U3M0EwaW96Q1NGYlJ2STVFYVB3eUg5SjVa?=
 =?utf-8?B?YnFXdnZXRnI5bGFvYmNEcnpnQU9mQ0pFODExdVdCWEhsNWN3VDdWQ1VYdzF6?=
 =?utf-8?B?c1VBVllIK3FLNDJmNVFiY2IyTVhaYWFHZEtVWk52b1Zrc0xWc1k4QUsrVE45?=
 =?utf-8?B?dTk3bXFjOTA5WHBObFg2dndqUmQ2NENTM1NFVjVxbkhxK2llMWgzeHY1enVB?=
 =?utf-8?B?QWJJZlNzaUxXNm5rVnJkSW1xdHpla1dnWEd4YnhMNkd5dkxRSCt4bVJnWWJn?=
 =?utf-8?B?ci9mcWdTTUNHSmgveFlaTVc1YnNlMmlDc2JaUTNiUDlxcXREaTRQQWpzTzhW?=
 =?utf-8?B?Z3BZUWZFamRQSnJLRCs0ZHJ3UjRwL2M0NEZlbmFpU0JsUGpZMzVqVUR5aCtI?=
 =?utf-8?B?NXJaS05DUHZFcW8rTyt1ck5iOWZLRFp5cjlvZVhZaGFzMkZvVHFiVlUwcG9a?=
 =?utf-8?B?bFc5ZjUyVmRqeHY1S09oQThRZmsrQUxLQTJUa2laa0k2QlRtSWFITDgwYWVL?=
 =?utf-8?B?RFdHQW1oNG1mQWZXRm9PaFNFR2JJRW1wWWtrUDJkRXRCaGNBL2llNUdjY3Jy?=
 =?utf-8?B?N0lRSkZHQUlYbEM2U1NxUTg3SnU5WTFKRTVBMFVkT3V6VCtMSFN2QkRXZ3g0?=
 =?utf-8?B?aTFSWnJGT0VXUUM0VDhoaXloMjJ5UWVZbUJYYUNnSHBlMktQUE5vekJ2bzJL?=
 =?utf-8?B?dnZ5SXg1bU4zdEJpaTRIaGE0bWZ4cExxRDhDZUlpdmZPdzZXSTZYYTgxQjEx?=
 =?utf-8?B?YmF0Q2NDM1RMM2lXZE9xWGZ4UUY5QlRGVUVXU091TjZsUnV3NERyR0lkdzR6?=
 =?utf-8?B?Q1VSZVFXQm1XclNXYmxaUklJQ251MVRFK1UzYzVVY0I4SEQ1K1RYckJzYTBM?=
 =?utf-8?B?eDZ5bTdFTEhKSHQyem9PYUdHQk9yQWdUa1V4S0ozN2s1NFZnK2hpeHp3cDVI?=
 =?utf-8?B?cHhGNnRjdzJOcmN1RVRYTUJ0aG5yS0RjUWtRRTE0VWQ1QnlJRG44Q1RRVFlG?=
 =?utf-8?B?ek1IM0t5OFRKMXRWanJXbGtTclFZdTR2bUJuQ1Bya1kweXhHU3g5em1udndQ?=
 =?utf-8?B?b2x0ajRkZXpjcUY3Z1JVRVFoL2RzejdrNjRENmd3cFZablUyZityTEswR2Q0?=
 =?utf-8?B?WFhwa2tycFgraFVuMDJXMVJIM2ErdHdUQlRjVWJ0a2hySysvYW8xUDZsOEda?=
 =?utf-8?B?dnF1b0ljSk8xNUNRb2FwTUhoSjJabW5FbDk2WGJJbTNyYnlUQTdkc1FqRHZ5?=
 =?utf-8?B?RzI3cWk4bU1TdEpoNHpsQXFrWElYbDVrWEhFVHJPeUt4M0ZjN2JsVEl1ZlJO?=
 =?utf-8?B?OHRIbTBPa1p5c3Jkb3FZanRPWU9jNUlhMnVZcE1FeWYxZkVWcmNSSkp3SkUv?=
 =?utf-8?B?dXZZa0xkcndVcDhReWVrUEUxY3JtQk5MK0w5Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3491;6:90VfmgLSyTSTlryR8mu584ndiuMbuqkztYAen77iaM5ii7g2xcAw5Eke46bj7LZVzoxRNfY0Pc5ymR/6bm5qr1Weu86a51w9SRnGW54SPbjJjp4mSynUJ5UaVMOU+X+bS/jZbrZc6e0KgPc5DP1pq58xpiTn4Kyn0DaniiiuTmEXxTHEE1jtTrmDlYutKkrjLzdSee7Ei0kx3lWZtkYPid02O8DXg2Qhc4LdjVPjvV4h27L4hK3EacdKyp78gCAG+dmhSAFFDq0eXcuLJyudIArJ3rHhRuInZYuR7WbFJcHLm9v9x9g0FyKMUH815YRCJs3KKdl9RHWdf2Jj0Oel3epUmog88HuptcxeptCm7JE=;5:Ieq+VVjGuHCQY4zPOz22oxVxJdHVNjvwrvCNVkVyjyIKAsbE7Cd94bwhPS5zagkz2JBHwGmCJxMHSAdZEPaKiFl6+nVRT/pD8TdPRLRO444y7QduaYOCNoJUTVmjvb1lh9Z2UUdgupDlygYmM4QLqB5YaFDnDNX6zu3314xf4wQ=;24:JOXLLTJFzRZsSWt5hX1c7Bm8vZmakmYjTHw3/lvhHxCVmO7pjv9z1qld7Kz1ZIFoyP4KArNfNUeaQLCaV1cElsfJsQqoBtJWnmigKGzK2v4=;7:gSmT+9Xr8ay+YjWOO4+tNxzG1/TGcFN+3/oxXhNPtT02BCyYslh89mzdDv2HRTgSN5NGR2dctMPeW6QqadkMdrfHavYDkZJQL/Hz7zMO2GBnc1Gcifb3fH8eCfnzlV/Fp/UyUK3MDzu2UEBB1ScCsPMgNTmL+cfcGTvsGHCSjzmoI+kQQ2wOe90NIltv/qWIIig3TioqFMme3fm5MOYaqp/Cq/C/pldMxMGOFHOf+XA+TxWXx/PCiCRrEmbVp9b5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 18:31:48.1676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da9a5b2-10a7-449d-d409-08d5221ffb0e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3491
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60694
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

On 11/02/2017 09:56 AM, Andrew Lunn wrote:
>> OK, now I think I understand.  Yes, the MAC can be hardwired to a switch.
>> In fact, there are system designs that do exactly that.
>>
>> We try to handle this case by not having a "phy-handle" property in the
>> device tree.  The link to the remote device (switch IC in this case) is
>> brought up on ndo_open()
> 
> O.K, so you totally ignore the Linux way of doing this and hack
> together your own proprietary solution.

I am going to add handling of the "phy-mode" property, but other than 
that I don't know what the "Linux way" of specifying a hard MAC-to-MAC 
connection with no intervening phy devices is.  Wether the remote MAC is 
a switch, or something else, would seem to be irrelevant.  All we are 
concerned about in this code is putting the thing into a state where 
data flows in both directions through the MAC.

A pointer to an existing device tree binding for an Ethernet device that 
has no (or an optional) phy device would be useful, we can try to do the 
same.


>   
>> There may be opportunities to improve how this works in the future, but the
>> current code is serviceable.
> 
> It might be serviceable, but it will never get into mainline. For
> mainline, you need to use DSA.
> 
> http://elixir.free-electrons.com/linux/v4.9.60/source/Documentation/networking/dsa/dsa.txt


I am truly at a loss here.  That DSA document states:

      Master network devices are regular, unmodified Linux
      network device drivers for the CPU/management Ethernet
      interface.

What modification do you suggest I make?


> 
> Getting back to my original point, having these platform devices can
> cause issues for DSA. Freescale FMAN has a similar architecture, and
> it took a while to restructure it to make DSA work.
> 
> https://www.spinics.net/lists/netdev/msg459394.html
> 
> 	Andrew
> 
