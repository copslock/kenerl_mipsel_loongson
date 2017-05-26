Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 17:39:41 +0200 (CEST)
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:44672
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993417AbdEZPjego3S0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 17:39:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9mL3apMG3uvZqrl1g7HVNAipagt4GPfb5uGHE/ENq3w=;
 b=AjxQ9nF+CBrMTvX6kV5xPanxnqQgwo7iiR42tqaHm8os2JUxdOAUt2SVkwG6AannqXrnATg1V7wgwqwROohQKr7+TASsT3DwkYJOUJVBf1qZ5Djxyc7eSxBSG9p1XnCb5T8FY04l3uYxZ7VVQRV3tDW/fe85FN601JjJjXnPlY0=
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1124.9; Fri, 26 May 2017 15:39:26 +0000
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
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <e9c9348f-aa61-4384-e065-ba6bafc0bc13@caviumnetworks.com>
Date:   Fri, 26 May 2017 08:39:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <5928463C.5000204@iogearbox.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0035.namprd07.prod.outlook.com (10.168.109.21) To
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR07MB3497:
X-MS-Office365-Filtering-Correlation-Id: d1452b70-63ac-4722-b453-08d4a44d6454
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;3:ctSE3jbW9IQvyKC89EY44btG0zGXL/rw9ILUMHAsIR4UnGE7qk1cydbbDLMzFwfljb2OpMPqJeki2g5MdQjFHjDBlGH2Gi0sMf0JJfq1QcWhW73Q9eyRhCLCCDQE92Kt787PjN2fmURZfjldU4imnNjv7weMZTM6kWmn6FTAADLCnYEg9kti8mpgdH3iB0o5DWyD9DkMwhmWPbqNmk/atp0psXZrYUc4SGdgzO+8eZX9kdBHQISFPMqLXJYPggjRx8Eo3pBmojxa3drZJ1wix3l89UeSI2ZIg8t4OO789kmI2GAsKdVj090BAJMUhXJMGUQFJI4EtWJ2Cau+H0HMqA==;25:iKJINvrAHhRrMUrrOim3BelAbjpDTWddAKrU5K33OyO8dT9G6QGCPg7gba8mMkTPls0b5wlDDQmtwOqlipSuA7bKskWAJn1OFdkxZlL+VzLnFdwd3+U4IRs4whOxQhJR66qWra+RPf1JOcigByqvUbvwjDpkFRrlz/kSEgOh/ybN4ce15Sa+xsoFD40PqRY2l6tCsn3clTcrtcJgS2xe/5XMo6xuLBd5geZaqiyDZ+1K+Ra8JkpJR3PwExkLZpsk4IHDAq93f/aR3SouoJVOQ4WvRHEUOTyk8h11/uaujY2RsNXmBDspqalCq72lH7eUykrc9Rv1QzXqmop1oH/hOApE2fXuA0jB6JqZwBXlBOubY3sdS28vt4T8YtSQKRq/8dNS2HEF5bsdQxmYx/rwZR6fpiju3ViRtgAaHL5jFlQWzf7Hy05LAUvkCNP/sjLF4DRvzodPxnb1q4Zup+w7AKloiYXnBfPhgbtf2IkFyLo=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;31:ZbkfjsyU/zUaaUDyWvGIjRQHVo4MDdRfY4MPH+dHfPAFDD5CvdEqLNjSZ16MhCH/fRkOYWNWdgxTmpir4ut8b8Q7oOH9OF1xQKTMqMl82L9wUU5zAFJTv8trCv6q0zzKcJu31skOygS3PhUjhpbZU7XJB+cpLOm8rxbLrcvvf+J32WfLuMA9cQqNElgnVFYb1oBbqiLru7MMteL/VL4CVl7Vv+U3WtU+BHi6GRm7ZBc=;20:UGE6Y0DjJuI5qWFbPkRBdPlZtS/PnOM1UkdNj+CDd9tgw/AJ7wlSc/VfCq5cdGJZpCklXvgroQTaPRzpa7XwyRMrK5ygIOR2kF/a4BRSqzF1mpilmUkxYFOvAbP1RRMZj0NOPirqL75UCSeDvmUNeg1982kU1Ke/BNNisVT7Kc1WK2bJeXZs1ExMJDH3XA2Ft/Fr3pZviUd3rs115v797CYs0ct+ClgBGsmNF9oxscAjysTyily5Fa2RqOeV7+1GXSxVVHgPhlADdZZXaw3mAbpNCbGTmHq4+DtOvyofy/GbMbMehZ6GRH08lb6YUMzTo+uUiGN3oKMN6zgc/lXS39yTGluGGCacLL1EliUNWGDweVFU00StTX/UXNAOfe9L89lrEiUPLWGtw/q0EWpFiLQFKa2Fg4d5UvpsnP7TWWhZl8iSbqHe7jB+yI+EEllao+9gSaLuLdbGVhqV2vZJskpItzD9KZqbY3i3WDck1TP4AH/Ty29EPEjeb5SfPxzbdK6TyhaZRnyOMpYUP0QhZtKtEG2J4qnEWK49kp5Y3o1SdDL2cZQneqXHRBY3xdm3uUg372EwGkUMgS0RpV7vbPARcHpdQVpMqr8KuuYTWV0=
X-Microsoft-Antispam-PRVS: <DM5PR07MB3497C596FD534C33FC6111D197FC0@DM5PR07MB3497.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(20161123562025)(6072148);SRVR:DM5PR07MB3497;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;4:GQjCZMmarjVJ2fTpFA4PAOZsrtpEj6EJ0Jheeqvnm4UAzbBmAo3J8qjiGhSoKFg3UOPHwxoBN/pNq1N0JPGIdaN6Z88HhFzeN5KR59GFNjNKz5s+h/TTwxyaQUr9Dp6kFJDiv9xYzoyehhA3DqQZ1/qtJCJXecZdS/7n+u1WKoGCzfKVZWAfL7MHMDjb72iDKoQyXpxj9s/IByHbuvV6wkKrS2O5G8hC7hdyn1EwtIQVJ71w+DS8fihK3y0XWKbS6/1K6nRxA625s8swZbg/FuDCN5Ollfhyvqsnz5yoIOI4HB30d7DrOAHxRAcYEf3XF12HaQ0XzJl3mP88piV1GoD6IuVRY0wZJQvykJYawui/ap5LHXm9jzydq348Rl2r8hPeGmMmZuufQA0UgphBfRfjJurq/+A5sfZ1y1TvQkC1NjWh56aKY/7hWtgBMzUdNhbCSDnQHcnJ7saFqTRm36RP8YkE1H+cxpSzykzr1y8acih4h7Pw073B0IgWSFefG3z2WKYa+1uJc+8JbY2lil0iH3nLkspv+eSI5SbgKSGOHy1b332U5NLkORcf9PPkubxjhn6auSWgUX/aP+f9QjweNRzkNkyydNtfNC0vO4uFXJY4i0y2lV0CVPb8ATPeeZKEk4bP3tgA3iBHcx/4GKlYuiwwRbnRKcBpLzeipKEHtFogL06qKv8RsbWLqy53/u/ThjUiD6U0I/7bkZbONTTBKXFPkV/23zsH8lQAojXFJn6pLy7A2SBakbjZtiE834IW/2X725Dryfyt9PvH+g==
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39450400003)(39410400002)(39850400002)(39400400002)(24454002)(377454003)(7736002)(31686004)(305945005)(4001350100001)(76176999)(42186005)(54356999)(4326008)(33646002)(50986999)(53416004)(5660300001)(38730400002)(6246003)(25786009)(53546009)(72206003)(36756003)(478600001)(31696002)(6512007)(2906002)(6506006)(229853002)(6486002)(81166006)(83506001)(3846002)(6116002)(47776003)(8676002)(230700001)(189998001)(42882006)(2950100002)(64126003)(65806001)(50466002)(66066001)(23746002)(53936002)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3497;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM5PR07MB3497;23:FrPgBuQX3Fx3i8CwODY9qzcHYsY1/HnOabT8L?=
 =?Windows-1252?Q?XlzqWyvXOzjOKhKmB/MCRKkKzs+Vr5Dw9BH5D9W/fKByIQhsHq3cS7Jd?=
 =?Windows-1252?Q?77+t2R9RW/KCVSSFNY30xyRnMN8kRJ27xge8VM69zswZi4wEgcCoh+hI?=
 =?Windows-1252?Q?GMbncBOINPJNL5WTdBaZcNGenUtkFTELSjR+FYFk4l0StsJ+eYcMGIDZ?=
 =?Windows-1252?Q?2mOKVgltTKCH6qHUocJHHOprZHoYIYqZa5t986otv1YlTx7haTEurJGC?=
 =?Windows-1252?Q?2j2LwolgGaoXrbERX5bs6s1OncSfbrv4E7t2UZQQ5IWvoEnos+3D07wL?=
 =?Windows-1252?Q?0hkeeMdCNH1l0cDOGga8RdQxIOnuBRy7yptWKJJ4lfZfDdYkWb683jSl?=
 =?Windows-1252?Q?bnrENPNifPayOXWuN93kEMWr9LybLvQ3TYfg9DFg0SzGWzltO9/T0jmy?=
 =?Windows-1252?Q?iYHdm44oCG9QZM87b4ge+LwheXh4ANlNyQXXwhP3LUHW1WVOdSDWu6Ar?=
 =?Windows-1252?Q?LuzW7uAtWVb46kmfCg9+BSvAuOa+REDj1gR7cZcrjoaeLgHKTd4BiN35?=
 =?Windows-1252?Q?CVFD7ysKf2DqbFDJqkZA7VsNXSna4BO32l60sSsKtiGYsJQ8NdYWByhF?=
 =?Windows-1252?Q?F7cuzhnX4Qvp8Y2oJ7xZyJlWWakc2W7wmR3RZcQk84I+fmw17Qt3GqoT?=
 =?Windows-1252?Q?XGZPxWkGHkawpSK+kSDWOElM1s+rRpEZcvQov1Cg7Fv/PZsHJClGon3P?=
 =?Windows-1252?Q?QzJjE8oAs2TK1vZR/DxFfe4j+oo4/zXCRV0jOelSq+8Nv2vdQHabCdZP?=
 =?Windows-1252?Q?OKQeDVxLKuV2eLDFQTzMQYfkUj6QcK3WK9k6gypw9Fn20YLoeYJAGMQk?=
 =?Windows-1252?Q?4qhqD5zTzDxPyL5tRWQYY59U3RFVMYLbwElkXW4VISrPBLqewVEFEiK6?=
 =?Windows-1252?Q?Elg7mdiuUXJf0kW/WD6WelIKhy01EXaswRvyDuUBEGZIeEzcAid5fxqu?=
 =?Windows-1252?Q?cke5MokYPxLklbq1n9HrrVsXU/gJSumToM9oxOG0HLzzys2AOKFN0mq6?=
 =?Windows-1252?Q?tktcz1GGCErsGOLC+K665lAF4Q6jH8ytAsDM/cYHZfMvhnfLjk/2CNid?=
 =?Windows-1252?Q?xUwT6cmDe/+C1MWjTi2EpN3BYJlr6VYhIisIShsGz3Fa/RrFxmZ119ue?=
 =?Windows-1252?Q?+GLRVlCPXFDpNExov5ixZtO9THR+rkuV2sOkCtYF2gEzQb6mq3Fm/yZ6?=
 =?Windows-1252?Q?tf6bnZDY9wJZOPVResfegbs/pIrBnp5YiJp3rax/0fe9O8RrKMmx7jUM?=
 =?Windows-1252?Q?YvG4mxft9ISA58+sjTzbKQA/1wPbYzqPid0jjeOh+vsEtixdjcKCZxpd?=
 =?Windows-1252?Q?8D2g3ZZvlFP?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;6:q1VbsnGvidXMXchsgH1th/mByal5cMak/n1dJrYyFxFu8p13d0yk+mesIWnGVeynTA1wTVcwGt5gQNCDcc9BN7O/oONuE7L0lXLJ33Eh8IjCbCKrVQDAfeHKlZRMhH6EpGhRdkYzdFcnHseaSWrXtdcqv2B8tWI5wM14PZCD2PFUAtnBzxnJiUHs2BQ60awOWCRlWrb2mbKbnGohn+9ewvjU5Fo6LPyaSxTDHj/yU4+GQWzTWHwGtVEPdLrH7F0Ix+143zX+IATIE8mU0u7eyq5YLl5G5zvz0XuE85vgIhHbALHMUlH9sRuLENWySGEnTgO4fwKlvpALaHYrFBP9kxumMUzJLWOu/Mwl/ER4K4etGK+L1z7zihBzOUFcelr/HqOy1BPCavSN+V5TZbFh4yAUgyjEIJYAHlbIHViRjSdVgMSHJPiBuK5lO9Mpb/jyHi2XyJTlr2bl1hjz+s3jkiCSXOVEm2Lft3mPXiEkrez24wJFigIx0YYmg0HD7xC62RX2uTMYjzRHxN2xsroc4Q==;5:w51ShztknSgPnJNzYvFk2UCLVFKS3WFWS33PeaY0AE/1fChHHORg90aXqKSyADvVWoNvKbU7rjN9rXrylxPPCwSI1bm21W2HIHCPW2xkSBEPxH/liLYDcZLTAWmJkNQfI1yRXmljpl9xI+fcArFODA==;24:vs2YW/Gsq07q8rWjunAdTqw6w3YXUUdUF2xMmfzsX85XeCP4EDJaDv6V3Eo1blOkNFJtnowARbFnAVxr/0s2A7kTDO62Gb9KWnfBOVsrDYw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;7:kJkLX2j+wA4ECP1bZwnNsdqwnDo9A3vMYEicxdUHkzjgLnUBU+gim0bYSSv/73YjeijpQ4EEcg+x1stvSUD+po5opjbMfjVufkeoHF2fKgFg+2LSh+gUNBryX0KHEYkqRVSL6Qc5q9Y4NnPLqmHFlnLtzmPJxBXfbruecw8AlfjjbsH7JAVYelrGJq1UnQwSA5WHQ0FGUIaUttCcClEbLBvw4YUKQDrb3MuzI13lIjZqJ86fdF66Hsg9GNoBKhsiqgh4aL6Wr6g0ExY+xdUrcfJ8HekP86G3Zu2/AyltNkMVeftgFlp9aw+O6g2c3RlSHoNqQfSx3+eiES3qTCo0Vg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 15:39:26.3636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3497
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58020
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

