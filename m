Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 22:35:13 +0200 (CEST)
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:19904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994641AbeIFUfKB97OQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 22:35:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhyhNfFeyijyUYSNfbNirnh5kHIPsMHYWnpugB8mfH0=;
 b=Q4cKyQbTD1+Jy7AH7TQUTS6+ONETIXLu2UNwYRRmgYtHM7Z0sl20wnfIbnly4NJKW87tOQ4oAklTsYOp/BVb0WvDvfxXZfZKXU0IG4w7DLQeLsPBs9DA7AX5dBIA5G5gwpjF8BFUZ1JlbOBGQIUh/kg88o3yiCgUMS0wDRGQqec=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 20:34:58 +0000
Date:   Thu, 6 Sep 2018 13:34:55 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Message-ID: <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
 <20180905225455.luh32536uei5je6m@pburton-laptop>
 <5B917DD5.6020009@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B917DD5.6020009@wavecomp.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2201CA0071.namprd22.prod.outlook.com
 (2603:10b6:301:5e::24) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fda2aea-744b-4c27-3f09-08d614383693
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:lHYDHAJGvHVREu7+C5lgCmuYJqUPK3kFRcSMVw49Gv+YlNN1CeXyobcpZbmtAQjptcwb3RGnf8RUzQe5CuR8Y8Np7MkWmNz2oYdT7aTdV0CFWMePzV2VPFJxXn7SJbtqzct7hkCoExva27khDEt9AMC046M467UinOoOIA7yCHHfF2ftum3uttT1HXkxqK+mTJ1X4C7BkOTGGGhvZ0DHi1D8+4j1XpQirMjJE8M6Hdq/a+8FerA5+hDEpOHipamT;25:KyfXlzap+y8TwgpCLnDQV/HPzkXIY8+uSBJ3wfLs4Q8WBoPwNxf3XHUp8qY5fO4A7DTcSxjFYfgztgjn7SkSfQRLlAYwTG/QPoGOiLYK4yHdIvCeQGhvdFPGR3TO5sMBwvDwrgjHVW95QuiG3IycQtZq6Jk4vAObRwhsHC+egAJtUlZa/AhcjMcg6wOfPM3u8P43TawUQlE1ky/GEPpeoT7g9sNMIMe36OaIeb9bLk2uAVTA3N34CoBw/8JRZFYcf/wWvd5JqCTS2vI+BpMuawcXOhAs8tos/nFKUedkAeuqWNK+K10CPRFKoxjomUvoIwLT+E9s3FW/qjcNUiZedw==;31:W/5Q72GkM4a+9ZmFtvgVupzEyHQGlE/eZeHLHZkRdIwgCxyl+ki2//D5kUsPxCgO2b5X3F7dAhh6zd7BzI6W00g1kTjhNQP/VsBtewboA+rxHTwuLlDdIal1WYvf07bsvfg2r+B0z/BoGJ0FBXhIDMz1mjac6z5rpES3/WqnhVaLdsHvS9O+DvMQ3t7r0W5vcS+FDIY0HX0DuvryeBDoWRi2PCmZfQzol9Osw+Y5Rzo=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:tqY03TwIo6/L+phsrWuZAx0n9JeaqX1HjAFyNBAEHkzgm9s7tPUw5HJeCrz4UPyo6VotrKCrh17t8PVL+q/pH+jq7FgJfJMm7N/MtmsR076X01T29QPTmZVlVtHGtGTj/NTHU+vRbJjyfoOjRvKjrSgyhYsLdpJGPTdqBdQox7uyhdKHcPNhl/riC48YdIr/9WJcUNUr67bU0vOJ2n3/mTK0ldf5gxWcVBvGntR/dw/BavOaeoh4QAJjaSNcB2SW;4:GWqWVUYuGMaT2Jj5r3PtqGO+IQWoECUi4296joCGAPYjsNka+kVEJADdaIJNpOlyrhNjbRiLMscA0KZtzozBbeCdmpWNl+RvIefM0NMmZFheN//wrnagOym4a5hE4qfk0+DYk5Gaiwb53ZBsRps8FujT8COfYFldUqTpvobqEj7hYkNYxSs1EMu+0cYgd6lv4zEhjkRx2nW+o405gF7maOo0pP4rBspsIZmJtLDCE/FHNjmP5Ptiw5ndDbBb6UWg4QaHYl3SahaM4yBMK3lAxVa0Yheai3Esb8J6LMgpBNsPaM5z+X+cvElCTWbuqWYN
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932BD4736E817BF2B1F82EBC1010@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(136003)(366004)(39850400004)(396003)(189003)(199004)(52314003)(43544003)(4326008)(305945005)(5660300001)(42882007)(486006)(6666003)(7736002)(956004)(476003)(9686003)(44832011)(33716001)(446003)(11346002)(105586002)(76506005)(58126008)(106356001)(16586007)(14444005)(33896004)(52116002)(76176011)(6496006)(23726003)(47776003)(66066001)(316002)(50466002)(6486002)(97736004)(6246003)(8676002)(229853002)(1076002)(3846002)(6116002)(26005)(16526019)(2906002)(6862004)(386003)(8936002)(81156014)(478600001)(68736007)(25786009)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:wIyj3nreaEWoNgFlZZNmdmlQeepsIpAbsR2bucDjO?=
 =?us-ascii?Q?xyBNQ7Ft1JwDcDIqsLW9Hfo4OfGklaxZ1955lUn7s6/Pnc3Yw0n/YzlmH4Cu?=
 =?us-ascii?Q?igjeklhOjRtUeVqHPrdJfMa20fpoMcHhkioUy4Lbl+oeWpkFON01yXgbk/d2?=
 =?us-ascii?Q?vi7RGc94yBEUC/y9QNkHLp8l2+E/5zjGZIMvyuFsK72kG2tYCNWJ3NM6csk0?=
 =?us-ascii?Q?kECB5SJWYrX0PPVlGmqyKEulRZsitnnzESbOY1i72aeBXygDXUFf5KOaviu1?=
 =?us-ascii?Q?XWtiJA5Uz2y0FjzdynDmtGYknL3fsCpFUCSLuVIPdR3VDVFgiN+enT0JrOGQ?=
 =?us-ascii?Q?ENI/+MMRbp5OPzj/ohCgrh50Syqs5eNg28YhGNvWpvj82nFYI2sqeC9jMTQk?=
 =?us-ascii?Q?k217zEcUtoucKL62XL2kvfxC8PwEG3/Bno4j7DkcCPksmqKGSJSJp6+XJkLQ?=
 =?us-ascii?Q?j6WYjc0n5oQ5yGKK1WoAeJ2DUaGYFExtao19Z9DaboGFYGVVSil7d/9t9j3d?=
 =?us-ascii?Q?TavIubxrMy1cOGK+b0HaPrEIRhOc7Bg8V0P/OVAOOwoWy8NGn2RBamQ+BKFW?=
 =?us-ascii?Q?ftaT1TI/eiFb0YSatq61WNDHKonkI9zKJ7i+SgMl2y4MoXwu3yDZZKDUrFky?=
 =?us-ascii?Q?gKN98hBq4z+mgMX3rlk/ooRk1XtzVbnwVM9uizS8WgFYSXsOnQwpDSRSOAt0?=
 =?us-ascii?Q?AEvnhSACCGqSq84p61H6SO2WQ238SKwPqcIF07A7c+2MAuJFXoXgoZYYxtF/?=
 =?us-ascii?Q?slvaasYNWq+OFH7/tYn4gszq7TY58O7cMTTOcr95pqgdf7CSJc5ggJJt+2Px?=
 =?us-ascii?Q?JyKJDLzSda9zcvsZZ9UBP8leWiEaw6ICCrO9qFcrTsh177HSgwofMs7/WLLp?=
 =?us-ascii?Q?P1Y6CJmDf6UQ8SjNthE2xgaYcIX7C9Gn5X/dFrxhMhCX3mDYRTTsikwhBITS?=
 =?us-ascii?Q?z9eO8C+mZ7Aqa0Y1MZx/fOl8S2AdAzRrNDSfAiAzKGxCLTrLTcK9CKQBKZNE?=
 =?us-ascii?Q?5/2QiOTBL+RAzb/RW/S5Z+Z7HawjrcYYmFe+1sBEwmG1ghwuEvpQ0H4id9Qk?=
 =?us-ascii?Q?DtotiRxyDYxJtxQ2hQAlHSt7wAalv1DsQB5vb2jRDkHgPAiTz467HfgFOUaI?=
 =?us-ascii?Q?J07I3tpxEq280sn7cp/znNeGC2t+RRll+q5Zz8znmyPpm3D5ecXxCcczcn9Y?=
 =?us-ascii?Q?M8J7jnYKMA1SX+sdhvBg0arxe5QkbY0zYoObmLQCSzv5ql5KJbVqu5buPB7p?=
 =?us-ascii?Q?vJ8qBwLth81hLDz4OS0Tx6zhuyPIvnIhq9B04mUalARgU9KrFpLWVcITqZ+O?=
 =?us-ascii?Q?m3kQjEmAzZH3jOSaHTYmxnA9zRXcbTd7/yK0qHi1V56?=
