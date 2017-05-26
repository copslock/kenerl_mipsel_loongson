Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 21:20:50 +0200 (CEST)
Received: from mail-by2nam01on0059.outbound.protection.outlook.com ([104.47.34.59]:51552
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993459AbdEZTUnWCXkZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 21:20:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tLsomuDWHP9mrDEnOqWqLQNyHQrr/NcGTJKKwXBgnvk=;
 b=PEYugjwgMzX5oE4WSXyaUmScy13xNi47NwFN2oqIQAux1mySweWnw/jWd3tlqMSJJ9nmanNWW05+8+LH85fwPi9bQybUCoHUHT8g1tquNim5/vQNuCIfnQg0jC9O2BqqGt8YLgPbiVLVUAudsDQBPbdIKEhXkS1oe6n+vReoVj4=
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1124.9; Fri, 26 May 2017 19:20:34 +0000
Subject: Re: [PATCH 5/5] MIPS: Add support for eBPF JIT.
To:     Daniel Borkmann <daniel@iogearbox.net>,
        David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>
References: <20170526003826.10834-1-david.daney@cavium.com>
 <20170526003826.10834-6-david.daney@cavium.com>
 <5928463C.5000204@iogearbox.net>
 <e9c9348f-aa61-4384-e065-ba6bafc0bc13@caviumnetworks.com>
 <59287D71.6000307@iogearbox.net>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <9fcd54f8-ab2f-84aa-7db4-2165b746d7c3@caviumnetworks.com>
Date:   Fri, 26 May 2017 12:20:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <59287D71.6000307@iogearbox.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM2PR07CA0028.namprd07.prod.outlook.com (10.141.52.156) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-MS-Office365-Filtering-Correlation-Id: e33178e6-d54f-4b2d-d1b2-08d4a46c48f4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:+u5Us9AHu6JuaYGQx3DpYLR3vcQIXCDluNdZII96pqrWMb9H4/M3u+EYYpZFNmN2M+9ELc4GADkE6o2k+1SZC2ErbzfSWGS+dm3AWDNGbwsaYp36hVRz/BGfxUw9Db9h/g6nuxox+ALt3i34Pl8OL1dJeBtZXx5Qp1MHWH/6zsX9sJG3gicTIPc1e7IvWaFbOjmHFrEqehazbXbkoOzHSwGew8bj20M/pFt7N6rmRnXtaXOHmcLV21DI+OCg7qlX9eIaxK/rHNjUAXWsSFub/Hmj9VMlYz2sWagAX79aiq+AsM7F7f9g0sCoXuGPlnZ4GP5Ugb44OismXtl1LxOcCQ==;25:uRE8I6C/geP6mOsxDWwolejiqHWqlnat6AF9eHuUs+SjgWWRHF6PW5zfH7icwgu+o/w5SKgLpv6ANeP/zP6+xm3RQncrzfHHpBOccjE9jK470hWfbES9kYTzIrZR0RAZXB/YMWbS+/KUkXGaR4lxizG9Bi83lS+JFqvxXpVFb+Es75GpRd4x6yXeZ1hGOiSiG/tPg72Y/TvQbseNStyi5YOF5p12dj9x9yiPLPCEY2BmytvFfzedUQ8Ouuvz/IaLziXcIBWySBcE3sfTtXpoXxy9rtHFrCrRn6w73zvj3pOQu/2xjlFUirPWvraAVdSWgYBrZ10uu+GSWawSadQ5oxYXMy5Btcf0j6QPVRPqH1RZmy67E1tDqYe2t/wGmolNGd62Lh5KujCXWdXg1F6NUX7B7Z9TtbIjWIQi155MinzRNA02jS4Q51nJTlLtYf3pwIr7tzRsGZs8nGoLbXx2vp2NwX34z7NpjBAZKKJyh3A=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;31:S2URIwY5J/oK7lPntjyScEacw17QbuzqsoZeKmb6qQP4j1OH0o8on6NUXoQZKNLbcldQ6m3oWNbi7poe+vqKcADWXhB3dNYI5urFdTvBKz1uxjAYfKWoUo6bvMnLUwqxixqf8aIut/oqkWN8j/Q7hW+cEf8lFahonpfhjOI+a432uPKV8t8vyfuCXBu44NgSiTGorjOL+fAff/bkTjIzEELDcqQluyUt7skNNxdoe5k=;20:JHc0vwIFikiwKutEyb4iV9IaI+E3/xasTPTMDhUxSUmwdUz1MXl3VQT8INWgfzDItMaSHln8NKv9jvPau2aP36c5AfF20AYyJBlSvS05Dm7iAK+AH6n8EbsxHZPLvpE7GKOSdlpFedplpgwa1aJqmA0yRbut9CDpbmQinYerd5HAUw7KpuaKKii0sJvxFcVGk3qaSnC9gC2lQuD1mM4PqpS6OVKImNi99oktNrc0+wX5leZKaeprQ8eS/caXC9DRDS1DXiqLKVGffl3yO9fQeztmDJvhlAkyyukWqJOK0Y/P3VsazViaNIUI/p//6lkwhDbr+2CgEwUB3FliUIIZktENiu25BJtLop9x0MWCKyI1+7H2O4oBdwLgCRkPxKBgl3Budsvm1ALJjQ1exfHt9nJpifokW590z9v53cyMuYASp1aPNYOJ/ALWNOtf3fzCRKsqx6QfNAQVKbLj07+fCRKbEOIRrf0b1yX5Nz8TSiX2w0axbXdZmBPC9yLX8VFSbnFhyWptElJ4jvMVoHa7cxsQx03exl1L8uMw0zCOdkfmk21Xvyib62oL6j/mRgyMuZiVX1jc/iCypKI7hHJ9HmPGsfjJs+yQnX1zhhsL4OA=
X-Microsoft-Antispam-PRVS: <CY4PR07MB34961FF6066F74A947981A6B97FC0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(6041248)(20161123562025)(20161123564025)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;4:8m0LS4LK91v341zZ6wEaq9W72JYKFZet+wKOBkPNpbzT1s6z+dIaFG38WA1GGHwr3n7CXd8ipNBeLa2OKMvxyb5fv8wf+2fx8OZbCT25jOhQqTwOhZPctLFrcJtAkMcMwIF58Lih0VqX3pB3u4/PFCcTxJcLW7u0X6QYthhtX+3gUqv461t0dSF3SAdDYtM/kKu7Y9SEbWPQcuxOJ1HHxWOHZhjgyEr09jTNWH6Y5Lm+7mkbvHsDScSn3RykK0RjU4dhfpB0KHp0RCu6wEAb32lC4w2/8ULOw1DiZ+GUF3DmDcQmKHI2jfd1LOuL5+1wgNTsjvCToCvDgAE2m9fg3Vp5xf7qKlV4IshvGwBhYAKY8mkoOFnRUbaG+UMObqq9q5aWupDow23Xz2tI9f/Alr16WifIVzyXz+tuKvZx7CY8HARLbmAlsjyV4p6J9ZJ+b9DfrdLtYHJo5prw+EH7WgWWGBs4137pPgv0QYY1Pn5AvsHxGB2HbmycwJOarYFe772v9fOPBm/EEZtRUrao4CadjhhF4tj5hPlIETBI2h+trognyfZcbAnN9x5w4bXyF2nd6TGir6jhVioNyPcysFqkxlb6lgcc71jt7n38zzYugluJB3DfS2Pta6DEZuVhCaqMjgHRSyGFgAsr+QYVdCMI09mqoDD2DWnZE4YXq2MFucRTNBMS6mXDgczkucO6EUQCOXHY4/8p1kU1OntYrUke99KnZRo3ZGwiIco+u1glxkFqSfP3jeDvAdt/7Uq2ya5WR77FJOOoVb3M4xU18w==
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39400400002)(39410400002)(39850400002)(39840400002)(39450400003)(24454002)(377454003)(2950100002)(53936002)(2906002)(42882006)(50466002)(53416004)(81166006)(64126003)(53546009)(33646002)(6512007)(189998001)(31696002)(229853002)(50986999)(25786009)(3846002)(6116002)(6246003)(305945005)(36756003)(31686004)(42186005)(7736002)(76176999)(38730400002)(5660300001)(54356999)(47776003)(93886004)(230700001)(8676002)(23746002)(4326008)(6486002)(478600001)(72206003)(66066001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR07MB3496;23:/KdOLUeRtWODOreRq00ZaVxv5+ILQMdfOalrf?=
 =?Windows-1252?Q?g1dDiDNIVdsNTGDDdnnelyxNhIs/dd3w4gp5olG9dxy53ULxMu+EV6dN?=
 =?Windows-1252?Q?868MRK1lEhgO07ZyYgSBJwT4jpY58Rk8lG5K3X1+Ei8D5ngLOMGZDXY2?=
 =?Windows-1252?Q?CaLviDQM2syYOdNLNUuGWoLCorzUtjdx14HiQXG9WcWf/xpZuUDFi3xp?=
 =?Windows-1252?Q?9q3H130l/cajzbdvcercwBkGdc0byLMD/P70w1crzjd1hxhPgJGJtf5k?=
 =?Windows-1252?Q?V4V0OF9URF+tZg9chlZJGDuwMAJ3msHBiRRJ4/uH39xmFZ/l8iY9QAHo?=
 =?Windows-1252?Q?Q/4mEc2DrKelGslAnRaa/caISZFnbobBPOtn1xEyCBsjgyTLX8d8p0zp?=
 =?Windows-1252?Q?D46CkicWPqnLFJaMSETYeu1V2WjsmGmX03DvuT9Jm47AUoiD88g4KWl2?=
 =?Windows-1252?Q?pjBT6AgrroSKZqO0KeecMWtrRDXJs3ySlZLVPyNkagL5aYFa9mHEfLvA?=
 =?Windows-1252?Q?Nh2jOy0zvSdlbGNorty7tOqbORLDVxdq473zOvdBMSOWp+DoZKa76hk5?=
 =?Windows-1252?Q?IJDi7fW6sAYw15aXiYcBL5yHQrzdpSjsRoSsMu8zQuiZSrihTvJv8e5e?=
 =?Windows-1252?Q?W9mFQBOTFhq61oGKGasba82lPjA+5LJ9YKi/dPSLb4LEThtnL3XsaQCK?=
 =?Windows-1252?Q?PO+pdb7inboMWThKXlOWFsGf2XM29x36ncqmdfliLYnJqe6EoJZ65Ucx?=
 =?Windows-1252?Q?4IQnktsnUayjSvdUOn4ty/RzJCbzVo7HxFXTjC/6II0CBAG1XUW2hw8F?=
 =?Windows-1252?Q?bbHvLKEvwHaQxk4vl1qoOZRO/TATZxoJrYbRx+h3vrR2VEA8qR3qVVl9?=
 =?Windows-1252?Q?/zjSLfza7fwHV3YFtKSIyTcGRrKI55PrLwdtisTJ3HCVywb744dBVWJC?=
 =?Windows-1252?Q?OY9xKgPlbwRBZ44C2xF7+AyFLQawLozB2urjeKiVj6/ap0sr9mI0dkc1?=
 =?Windows-1252?Q?ENewJ86ofs6nP1gYiNDPiQzLagKK+gWoZRcUm29T8xD6rbCudrN/vc3i?=
 =?Windows-1252?Q?68/3lEpPVXoPRlj9ks7tSURC+xUYRuxxJbwPPDwDUL2wxZ5R0XaXbNkT?=
 =?Windows-1252?Q?68bxMzW41MhhJeixoQ1d+fankvAUON9epDK3ECbxThACmt1iO2RMdhUi?=
 =?Windows-1252?Q?BCpjcqA7Wjae1hzWi02R90BhVfl3POtvAdkKoZxXs2oPVKG3sUOmPGp9?=
 =?Windows-1252?Q?Kn7mGXLMfv1C2EY49k/aD3SdX0XFve9JjACKTw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:BWqZaUcTT9ig6fNPRXEF1F3w04rxIPmR3TzzFByepsuynsQjBLznvzw0/56fXEiZ7BOIb4b6c7EmOq+s2tXBOA6FacfQIG4fc2oEZzqW3MjSovbwpoK/sCbdPI6YYEJTnbkVQegkyQ4vWexE0Lrp5xg1FiRufgeRJInAhZIX5g2vXX6NsPBeou4eCQoy9IZspiBOmK7K+EY3wDsXku/Uz1G6hmaS7zr8HjRT0uiJjvW4vzySE9+cFUliodUUUvzHAoW8ykz/IRzO1+CxzxiW6nIult1R0rDrJtczRqAOfcFpbQMAuZnnQezr/BAEJjlBHxaKpvKcs8/d0OpK01ayHyUmePamFuQ1IzSTZiT6EcPE1Iugdd6CrzNUUoO+5n+rhY6bdQXKJ1itxQenXsEv7cEhD9o6jTFH2uDZaTfpXRQpO7WCHHD3CMwoqMcB1Fp0l33JwxX5c15YIS7MG1CCjZSJV5Dm/LwVJlBnEmV3WODwid75epeuRFvzhy6yHKYhRk+zKb5i6bY9llOt6CPxag==;5:9o+8IRBTxiGnenZ8AwNvzKmNOAYjAtqj/nb+qYplN446R4pz8RDfQRz3G/PJODyEFkXR2NVCjzlaW1sry0d5GYUKajrdnAOj8dKvH8z12hppAX6hcgGBQ4nDYQ8ORoAbTg3AYF87HVeNognQGp4NbsJe1YIrVB1UGKh/5xJEt/g=;24:FE9cnz4bmKn1nbKk/QLv7iqcxghSljjyP0caRAraj5gz3tBRghqth5Pd7si9lOy256b6T/miBTuo+cOOohhLiw8V8bN3La3BlCxVcSyAk8Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;7:UV31oaW7hLx317GTSgHr8sffKIwtsDAjSJHQF79TXGz0nrsilF3SPjxtSdWS/ZodrdAtXbKXPw2hO3cUNQHwgcmhJr3O9kyb4BuwPf9dm5Q+OWmBjWR6zPtQtdDcYliBUIWBPIPuT1C6zOrLpxUVZQBJIAOoWfOfUdpZI7jS9cRXpXUS+p9AyGZTk6jM+xCd9R0OO5C4cYeGjAnGa3a5ShQrMJjDmZCQ+WG8+RWV/vnQtrWd0apcWbY7ltNLB3NpFyXIg+bGIoldO4ngkqm3/o8gO93aFUl4UfNq64pErf+ByhPzqr3cwzmmvarREJJs9BJEgpg1NB4xnBxK0fU0aQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 19:20:34.4759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58025
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

On 05/26/2017 12:09 PM, Daniel Borkmann wrote:
> On 05/26/2017 05:39 PM, David Daney wrote:
>> On 05/26/2017 08:14 AM, Daniel Borkmann wrote:
>>> On 05/26/2017 02:38 AM, David Daney wrote:
>>>> Since the eBPF machine has 64-bit registers, we only support this in
>>>> 64-bit kernels.  As of the writing of this commit log test-bpf is 
>>>> showing:
>>>>
>>>>    test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]
>>>>
>>>> All current test cases are successfully compiled.
>>>>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>
>>> Awesome work!
>>>
>>> Did you also manage to run tools/testing/selftests/bpf/ fine with
>>> the JIT enabled?
>>
>> I haven't done that yet, I will before the next revision.
>>
>>> [...]
>>>> +struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>> +{
>>>> +    struct jit_ctx ctx;
>>>> +    unsigned int alloc_size;
>>>> +
>>>> +    /* Only 64-bit kernel supports eBPF */
>>>> +    if (!IS_ENABLED(CONFIG_64BIT) || !bpf_jit_enable)
>>>
>>> Isn't this already reflected by the following?
>>>
>>>    select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)
>>
>> Not exactly.  The eBPF JIT is in the same file as the classic-BPF JIT, 
>> so when HAVE_EBPF_JIT is false this will indeed never be called.  But 
>> the kernel would otherwise contain all the JIT code.
>>
>> By putting in !IS_ENABLED(CONFIG_64BIT) we allow gcc to eliminate all 
>> the dead code when compiling the JITs.
> 
> Side-effect would still be that for cBPF you go through the cBPF
> JIT instead of letting the kernel convert all cBPF to eBPF and
> later on go through your eBPF JIT. If you still prefer to have
> everything in one single file and let gcc eliminate dead code
> then you can just do single line change ...
> 
> void bpf_jit_compile(struct bpf_prog *fp)
> {
>          struct jit_ctx ctx;
>          unsigned int alloc_size, tmp_idx;
> 
>          if (IS_ENABLED(CONFIG_HAVE_EBPF_JIT) || !bpf_jit_enable)
>                  return;

Yes.  In fact I did that for testing.

The cBPF JIT generates smaller code for:

test_bpf: #274 BPF_MAXINSNS: ld_abs+get_processor_id jited:1 44128 PASS

When we attempt to use the eBPF JIT for this, some of the MIPS branch 
instructions cannot reach their targets (+- 32K instructions).  I didn't 
feel like fixing the code generation quite yet to handle branches that 
span more than 32K instructions, so I left the cBPF in place so I could 
claim that all of the test cases were JITed :-)

For the next revision of the patch I will revisit this.

David.

>          [...]
> }
> 
> ... and bpf_prog_ebpf_jited() et al wouldn't need to be changed
> in the core, which are used in kallsyms, and kernel will then
> also be able to automatically JIT all of seccomp-BPF and the
> missing cBPF extensions we have through the eBPF JIT w/o extra
> work.
