Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 23:42:59 +0200 (CEST)
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:55744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994666AbeIGVmq5fn7n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 23:42:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YGbXimNhorht4u+3RmyggctDLxT1Box8Vco8wjhWok=;
 b=a6ocCSynKYpy6IDKH6OvbiuzkbsTYQm6BKM4xXvx0RzJKirXBQWRI7qjE+HqvWKMhdGdlS9AUpLp4klIpOCjLlBUl+3N3P7Mkvy6G/J31i3OYRbNxabgyXUabLP8dhesE92KtwZlHgsjs08+OgAYB9mv5ShZmSTvNV3GONjWbyI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 21:42:35 +0000
Date:   Fri, 7 Sep 2018 14:42:32 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     Paul Burton <pburton@wavecomp.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "rachel.mozes@intel.com" <rachel.mozes@intel.com>
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Message-ID: <20180907214232.du2fh422uwzhdusm@pburton-laptop>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
 <20180905225455.luh32536uei5je6m@pburton-laptop>
 <5B917DD5.6020009@wavecomp.com>
 <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
 <5B91A8D1.4060206@wavecomp.com>
 <20180906232122.wp72jwfnsbb2ps7b@pburton-laptop>
 <CO2PR0801MB21512A2FA3A3A718725DC035A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR0801MB21512A2FA3A3A718725DC035A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0025.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::11) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf9820c8-4c30-4ae0-cba1-08d6150ad321
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:E0wK/aS0doYsOEwEWRO1qGdAqtsiFqWb0cYrzMWuY7WOF3CrdJhFwbyw1ySDg+9gcAJnv3BcNJvPH6jZ2eV3WL5psalo3r9vXKH0QCizrPhBM6x+M90pOHcPbMI8S5+5ShMbmX6jF4uTPvxX9mlcX9iAA28SDnEqaGfD186dyITvP21O2Fci+GfsV7CDPawwipq01/IXpxIi09Z1uahDFNCiVYGj/jlmttgOTZZ8r45/vaCLyG7ViLriTD2SwmGB;25:CuNvSbM/NnlL+PzVzFTjL0+kaOdAC2c4Suvksc1jjo+vOJqJ04Jlx8W4y3Pb65CB+yIy9woEEN8mBPYiiyHCt6DgfsB5P/WCjcjQuN10TzfvP/XdX7KJpfyWM7FfheUxmHFYKuDauMAqy7nW8fNoPQtjrmiWfD+gBwntb+7IQZ1Xvlw3CdWsSWPe6T5D5zlKE8TwjBZQMzHn1rCvypzDFVBGiG5jqjQF6+07EwUJj7nqZQzvy0GdNhUOkqnf6WnXPRe4M+9a4NBEdv0/p9/hqxMdLqjGLzGN6N5E1NVLAl0CF8ApQsID4IC8RKG1WrOxceDQMS1748nExhTRGOHUgA==;31:Rnelb2yoO//AMjNWMCu/wpMFKN3dRW2uW4c2pOivwGuyhDbhwZZWvU1fbejtPwmBPtmlAVeolATQlho6zBWe3hPFvsuXD9Zu5VHzoFPx9xhsfnavHmpXKv2+wjVjKC4Q8RiYNPkrl6XkJYRAkb2QlxpHCkzJKksa05B6mDZ5vQcRAXaATmlA2EYhUvCwSkPCaflBE1Wtp2eClxW5B23E+52MTxgOW8tN3R1PLdjiGjw=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:OyJiqwraP+dpqrQV9rL2vNJMwZKVT4sxqKjmg/xsHVaahy6yiQNNLp+pFi+dOaim814ruSPYqkuL/5mCCWJVDkhmButfNBu50G8fGNUfG7HbU7er06pxozZ0b28owJ5vcD1S8FHNZOY0vIhUEXekbFtKoQo7ZdlwDzSmQaO/Ged4o4+q4fZ2A487uv7gzZMaPp28gpJymhRuJhQTmgZKuHA6UaaLLoBuFVeiPwL9XYTj1fzMt9rSjFGo8PYOI1tX;4:oEthLNpFRN6axG087hfyd/V+nBmimKXl/BqLFklLcm66IHFQRDYgpzQoVxOYWYFhL8slCKN80j/UH8mk9U9BHxMCVT+xljvAE+0zVzcfTrlfA3QnHpGBRic6z2JkwhjcNNYUBWLP/wXJfSRD0frKUdgbv7w89ugCqgwYylXZ6SfLKZQfPq6KSDE80UBsrSKmv3rlc//gIYWj6Uv++yj5mQWCEZ6nsW/E7iM1WJy0KmK13syBvzKeA916z76d+sm5QX3Vd2CsTHNuLbfUG6mWbGje0h+DL+ZXoGrh6xpj4boyI46IFk3ZIb93WVHnjaHP
X-Microsoft-Antispam-PRVS: <BYAPR08MB493434F8A2C8551D4E66BB19C1000@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(346002)(136003)(396003)(39840400004)(199004)(189003)(6666003)(23726003)(5660300001)(3846002)(6116002)(81156014)(47776003)(8936002)(25786009)(6246003)(6862004)(81166006)(97736004)(4326008)(93886005)(8676002)(50466002)(2906002)(106356001)(229853002)(54906003)(44832011)(33716001)(58126008)(16586007)(76506005)(68736007)(105586002)(6486002)(305945005)(316002)(7736002)(9686003)(33896004)(446003)(42882007)(478600001)(66066001)(956004)(476003)(16526019)(386003)(26005)(53936002)(52116002)(486006)(6496006)(1076002)(76176011)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:z5xnykatmFdfFxanK0PV+op8fmHGVaYybdqSiUMZn?=
 =?us-ascii?Q?imv7kqnnCvVWoPZpJHAuIojaEr99gliI8MyKjmRTkrzKF88DxQLwPrb9cTxR?=
 =?us-ascii?Q?VU/kpA/ylR4OhMfzj3cMBBZqq5HpumM1hzTamgbMdPnTHoNkl/DC5lXuIuDB?=
 =?us-ascii?Q?7mEf0mk+WqC4Sr5+sSVn7/MncGdZZxtR7BwIsIY5NFiEQ7VH6WeZujCpqxp/?=
 =?us-ascii?Q?Uq1yDbEBa8pFK2zuWAwTFXiEixZ97J3d7PD7rpA9c0z+uLCx85+CxjX2dAy+?=
 =?us-ascii?Q?ytTwZYj9noONHbOLZTQHMDqwEjCwKKLe6pYXxitxQgzLJVu2IlbbaiMgqCJ5?=
 =?us-ascii?Q?hnhF80XyXu1jjmncLd1O8/VKDYSeUMvbdargU+NEMxP2jIs2hPA+aqxh+IzW?=
 =?us-ascii?Q?sVxq7MN2Ki2zeZD5fpbcxc+4TH5GzMpvmhMD45CoG6OGW2TUHRcRiINtsGDo?=
 =?us-ascii?Q?7fSCbrEXks5yMoKHygipiCrhR08bPY7o0rCViyyM5qEXwjQubIShx1XU9wZY?=
 =?us-ascii?Q?4UywfQ4AUd1h9nxD1UMzDcZ+nwbCyPs6cdmRxI7rwxCkr71PrwH8RVPbNxdP?=
 =?us-ascii?Q?Gyim9CcFhaX/CQYVR+j5lyYimnGbEk4gyWUlRl588tXmXRkiOqpfc/KO61F3?=
 =?us-ascii?Q?2a45Gj3M9GVbyTjIWecGjyw+TF482+40nG9ElwC2WgoHGXSyEndgUyBrd6Yd?=
 =?us-ascii?Q?5jrDjc3UyjglFQCwpiDuKZS57+StzaIBda+OpqQ+1jIzjzUfcdL/yyk5Z3qY?=
 =?us-ascii?Q?jTA4/Lmr6CN5gZNbxsvm5KYN6BLNYNO88fY1qSCeH1iRO8SbsnaYFTFPcThL?=
 =?us-ascii?Q?m2X3k3iCeuWaDxPz8aP/fRdwp1JFRac5dznuzb1snhG6aqQYkGexYPwIdXjz?=
 =?us-ascii?Q?VPJGHBeI3oJatK91j04ErzQMxmZ4rzGpnAt7IYGVi08qEODViibqvIxDomFY?=
 =?us-ascii?Q?tabhEUvwZyjLUueNJxE9CERjBF7RiGSYHjDxjUuDCybJjSqPkoOojvnjmqLb?=
 =?us-ascii?Q?/nHFX5cfl2Gonodcilka6//dNDTSNNSDM/zI4kjkzj3q6ikaNE+zyKWuUEuA?=
 =?us-ascii?Q?LaZWs+emo3sOVUKPVf6JR/K1P3A8OAbMixiz+sJjFe0M1HESusxry6bj8cYL?=
 =?us-ascii?Q?RrJ4CZZKQa3XVDaog+VxBD2gy21wx1Ix2bLVwmxWV4KNmp/4bEpGm+W/Fpph?=
 =?us-ascii?Q?4No2xeeVPnJZd4LhHEsAHavi36b2MbpQli9w8MM5AN9b4fvdKHwBoWEBpwvl?=
 =?us-ascii?Q?7rm66EQTHECXZIBGhfXQ3Q9P6wozjkWT16/QmlQbFopEOwIf6k4iOCrjZhH7?=
 =?us-ascii?Q?jVAnP72+KKW/I3UaH1spZs=3D?=
