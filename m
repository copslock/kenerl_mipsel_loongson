Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 09:53:00 +0100 (CET)
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:2272
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994559AbeAPIwyW8AY0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Jan 2018 09:52:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ENdlRBpTNjWGnYkBBq7jfCK3ihI1wBgWboTXm2Bf/yM=;
 b=5F36gZrUJwyanRG6C+m++49ngQJRwbkE7EiVxPLx7Iw4t5ivc/uajteyO9AhcohpvbCehcc8OyXP8WC1Khe24ny8wxtbOBXp1MGHGbEkEStQgM9ggG3vF0fzz6GXgJVrHVukA8DeUjSeoNuQ5Dx/epxdQnO9m/u0/lyFp1pFMAU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
 (2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88) by
 MWHPR12MB1309.namprd12.prod.outlook.com (10.169.205.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.407.7; Tue, 16 Jan 2018 08:52:39 +0000
Subject: Re: consolidate swiotlb dma_map implementations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
        linux-ia64@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180116075338.GB12693@infradead.org>
 <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
 <20180116082827.GA9211@lst.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <485e6f8b-ef22-0792-1acc-3fefe203040c@amd.com>
Date:   Tue, 16 Jan 2018 09:52:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180116082827.GA9211@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: VI1PR0501CA0002.eurprd05.prod.outlook.com (10.172.9.140) To
 MWHPR12MB1309.namprd12.prod.outlook.com (10.169.205.21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2144c40-ff5e-47dd-cdc4-08d55cbe81a3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1309;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;3:72andxCZ0zVWPO3/NLSfVVJq8Fxh2rBKlYZHIoYFVp8F6TWfQw063cB98KRXpOO13j9fiR4Q914A96hE6qqud6ewIphFWBpOgLEBhZ/Bigz16fPTpygMbZENm8JzZLlHenGGowxvnORSOjcwQRYaZPBtK25DgfDnS2DI8xRGKFapw57BfaBsAQ5Rnscrs17xFNHFyfBF63wvw9iyCWqCa5VbWYkJkD/MJVLu5fWZqnzZcvsbQTPjqAgRoz3wIifa;25:2X6aqcjfP4xvbjOwNOpX6C7j/xIDkqz1E2U5rpxsPLEz8dfAX7afDJLnJRV6xT9sYFwcD9jmZKDBNQuEnLzfeyk0f5ZpNTWGqe5+E5fYGxd7WBde8AhKW1FGpjsqBgQ9/KiDqpP0xNU0dpcrzMEoLcxB+ZwARMpJ9Cz1wXyINFI7cbcfelwqMUqp8z8qRrMNzAhpP4Iwd6+ts3xqXheZE9osPKBmDrz8aN/LuwHBSmz7Ce1J4D/qXztWV3rUhPAzVHBNrKQfn6RISqYxRkeKTouCVXCwIIAdqqDAJwakXgJdngIwWk9mqoUlu6PTDBOUUzWrh/s3dY3sMBDUT8GZVw==;31:bH+az7uO1mAlnXBcuakM2+aGhHiWkNNNT9HVF1XbF0UgLzsWNYX9XT3k6BbRQoLFuWEmlr+SxWAEkTF8AaW3sleHRjG0irEhCijX9fMUudYFX8psDsMaNLiCRtARnJ8yyXcudgVba4qPPFgZKEsgKMUFAX6/CgzaF8uTs+3PPe1KGMdMHwQeP+c3pnAWl9GTj9FVp7Cyk2ySjBg2b7nQVII9L+Ey8XMgdSihChMLzx0=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;20:S1gBbvzaqxsfdmUoDBJJ+aCMT5+fCQGcQNwyyUJOWbbKvHfYOGSAZyfNs7+edtCN9P5zlXFfz3DdC6R+OJSSe7+Dc1YcvM9ek9zm7L2e6x14JVFduObojeoY037nm4gBMRpiMLbpnlljbZMMZ+Wc+XTQkXCpYeq4QSeeAX+kywdjZ0B5aKiQ4so2oeKAtJFrG0moHWYMqs+UfFaA3hXaiz7UVhYT8oRJuVq0mbbl6vInlL0Jq6KDixnfaOSUFc2ZIsrKquZADHT31gMwpPI0K0A73uAOyefW3Bgkt38olI+4LzBJj7j0vcocmmoXmhejBB/WcPN7jSXwLKpXibpqvFhrqACuonJtFebtJV4SI/SQxrI9Td4ufkQnekpilVpGA2GgatmKt+OQI4eHHxnqpcrZAPAhVj1NAk9RD9D4bK5SXEqPZhLJa6Hx/EEriudhOz4Y8ujteT/CPOd+JVqlSunpLbe3ZKw3cxZxAJtsS6eL979p1hS8r3efr+T8zkcm;4:GEvvvZkknNytkLwnJHxMmp4BBtc7BT/QynRGF0fo5GC0oUDpYn91uZsTIzzj/zzHS+FFInxaPwUYkK1mBQ//megl0y5wp+SHqYIbs7tco9ejZ+1o97eb3pD4L1c5swTTarhWY1ouSH9uCLjRgodHJ0m2tEwfCPmRYpLVJjuvxpaJfDhZJsUmvtD52fD4IiJ3IdSLID7/Ic8OecRpwCXMju24zpDOUpTVXaIB8GKWvI9be38Qa4YtA0vubgCyeHbhQ7sS2/Yi095ZGl5hexfnjQ==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1309155D7F5085679617DA8F83EA0@MWHPR12MB1309.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(3231023)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041268)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR12MB1309;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR12MB1309;
X-Forefront-PRVS: 0554B1F54F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(24454002)(6916009)(2950100002)(6666003)(4326008)(25786009)(316002)(58126008)(54906003)(65806001)(93886005)(7736002)(305945005)(76176011)(52116002)(6486002)(23676004)(52146003)(52396003)(5660300001)(83506002)(2486003)(65956001)(31696002)(36756003)(6246003)(86362001)(67846002)(47776003)(31686004)(6116002)(50466002)(53936002)(72206003)(1706002)(64126003)(229853002)(68736007)(106356001)(105586002)(97736004)(386003)(59450400001)(65826007)(81166006)(8936002)(81156014)(2906002)(2870700001)(7416002)(8676002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1309;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzA5OzIzOkY3aFJ2Rmxwc2h2Zy9pWjM1VWk3Z2ZNd0l5?=
 =?utf-8?B?S2RwTVZSK2haYTdDYStiVi9XRVEyMmgzWHRLSVJZSzBoUE0yLzNiTDY3K1E4?=
 =?utf-8?B?VU9QdFpubFo3Z3FTei9aWDl2ZWk3S2FJSFAyczlORnJ6d2NqMm1qNmV4L0VX?=
 =?utf-8?B?bEFzakZVUW11OTZCd0N6Zld5WmxUUGZQU05QcUJQSElyUUxycHJNYkRZS3VK?=
 =?utf-8?B?dFYvY2Vqb3ZZRVNHZUVMK0JlUmliOUVHZ2NVRjlFZEZ2RW9NVmp5bThlcmk4?=
 =?utf-8?B?anNUWEN4RUwxdVB6N2l4cGVjVzhlZlZwZnBlNHNjcXdmRHdSV0czTXJDQTg3?=
 =?utf-8?B?eEdJbXdVZHNzWWNsRVhHTmZabm5MZ0JESElQMWFIaTlDMjlKZTdUNk5UczJG?=
 =?utf-8?B?MEhoMjZvdENwZ3pNQkxqVGlCOGgzVTVQNHN6QmRHZEJUWHF5MzVEYUtHS3FY?=
 =?utf-8?B?N1dlK3IxM3p6YWo1ZjBJdlFNZjdZeUx3ODZDZGthVkZtMkNBNHpYUS85bkxv?=
 =?utf-8?B?c2I5N2RuSEkzbkJlR2x5WWNiL05HNGkxV0dnRWdXdGpUenBBb2ZYTWp0eXl1?=
 =?utf-8?B?OWx1WWVyWGxmVnhrOWNya0JpRlhwNTRmWmtjNld5WjlUK0VIdlJvSnBTMi9l?=
 =?utf-8?B?a0tIRzVqdzRuSzdFalBOZmZzK0JMMXRJOVVQN1FCOGhqQ3NtSG50dlgzMnhU?=
 =?utf-8?B?MkRRNFNicUJSdGtoUnNIOCt4dXFLbkRIbERNMnpKeTFVNXBsZEhobVF1THkz?=
 =?utf-8?B?NkdRRXhaaks2Q1hsRU1DZWRjK3ZoSENJb0tOdC8wZDhkMzlCM3FLNlpueE1C?=
 =?utf-8?B?dkN2WU1adGVLLzFuVGUwaFNaNFZrUkl0U3QwUlowUWtuZHhWR2N2cU1VOEZl?=
 =?utf-8?B?dGZDOGtUSlkwL0swcVROQlV5V0IzSytSQVl2SjRtZVg4eFVyTG5kTHJzZE1a?=
 =?utf-8?B?SlpuREowWG5seTdLL0c2MkN4OFJZaVlwRytFcFNnMEt4aDhEczliWU5RMUZp?=
 =?utf-8?B?N0dJOUkvblB3MTNqSkUwZThOVXl2QjdYaGIvYU1JelZsTG5KWnBQaFA5Vng4?=
 =?utf-8?B?eVZDajVlclpMWU5DQWpWbVdlUGErV29Nb0c1a2QvZU5YRC9MWHNuSHMxbktP?=
 =?utf-8?B?MFB3VmNFYS9UUExEazU4TEt3V0JDNDZBc24zTE9xRGpQUVJ5TDNsSDBBV2pN?=
 =?utf-8?B?aE10TjdXN0RWb1hQSWU2dU9RMGJZY0RVK1dVVTNwR2h1ZzNTV3ZWaDhnM282?=
 =?utf-8?B?TE5NMGxaWFlRYU5QNE53NHowYXNlcFFPbjFMQmZwS3ExN2M1cEtpRjJiaDhJ?=
 =?utf-8?B?RlpRdXBCVnpBQVd3TjQ5Q0FMRTlmUEFPUGtjQTNuR1dJZkh5WklQOTJUTmc1?=
 =?utf-8?B?TmZsazhrazQrU3ZRS21aclZCbEZHc05wVW1JeUVMMG9LRDQzTUVrblp6dm5t?=
 =?utf-8?B?YVlUWHk1Mk5DM1R2ajAxeGthQWgrbE56ejRyam5yZVBpZ3hLNWIzcy9GWm1S?=
 =?utf-8?B?Z3lGaGxaTU03THNJZGZreExmbzRtV3lmOHg0Tm5ZL1BkcDh1ekVjTk81bFdR?=
 =?utf-8?B?SncwaGlLNnNzT0txSDVrYjlwTmVERXl4Y1hFZTVnL21OTnV1ZzJzUk5wMEVp?=
 =?utf-8?B?Qy84aG9LcHNUS2cxOVRmOFYrT1dOamNRa2xzbWUzaVd6alp4SEx6R3dtWldN?=
 =?utf-8?B?RzN4WUgwdlFVc2tQV2J1cmVNOGFBelFhZ0RXSXowMFMwRkkvYXd0ZnlpVnBv?=
 =?utf-8?B?QW9TU0ZzYWQ3U3U5UW5UU3BscmZ6cFNiQ0NwcXI2UFF1STNVN2h2K3VFdnhP?=
 =?utf-8?B?WlVJVmtiUmx1bkpZcGlaanlaN0xXQUtYdGRzcHNFbDVvZy9wS0FBWDRDbjFk?=
 =?utf-8?Q?ht3IB3mNUIE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;6:wdPsOfex3Uj21e9Zm24YtD8lHAqwV7/R9C82ffSrGqB69cZMc1ag6sG0YqEhZQ1ibSiZdeeHPiq3VbxB3JcjAXAdZmICCjLAKvsRKIoDzd4tncu+L+XsvVCQiAmTBgJsWbFtOX65rZxRtMixgbxBrEpwlWcGG/xyuRVhDq5ZPxboEvLSjtGm/Wy1TdD20XCXgYjWAkvqCSEQ2mdUom+l5zOvBcKN2bI+Uh9RNxJ2pa6gWTa+8bfPUT1Qgqg4LzyIaAcanzDIt0ZhuPBQPS6OfyiNj8tef+q7sDLPtP+O9K80B+0BzdX4HCKO9AIIlqbCOOgYaSs3btwJJsziO9xPzgdjdEnWSRKTGU4Gq3VUYpk=;5:uIP4IFHVwWiOSkf1frnR3kwtrJB8QPk/PjhxcWAADW1AjwbsVEJw3gAgYo/yKnb1GfZrTINHy1LlvaJULKSLtE9DUIKG4aVi4wPg4oNimw+iRXi5Ft+6P3qpl1/A201nVF6YiE0MooWY90gAxmBwJrrzd45n3EO4YHhC9iAylls=;24:C1tyvoMWvBjxTSql+OxQhMKxPCXt1rlcZo8jsbkQHjfgAHeYJGSe+2df/JjXoOp6pkULJUXIwd4OkgnjVxZPTNV3dt9dPOADI+eRAdSuC0A=;7:NX1SBMEKP4OghjUf9QMnQWLLQqWvagYlhPE2As1EKQkXQB96HaEL4lOk1vixuV1IkYskN0PxciJU0QPbuj1s6J8wtRoDtCh75TM2wpnOSTHZ6rZdSBtOYLWjZMEdfmse+QaJ3xVPf3iZn/PDpmTMwOClvXLCYXQYt7Z8WnI2PQ8w785rjQ9JlHeAtEd146NQc0HPzU58VeRn/Tv1b1AKkAvRROqrLHs32vYBigWSscsfkHzN1zCtkWnGbb83HVRj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;20:PEjn/nGQ5+I0E0/2owZz2TwCS9FI2QFnDe6IkCj1B6fIH+kwdUh4OCJFzzr+/AymF4bAF8Fv8WIrhhXcopF6UwxjTxoSZeUQ5xZQ9S/yx+6aWmu+lBPdbUoXIEjUtPsCKzZR5fYkEZ9NhF1OROrpZiZ+mHIEMoyuePdjvgdk6SGn4xQ4Uo/SnFjqxezi2O7/gUB9SSkpdv2NmQTEDQaBI7+G6F8COLza9P250EsK9eQGV//3+KsUlLZMbzBbXiFs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2018 08:52:39.9142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2144c40-ff5e-47dd-cdc4-08d55cbe81a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
Return-Path: <Christian.Koenig@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christian.koenig@amd.com
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

Am 16.01.2018 um 09:28 schrieb Christoph Hellwig:
> On Tue, Jan 16, 2018 at 09:22:52AM +0100, Christian König wrote:
>> Hi Konrad,
>>
>> can you send the first patch to Linus for inclusion in 4.15 if you haven't
>> already done so?
> It's in the 4.16 queue with a cc to stable.  I guess we're ok with
> a duplicate commit if we have to.

Yeah, while it's only a false positive warning it would be really nice 
to have in 4.15.

It affects all drivers using TTM in the system and not just the two I'm 
the maintainer of.

Regards,
Christian.