On 05/26/2017 08:14 AM, Daniel Borkmann wrote:
> On 05/26/2017 02:38 AM, David Daney wrote:
>> Since the eBPF machine has 64-bit registers, we only support this in
>> 64-bit kernels.  As of the writing of this commit log test-bpf is 
>> showing:
>>
>>    test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]
>>
>> All current test cases are successfully compiled.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
> 
> Awesome work!
> 
> Did you also manage to run tools/testing/selftests/bpf/ fine with
> the JIT enabled?

I haven't done that yet, I will before the next revision.

> 
> [...]
>> +struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>> +{
>> +    struct jit_ctx ctx;
>> +    unsigned int alloc_size;
>> +
>> +    /* Only 64-bit kernel supports eBPF */
>> +    if (!IS_ENABLED(CONFIG_64BIT) || !bpf_jit_enable)
> 
> Isn't this already reflected by the following?
> 
>    select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)

Not exactly.  The eBPF JIT is in the same file as the classic-BPF JIT, 
so when HAVE_EBPF_JIT is false this will indeed never be called.  But 
the kernel would otherwise contain all the JIT code.

By putting in !IS_ENABLED(CONFIG_64BIT) we allow gcc to eliminate all 
the dead code when compiling the JITs.

> 
>> +        return prog;
>> +
>> +    memset(&ctx, 0, sizeof(ctx));
>> +
>> +    ctx.offsets = kcalloc(prog->len + 1, sizeof(*ctx.offsets), 
>> GFP_KERNEL);
>> +    if (ctx.offsets == NULL)
>> +        goto out;
>> +
>> +    ctx.reg_val_types = kcalloc(prog->len + 1, 
>> sizeof(*ctx.reg_val_types), GFP_KERNEL);
>> +    if (ctx.reg_val_types == NULL)
>> +        goto out;
>> +
>> +    ctx.skf = prog;
>> +
>> +    if (reg_val_propagate(&ctx))
>> +        goto out;
>> +
>> +    /* First pass discovers used resources */
>> +    if (build_int_body(&ctx))
>> +        goto out;
>> +
>> +    /* Second pass generates offsets */
>> +    ctx.idx = 0;
>> +    if (gen_int_prologue(&ctx))
>> +        goto out;
>> +    if (build_int_body(&ctx))
>> +        goto out;
>> +    if (build_int_epilogue(&ctx))
>> +        goto out;
>> +
>> +    alloc_size = 4 * ctx.idx;
>> +
>> +    ctx.target = module_alloc(alloc_size);
> 
> You would need to use bpf_jit_binary_alloc() like all other
> eBPF JITs do, otherwise kallsyms of the JITed progs would
> break.

OK, I was just copying code from the classic-BPF JIT in the same file. 
I will fix this.


> 
>> +    if (ctx.target == NULL)
>> +        goto out;
>> +
>> +    /* Clean it */
>> +    memset(ctx.target, 0, alloc_size);
>> +
>> +    /* Third pass generates the code */
>> +    ctx.idx = 0;
>> +    if (gen_int_prologue(&ctx))
>> +        goto out;
>> +    if (build_int_body(&ctx))
>> +        goto out;
>> +    if (build_int_epilogue(&ctx))
>> +        goto out;
>> +    /* Update the icache */
>> +    flush_icache_range((ptr)ctx.target, (ptr)(ctx.target + ctx.idx));
>> +
>> +    if (bpf_jit_enable > 1)
>> +        /* Dump JIT code */
>> +        bpf_jit_dump(prog->len, alloc_size, 2, ctx.target);
>> +
>> +    prog->bpf_func = (void *)ctx.target;
>> +    prog->jited = 1;
>> +
>> +out:
>> +    kfree(ctx.offsets);
>> +    kfree(ctx.reg_val_types);
>> +
>> +    return prog;
>> +}
> 