X-Microsoft-Antispam-Message-Info: 62K7WuM7v7nX8hBWYbrfsjTbPmR9o/t+eycF1OJkgQvfut/Am4iwM15OdVTWm1Lb2kBdOY7BAbpRI07ULsy8OVmD0U+gxFsWPNVC5NF9VpsrDrP7ADwfKl/v8cxKoUmo9e1owbkPJKnyuA3/5zCKS0+C/Va3wE+ExJ6XCSxwOsHnbtWEM5lVLkaHnOvjEys05WS4jqqbdNnoPAzeWDfi3d+6KtBlt9jRctyU5DHgF956OAFpOk03oKHIxlim7U8o2jhMJ4a4ZUuzihAFsLVHlIZ1ArwGlTgFBMfXXqq1WuCeuhZpCr5PApmLnp09Lwh8qcOTHtpbCGkeyt1356ICXjsz+CPTTdkP9oJIhcqGjtg=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:fakPrHp9ZpV4Ub+Z+cZYBwkc8SxHT3fRlfCfCtgqPVtzGR/fzT4bQgTMpl61uuYR+NW2XlIvY6jh2obpRshhs/WU5Jo9pvmUUE3TQQiZ6F2gZdiu8IOC0+S90IlCF2J6zDe56D270omFcyEFTtx3nXcrWDTCGrAziEmxQkTAhfmEVSp9kD6ZQ6BmS3G6RR6/q8sbhYkcrDHf6e5FjiMgngUaXVyV40GiktKOYmfjYPX70K8Or0Y0iZx1OPb8bCcndoKzI+wcs3R7o05Yk0bibF1pJOP+Vw345MzxBTns6/8eKaw4x/tn+ylw4wN1YG8G24G5jjIDQtZ2Z1/ZtTyHXnNnGFiLIpV/hGLt2aGghNLiwfUN3iGnBSWJvZXztmiezSDXdHTFCD6TMh6P66kFTl4SSYIDM6gv/3zW+MCV6EhOBpY2WcCNKnGXaBZcGpr57vcOIwBKx11ALADqOyH36g==;5:XT32fjEp9WnGU/+U/K7droBlrk1bOXUQ9dyInmGoRsJbNoN9wjwiKyAqLV2hFKvlnELJwD7VASjy+fOrUL8uAr5SzMh1KRl6i+IyeSn97Ww00nQxn8Q+kEltb8Wcn0yG2wtukpl7NMUl3hhNceivfb5vOxKK2ZZF14PqS/tJzTc=;7:O6KFBkhA6EAhU8miPLJmcpRE2jy74vt4zsZpssoAC2M/v6ktNfeg6mc0YBARJ3u1PvLV7AMCK4eQzXHPjk7YPIolnK14Umjn0rwlLKNPnBtwE/am2nmzigLR7OVsPtij+5VuGV6ADb+RLOHyo7kAM7Y9qZQdx1mrk/IEfldOL3IiX2vhHvNgXtZK4XOanDgO20JvO74H0u9Hz/DNMbufAb5HNCmR8Agv5n3uMH9NuEbfoj/w7Mg33T81RMWqOkwR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 21:42:35.3826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9820c8-4c30-4ae0-cba1-08d6150ad321
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66150
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