X-Microsoft-Antispam-Message-Info: yinUIs7XUZLAh2QyOqzdCrvIMPUS587wrHIGOQivlWPE5yhV3u2jFUjBR9XC7+jpWVtoZWrEQgNSkedbedtIpHbRZv7+kWeKiyFemumwim4C9qXH8pKeYdkmSHRlBwMgbgbEcHGMsmWqsC4RTUZcveaMTo6iKIvLmKeNvTAhJ+sQDDe8ewTzc9mp2d0THOpzlZnSvdUfGEbmQBKsi2liVJoVoxDDuy7Wuig9fiNSO+LcXqrodOYSzwcc4PgB8Om2QPwjbvQwZd0nyQeFAS8nZiTNzdOyP6ZR5z9s8gfOk9ZqGx1qkup47XKscl8krOIDeyROrfCl39X6GPQ+kqgqoWnw56djaVmrkF+6TpdS0Do=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:+zOJ9AAplyaVdCz558OgQcIlEuGPXcRRUEHfwN+nv22vs11SQLlugW8qnnILhrTI0jHqKA1HoynSm3lc7iQE4KN3U6Pxrfh6/+ULst1NgzH/i0xM4gwzj4uf6A6NgSuvKHA3XN+dddsIedWizn1vb/tvvrVDhEQiplGnF1H7S8Y7bYA65COxYCJDD/JBXj9/vAc872FQ2dLeYIcP6TI5Cvh4t8kUj9os86SIKzF2s68cfcNZT6wr6V7JaKwYAOPNk06pDpoORHbibp98ZNHmzOXHgHa9tCzSxT7sWRwF7CMZ7y1JG3mkWtRVgGo8c3ZAPu45SPVi9DLhbclI4eztssH07KagVRt3WGTcyLF0tartPSNk6XGFuv3IP5QCFbMSi3hFSBLhkbDtHjKbecHKhC+I3ZcuZa3purNW06GrZ3IOEdJgn915f79HvHOkLtuCHlHmpcM6L7S5o5/GXl5sEg==;5:W/z1Z1fal71tLdLS7H6/rBIbf99oSBrxAokyFolNd4D+R5eT3X5BE352FdJP83gb0Z/1nz3OTQ+c7VmNUu6NUhWz7n1g1CSn4LobEllydQ+2irjuEzlRaJQj7k1wZ+/5gdOIlsalpygRHV5io3fYKIjOarwIe4D+O/PgZyIircE=;7:wLV7Hr0/mUV5t60JuTvoPDT8mynW3ZqD447jTmjw6hxaRwTeqsQ5O4h1/NurhildQSG4TDcAOWsEtGpFA8XlOK9Ha8oFNd2SMBiuGJEhAY/Q4375ouI9s2eKFEoFJf+pX4eOuvld9oqlJFQWfJJk4GxU+tw5DqMj/wLIMMv5jE5GaSn91CvAu1vNY7vxKjql5rx9V26vxGp/4bi/zfabKh1adWZk155JhlaNRZng1hNUr4b/GyW4IlEKrag3gZ2A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 20:34:58.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fda2aea-744b-4c27-3f09-08d614383693
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66076
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

