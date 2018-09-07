Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 21:48:01 +0200 (CEST)
Received: from mail-eopbgr680135.outbound.protection.outlook.com ([40.107.68.135]:51136
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994656AbeIGTr6pIaaB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Sep 2018 21:47:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o86TgQCR4LeLIAN9mfl5IPveXOaRF3cG3qZSMye3HNQ=;
 b=p1jcRiYPsJ8k7s4VzDJeqlMJrPWORWZ/R0EePQYSzOGKAl4SGy848RKoAWn/bniBoipKICbuDBSeEY7SMun8wWufzaVjonui7shiZ7FMOoPWNJuHsC1Vq9QBb696jQh8tVyeaGBQ1f1807WP6hgjKDRxaPfH/OMWTZsZZL0n/3Y=
Received: from CO2PR0801MB2151.namprd08.prod.outlook.com (10.166.215.6) by
 CO2PR0801MB661.namprd08.prod.outlook.com (10.141.247.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Fri, 7 Sep 2018 19:47:46 +0000
Received: from CO2PR0801MB2151.namprd08.prod.outlook.com
 ([fe80::c4c7:4eeb:5aa4:a77e]) by CO2PR0801MB2151.namprd08.prod.outlook.com
 ([fe80::c4c7:4eeb:5aa4:a77e%6]) with mapi id 15.20.1101.016; Fri, 7 Sep 2018
 19:47:45 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "rachel.mozes@intel.com" <rachel.mozes@intel.com>
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Thread-Topic: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other
 issues
Thread-Index: AQHURTGC8dvwr/NLxkqUoeL58OaY6KTiTImAgADg44CAAIpUgP//qOqAgACFmACAATIi2g==
Date:   Fri, 7 Sep 2018 19:47:45 +0000
Message-ID: <CO2PR0801MB21512A2FA3A3A718725DC035A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
 <20180905225455.luh32536uei5je6m@pburton-laptop>
 <5B917DD5.6020009@wavecomp.com>
 <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
 <5B91A8D1.4060206@wavecomp.com>,<20180906232122.wp72jwfnsbb2ps7b@pburton-laptop>
In-Reply-To: <20180906232122.wp72jwfnsbb2ps7b@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
x-originating-ip: [73.162.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR0801MB661;6:OrqWnjDJRpQ8KDwYTlEF6LdWTTXKNoZpTewH/UDJ2RUC0gNr2frt5+lZT4NaLt15cfEQbVGLaZcwqJ0DDEi6WyozQ8P0xqnTwFNLQ7+baGrVa09NKhB+vTCHyYRu8Ge5H/omfasXXYrouD8Bc5PYuJoT2A5vf/zY90uRtrBBvRYq1bfMX8SyQBdC7Q+9GqxdJv2ri0z4G1QFvH4+QPc6zKRvR4KOOtpJ7OUuNb/HeSMOYSMgqupnxEPKiMQsRS9JwlhDWiJuPL4aF2kCb2a8MjqexA3polCtufVM8Jrkn9q4stggYKsU1VIfP3VxsLcGxglOzLBBy3rgoZkfNcKNX5CABP4XAtJ0NzFka32OwCdOaKrKbuy6fLlsYae4ndiQc2FPZl29CjoJ1ceTYCyF91+BC1nRypDmVo+Wh/w89r7Dod4U3635I1LJWCvAfRnzKs8fdmCZ3TnjsUhT4Drb9w==;5:+IpnLwWDWzJ5U2/J7ZtDYMcEuIu7YvFhpsVf/dghlpqboVSLWYzu1S10Jltxsaw5ouhCece67yjoC5JE1k7AednkV6WZPrdU3eNJyeYVt4+00RsbJSG0nMCzf/p2bcMj0q0nk0ZYEfgxwr4zwFgmt8WGymXghMWyAFSGNnZzv4w=;7:5eD505M4sj2ufnfOY6O6XDVlFy0whjxyCVIy02yrnz4S948fPUT7SDSK7njT0dxFymMuvTQhwmNEbye9WKWIR2803jUIgMdUTrujJNCE9J13dkBe5O1aWfHiGUa6gJ/tkZo3+GfjBzzzmuK1VqYPEU49fNJF5QEjnAJI8otkuKiGnLFTjM5SN5fWGIE9/VihPBnTS9bOuOvNrBDRaRk4qkM1Ms5Vg8PK9EI6TrqJvJUkYKvjCU78bP2lwqhfSSxD
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39840400004)(376002)(396003)(199004)(189003)(55016002)(33656002)(8676002)(5250100002)(99286004)(9686003)(186003)(74316002)(229853002)(102836004)(6506007)(8936002)(53546011)(26005)(305945005)(7736002)(6436002)(81166006)(81156014)(478600001)(14454004)(68736007)(93886005)(7696005)(2900100001)(476003)(66066001)(25786009)(105586002)(86362001)(106356001)(316002)(4326008)(54906003)(76176011)(2906002)(6862004)(6246003)(6636002)(97736004)(256004)(446003)(486006)(3846002)(6116002)(53936002)(11346002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB661;H:CO2PR0801MB2151.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: b5ea5225-bd8e-4ca1-fd63-08d614fac893
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB661;
x-ms-traffictypediagnostic: CO2PR0801MB661:
x-microsoft-antispam-prvs: <CO2PR0801MB6618ED6125947926594896DA2000@CO2PR0801MB661.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699050);SRVR:CO2PR0801MB661;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB661;
x-forefront-prvs: 07880C4932
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WaKvQ7pztwdZfq+x2EEQeMYtjhDmbKetp3z6bx56vUizjS75hqV6hQD9c52P56G99cfrBGHW4x7B0oWzuNOgA5GV+iXk3OlNsP1dfZAuwiNlooOQYbnMykmD/4mVqodMxCji7Y6X+3LqiGjUhv0UN9XSjOauDHFz6Lqrl83Tp4Offg5I30PUCG+wcYOmj6svOhTvpk6UKq6Tqwwnb5lBl+QDYzXMMQw+aFJDgJhhGWpLSj7wuf/saNj34b/yv4caz0pOMTPrrD/MCP8SYKbsILBH82GM/zQi2MR8jC8N/sGL+OLMnynGd7UaOyr1TA+wZoiIchlpIWZgwKIM76/oA071YDRemk5TRbPeI580jyQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ea5225-bd8e-4ca1-fd63-08d614fac893
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 19:47:45.7775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB661
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Hi Paul,


On cache issue, what if kexec_this_cpu() does local i$ flush and scache
invalidation? This is done only on CPU0, no IPI needed. And only CUP0 will use
reboot_code_buffer. In this way, marking other CPUs offline to prevent being
sent IPI is not needed.

As to "the associated fragility of needing to avoid anything that might IPI
them", I hope that's not a problem as the kexec sequence is determined: The last
IPI received is to ask them to stand by on reboot signal, because other than
kexec there is no other kernel code beyond our control, which might send IPIs.

> ...but the new kernel will have no knowledge of whether the old kernel
had CPUs marked online or offline, so I don't follow the argument?

[Dengcheng] I meant the new kernel shouldn't need CPU online info from the old
kernel. The new one is doing a "fresh" boot, provided CPUs 1+ have been halted.

Regarding the use of play_dead(), it's simple and generic - MIPS CPUs have
implemented their own play_dead(), which we can use to stop execution. Other
options may still come down to play_dead() to handle MT/MC details. The concern
of running it in parallel is really about the online status, which has been
explained above and in my last email.

A 'nicer' implementation stopping non-boot CPUs from one CPU might be available,
but handling code duplication of play_dead() and saving CPU states could be a
problem.

For now, no __flush_cache_all() in machine_kexec() + no marking offline in
kexec_this_cpu() + scache invalidation in kexec_this_cpu() might be a way to go.


Thanks,

Dengcheng

---

From: Paul Burton
Sent: Thursday, September 6, 2018 4:21 PM
To: Dengcheng Zhu
Cc: Paul Burton; ralf@linux-mips.org; linux-mips@linux-mips.org; rachel.mozes@intel.com
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
  

Hi Dengcheng,

On Thu, Sep 06, 2018 at 03:23:13PM -0700, Dengcheng Zhu wrote:
> Regarding cache flushing in machine_kexec(), I recommend simply removing
> __flush_cache_all() as CPU0 will do local icache flush before jumping to
> reboot_code_buffer, and other CPUs don't jump at all.

Unfortunately that doesn't work - what if CPU 1 runs machine_kexec() &
writes to reboot_code_buffer, then CPU 0 fetches stale/garbage code from
L2 into its icache?

The icache flush I added in kexec_this_cpu() isn't enough in all systems
unless the CPU that wrote the code writes it back far enough for a
remote CPU to observe. The existing __flush_cache_all() is one
heavy-handed way to achieve that.

> Re: marking CPU offline in kexec_this_cpu(), it's probably good NOT doing
> it either, as the system is going to reboot from CPU0 soon.

...but the new kernel will have no knowledge of whether the old kernel
had CPUs marked online or offline, so I don't follow the argument?

Marking CPUs offline does have the advantage that we won't try to IPI
them. This just makes perfect sense to me, and note that both arch/arm &
arch/x86 offline CPUs during kexec too (I *really* like the way arch/arm
just uses disable_nonboot_cpus() to go through the usual hotplug
sequence in the non-crash case).

> HALT is good enough, no need to gate core power.
> As to whether it's safe running play_dead() in parallel, it shouldn't
> be a problem, as the loop is based
> on cpu online mask (which we don't mark offline as mentioned above) -- The
> CPU will simply halt itself. For non-MT CPUs, play_dead() does make sense
> as well, as it's supposed to stop this CPU's execution, getting ready to
> reboot from CPU0.

That feels like relying on play_dead() accidentally working rather than
doing something it's designed for though, and it would come at the
expense of not marking CPUs offline & the associated fragility of
needing to avoid anything that might IPI them (like some cache flush
functions, as we've seen). I'd much rather we figure out a way to do
this without all that.

One option might be to add something like arch/x86's stop_other_cpus &
crash_stop_other_cpus callbacks in struct plat_smp_ops, which we can
then implement as appropriate. We'd hopefully still reuse some of the
code from play_dead() implementations, but have the separation to allow
them to function differently where needed (eg. the new callbacks could
halt all threads in MT systems without caring about cpu_online_mask).

This would also give us a natural way to check whether a system actually
supports kexec properly, as we could just return with an error from
machine_kexec_prepare() if the stop_other_cpus callback isn't
implemented for the system (ie. is NULL).

Thanks,
    Paul
    
From robh+dt@kernel.org Fri Sep  7 22:29:23 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 22:29:30 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994660AbeIGU3W4apiN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 22:29:22 +0200
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com [209.85.216.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21042087A
        for <linux-mips@linux-mips.org>; Fri,  7 Sep 2018 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536352156;
        bh=qaTN1sLAoeF2hUo9r8Pc8zfcetm74aPR5ccLPi03ij0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0SUTw9D9BeFNMT5o0w5IOq9Qq4GPH8asGBAGCSdLD+82/wgI21oSiel29VgRO7o9r
         TFsXjXPpeSVNZrPUwwtffzR4uEBF6N0e3nhzggKjy3fb8AcNX6hRW8HnqH2TTyaKpG
         TuG9BaZggjEc1PCQ62qDD99KtyTZXb6C7kT18FJg=
Received: by mail-qt0-f176.google.com with SMTP id h4-v6so17605621qtj.7
        for <linux-mips@linux-mips.org>; Fri, 07 Sep 2018 13:29:15 -0700 (PDT)
X-Gm-Message-State: APzg51A5FB3qFRoe7k9J/C3J43UR8F96WmERZydouBPdTeXBxrJB+jh7
        je6rvBEhKoEa/OHnmmdJAPahp3G+96wzh9N09g==
X-Google-Smtp-Source: ANB0Vdab3hT61u1M8M/lHOL0mWGQ/USdGai/hWOrTMd+yeGvnL96ZvpFeSxppjPt10TdKLI1ogg9PQzqaJMzE9dHMxc=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr7110948qvk.90.1536352155200;
 Fri, 07 Sep 2018 13:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180907185414.2630-1-paul.burton@mips.com>
In-Reply-To: <20180907185414.2630-1-paul.burton@mips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 7 Sep 2018 15:29:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
Message-ID: <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] of/fdt: Allow architectures to override
 CONFIG_CMDLINE logic
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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
Content-Length: 2303
Lines: 46

On Fri, Sep 7, 2018 at 1:55 PM Paul Burton <paul.burton@mips.com> wrote:
>
> The CONFIG_CMDLINE-related logic in early_init_dt_scan_chosen() falls
> back to copying CONFIG_CMDLINE into boot_command_line/data if the DT has
> a /chosen node but that node has no bootargs property or a bootargs
> property of length zero.

The Risc-V guys found a similar issue if chosen is missing[1]. I
started a patch[2] to address that, but then looking at the different
arches wasn't sure if I'd break something. I don't recall for sure,
but it may have been MIPS that worried me.

> This is problematic for the MIPS architecture because we support
> concatenating arguments from either the DT or the bootloader with those
> from CONFIG_CMDLINE, but the behaviour of early_init_dt_scan_chosen()
> gives us no way of knowing whether boot_command_line contains arguments
> from DT or already contains CONFIG_CMDLINE. This can lead to us
> concatenating CONFIG_CMDLINE with itself, duplicating command line
> arguments which can be problematic (eg. for earlycon which will attempt
> to register the same console twice & warn about it).

If CONFIG_CMDLINE_EXTEND is set, you know it contains CONFIG_CMDLINE.
But I guess part of the problem is MIPS using its own kconfig options.

> Move the CONFIG_CMDLINE-related logic to a weak function that
> architectures can provide their own version of, such that we continue to
> use the existing logic for architectures where it's suitable but also
> allow MIPS to override this behaviour such that the architecture code
> knows when CONFIG_CMDLINE is used.

More arch specific functions is not what I want. Really, all the
cmdline manipulating logic doesn't belong in DT code, but it shouldn't
be in the arch specific code either IMO. Really it should be some
common kernel function which calls into the DT code to retrieve the DT
bootargs and that's it. Then you can skip calling that kernel function
if you really need non-standard handling.

Perhaps you should consider filling DT bootargs with the cmdline from
bootloader. IOW, make the legacy case look like the non-legacy case
early, and then the kernel doesn't have to deal with both cases later
on.

Rob

[1] https://lkml.org/lkml/2018/3/14/701
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/cmdline