On Fri, Sep 07, 2018 at 12:47:45PM -0700, Dengcheng Zhu wrote:
> On cache issue, what if kexec_this_cpu() does local i$ flush and scache
> invalidation? This is done only on CPU0, no IPI needed. And only CUP0 will use
> reboot_code_buffer. In this way, marking other CPUs offline to prevent being
> sent IPI is not needed.

The problem is that the "only CPU0 will use reboot_code_buffer" part
isn't true because CPU0 might not be the one that writes to it. Though
perhaps if we moved the memcpy() from machine_kexec() to
kexec_this_cpu() that could work.

It still doesn't seem ideal to me that we'd have to even consider IPIs &
the fact that we might silently hang if we accidentally send one. I
really think it would be cleaner to mark CPUs offline & the problem is
solved naturally - we shouldn't IPI these CPUs, and marking them offline
means that we won't. Problem solved, and consistently with other
architectures.

> As to "the associated fragility of needing to avoid anything that might IPI
> them", I hope that's not a problem as the kexec sequence is determined: The last
> IPI received is to ask them to stand by on reboot signal, because other than
> kexec there is no other kernel code beyond our control, which might send IPIs.

But it does mean we can't call certain things, like __flush_cache_all(),
which means that developers need to 1) know that and 2) remember to
avoid any functions like this that perform an IPI behind the scenes. It
just feels like loading a gun & leaving it pointed at our feet - by
itself it's not necessarily going to cause a problem, but it would be oh
so easy to trigger problems later.