On Thu, Sep 06, 2018 at 12:19:49PM -0700, Dengcheng Zhu wrote:
> > I didn't apply patch 4 because I'm not sure it's correct & I believe the
> > changes in the branch above should take care of it - CPUs that reach
> > kexec_this_cpu() are maked offline, so they shouldn't be IPI'd by
> > __flush_cache_all().
> 
> I believe patch 4 is necessary. As mentioned in the code comment and patch
> comment of that patch, machine_crash_shutdown() is called prior to
> machine_kexec() in the kdump sequence. So other CPUs have disabled local
> IRQs waiting for the reboot signal.
> 
> In fact, in kexec_this_cpu() [you renamed and modified kexec_smp_reboot()],
> the added marking CPU offline will cause system hang (tested). This is
> because it will change how play_dead() will work.

So the problem is that patch 4 isn't really right either, and I suspect
the hang you mention probably shows a problem with the whole play_dead()
approach from patches 1 & 2 too.

On the cache flushing, what we really need is for stores performed by
the CPU running machine_kexec() via its dcache to be observed by the
icache of the CPU that jumps into reboot_code_buffer, which is always
CPU 0 after patch 2. Using local_flush_icache_range() will only ensure
that the icache of the CPU running machine_kexec() observes the changes
made by that same CPU, and does nothing with CPU 0 unless they happen to
be the same CPU or siblings sharing caches.

