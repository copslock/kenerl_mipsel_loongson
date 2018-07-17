Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 18:59:33 +0200 (CEST)
Received: from mail-eopbgr700121.outbound.protection.outlook.com ([40.107.70.121]:35645
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990422AbeGQQ73w8M7h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 18:59:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC+IrgDUHhfAtxGPnz1I70dcfg0VUiuV3MEAB816Sdg=;
 b=mefQaZurpxvVdrbbMPEYqiW7Ls6GWvZjk3VC1nSSBAL4/61isZjb7PhDhqciOukauAjS05s9KWOlVxc4pi7HIbupiFils5a7TXFV2q8N54qDDdYX5ZCR9SUgkyMVm++/OkiP1LzZorqjvgpgwY2+HPa2vLNELhaNPhbb4ThIbxY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 16:59:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.9 Backport] MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()
Date:   Tue, 17 Jul 2018 09:57:18 -0700
Message-Id: <20180717165718.11543-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716094023.GA20647@kroah.com>
References: <20180716094023.GA20647@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BL0PR02CA0101.namprd02.prod.outlook.com
 (2603:10b6:208:51::42) To SN6PR08MB4941.namprd08.prod.outlook.com
 (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65632fd7-5abb-4110-af20-08d5ec06a1ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:Ih981X44+cqQBShPGK5JYKeGfyWHfcBpRWkZbrM/l+olhDLDxWbY6fr3VMQTf3IawGMq690RvXCXkrussUBCMXHnHLzzJZEVybWjHBermd/JpICPTXF7f+1XonW2LTZXzDf6pvmXc+E7hZDRDhzDMocfuzWqHZq6HJjUm9dsKizRRCnuUGpUnER1XRHZJaURKyHZ0JyyqNYEpPYrEPE326bL0Br5xTNBQc/at4hb3Qi1FByBPFHZ1PeZgXMv5yN9;25:cG/+fyfnmKQ2FqLeGFExuX2CcKfQ5kUHwr217tATGy3qU54UqK/aKcZsB8Ggq3SudsiI3NrCm5ovmADOw24hmfL1GdzmN71dxusdy7pBZcaZ7xPVYpT1Z/j16ZZo16GKGh15hGWo+r7h/7xjOh3TKHHvkSLjsWu1z/jISpcDwElh8Ekva/Viw7Icd1GtFmfIkFNNQmkI4q5YER8DezOnV6CgYdr9Iv7QfjfYsmEFmVOnWnmAnGxlE51YzGXha7TNhHENtiwiybSMftR6gsP+hWc36OYDCZghqGMmmwtpMO904L28qyWJdgXDX3El3YbxfeO+X/f3noxo8HM31SrlHQ==;31:3SznFGecPYxdyNTFiBqMyKHjD69s+0Zn/MvBU5Y/7exvlTWYGR1OA487SzFpcc4hHnrlYHazJlY9RnOfunwUlGlMPKrbPN7HuKde8ZdrVviYWkrWCZ/TN/QDqAv8NzMKJ8tRwPyyv0AZJUFjs6FOiKFA6ctLimqZIHJt8NNUAEZ73CW7RIX8ACtZNuqS+whDfYkPYzVHX/phuxSyaKmUOpWtlFWECEkP7wqh+svTEF4=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:0s9ZtwZBllMHKDhBKUu4zDJBdNRxllc/IDdXwG90LoreBFXeEMy32bdIJDb6KSDiKwDgFTT2ycFh5yGSpevX1WFDfVr5pacitDD1dE8i+BYXz/e4BvE7QkabitiNxbC0b18E6G8RXxaVO09ax7Hs0MXlE5S+jgREAYNwoVrDBtFTQuVFd8ZOwZ7G9NbRa8S4MJ+FjINaDDUo0rLNUOOxWH2vlxybkmWykyNoi6o/C7f1f+EiS//a0gRMRjhmPn0W;4:/pUK5pdpwlbiGQP0O23dZRM1Xtn9OKd+HbmJzi0MGCTkwNZZIbXB+hRwrJb6k620/EG5QztgRE0BdgerzMmEbuidxhiNbzSnFzKfdI4DOPuwMwsZ9qg24JBvXk0NKs7i1RL0VwDXz4wEK+QP30VeFnNIxKJzpXS1ECSU9menad/wJw4kdv5k6BTurXdDrzcqCD2/82IiIOqcfAiNf2h99tUa95X1YmpCvmhsIsmlkzP8QiubhiVbDT1iayYgeHfkyfDgWYv9+LsJN+53gtFKb0UZilwF1YcKxQ7RUPvLO1Z9kyZ4leys8GCsDT++aeNo
X-Microsoft-Antispam-PRVS: <SN6PR08MB4941C9F2A5DA981787B750BDC15C0@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39840400004)(396003)(189003)(199004)(50466002)(97736004)(2906002)(4326008)(25786009)(68736007)(14444005)(16586007)(476003)(956004)(575784001)(2616005)(42882007)(47776003)(66066001)(6116002)(3846002)(44832011)(1076002)(11346002)(54906003)(486006)(446003)(48376002)(52116002)(50226002)(76176011)(6486002)(6506007)(51416003)(6306002)(81156014)(81166006)(53416004)(7736002)(386003)(186003)(316002)(6512007)(478600001)(45080400002)(69596002)(16526019)(53936002)(966005)(36756003)(5660300001)(26005)(305945005)(105586002)(106356001)(8936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:7qEZfc5U9gRDGpRbojuUzF7igugLjLhHtkWZknq01?=
 =?us-ascii?Q?QFLRUslQ+Gm2W0mZGJa+MG4hOSrtsc/iX1BuWNTc3YdpQ2luoGE6FIvtMeN2?=
 =?us-ascii?Q?p/A8IXthRLhTCCqlurBBWznEHN2yat4hfJKz1q6E2ITQM3zrRqan6Mk2vedM?=
 =?us-ascii?Q?lhp+nLlBdus2NYFsn+phhEuRDNfbSqHuWjR7Fpif4LRGzrkMJ/l+FeHd1SUb?=
 =?us-ascii?Q?Gnrvq2YYy/IBXtUmwgK4XqCFMZkWD6XkfqTbGV2zxhKTVEP7cZXGzXnrr7kb?=
 =?us-ascii?Q?0eAreoUd70PP4YRjhlLZCMkKJvfaD8G0yVcfnE5jdcxa0ZansPtzH7CGPXLa?=
 =?us-ascii?Q?1r97lKvnEZebA7LxbolluOZV7f20+dlTcOuClxYy/vQh+1s3JQTXuxaR87Km?=
 =?us-ascii?Q?EC8xVv91ocK2LXYqVmrZt62uy3ZxIYp+syonhGm8HzUeQMklIJWKHGsI8qJ4?=
 =?us-ascii?Q?y91jhL2Hx0UYtaJtB/g9pha+SCjzSgfQ36grA0MgMfW5T5mLXvU0tVGRgKg8?=
 =?us-ascii?Q?i0ovB86LEh21HFXnqKuRvv5LcWdcAC7Y2y4vIiHMKcnuLKPe3HMVIwDATdiF?=
 =?us-ascii?Q?ulTdCELO8e47ipyafPDLgOlzNoycGn0eUNgzGbhpboFHpYQbhijwqx7iVXm7?=
 =?us-ascii?Q?VRgcnvurZThDHRPBwhuSSIJZXpC9LVIHS4z6qS7xOcZlDPZqE7sx7RooIg6f?=
 =?us-ascii?Q?i15G1WwYpRRtG2d7GCrjTU64/rpEt35DvlrOWoGNKIh9M5XNHfivm+Fbwa69?=
 =?us-ascii?Q?ycH+wUTAZEJumJAYytEQzqXaCgXQW+1z96QcYua11cTUpeclXYBUHr/XW3Hz?=
 =?us-ascii?Q?pn3WzZogv/B7CrV7XMXEit/ZYtIkelOJZZmrrDqDdJayQ2NGItlSzRaejKjy?=
 =?us-ascii?Q?I3YyskvzRSzeEMmIOcHPi52x5zXTxkHUODwb2yoYkQUbz1tKfie8nEVlM3lf?=
 =?us-ascii?Q?YQOvfO//64MAuiM7YqcwBjCHEpqDA0xjzv7YD02EZ4kodCPrK6CEHaJWzSEZ?=
 =?us-ascii?Q?Efo/ciE2GW0QEhG2/SIb69n32ZzskcIGcd9dyHUkwyz7o9x7a+0BnMAsZZC4?=
 =?us-ascii?Q?/DzzEBgfpNjnvz9Nb48OlVSOeBQ/xk1wOFlEiz5sVHnP/U7E2RB3ukeMD0y6?=
 =?us-ascii?Q?u5etK4LEH8JUhgJYON9SOggPCLhrEZGq0dMMz5n/bvOczu1ZLMB8od51b8G2?=
 =?us-ascii?Q?diwZ6JxfT85NYwt7rvpi/4m/VMoWpkzDIXPlli9TydXHj0KRu57FnOVUZuLO?=
 =?us-ascii?Q?hQF9Q4Dw8ZMBtohou29GShci022U4H0kzgfAuUJeIoDNecoM0vZLpdu03rUU?=
 =?us-ascii?Q?WvXVYxG9Abl3rBaieS4VEwtPU+Y1pllFs80FpomRsWg?=
X-Microsoft-Antispam-Message-Info: 9abRwUWZ15ybcnpQBcJ2Gs02f7qMUiQvKBI7opW9lL6O8LLQoLJZXm7UWB+n+gxlyPqmr7lbpKXwK3Ke7w6Gt83+SDb4+GTHnnF159L1CzN3wkd4CwVX1dPT+46rVlyhhpWS+ZiANhyJ11EVv60MEfx/xeXRgylQZFYzpad0PARIBl2z4zyyKBLuGQJRlXYq7xCpGRis8bf40ecjWQ6yv66mxAWBC6/OD/BX5KO4r+Nb4n1AMFUaGW3f/6KfhCFeNg9Heb0UMXkBBV9nSOZQ4pinL/8/qWM4E8v7Si9cHoBw+w2J2Dc40riEYyxKL73vWWr79azQ14bfJHh9JD26cOBbT8c3LFqDFyt1L9GigZ8=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:xptWSDXu9GVobtODAj6UvYUZqWZTYQ3e1rfcvSaUjqtNBg8cm1Sfa0UhYR2lMeggQzzWcG1Lsc2M5ftDYB5q/fKF0FKpXKtYfbI9iAK3jq5qKQ9yyJ/ziwuRj0uCWBVdJfq6dk826uzPMA6RXgJHzlIlysNwlc9OYk5UnN3JI4lUO18uXnX6Pd9z6FVK+OYQ6rLz9PFywL+uq2rAZpwNiq4Y1bIy5NqrXwze43sX/48l25OD6vkg21uQsyFWbABnz/lWiWmquq6IjltBstFTHaSt9MaJoXMVOxVtgVzsO2fXh2qguX5lndBGQtAj4cA2fO5xiGzdJlnDoaEHv6UVgv/8qf1RMad3ORfpW5FsYWOyTfB5UOM9O7xj9MJut0T8S4aWDvTPvAYjaOjE3AQDjwqy9zrJDJZpuXd1KM1zcLpuDwgfyN+s74yz+DMA6qzFk4OMogMj5rIrXFAQ7nhL3w==;5:Bl3TiwTlsWtZs9EqLA8h0kDQEghgwcAkvR1zHTqrYQvzJpu6PhAKp0rxVIxlLEdBv2EFzfvCEzZIoqhSHqD0c3XBeeD31Gi40ySzPc9YDnH1BJauxIrSymJGjJwJViuUPRPcXFZk7KfWbn2IxyaR9Qafz+u4262XKZYmtC8y6Rw=;24:nRVpuJ04CxBwnBTOwkIyMM3/a4t2KSu5cwrERfpF6Vu78Xe2rMXiGXvwrgexBOqBBUp+NldppMn4DkHHXwOzJiom5OnEf1f/1FuA6rr7zGM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;7:OKrQWXiqQphUSf0SfytDg0TeWxZeffJ3VyEX9Z27NsUhRNV03tmgHvN9+DG6j4J7pdaV5HVHW2YNm0W6il+7vII5/dqd/OC3r6ixzmcI/nHkjCw9ahNaB59APRKaJmvTvvMuAV/LqU6FEp949ckSpzHhb45VxKTes51wINSEECFJozkV4YEU7kOGd9C2tGfxkr0iB8q68DkPqcTMHBrsW+5EY0dZl9++EL9HkdS+Z0mfMympcYXlYEjGh3sXfs+P
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 16:59:16.2142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65632fd7-5abb-4110-af20-08d5ec06a1ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

commit b63e132b6433a41cf311e8bc382d33fd2b73b505 upstream.

The current MIPS implementation of arch_trigger_cpumask_backtrace() is
broken because it attempts to use synchronous IPIs despite the fact that
it may be run with interrupts disabled.

This means that when arch_trigger_cpumask_backtrace() is invoked, for
example by the RCU CPU stall watchdog, we may:

  - Deadlock due to use of synchronous IPIs with interrupts disabled,
    causing the CPU that's attempting to generate the backtrace output
    to hang itself.

  - Not succeed in generating the desired output from remote CPUs.

  - Produce warnings about this from smp_call_function_many(), for
    example:

    [42760.526910] INFO: rcu_sched detected stalls on CPUs/tasks:
    [42760.535755]  0-...!: (1 GPs behind) idle=ade/140000000000000/0 softirq=526944/526945 fqs=0
    [42760.547874]  1-...!: (0 ticks this GP) idle=e4a/140000000000000/0 softirq=547885/547885 fqs=0
    [42760.559869]  (detected by 2, t=2162 jiffies, g=266689, c=266688, q=33)
    [42760.568927] ------------[ cut here ]------------
    [42760.576146] WARNING: CPU: 2 PID: 1216 at kernel/smp.c:416 smp_call_function_many+0x88/0x20c
    [42760.587839] Modules linked in:
    [42760.593152] CPU: 2 PID: 1216 Comm: sh Not tainted 4.15.4-00373-gee058bb4d0c2 #2
    [42760.603767] Stack : 8e09bd20 8e09bd20 8e09bd20 fffffff0 00000007 00000006 00000000 8e09bca8
    [42760.616937]         95b2b379 95b2b379 807a0080 00000007 81944518 0000018a 00000032 00000000
    [42760.630095]         00000000 00000030 80000000 00000000 806eca74 00000009 8017e2b8 000001a0
    [42760.643169]         00000000 00000002 00000000 8e09baa4 00000008 808b8008 86d69080 8e09bca0
    [42760.656282]         8e09ad50 805e20aa 00000000 00000000 00000000 8017e2b8 00000009 801070ca
    [42760.669424]         ...
    [42760.673919] Call Trace:
    [42760.678672] [<27fde568>] show_stack+0x70/0xf0
    [42760.685417] [<84751641>] dump_stack+0xaa/0xd0
    [42760.692188] [<699d671c>] __warn+0x80/0x92
    [42760.698549] [<68915d41>] warn_slowpath_null+0x28/0x36
    [42760.705912] [<f7c76c1c>] smp_call_function_many+0x88/0x20c
    [42760.713696] [<6bbdfc2a>] arch_trigger_cpumask_backtrace+0x30/0x4a
    [42760.722216] [<f845bd33>] rcu_dump_cpu_stacks+0x6a/0x98
    [42760.729580] [<796e7629>] rcu_check_callbacks+0x672/0x6ac
    [42760.737476] [<059b3b43>] update_process_times+0x18/0x34
    [42760.744981] [<6eb94941>] tick_sched_handle.isra.5+0x26/0x38
    [42760.752793] [<478d3d70>] tick_sched_timer+0x1c/0x50
    [42760.759882] [<e56ea39f>] __hrtimer_run_queues+0xc6/0x226
    [42760.767418] [<e88bbcae>] hrtimer_interrupt+0x88/0x19a
    [42760.775031] [<6765a19e>] gic_compare_interrupt+0x2e/0x3a
    [42760.782761] [<0558bf5f>] handle_percpu_devid_irq+0x78/0x168
    [42760.790795] [<90c11ba2>] generic_handle_irq+0x1e/0x2c
    [42760.798117] [<1b6d462c>] gic_handle_local_int+0x38/0x86
    [42760.805545] [<b2ada1c7>] gic_irq_dispatch+0xa/0x14
    [42760.812534] [<90c11ba2>] generic_handle_irq+0x1e/0x2c
    [42760.820086] [<c7521934>] do_IRQ+0x16/0x20
    [42760.826274] [<9aef3ce6>] plat_irq_dispatch+0x62/0x94
    [42760.833458] [<6a94b53c>] except_vec_vi_end+0x70/0x78
    [42760.840655] [<22284043>] smp_call_function_many+0x1ba/0x20c
    [42760.848501] [<54022b58>] smp_call_function+0x1e/0x2c
    [42760.855693] [<ab9fc705>] flush_tlb_mm+0x2a/0x98
    [42760.862730] [<0844cdd0>] tlb_flush_mmu+0x1c/0x44
    [42760.869628] [<cb259b74>] arch_tlb_finish_mmu+0x26/0x3e
    [42760.877021] [<1aeaaf74>] tlb_finish_mmu+0x18/0x66
    [42760.883907] [<b3fce717>] exit_mmap+0x76/0xea
    [42760.890428] [<c4c8a2f6>] mmput+0x80/0x11a
    [42760.896632] [<a41a08f4>] do_exit+0x1f4/0x80c
    [42760.903158] [<ee01cef6>] do_group_exit+0x20/0x7e
    [42760.909990] [<13fa8d54>] __wake_up_parent+0x0/0x1e
    [42760.917045] [<46cf89d0>] smp_call_function_many+0x1a2/0x20c
    [42760.924893] [<8c21a93b>] syscall_common+0x14/0x1c
    [42760.931765] ---[ end trace 02aa09da9dc52a60 ]---
    [42760.938342] ------------[ cut here ]------------
    [42760.945311] WARNING: CPU: 2 PID: 1216 at kernel/smp.c:291 smp_call_function_single+0xee/0xf8
    ...

This patch switches MIPS' arch_trigger_cpumask_backtrace() to use async
IPIs & smp_call_function_single_async() in order to resolve this
problem. We ensure use of the pre-allocated call_single_data_t
structures is serialized by maintaining a cpumask indicating that
they're busy, and refusing to attempt to send an IPI when a CPU's bit is
set in this mask. This should only happen if a CPU hasn't responded to a
previous backtrace IPI - ie. if it's hung - and we print a warning to
the console in this case.

I've marked this for stable branches as far back as v4.9, to which it
applies cleanly. Strictly speaking the faulty MIPS implementation can be
traced further back to commit 856839b76836 ("MIPS: Add
arch_trigger_all_cpu_backtrace() function") in v3.19, but kernel
versions v3.19 through v4.8 will require further work to backport due to
the rework performed in commit 9a01c3ed5cdb ("nmi_backtrace: add more
trigger_*_cpu_backtrace() methods").

For the backport to v4.9.x we use struct call_single_data in place of
the typedef-ed call_single_data_t which is introduced in Linux v4.14.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19597/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.9+
Fixes: 856839b76836 ("MIPS: Add arch_trigger_all_cpu_backtrace() function")
Fixes: 9a01c3ed5cdb ("nmi_backtrace: add more trigger_*_cpu_backtrace() methods")
---
 arch/mips/kernel/process.c | 45 +++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cb1e9c184b5a..6c3699daa36c 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/kallsyms.h>
 #include <linux/random.h>
 #include <linux/prctl.h>
+#include <linux/nmi.h>
 
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
@@ -633,28 +634,42 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ALMASK;
 }
 
-static void arch_dump_stack(void *info)
-{
-	struct pt_regs *regs;
+static DEFINE_PER_CPU(struct call_single_data, backtrace_csd);
+static struct cpumask backtrace_csd_busy;
 
-	regs = get_irq_regs();
-
-	if (regs)
-		show_regs(regs);
-	else
-		dump_stack();
+static void handle_backtrace(void *info)
+{
+	nmi_cpu_backtrace(get_irq_regs());
+	cpumask_clear_cpu(smp_processor_id(), &backtrace_csd_busy);
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+static void raise_backtrace(cpumask_t *mask)
 {
-	long this_cpu = get_cpu();
+	struct call_single_data *csd;
+	int cpu;
 
-	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
-		dump_stack();
+	for_each_cpu(cpu, mask) {
+		/*
+		 * If we previously sent an IPI to the target CPU & it hasn't
+		 * cleared its bit in the busy cpumask then it didn't handle
+		 * our previous IPI & it's not safe for us to reuse the
+		 * struct call_single_data.
+		 */
+		if (cpumask_test_and_set_cpu(cpu, &backtrace_csd_busy)) {
+			pr_warn("Unable to send backtrace IPI to CPU%u - perhaps it hung?\n",
+				cpu);
+			continue;
+		}
 
-	smp_call_function_many(mask, arch_dump_stack, NULL, 1);
+		csd = &per_cpu(backtrace_csd, cpu);
+		csd->func = handle_backtrace;
+		smp_call_function_single_async(cpu, csd);
+	}
+}
 
-	put_cpu();
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace);
 }
 
 int mips_get_process_fp_mode(struct task_struct *task)
-- 
2.18.0
