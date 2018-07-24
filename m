Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 01:24:50 +0200 (CEST)
Received: from mail-eopbgr730103.outbound.protection.outlook.com ([40.107.73.103]:31332
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994562AbeGXXYH7acxu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 01:24:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouHacMQdhJSc6IaFTb1y1yqdMXec0pOZF7OUQ9VYlD0=;
 b=ltK8Itz5LzR5aXIZWC3+RiyJoYYeNWHk4U4jPnom2GHb2zItiHR1NaubsxS1ph0Jju6QU6B8f9zMnUGQAy4BUj1zZM94UpcsV6+qglxGWUfUMFtJJUKwPNi+3K/eTopTeC85OBkJ4mNVPvOn66II0iSVlvdmolaCw6GOQYgiH4s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 23:23:57 +0000
Date:   Tue, 24 Jul 2018 16:23:55 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v3 1/6] MIPS: Make play_dead() work for kexec
Message-ID: <20180724232355.z6j2wvs6srigr7kx@pburton-laptop>
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
 <1532357299-8063-2-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532357299-8063-2-git-send-email-dzhu@wavecomp.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::26) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121fa072-3298-448b-0a73-08d5f1bc879f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:dWwBR3YtXrC4EkkhWWP36xVStkbL+C8nINKolwAhoG+80EMkrACRh6pyXSDn913eHcttGlbrAzzdBP87nT69BiRowPEWdjMPtQAhUUTyPPVyxCA0PK37qbG/VtdtQV4L8uGVztrQoj0ByNaxW4k1SuW4BoduT90AkC9fMplQBnRwCxcwvZ7aaFLvRTpaiQiJQQVmCUlFL42kVQ3F4AlcVRwNb5PRnPvRlsMdFKp1zmaaJiBZZ/qXvsnz3Y8dKNyL;25:DPK/XqA71XJqvb60d7gkIW2xOo6NZOGewaSDjmD6eRdmcDQORFDzfrNo/Dz1WZPf2xa5gLwb1j5+TqfCgv6EIO0FRkT33h1e1K/P8FmVZ+FEaKecvnNZE+u2WdTEgfXy+Or74y058yxR7xHEMSSzLVAjAAzDTw07osK2T0t0iDGAC+qCR1pBFbfkM6Bm1k0MweeXTI+FNHX2k9i2Y4sComN9LGbfnrTKsfhX5/7AgXLLR47AlbhJ85m/O/NeuXmqQDTsvTJFUic3eNvrEpouoR9PqMOz7JVPLEW+rKRmBeUDVCcztFS9kqaurTscJH0FgvUkLcSyEOob29VlkCs0QQ==;31:Z9stHAdSK5HzGPzXYtYI3OSlr7QWyAkgiGDYENujs0wRAK4AseOE9Ed1/EMYrfd/bXQitGYj7hWzGyZEbPik/ZB2EsK6KcdezVrW7hMv9AL0H6KQv/xN57xCBGNEKzaPiLoR3PZRjnYv7RBWxB3Di7t8GlVnZXG5vgrex0tRIDYacPWztTAYdxh4U6ujQkAtr6DBo8RhogECAvPdhoM3gJHcdyJyWv/TzC6gSkExY7o=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:fp9CpGenoX5fvTMYCsanheFbjP5ShHEm65MWK2w/MwQ8/JpFBeLXwowecgh2QlXpBrzaguECTWnYEFgwy0ZGDXGW9lp/4y7Oc3jGruppyf1XXDbxNEwTANyCIgBJjTPeIdGMHquFgXgMWiOJc7pjjctJQrTd0EUD8/XKLuSLhCmY5l/2DPWL/yoYggXJG8VReeJVJpD6uQoBPuailrVA7JAYwTCvjGtogKNYE7+HWdEql+Ulujp4o8LeJ7befEUl;4:G2ch2yQBALwcO8g5s6ihZNzXcObODODTIKyu8hvYhcWY0zDR6eDukJZHInd01tDZF1UpJyaQ3FwKW8K/5LnMGxmtMRRGcK37wRrpC+C8+IRixBWomeYhYSMlaywCCsfEnF4T2SuRvBPA5okxm50GyQ3SfghMZW0e2bqvfCKZ7WDDrUo1p0+U8THsggXo3wBMeX1wrs4XmN40eVs38+Jim3PtPEOWocwJ0v0m9Rn9jri0ZxGGmfeJ7/m08JrDLJigxfrQHPWzfHPvj801iOH2HA==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934D852BF4C2FE12DFE3BF4C1550@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(366004)(136003)(376002)(39840400004)(346002)(189003)(199004)(1076002)(53936002)(6246003)(97736004)(229853002)(58126008)(44832011)(316002)(33716001)(66066001)(6862004)(76176011)(486006)(6116002)(81166006)(81156014)(23726003)(3846002)(16586007)(47776003)(6486002)(6496006)(16526019)(476003)(8936002)(76506005)(5660300001)(106356001)(386003)(50466002)(305945005)(105586002)(2906002)(26005)(9686003)(956004)(478600001)(25786009)(42882007)(33896004)(52116002)(68736007)(446003)(8676002)(7736002)(11346002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:+VJ9ejaBFqC24kfWiKVbsWOXlGY37vDvNn2tbn6HE?=
 =?us-ascii?Q?YOWE3TfT1TYzFWwVO2eXw8Y9gCHxSCQdTXCbkHUdQTx5FNDudNkKnarLLWaC?=
 =?us-ascii?Q?wmthewu8YR2P27BPw8sOL/7jAXuXUdoBbKvga8uAmQ8geDX8nNMEdfWMGJ3Y?=
 =?us-ascii?Q?gihRlwbZgF7qioyTA51sBCYa+AdhK/WkDKuFOkHOfwpuI/c+Yo4jDJC+g4Vz?=
 =?us-ascii?Q?3bMPaKM+zYNIZO+JWl0rWOXvXsemFZYIL0ZmRzHNYPNJzdEhNHvHGqlMxrkG?=
 =?us-ascii?Q?uvxxKvjnKDNdBT+k0B82nxNdCAED9Xrw9wuLKor2oFdR7kqO56EpoYtRIB7J?=
 =?us-ascii?Q?ooJMG4LgseuNfAXbpzcD5Dr2INTSpbBbjHimetKZM0hPMTNqMARIRNhZUhnh?=
 =?us-ascii?Q?Jx7Tg0v/IICyvFsdE/jVIc8wYXvlTu68vlPxyHD05ML1MmXtrIgkzonKRKC2?=
 =?us-ascii?Q?xmJK/PouDjLyMh0sTXk7YGzHpbsVwu9Elo3igyKQvy0zmgRWWXOEW5aNUl+0?=
 =?us-ascii?Q?/Ly1ufPMETJT/7UJLOGjFwmA6wA15h+VLrrhfp17RWL9yWpcS8lR1aUhTMgb?=
 =?us-ascii?Q?GEq2k0NORO8o+yA+IIuGGxfEIzWbXACHh0vyUiAYB5PxIBT1pNLB7LSJ76yf?=
 =?us-ascii?Q?T/ZXJzfLYgbBnjcOoA1aDAeoxPt0DS7t4ENsQUyqdKcbsKp1yYVhYr47VipM?=
 =?us-ascii?Q?eKkr8thBXYoRZ6MnbOHL8ZxY56ohSQ2SUTFWg8/Nzo4BmHXROb7Dzy5OmW6j?=
 =?us-ascii?Q?NtdgjkiQ4Vd8N/xpHmC7+mGSVOpKqe7VGWfyBlU5xBpbWP3CugTdDdLVYq01?=
 =?us-ascii?Q?vvx6mxTRB5e0WhodMR9tozkIdO5rlVOog0Tmoz6wfW67Iij0w0VLGdidk/lP?=
 =?us-ascii?Q?WcViQZFvxNbrayjot+6W7lDE7eyK35Ycriro3zHmnX7/p5ifnXQhifUORnuC?=
 =?us-ascii?Q?LFyP4dT/6ANdeidEGeFFUDOvmN3DYfRZFsF0i7kMDEdAn8ilWR5wGCP1gQoe?=
 =?us-ascii?Q?sbrVJhud/xNC4ObXdwFwewRvjAmCb15gh9MTr72o6B7D+ROrGo2w26BOzeB5?=
 =?us-ascii?Q?bOnUzpCow08iuGneO5QC5Ck4JL3Ushxj8HYVdqBcPO6/WpD4kAPjR1KyUEbS?=
 =?us-ascii?Q?fF0qR4xaEUQsImc0+iajrGZiIS3y+Fwr1AnfDXX6dz3PH/3AjwgT4w/UsNjE?=
 =?us-ascii?Q?x6SUNSicim1U5hvvFIGQ10bVcfEV6bD41FE+aqT+VUT+r+xBzyJk5Z2R6qB3?=
 =?us-ascii?Q?p8H5cZ7LgaBoKfabhg=3D?=
X-Microsoft-Antispam-Message-Info: XurGtm2k03lssYjm/HD602gW/KmdKl8gfIl2L18nZ6HpkcjqOzbmsR56bQEo2UdXT/I7sa81kv3vLLxSRO8AmmfTp3CKaMa8rJ5QmlaF/wnOx+qDCyttBhl2X2HxYmt0BwLarpuP5tnbnDrFHedAsmRPm6wIOHaIv9/XbZQ6dpIZbK8Kp9DeKPoV/ITp2RE4BDobe7SQmXc8l6ee3F+OHSkwevKI1VXem5rZAJ7/s+OUQIxtu9EfI5wPjQ/cHOm+TAnVLkGP9/THavohnOgxboY2NGyjab5GOwbT0U96+vuSC7GebdyWhd5+nmxuMjPBObWg/p3ibpLDjf2HYD63SK2Hi0iMiUsrz18zbaG3DHY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:YLxfWqAMcNgtRqE370mVjshHpKwOdjoblop+CCF0LgxbtvKPfa6rBpJItifhNxW8TGV6JmG72+dsFZPrEPQ98dQsKgPRAv8WFUp87mATJMv+yTB32nREWZXZWBn0ecA0DH+L7KUB6eec1ESqV3rhjFvQEBYSJ+jUqyyHu7l3JnmrX1th4LCWsa9ml/bNw6umpNdjzoH2mmbzbsClsKLWG89ZKdFq4iOMV4JbxlFkZtC27wcdSA47kBipX2xWwczsq7a3741BDcI3xYjW/Ucu6hGh+rqAvRpsmynzlVen+Yuc6v/WAPkoOc7S5WYls4jIgXReS3lafXCEFANTHsRv5YenE3NYCptyEHY6dFn30t5n4QHYUTK+CgjYLJYIdn3uKlRgCeKdXWB8iGaXI5DUva4+P8gGx3UIw23mISfHx0hyGibpXSwiZYVPYgKVXtL6hLzF4pYIcezl4eN7P50NhQ==;5:mH9Im5azZjz5UjEKvR5o1bQmlh5NY6kJdfFzHWrqBkbtOPVmDd1iap1jzS7XWKizwU1xROAGW6WsVfiuR+EK8vEynxPvL4RugwlUx0cYSXxs+DWelZZq4TB5+ourep8Bze0adglMqwB/wL3Ya9XR709rLhyo1LIm59j8l4yBNBE=;7:bYA8E9+fuDs6WjrOzlFk4FtfEiapfQ+UQmfOmUVwtuLHvnYJ7a7LbxvD9FSxUnb+AtEu5hB48x8aGjDOcLu8bwP0PSL4usXA/0zwUk/WRcgNXti0IalD3BkxtsXMoy6LURTam1lz3/zu0/IAzN4nJTJ8a/VkS7oNN262Ip679TsokhQxGFnDoVXPMo8MN/MPuwhgolYw5IYgBZWdUkA4fe77ysDbjmsrq7IzAhn0KtWHDV0V7iX/4a5TRF+GhOub
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 23:23:57.3817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121fa072-3298-448b-0a73-08d5f1bc879f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65121
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

Hi Dengcheng,

On Mon, Jul 23, 2018 at 07:48:14AM -0700, Dengcheng Zhu wrote:
> Extract play_dead() from CONFIG_HOTPLUG_CPU and share with CONFIG_KEXEC.
> Also, add one parameter to it to avoid doing unnecessary things in the case
> of kexec.

I'd prefer that we use a separate function to play_dead() for this, for
example we could provide an implementation of crash_smp_send_stop() much
like ARM's which invokes a machine_crash_nonpanic_core() function on all
CPUs other than the crash CPU.

This would prevent the kexec/kdump functionality from depending on the
board/platform specific play_dead(), and wouldn't need these changes to
all of the implementations of play_dead().

We should also be calling crash_save_cpu() on each CPU, which is a
further difference from play_dead().

> This is needed to correctly support SMP new kernel in kexec. Before doing
> this, all non-crashing CPUs are waiting for the reboot signal
> (kexec_ready_to_reboot) to jump to kexec_start_address in kexec_smp_wait(),
> which creates some problems like incorrect CPU topology upon booting from
> new UP kernel,

Do you know how that happens? I'd expect detecting topology not to
depend upon what state CPUs are in. That should certainly be the case
for smp-cps/CONFIG_MIPS_CPS which detects topology just by reading
CM/CPC/GIC registers.

> sluggish performance in MT environment during and after reboot,

The function running on non-crash CPUs would just need to execute a loop
of wait instructions to avoid this.

> new SMP kernel not able to bring up secondary CPU etc.

If the SMP implementation can reset CPUs then that ought not to happen,
since no matter what the CPU was doing Linux should be able to cause it
to reset & run some known piece of code. I'm not sure the current Octeon
SMP code can do that, but there are patches in patchwork that look like
they might (& patches to remove Octeon's current kexec/kdump code which
suggests nobody cares much about it).

I'd suggest we could perhaps add a boolean to struct plat_smp_ops to
indicate whether kexec is supported, and start by setting it to true for
cps_smp_ops. Then we can have machine_kexec_prepare() return an error if
it finds !mp_ops->kexec_supported, and deal with enabling kexec per
platform. I think this would be better than Kconfig because there are
systems where we may use one of multiple SMP implementations - for
example Malta might use smp-cps (which would be OK for kexec) or smp-cmp
(which wouldn't). If we get to a point where all our SMP implementations
can deal with kexec we could remove the field later.

Thanks,
    Paul
