Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 00:29:36 +0200 (CEST)
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com ([104.47.32.45]:19983
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993915AbdHVW31t3xJO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Aug 2017 00:29:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vYkWtkxoYggT+JRSkzdCJs/PmjiWfez7gi8j7clBQbg=;
 b=DuQU1/nqmO+F4QsyUhIocI/dwS1FxGApvrwYCLEKbsknkZz13xMovcLT8JdI2z0hZ+hovGQP2pHOQ0f0HqGhC4NR9fpR4pUAXZp9JDlv+8pq0lYb6k/G6pWE3Hb3EgXmuc3Ocsgfmy4MflYOOBe1Uk1B77EcUax6PODQi8f+zGc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1362.18; Tue, 22 Aug 2017 22:29:18 +0000
Subject: Re: [PATCH][next] MIPS,bpf: fix missing break in switch statement
To:     Colin King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-mips@linux-mips.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170822220349.5648-1-colin.king@canonical.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <93479b06-c3a2-a08a-fe5c-d8f155efeacc@caviumnetworks.com>
Date:   Tue, 22 Aug 2017 15:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170822220349.5648-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0082.namprd07.prod.outlook.com (10.163.126.50)
 To MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 510bedc1-4de4-40ed-a60d-08d4e9ad3afa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:vXNRGSVLnhl63ZZkGBmRwGuOYAqTnQhVlDOILY8G6nEcQNLIHqZ7zcP0BgrNmzLiewg3dKdbZnuAB+DbNO1Iu+G6TV1Q7Uh+UDSgUbhYOotux+kHhdZzBvrI2ikJlmhT+VfJ68FoE6fAUMjEEfjbfdXIH70Z26RaIEVl3oE32HTkxcyJ7PehTbTFHDSvGtblcQ5UrwfyBF3vtuiD7DHC7BxtaJhTgFncnRwZ+aUljeyJwncs235Qhi8TwXe25LFi;25:uTCSynXtUq9Bj9DWx4taltkgDLjz8cjsaJRNK4YXZTfRwUHggA/lUFQp4HpRWIctpDxQnXJX30Nv/m8zlG2ITxIAldndVftK5XKC8VOU/JEoq/++aXf8HbQ/+sgAl85TIb1uZSv3t07QZNxc7EZBo+lIMGoSd/d7lyR/lTW+xnfynnDFc8IUu5CMlSL+cvIUbOPHynt+GC5i3tFEztQcOsy0Hi4TtROb+d7WA11aF/3VgfujJDfNaGN3jojkzkaH+wmanaZ+i6hIwckeb41hAiOZbhJkLzNf1rtyva6MxJTM4IShiK98BL3hyYafKtjRU8MTZaMkFjdNTGPq466bNw==;31:X3UEAEmu6DfOhikwHhbE6SU6snMILtnig+udsldqtDlsHPClNvVANBSYsuweU/j5NH5WcILghoweSuPpSHWCeu5sPsXzqpu+SJHr/XWgunqDEV9O+VXjHruvHZfsFxYHmEfkPbfumjlGTh4goc4QgjbQvO+ToApNtX3iLEBmbRzlOHqVYkY/opnKo+6UgubVcY47QuWwGH0HLG4L5q+QLTy/EMH9QRtEFwQv29Ya2wI=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:HFrgiKJU8BAnBZr9R2qXqboL9MMqzPH3E53H4opaVLor6MoEb8KQq57ye0+PRaCIBjFfBjxnZ6+YHUjtXceW/ItyznP+kaDic5Xm32RgHf8prRyCHy/eEJmv2Quf4KZb2gJNwdxqrENcN2SJMlH0nyK4mcdshGszFDIQJYi2p/XCck2DMG0ai9dAl1FrEWU2pC8ILp/8GQuv3AcX4kV8+WYvtIQjAhqkU1v+ZB+4LqOTJKFJ5QdVQfVeIFaisYWrGaaQpBZtWZYGE4X5MNTMSyXdiN6j1XXhQvD5OjnlPZA8B+ShFDnkJxJC7ogvmtYO/96xubTTaA5cQtUhTjXC7/APenD5a376kp/ej6+6sB11pdhN/UxpOupN9FvNcQpaqidX5ncCQcTWuOaRCQZDibWHv5iSmfMPa93XWLLtamHb3GMUzxqHehfFAs6Pn/T/u1EBhvYB8KTAL3m9Sj5YEqgAoxy3VHi+mkFrQAaCOatVLMdpXTz+WLAktVaHiXS6duj2E6RYgiARBHtqAdp/qrNL1CxAkhOwtl9tx3GGo8nUtzwtYc9Jjmnbj4p5VxTe/nd/z39kys2Rd2/0brPLBYNZ71o6VsCf73HG3LwCRzs=;4:7ZleAo0jSJprCU8YLQNPvu4osG5lwHtHXSYpz9rEKq1ewJ+Zn6WDpGji0BVuxH5GVQiuSgfFM/fX8L7Exxq13W1Iy7wQ/lmYmt2V5vmkZeiN6lKOHZ0P/VqifkPLHkrmpZAsAPgBhjQjviar8lTpVcT1TIeqf1C5MTKLbL9c56MJ96ACGmA5eNId1hrxoISt2Yp5OwJ5ThkDHuA9fD14w5+4Vd7gV3gsvlepaIGPFcvtzdDF3W6Pv6wA1R9oDVH8IKUpPhvpIZPlGxEdx5N+UYIDF47WgnlgnVCYn8ByT5k=
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-Microsoft-Antispam-PRVS: <MWHPR07MB3503C5870E817BA93C18134497840@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(100000703101)(100105400095)(93006095)(10201501046)(6041248)(20161123562025)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 04073E895A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(24454002)(189002)(199003)(377454003)(105586002)(106356001)(2906002)(8676002)(7736002)(305945005)(2950100002)(5660300001)(47776003)(65806001)(189998001)(33646002)(65826007)(65956001)(64126003)(575784001)(53546010)(66066001)(83506001)(6486002)(31696002)(50466002)(69596002)(229853002)(230700001)(6666003)(6116002)(81166006)(42882006)(3846002)(7350300001)(4326008)(53416004)(25786009)(54356999)(42186005)(72206003)(101416001)(4001350100001)(81156014)(6246003)(31686004)(76176999)(50986999)(97736004)(68736007)(23676002)(6506006)(53936002)(478600001)(6512007)(36756003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAzOzIzOmhESk9zL0dmZ2JDV2xPRkZvQjZaVWxZNnVH?=
 =?utf-8?B?SHBTVndnekZDVEJqR3d6a3NlczQ4cDhxdGRBSnNIMGVYdFVJWmMxOGQzQi9h?=
 =?utf-8?B?blRvRW5OSVQwU2VJWU10RE15cU5yaTB3ak5RTlNxYVlLd0JVSVRWQ0c4Yjcr?=
 =?utf-8?B?SnEwQ3hMNlF1QlorZVg1UXVKS3BEd3crZlYzaVNXYW1keCtVYUwreXg4TEhR?=
 =?utf-8?B?MURDY2NGZStMNENNSDFzVThjSGdSem1UNFJuZkZGWVRDRmhZQjdQS0FlVllF?=
 =?utf-8?B?WWNjSW92aHZWNkt0amVBeFFsQ2J6Ui9XQVgvaDJEWXlRd1FsQ2VQa0RMNjYv?=
 =?utf-8?B?SWl5dG1Wdk9wMG51MzBxN3lHKzBTWndOd2JnRVpJdEQrMHR6elBzd2xlM1hW?=
 =?utf-8?B?SnZCbHoyZ0d1dmFsSWFaeGNNS0hnRXpzV3p4Q0NVei81Yndjc2x2c3QyQVZj?=
 =?utf-8?B?a1ZtRE5RTzY1Tm9qMGJzU3FuNi9QcXdDbWlNeG8vQmlLajMwZ3gydGl4RDZl?=
 =?utf-8?B?aUwrU1ByUGEzZUZxVUFrcTl6RjdmQ0FBV0IyOCtJK3JvdkhKT2lXcENyL2lG?=
 =?utf-8?B?WkNFMWczV3M3QzlndFVRNlZhMUhrQzdiNVA0YVJBdHRGMWtaSVdQUEVhSXgx?=
 =?utf-8?B?UGJJNFE5S3VMbExKZnZ5cUl2TGhscEtlUzZ3b3o0L2NuV01XYmlZaDVKSUQw?=
 =?utf-8?B?Y0xhYzRMNFNVNUhUejd6Yzd0dkZtbUdpQ2lzZ1BLalUzb2RjTUovMnhRRHF4?=
 =?utf-8?B?TFJjbmJmM0EyVUVDTTJ6cXZFZEY0ZS9MSE9iVFNKSDEyQm0wc1poYUt5V0NS?=
 =?utf-8?B?bFNjU1VNenhibW1mWlNFdVpqVzUzYlJxcm40SWZzblV1d0NNenVER2Z3cmlZ?=
 =?utf-8?B?RnQ1VFViTUE2VGE3WXJET0w3SHdDQ0o3YlVpM3NCVUNZU0t2VGtLZDNnTzYv?=
 =?utf-8?B?eUJYajlrMVYvcVM4dW1HK3EvbmU2VmVBUWUzTlNDd2tLQkVscDM1U0ptOVdw?=
 =?utf-8?B?bUtzMHFUb1FydVRNai9YYTVqMDloSlFGdWl6TStFaTgwOFdPRHc1Vk1VdFFx?=
 =?utf-8?B?anNQT3daLzJtekVZZzJVc3FLUlpaNy9Nc1RJN040bDFvc1hZd3RlNVBMcTRt?=
 =?utf-8?B?dnUvQVRlOXU3YThqQlN2Y3V2QVM0Zi9lNTV3VVZ1UGJYc1NEV1pOQ1FpSlhI?=
 =?utf-8?B?V0NQU2h4UVdPajRXL09KcmFmT29rVWsvY2pnZG83ZGNjUG1vazZBRTE4dW1R?=
 =?utf-8?B?WVY0cFBZRmI0VWwzOW5nWlhPcHc2NDZVTVByV2dDL3BQeHNXRVZxVkdOUGVw?=
 =?utf-8?B?SXlzTWw2NjlxaVoxMDVaem5pUGhDK0FGN2pOam5OTDVuSUdFMXhVYzVlSkhi?=
 =?utf-8?B?dGxweFAzYmxTODNvN0lrRTRYVkxQellxUjdBbTk0Nkl0TFYrVFVmdEtrSHd1?=
 =?utf-8?B?YnkvcXJoYVR0VVdEeEZYRmlBT05zRW5JaC9POUJWbkJZSlNUQnpJQktaaEp6?=
 =?utf-8?B?Q090V1lNbU9NeDZTWTR2dERIaHJ2N05yY3kzMW5UYU9UUFVLS2g3WGpSZTdm?=
 =?utf-8?B?SUVTNFdvSkFXbE1zcE14SGRoOW1QK0hpUFBjOG9LdEtRcXlDZzJqZmJIVjBo?=
 =?utf-8?B?V3B1cWJCYlJKeUMxMGh1b0drWk5QMjZJTGFFWjhXYThBaUFxM09LSnhuc0sv?=
 =?utf-8?B?TGFTTTgzcUFodjYyKzc5Zjc0ZFZTVTlYSWpxWDZLYmVWdjZzeWQ4SGFkTzVy?=
 =?utf-8?B?YjRYdEpYSVo2b3FBS2RFQ1F4VXVBR2pQdGN1emxheDBzUVdmOW55eno5Qkpz?=
 =?utf-8?B?NDNMMnRYbTkxSER5TmhMYzM5eEt0bjhPaEdMMVo2cHkzb0dyYmQvcXNFWi9V?=
 =?utf-8?B?UmxnNlRsSHNyZzQrSzRqYm04dUlaQVowWmx1SkZVR3I5aHl5bXowbjdTSXNZ?=
 =?utf-8?B?Zm41TlpzTnlRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:9zezRuyoex9UpnWuqn06kRW59OTD45kJES13d+CHjUHe1gIxI9ZHyvFMOetw5kwkbJr36G/OM2hDQqZe0mkahQCJxrUdcwxAZgW/qGF+f3kyhqjEghpP76PFdkmfmMSo5qdP4EdI+v5cb/LufpmO8gA8W5UJPESfwvvL3CwlTtkUB8d7BZwLR+ZYG4m2TpVVjJ2Ezk1k8Boo1R/JzH1diIr9tMfOOGdTIkAk87JQEJOKXrimsvUUavFa2tY3NtbvQfGOjpXBcva8MtWtGartOBHhbB7LOq2Ljf62hPoP1cBcEhFd/yfCXQ2MUsWiNyicOFWbXTeZuXmfzAj/v3dw5A==;5:BUbzilRFQxCR/pP0LJFjhkEtvDH+7MZ9NCAznE3yAgpl0muJexnfZZegGURflDzxcK1CmlQfqm5zL6BuLAbJhyGC547hjSQKPIBOnlfnzHbKVgMyAz7lrk+xiR8NfMfDcl1htCEPlDC7XrW92guS1Q==;24:fIK+7FW9oSKOLPd/Bg6lyjvyiI54dh+sDlMs1ynh4zrsTOwnT3W8Pfo8+NtxqUKidXK7yr2LupVjL/I6Xtm7B7XAbE8knBNPjjFb6sImg4o=;7:5u3tuDBbyJbENRDGLDN2YRyMsLcICkZPgEoM3fmnErotzdoqNntAHoOHkkkAhrc37GiZPNrYpSrH0hpnssdtZljlhlT3CeUAyX9249zy1aL6bqTt8pw1/JD4FpEpMhVsxUyyNxXUSGQeiF7jWbjYcMM4cEyl9C+oemRYATx0uE/jGGIbLSYfW4gtFrfCe3JGpq0guKlNKdU9sNvJQG62Vyy8VCbKX7zjB/k85Ev9A8U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2017 22:29:18.4361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59761
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

On 08/22/2017 03:03 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a missing break causing a fall-through and setting
> ctx.use_bbit_insns to the wrong value. Fix this by adding the
> missing break.
> 
> Detected with cppcheck:
> "Variable 'ctx.use_bbit_insns' is reassigned a value before the old
> one has been used. 'break;' missing?"
> 
> Fixes: 8d8d18c3283f ("MIPS,bpf: Fix using smp_processor_id() in preemptible splat.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Crap!  That slipped through.  Thanks for fixing it.

Tested and ...

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/net/ebpf_jit.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
> index 44ddc12cbb0e..7646891c4e9b 100644
> --- a/arch/mips/net/ebpf_jit.c
> +++ b/arch/mips/net/ebpf_jit.c
> @@ -1892,6 +1892,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	case CPU_CAVIUM_OCTEON2:
>   	case CPU_CAVIUM_OCTEON3:
>   		ctx.use_bbit_insns = 1;
> +		break;
>   	default:
>   		ctx.use_bbit_insns = 0;
>   	}
> 
