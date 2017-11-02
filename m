Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 16:56:01 +0100 (CET)
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:61848
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993373AbdKBPzuDjs0t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 16:55:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BK/LFZBs3gmGskjR4lv5TiU75DKo9CIPrPFqP0rUT8Q=;
 b=Xwha/gL+uHpQUwroF45v0M5NdaBNbQ0Kj9PmOp+gb8Wv9My2sP13gCTlC9+XbqNpbG0ny5wZEAdtyRDdDW0beaYwZuFePsmfckElltfG5JqFMeUP+/TP20beCfnOJqfeFjKJqzldY6QJCK9zbpqkXc7D1+5CF3ei4VIef5N4d2k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.197.13; Thu, 2 Nov 2017 15:55:36 +0000
Subject: Re: [PATCH 6/7] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
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
 <20171102003606.19913-7-david.daney@cavium.com>
 <20171102124339.GF4772@lunn.ch>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <521d6b21-b7f0-66e0-4b49-cf95d83452d1@caviumnetworks.com>
Date:   Thu, 2 Nov 2017 08:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102124339.GF4772@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0032.namprd07.prod.outlook.com (10.168.109.18) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f0c69eb-743c-4296-1dc8-08d5220a2937
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:57dMwCarFDCVlQ3/GA9hvwZxeCBDrhAWL5jVGYoCiJxA5f/e+r7ljgI3zvhl2RTr9Man7gTA87TLZOoim2m1ATVb4USVtr6fd9vU/7daRnYTyhu62rGmvjzoANQosbUFN6mrkz7Xpk1QfOaE+gAFr7yNWS/2ODkcZHQgJPEk2RjoqSbNGX30cDaFl8kI4M29K4opnGFobhCU477Q0gG8TsUoBOpoFIdNBnLdWzRjnhAysFQX/luvZy5HpIZzpFh0;25:lyYMg0DkU8/kcKTcmTgOO+Z7367ZLFWmuj8sN/7B3fo5+dC5LIE1BLsceBrtMY7Gk8lXdNBsNRwKU3izLgdH3ehpxwaqKYppYlLy9oRubMKrNyCVv/OiFLt9cBhSr40TLmdCNi2ktFZoA5W8jvfDEEihHA/a+WtBBi07UQwY5kZVQozOHrZuxk5IQpNUPCLciEAZZrfNOtHuU4gAdhP1oMlrklSY+B0nqIRF26qUky8UEMqwfdQqEQ4wF7XgoB7k/KJSqju6XkF69HAkl07srsbR6wbMCRQ0B2eJ8nKm6tzgs00g/GL+P3Qd9ycTAg7RQ0sJQmi5kcJJU8SGGI7ySA==;31:/0u2uSqej1cVho0fWpHWx5FkYmxxGRxpX5gqxkvwy5VSyx8xzl/FdOJ29A5XJRqFiigFayHs215Hbn/cNrJ3Y6JK9CHWieRw2W3rQ92oeL+S6Ll4a6OSgkKj4PZfggfjx7CBImICzVb6JhVCzNK9oG+oJd8WD1JQlCaZgvBVsqrlwbcuZvJ0mWRjUmi39wL81By2GjIxnbP7s+HgmdWijEd+WECrQ3bVErpIk25UuGQ=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:y4DZ9XutLUbNInSHLI6YxpZQUuw10bzC4VtLZ1N0a7VGJjGhjOmtBU86mgHVhxaqZyamcY6lBmkK6tUV6Nv1IIX+9ej7jTBZLgoUr11F4lodxVwG1mB7oAv03k1fEEF2uGqXGTcc2uGsD9wMEdgSpNiIzxOm4k0wN1mgcv+PA0r6TMUFJ9JhRVoS73KDS5xdb0BR9lUiX33wh4luYVLpCSKr/OdnAfDKMPvMuUmc3X2xIpTJG+a40oOmJAJTGhkHJdWi/04s/WI0dnRd8RBxKmHgMQoq2HqWlz8IkhMrxW+lRuM5Wc/IvQthnuCsgHvUgImUG7c4gtAsQ5mSvduCaoRfO5gd9OwVY4bkCP5S8emt495HwwWK/uanlFyOkhcGAfkCA/CTfJ4quEIusm04ZotPYXyGGdjGr3SY1ms1earaCwh023CqHS/qn67H3T4x/t0aCxq0N4akANoieucLA5Bpbhr+s1BkC/mUEXAoPxmmpkfwfPJ1eVJM6jOY9Wauh+Mxa1qo08Ohd8ITQ84REIpWd+A/47FVEc5RWr5n4/ka9MhZ11e8N4pdfL7i3AHjL0W7RzJIxzKQnq+RsDf+rS6CnnCoLxNh5rka3nGCfQE=;4:UXoHjjZfdqkz5eF/efHLxdEBbZ3CWcPYK7R/PQVjRKX/DYt8SVeu5kZ04qLR8jx0T014P6LY/5xCYY1mEK/WJZchV/6iGtBUsaIFAC8JXj6RgjHTGkOe5jzA8kr9Uj5Pt4fMV7gtnNubcxlGsqcAq5z++FO65WiPcW5QY2wMdbx9IgWQf4NIXwnjhHyMpvw0gMk7c/9MpTE2zOmPUg739AS6+qf/5EV+IRT+KOjN9IALhigOOBC+A8rMLSozHypxLM4kzNoNr7K6TI/cOBuRuffJDHvcqD9U6phPHdfQdoV/KHxEgWYtP1Ixl6JVqsN1
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Microsoft-Antispam-PRVS: <MWHPR07MB350355A945E79C6C3DD5961D975C0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3231020)(10201501046)(93006095)(3002001)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(24454002)(189002)(199003)(3846002)(7736002)(36756003)(230700001)(65826007)(6116002)(76176999)(478600001)(54356999)(50986999)(53416004)(305945005)(47776003)(54906003)(72206003)(110136005)(5660300001)(65956001)(65806001)(6486002)(8936002)(66066001)(6506006)(42882006)(6666003)(2950100002)(58126008)(316002)(229853002)(7416002)(106356001)(189998001)(97736004)(83506002)(67846002)(23676003)(6246003)(33646002)(64126003)(53936002)(107886003)(53546010)(101416001)(50466002)(105586002)(81156014)(2906002)(6512007)(81166006)(8676002)(31696002)(31686004)(4326008)(16526018)(68736007)(25786009)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAzOzIzOnVSRWcxa3UvTmlmQzVlRzdSUzlXbTRjVkRi?=
 =?utf-8?B?SkNkZENQcHNHVGhNQlBuTzNKcUt5clRxMEJQWmxsSFpFaUNoV25PYzdMYi9T?=
 =?utf-8?B?VUZCeTFweGVPK3VCdVErN1hGTjgzSWcrV3duVWo4dVhOL29NZUdNZFl5N2JS?=
 =?utf-8?B?ZUM5SUR3QkVyTmljZ09lRFhtTC9MT3BCRDlYKzE1U2FzN0RDalErU1FFZlRv?=
 =?utf-8?B?dWE3TWR1RkpzQkpTdFN3U0VuVTY4ZTJiL1Bvcnk1eWV2anRpMDFmTFJIN1Fn?=
 =?utf-8?B?ejZDcWN4RTZYQkdZVEt2Y29LRHI5RGlzMHlvQnpaNDUyd2VZZEZ6c0ZHMnEr?=
 =?utf-8?B?YThVZ3pTdFhtUCtzNDNYMlNNUTJNUDc0ck5ZSDE5dHVPV0QzcEdXdW1CS0Vz?=
 =?utf-8?B?TEEwdHcrcU82cmZLMDhVWmRMdXZnSTNKT1FxM3BuMFlVLy9JaXFxZlRMM1Bz?=
 =?utf-8?B?engwZGNQYXAwZnZMT2I0OVR5TWVOd1ZTT1hSUWhBQ0VrQmdlZFJmd0hnTjBk?=
 =?utf-8?B?WkFtbTFlVU04dTVtaHB4Qm5HdzhGYU1mTkFMZ3ZZbXRlUU50N0R6WFBpcVhU?=
 =?utf-8?B?WGg2bytGK3o1S0tXd0hteW5HbGpVNW1paU84Vy9yeHI5K0R5dVYzUVpnMGFJ?=
 =?utf-8?B?ank4MTZwUllxZG5PVzkvTEU3bk42WUFEQ2xlNitHUVZ0UkFRVjNoaTlOdk1n?=
 =?utf-8?B?WnJIRHZFMWlyaVRXTnVWbFUwM3JvNHcrYzRlMm9ya09hMERJc3ZQUGVybWp4?=
 =?utf-8?B?b1NxQjJUY3dPdXFZT3htSTd2K0FtR092TmROaGlmb0JrTVdnUkJBOFk2aFhl?=
 =?utf-8?B?aXMvTFg0T2trNUY1U1hBMTBmcW5MQm92U3NpNmMvRy9JQTNJVkZhOXRHZjJu?=
 =?utf-8?B?NFYxbVAwZGV6RzlqREtjQk5uK1U5amJ3TVJJdVB1VmtzME11TllIR0NZeDRW?=
 =?utf-8?B?ei9WT0VoUUNQQ2FYZURuSXppa3FnSzNmSlczZTUyR1BxTmxrTUNKNW0ybHYy?=
 =?utf-8?B?ZFYvaFdERHFGK3hzMnZQNmk5V1UvWnlROTJVN0ZPcWxEdko0SUQ5WVFRK3ln?=
 =?utf-8?B?ZHBPamhuTHBEaDZ4bFo2VWsrVFZQSDUwZmp6bndCL2lSOGpZRWhrT00wTXZo?=
 =?utf-8?B?a0p4dHl6NTVmVU1tYTBha0FNSmx3T2M5SjA0ejR4ekFka1JadExYVE9ObXg3?=
 =?utf-8?B?a2drbXNqN1FvMjRJc0gyLzNodjBXTEdyRlp5aUpacVN2VTJRaUY2OWdpWFkr?=
 =?utf-8?B?ekUvbjBtUTUyeWlyaHRxUWhWa2ovK2tNMmxUYnMxeVFROUxzdEdKQjlNaXZo?=
 =?utf-8?B?czNVemp0ZDdWRTE4QnlHYWZMSkNJWk5LdGo1SVRZeUhrS1gxbkVRUEo2aUgx?=
 =?utf-8?B?bktFdEV1bHhMR2ZHd09WVEI3bzJsZkdhd3VZNytxb1Z1NnZsbkp3Tm1oSmVw?=
 =?utf-8?B?ZzhCZHNaWllxWlJNdytoZm85dUl6a0lQZXc0VGROSytWSTUyZ3QwbWhzcXFn?=
 =?utf-8?B?K1ZxZVBZMithYnV5a1hlVTNUbE1Qb3VqTlBQVzQycldiQzlvZXZuU2lrcG9W?=
 =?utf-8?B?MFdzYUMvK0xXWmtnMFBtdTRXd2daQjBqNDRrNXluNVBaMDUzSU9jL2xMMGV2?=
 =?utf-8?B?MFN3ZStsV3NHNnZQTitZVkpPYUF4Y2FwRExQYkRkbkpQVTd2ZjYzcDhsZkp2?=
 =?utf-8?B?TTlQMmZrZlFGeDBmNUxyZXliNWp1Y3praGRQaSt3UUd5UElVSVN3M2l6eHdU?=
 =?utf-8?B?V1BKaEpHand0TDdRMnlqajFEci8zK1R1L0lPZGt5N2pLR2lSU29Ib082SzVK?=
 =?utf-8?B?TFB4Yis0anJJcWVxTEdPeEZWYTBSWElnaVBGNXZ5UGRHd2I0ZTdFRXdLOVBo?=
 =?utf-8?B?bDdqY1F3N2ozVHJiUDI0N0FLaVlrMW5nZUtNOVJyLzJ5dkxLdkxDNkpnbGp0?=
 =?utf-8?Q?a3EuT0OZU1KhxCo1imWcd1B0UxvHcA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:zac3yv5YUsqz4TWTmfTP3P/E6ksFmMwsknbvmLcZx71HN3P0tQ8Dt8NbYTRjvUahRxS+iOXQ9kGr0jQEebnxhv9XVZwnVK/ZTMnw4UW+pp/oNFxUn4VZ7g34D46HCqqqm73IAzr5TFhgJk+27geBV2aU7RSe5WnfD9/hb3UG1l7oErcQh2GISj3STi6jE5T56zr19QDJLZblYBcJcHY23NTgzgYxftVgwFsCZumpgpB4nw2ymwzJrwB4KOg9wYFGCH3f4xb7CQ4jdJfet4siFSC5NOfmkE+J5vtf7POT5e/CEbJ+64SU1vGbIGlhMytr40L0c68yXCuTtg7K1gMFG0g3IHq1ZfusEMTanAa9ol8=;5:nfvw1XlgvjUHbANytFiaNwq5jJaWNWPdGPiASqlk7HFy9klw4G8oIYlDlsU1Kf480b6NUP3IG47WBTaRv2va01k86VAViV+JNm1kV613chIuSqV8h/EZq4K4uLzUKyJyoRN0pkweV2CixuYcpoeKRHZi093Nv4lmxkEMzQfW0O4=;24:9CbMwccGbRzYKYM87L3gcS3Ew2Bgrtx/DfYIOf9mmHfF90aOz2VHDWE09EMpkTABwfr+Y4qIkQ35vSYWh1tcdfmDmUlk8QXonMIIigg/VeM=;7:VYvE5s6hsRBmY7zbGjjtB2CGl16hNKeGMyhWnNJ92Hh8UWqOons705brKx5mhrOOwxI298Va9jCtpvgDwVIyraWOnTAjBTnOJPNxu4ajamDGD/Cu2f2l75Gu0Eh03EZ44RpOj1NW4JoU18tQ5su1xPTIvvdWt355Crj3xZCPWUoS6GbMhtr1e9xEqbe/mUgRKA6G4747GLo/Cat/Jc2whVTGgwtXkja/AJ3zFccTetlHKd54Ss8JeXTCc65bEgVP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 15:55:36.6788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0c69eb-743c-4296-1dc8-08d5220a2937
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60678
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

On 11/02/2017 05:43 AM, Andrew Lunn wrote:
[...]
>> +
>> +		i = atomic_inc_return(&pki_id);
>> +		pki_dev = platform_device_register_data(&new_dev->dev,
>> +							is_mix ? "octeon_mgmt" : "ethernet-mac-pki",
>> +							i, &platform_data, sizeof(platform_data));
>> +		dev_info(&pdev->dev, "Created %s %u: %p\n",
>> +			 is_mix ? "MIX" : "PKI", pki_dev->id, pki_dev);
> 
> Is there any change of these ethernet ports being used to connect to
> an Ethernet switch. We have had issues in the past with these sort of
> platform devices combined with DSA.
> 

There are only two possibilities.  The BGX MACs have a multiplexer that 
allows them to be connected to either the "octeon_mgmt" MIX packet 
processor, or to the "ethernet-mac-pki" PKI/PKO packet processor.  The 
SoCs supported by these drivers do not contain any hardware that would 
be considered an "Ethernet switch".

I'm not sure I fully understand what your question is though, so I may 
not have answered it.

David Daney
