Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2017 16:16:53 +0200 (CEST)
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:6123
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993960AbdH3OQmK6dSE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Aug 2017 16:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8Pp80Yj7E8ek2wUZrugiXk6XMJmJF0ZJ/F7glZk+jTE=;
 b=IG0wWAErNhEjQ3LIEeC4D60kgnO0J78YJJhnfMIG+NEYRMjNfZ7QgzpsTFtALTce/qukXoaWClKzcv0OC4VvXEiQMu7iwd5p0C/VYqzlcdYnBr6O7LyyYBWr9wPOUVlcFQZBAjgR1YvBB1r6MEe5ose7r+CLcmTwLDx3Gz/kNKY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.18.42.219) by
 CY4PR0701MB3793.namprd07.prod.outlook.com (2603:10b6:910:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Wed, 30
 Aug 2017 14:16:32 +0000
Subject: Re: [PATCH 2/8] watchdog: octeon-wdt: Remove old boot vector code.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
 <1504021238-3184-3-git-send-email-steven.hill@cavium.com>
 <20170830043309.GA14791@roeck-us.net>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <804f51c2-55b1-49df-125b-ec47ec5e27ee@cavium.com>
Date:   Wed, 30 Aug 2017 09:16:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170830043309.GA14791@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: DM5PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:3:d4::11) To CY4PR0701MB3793.namprd07.prod.outlook.com
 (2603:10b6:910:94::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b6776c6-b8db-43ff-2b25-08d4efb1b72a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR0701MB3793;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3793;3:LJ+nmvgyXxT1hTj0q+i4DCPrn9UX0dLlSx0Hu4mxn+dLunv0AWXYqIbupbaeWa7X510xmQwgfgcIlVR1C0/AzbVBKV3fS3VFYmBOzGd//CQA2zGx6E7DVwqdPbfk6VJM3Sx6Q0wyowgi8yXLqtYcSPtVVu84v5n5uluGNzGUOHR0Gc7J/mkRwdP/p/FCE8wGpXYyVP+g8ZGxuvdJWJxfNSOT0anzgyEJF7NX54pMCGcRPzpbgXUBDzJJfx+3YvEl;25:df9vpIZ9VFHm2iJhuMDYsbZ/4//uCtlHLaVhszWcd2pHM481iklkCCRUbHtG+oVJSJcm60Gzt5wbs+ocA6bWXLai8RtQyRwKS/Ji81iblGOfQex6iGct04325h3nOS4Qc9prEyTCHgtwG76eoDj7SXFhHeQw8BQIA3/JhlZ1DGFf0JR6cGtCGHdcHMBuJKPB2HI0nvSwhOXsLrS77MEzRwALlKNkaOrMcuD/o27hwu9oY3m80rcgXphDzUNKCVZMr6E7vdtFpvgduSwnNkVC8o58zlHvpSU5C6x297fZtKPmDfGfpsPSY8c5UGiUwRgL3O8C6REeNimfQWxr5y5fmQ==;31:skwkrlkFuwMJGUJBu7q26BpC+UbNgvhaCgbq5PeM7+dHtqglJ9+HUur7VQkd+PRLkNQcoK9KB71g1xIkQNKowdoflxm7UlTYJOFxYNu+pyNPyTNdL5tFsCRXx3J97QoDyEOpBf63x59p5yqdrcHwhEBLsdRGJkG4VhHuDzM+bfflmAjO9jjDuIGrug4y2d/NelW5nENDlR7S7ye+mwZ1+0Yzlwlu46yJ77ZQAE6tXdU=
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3793:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3793;20:cWD8VCxIsH5DS6z81CrGz3T5aJqtuD4Z1eBgnFXv0Pk8i/i4uQ1bZi0eOmgVvPFH/AQITvIdHyxw5LZb0xtMyHb9HKr+dupHOCL9kpj6TMJ/Vfrk5SpxYXacg4HZDUEsP99z0dqie3/F2z64ZscSkqoayukgZFDnT2/cafiPWIHo5+opjfZnpNG1SlHHSEmYd07+46Ns9jaY8xJg2lWW8RkUrAGtBlRRkpS84HJPHTPst/P7jYW/h60FVDpfxnLf2dfN3FlC1I/JQWSa6B7XFyGa/QVH9WjQjnAZAlBrI1u8ZhAQ3V6hoSaK7su27Obz2g6TrpHDW/uyGr++P31GQrjlp9smTtgwnwhAhvc0m97evfPYe1S3zUgEzsdxNcu9jtEmCnWjSZxFOvaEBEwnDIEgtnVR/qURYsCHipeYa0HvZijpQ3sGkW61+gfRJfqH3YVLOZx/uxowxOIQi6B7D9eJtTI9frnZmFvlm7ySdggowyUuTZ+lJukmBFecWi04;4:TLKmILpvo8W8mIf2K7SZMOhPc120jGYXo4GZg4wniHrwDPnSykN4l3e7wnoAAVqeQtLej2+mqMTGkLFAEEaNlzfWS/gb1wIYIzoVchLi+I/baCwUIH7mNhsjfqp3BHlMOVmrp9yKNUNnc/Fp0BsCKCikGu7Czbf7HdvWfUi9p7otR/VBnjcqlIY7M1ldBtqVfr1lurNcoyEG4wkIgjEvGxkCTbNM5fgLTOKCRkZHKjDfxTZMx/IptJo+boXtYm2r
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR0701MB379301BE7733B57456E15D06809C0@CY4PR0701MB3793.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(10201501046)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(20161123558100)(20161123564025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR0701MB3793;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR0701MB3793;
X-Forefront-PRVS: 041517DFAB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(6049001)(377454003)(24454002)(189002)(199003)(478600001)(229853002)(305945005)(86362001)(105586002)(47776003)(42186005)(106356001)(31696002)(65956001)(66066001)(3846002)(7736002)(6116002)(36756003)(65806001)(54356999)(8676002)(81156014)(72206003)(81166006)(8936002)(50986999)(101416001)(76176999)(33646002)(23676002)(53546010)(230700001)(77096006)(6486002)(2906002)(4001350100001)(68736007)(50466002)(31686004)(64126003)(6246003)(53936002)(189998001)(110136004)(97736004)(4326008)(25786009)(65826007)(5660300001)(83506001)(6666003)(2950100002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0701MB3793;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3MDFNQjM3OTM7MjM6am45UU5IZzJjenZoMGV2NUlRd2Zac2pz?=
 =?utf-8?B?VVdPZjFvQ1E5UVp6WWxWMTFhY0g5aXdOSkV6QWJJNDZDQ0xxZ2g5dHBwUTBU?=
 =?utf-8?B?QVhlUWtMRUpBVHp5UE9PU1lGUncxNEZDbWE3TnIvUUh1N0NtRjFSQVdiaFlB?=
 =?utf-8?B?bjh3U1F1aGJTbGtUL0czTHk2bmlzSjdzQTcwSGkzRHpmNk5SdEszZ1BoRHRY?=
 =?utf-8?B?ODZHUWFxczEvMEoyMUZnNWZhN2NZZXJ6aE8ySWhZclZLUEZ5bzlBcDMwVU93?=
 =?utf-8?B?cURRUHczRTA0RUJOc3hYalV2eGxmeDFiaVcwazV6K216aXFNSU5WNVIvM2RO?=
 =?utf-8?B?SlQvaUtZSFBiZThCREFadzBQNDc2N05xdkRVV1YyU2RJaVVoZHFvY3AyOUxm?=
 =?utf-8?B?RE03SDNzZ0tJUFRuaXpDOUp3WFJoQ1dUdGYxUG5HNFBlaDZpc3BBNkpDMzhj?=
 =?utf-8?B?bTZKbmhmWmsvUHJGNmV1RzBYY3JuZ3hyVHY4ZHF5RXNOWVJRMU5vSW5VOGdD?=
 =?utf-8?B?ME1heXQ4bHYrc1VpTWhGQndjajRBZEo0Q3ZvNUYyR1ZRN1NUbnZoMmt3Sm5j?=
 =?utf-8?B?ek9RaERUUlF3eWUyN3pUMmtFZWowRW5pREM1UVNYZXJ6c0YrblVZNm92akU3?=
 =?utf-8?B?NWRFQ0V6aXFMZWp6bmxPWjk1dU9MWlZZVzhBcUlhb2o5Nllqb011SHB2SWZT?=
 =?utf-8?B?bUpXeVRPZ05DKzkxdVY0RFRuRHNuY1F2UFJXMm9aZnFiaEdkbTRObUlFSFg5?=
 =?utf-8?B?NndMMzBiSngwQmRpMzU4V05YYkpyZklsMXRlSGY2Wjc0SVVaTUMydnY5YjlQ?=
 =?utf-8?B?Zmw1c0VFR25oUmRKZlVPanlQMnFSbzUwZkZ4a29SM1BlL280VTR5eitaWjMv?=
 =?utf-8?B?YkduQ1ZuUjd4bGNrQ2h2VC9MMUtqYjRWTkdzRjJBS0Zsc2NzMzgyaHV4eko2?=
 =?utf-8?B?c2NHczNDcW9aSmJubW9DcFFVRXd1WjBUWEdmeUdyaE1UMHU0enBPbzEvbUVW?=
 =?utf-8?B?Y3oyaHFNZVByTXl6NjZQT0kwdFljQVVnQ3JzS3IreHl6WVN0L2xPUmk1NkVz?=
 =?utf-8?B?OVBCdVdHY3IzMmlweThPQ1hEcUZXOUVzWjAzTlJpMVZoS29FcXg4THhYVVVv?=
 =?utf-8?B?bVhhSUJQN0h6cjNBd1l2K05zSGI5ZU55L1RteU93YUVjelN1V0Q5WWJDZ0xo?=
 =?utf-8?B?eVUwQlljQyswQTdmMU9Mbk44amF5NHJCc1JnV1QzeC9mYzlWMElqeERPUVh5?=
 =?utf-8?B?RW9ZOWpXZFlNY2ZBbjZVa21WdTFLRWlvY2w4b3Zwd2RBT3VlVS9IajB0MFVJ?=
 =?utf-8?B?Z3hhSndiUjZEcGw2Qk5vdEwrSld5REtYY3VBbEx4Mngrckh1WHdOMzBNbFJC?=
 =?utf-8?B?TURDazdIZ1ROMnd3U0ZuVjAvNWtZTHEyaXVsWDhhbldSVEZoUWg0a1o4aVVM?=
 =?utf-8?B?c0NBdk4yUDl5bzBBNUhqazhMVXhxdWtGUGdSM2YxbUVBMGdheFZZdHEra1ZW?=
 =?utf-8?B?OWRRRkFZTENrd2d5WjF6alU4dGV6SnUxNWJYTVVkN1JNaWZGbUtRNllNZThs?=
 =?utf-8?B?am05WWZxUHNtVHJtQXZSQ0swVWsvK2w0VmNkOWZvL3FWNituVnMzYTBlVmlr?=
 =?utf-8?B?M01ZZUoxM2ttbU1IZ2FRL0JYekZQRjFUSEVVUGVZUnM3a2lKWW0vZmJ5Z0t4?=
 =?utf-8?B?YisxanBibHl3bE5mblhEUmdNZmNUUmdIN1FnQTVrUTFrd2RJdnhZSDhhcUpq?=
 =?utf-8?B?MUN6L1kxME5aOHRMOGR5TzAwWC9hU2srdDhudXlldkxzWlF2ZmdDSUp5dURa?=
 =?utf-8?Q?hFTDJskLj/F90ba?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3793;6:XfL+msuyDPrTjrL9s27+sSCMIHvV5n4pLsVKZldsijuhwNX/Rky8ofwAJX971q9IkwSLHoPj0amNIdUvZMevJxNug3qFK/BLIAVUC8YfaisAtBZxKoFweUJUcq7vQqiLc2T1YQMnUAg9toUY/Wm0PdzkjdrtPCaeYVOCTpzMZJhK1erQhhXeV3M5QWBi9BZn8kJd+nnn1MD8tIo7K6Odrvo2IamyZLivHj5dwmo3Wjn8ZHf70CVpYwmjZDzWAoCi4F3rOGDV25dyW/oaUnDHBkXh/pqmzYnl6AhbQ5gp98Q00uuJCWl/UqAvdOGziDzQRcwqpRFFwaTVPfgguGhhwg==;5:/i7whYwFYCdcBrJVb/6UX6v0ItprPMm79lC4DHG4OveBgbhWV9oHhHzgAK0UILjimwFxBT5EfeX6uS5N72oIhPObKmqUhRe1hHQnRXpZhZUTQKNeJ7JX3fiKjask76MbULerG/ui5ddKLP5hK17ypg==;24:XiNVnv0UljCTrzkSBHCnnydjLVF2NIZkNhu1FUpBelCN9e5274lKqm9UTgOtSeSSxNfg+HoP8fmDhbS1pk4Hql+pI8YwmCbY4TWzlubwaN8=;7:q1VKEyp4sihtLEna+PPSRvpMsxp7ExI+nHlTB5d9rq4fsfXcZcCTjmGtaxg99lenapQk6Se/IJPkE3G/iTAH0xqvnQgCXTBytFtykrM5HdXHmGwVXe8V2WGLT+rvyLzXPEBKBzMlPpDpuTfbjmUKDd4LABIkbqcHhTvcjJQjlz994EVwxFSUZwQOaQv9EPnl6THkea0hGtZ06+h1KxVx/ZZMi8eMR4xTxmtTUnWkQTg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2017 14:16:32.2638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3793
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 08/29/2017 11:33 PM, Guenter Roeck wrote:
> On Tue, Aug 29, 2017 at 10:40:32AM -0500, Steven J. Hill wrote:
>> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
>> Acked-by: David Daney <david.daney@cavium.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> I assume this series will go through the mips tree.
> 
Hello Guenter.

Yes, we will have Ralf or James take this driver with the next MIPS
push upstream. Thanks for your Ack.

Steve