> > ...but the new kernel will have no knowledge of whether the old kernel
> had CPUs marked online or offline, so I don't follow the argument?
> 
> [Dengcheng] I meant the new kernel shouldn't need CPU online info from the old
> kernel. The new one is doing a "fresh" boot, provided CPUs 1+ have been halted.
> 
> Regarding the use of play_dead(), it's simple and generic - MIPS CPUs have
> implemented their own play_dead(), which we can use to stop execution. Other
> options may still come down to play_dead() to handle MT/MC details. The concern
> of running it in parallel is really about the online status, which has been
> explained above and in my last email.

But play_dead() really doesn't mean what you're suggesting it means.

What we want for kexec is that the CPU is stopped entirely - either
halted or powered down. Failing that it needs to be running a loop from
somewhere that we know isn't going to be overwritten, and the code it's
running needs to be able to hand over to the new kernel later (eg. the
existing kexec_smp_wait loop implements this latter approach).

Whilst the smp-cps.c implementation of play_dead() will currently halt
or power down the CPU, that's not universally true & doesn't necessarily
even need to remain true for smp-cps.c in the future (eg. we could
decide the halt/power down step would be cleaner to do in cps_cpu_die).

A quick look at the other play_dead() implementations we have shows that
both the cavium-octeon & loongson3 versions leave the CPU running a
loop (within the current/old kernel), whilst the bmips version just sits
at a wait instruction before jumping back to the fixed location of
bmips_secondary_reentry (in the current/old kernel) once interrupted.
None of those are suitable for kexec.

In general the CPU hotplug code just needs that when play_dead() runs on
the CPU going offline, and the struct plat_smp_ops cpu_die() callback
runs on some other CPU, the CPU being offlined will be quiesced to a
degree that it won't interfere with Linux. This is different to kexec
where we need the CPU to stop in such a way that it's fine that we might
overwrite the old kernel, and then be able to start it running the new
kernel later. As described before, that means it either needs to halt or
power down until the new kernel takes control of it or it needs to run
some loop from some location that we know won't be overwritten.

play_dead() is simple & already exists, it just doesn't do quite what we
need kexec to do outside of the one system you're looking at.

> A 'nicer' implementation stopping non-boot CPUs from one CPU might be available,
> but handling code duplication of play_dead() and saving CPU states could be a
> problem.

Code that can be shared between play_dead() & kexec can still be shared
if we have a different callback - the particular implementation of the
two would just have both call a common function for the part that's
common.

> For now, no __flush_cache_all() in machine_kexec() + no marking offline in
> kexec_this_cpu() + scache invalidation in kexec_this_cpu() might be a way to go.

For the system you're interested in, sure that works. But as I've
pointed out in my last few emails it does not work in general for other
systems that we also need to support in the kernel.

Thanks,
    Paul