Consider I6x00 CPUs for example - patch 4 may *almost* work OK because
both cpu_has_ic_fills_f_dc & cpu_icache_snoops_remote_store are true, so
when the machine_kexec() CPU writes to reboot_code_buffer CPU 0's icache
will observe that & will fill from dcache without needing it to be
written back to L2. It's still not quite right because if CPU 0's icache
already contained any valid lines within reboot_code_buffer (which could
happen speculatively) then it'll execute stale/garbage code.

The hang you mention is likely down to the fact that play_dead(), at
least the smp-cps.c implementation of it, is written for the CPU hotplug
infrastructure which will only operate on one CPU at a time. The loop
looking for a sibling CPU just isn't going to be safe to run on multiple
CPUs in parallel like patch 2 does. That's true of either your original
patch or my modification - it's just that my modified patch will cause
siblings to race towards powering off the core, whilst your original
will cause them to all halt themselves & never power off the core.

Which inclines me to return to my earlier thought that perhaps we
shouldn't use play_dead() for this at all.

> > The CPU that runs machine_kexec() should still
> > flush its dcache (& the L2), and then CPU 0 invalidates its icache in
> > kexec_this_cpu() prior to jumping into reboot_code_buffer.
> > 
> > I'm also still not sure about patch 6 - since no platforms besides the
> > arch/mips/generic/ make use of the UHI boot code yet I think it'd be
> > best to leave as-is. If we do ever need to use it from another platform
> > then we can deal with the problem then. If an out of tree platform needs
> > to use it then for now it could copy generic_kexec_prepare() and deal
> > with removing the duplication when it heads upstream.
> 
> Understood. It really depends on how this problem is viewed. If patch #6
> is considered creating a framework for future UHI platforms, then it has
> the following facts:
> 
> * It doesn't create code redundancy. I mean, it does not add unnecessary
>   code to the kernel.
> 
> * Out of tree platforms will get access to this functionality by a simple
>   "select UHI_BOOT". When the kernel developer of an out-of-tree platform
>   wants to make kexec work, they will naturally look at machine_kexec.c,
>   where they will find this UHI stuff, obviously telling them to do
>   "select UHI_BOOT". Otherwise, unless they google onto this discussion
>   thread, it's harder to know the solution to the kexec_args related
>   problem hides in the code of another platform (Generic).
> 
> * It simplifies work if the out of tree platform wants to upstream.

Well, ideally future platforms will just use arch/mips/generic rather
than adding more platform/board code at all. Right now the only reason
not to is if a system has a memory map that doesn't fit nicely, which
should be resolved at some point by mapping the kernel which will allow
the generic kernel to better support differing physical address maps.

So I hope we don't add more platform code anyway, which would make all
this moot. I certainly don't want to encourage adding more by explicitly
making it easier to do. And if there does come a point where we need to
add more platform code for some good reason then we can deal with this
at that point rather than speculating now.

For out of tree platforms, I don't think that copying the
generic_kexec_prepare() function is particularly onerous anyway, and
should be trivial to remove if such code is submitted upstream. Whilst I
wouldn't want to make submitting code upstream more difficult, it's
likely to need some amount of rework if submitted upstream anyway so
this doesn't seem like a big deal.

I don't think upstream should be particularly concerned with making life
easy for out of tree code - if one wants the benefit of their code being
taken into account upstream, then one should submit one's code upstream.
In the paraphrased words of my pastor at a marriage prep class - no
benefits (except those already conferred by free access to open source
software) without commitment.

Thanks,
    Paul
