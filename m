Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2018 00:21:25 +0200 (CEST)
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:23695
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994663AbeIGWVWAz6Mn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Sep 2018 00:21:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZssHQCCcddGK0YNy/WNG5dxwWpz5C22b3NpLh8OKMk=;
 b=H70zBdJH6XZmKOvxiNVdxF5JpdCtPbT764U8TEb4j4PM5iFLDXLba9+Uz/t453t+32P/L2zF2u8PfLlJ0wdn3rDRVEOrgz5KDurIH2JdzqEialY7Fk5iMg8l0wNX4xZpvhNxR2+xsWNE6y8v3aFgY96Oq9m+q1rMVpMOx9qlerY=
Received: from CO2PR0801MB2151.namprd08.prod.outlook.com (10.166.215.6) by
 CO2PR0801MB2247.namprd08.prod.outlook.com (10.166.214.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 22:21:11 +0000
Received: from CO2PR0801MB2151.namprd08.prod.outlook.com
 ([fe80::c4c7:4eeb:5aa4:a77e]) by CO2PR0801MB2151.namprd08.prod.outlook.com
 ([fe80::c4c7:4eeb:5aa4:a77e%6]) with mapi id 15.20.1101.016; Fri, 7 Sep 2018
 22:21:10 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "rachel.mozes@intel.com" <rachel.mozes@intel.com>
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Thread-Topic: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other
 issues
Thread-Index: AQHURTGC8dvwr/NLxkqUoeL58OaY6KTiTImAgADg44CAAIpUgP//qOqAgACFmACAATIi2oAARJYAgAAH95U=
Date:   Fri, 7 Sep 2018 22:21:10 +0000
Message-ID: <CO2PR0801MB2151111E37EDDB45D93F0F64A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
 <20180905225455.luh32536uei5je6m@pburton-laptop>
 <5B917DD5.6020009@wavecomp.com>
 <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
 <5B91A8D1.4060206@wavecomp.com>
 <20180906232122.wp72jwfnsbb2ps7b@pburton-laptop>
 <CO2PR0801MB21512A2FA3A3A718725DC035A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>,<20180907214232.du2fh422uwzhdusm@pburton-laptop>
In-Reply-To: <20180907214232.du2fh422uwzhdusm@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
x-originating-ip: [73.162.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR0801MB2247;6:q/0YNHsyFyV4Uliy8DBtc1pFW7dP0NeN/Cglkde1a5S8lR/RLfeYMPU/g7hVn0sF9PxdaANGV4narLk/7yAvUVgKPeCsT6iE2FvX7hMSSMHgGOige8xdZVw7TPvYFnui8avmD2JVPOAiFX01KsgviaCnnlK5z4dzAw4so9r3QuIBArTkvlfuJliIpLizmF3YLiKeA8HJWg18U+QJDWw0dGyMyjdJ8sqN/7+JXAB9Ec7IVF6483wWRF8xwHvXJ0TUwh6rpTKcrInoTfBLbiZ4mY7TPHGo0linkGcGzt6VL8YEa0wSP5EhtBBhbRhhwb3o72b7NJGDO3rH740z1ZygEvVz0UPMA0cScxISD19bta26PCs06eWXD5g2+QPOjpj3a+L9Wn3a7IC4Du/KsgUGpi5vYRRbz78+AAlWEzXWlO5WErJZlLr8fgjEh8i1tSKNuyV1ELQ5IgGOXSl6MRgC6w==;5:rPcDxP04FD2dQEDTujA37dkbGqT27el+jsvEv7b+CfKqchZEEhnUebrqCgTzEZHLPy6cl2qVRcLZo7ErdTrk46xl1Y0MarmtvNvaNRgCL2DyICseQ8bVugeymnlh8MtOLJo39vVfdxHO6YzTEhnZnDb75NlgEYZYc3FsEv8g2Q0=;7:5fh9OVPP2SvjO3vaEeHO1G2nEg74bs+Kvr1ODXgnr6Bi25ouUO5SfbJcEUQsUVqwuOpGD882WSF/jYP7V8nRSfTebiQSVUc8jN1LLhHi0NLWjKAkEHXdbEm9ioRy7eR9AMcULd145Oxogwp/aSGoZ7zA/CURdQbKOpIC7d7vAqH/ZIsm9uxhP6cB6tRSi6PpLpHFQjwMhyiYUSzE7ZjORfYZ+b+JNgCMpGdc952abD59tyAYhwR/KY9I1/M02F03
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39850400004)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(54906003)(486006)(316002)(53936002)(6862004)(55016002)(9686003)(4326008)(25786009)(33656002)(229853002)(478600001)(106356001)(6636002)(81156014)(6246003)(6436002)(105586002)(81166006)(93886005)(66066001)(476003)(26005)(97736004)(446003)(11346002)(2906002)(5660300001)(53546011)(8936002)(8676002)(186003)(74316002)(68736007)(305945005)(102836004)(14454004)(7736002)(5250100002)(256004)(7696005)(6506007)(2900100001)(3846002)(99286004)(86362001)(6116002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2247;H:CO2PR0801MB2151.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 3641d28a-f756-4b79-def9-08d615103725
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2247;
x-ms-traffictypediagnostic: CO2PR0801MB2247:
x-microsoft-antispam-prvs: <CO2PR0801MB22479BC4628B41538BBFA954A2000@CO2PR0801MB2247.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:CO2PR0801MB2247;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2247;
x-forefront-prvs: 07880C4932
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ut6rxRBC/TJlqNi31TT2WY3scAUHybYNV6avfSAgkKy74KRkp/2evV7jJ6Z44gqDa+voc4c7pELkdCJ7vUy+LDDC5a7SMN+nLozVeHzBy7zAkjsY/kH8skw8hPB15mSNwHd88vruO7UeVV9EgsyD7rcbO/U+t7vD32cURHGdznNUGMtzoya3pjGVccjKm8AOFUSLdlnWzK3xG9JJY0LHEw2MSPVibu6Q6LUe02t2koOToxzgS41k3EeBYsDfZb+w5leJNPg1pEKynSuSWk5l+v8rkRGz/XKdEpSz+EXUU4U7kFhLYwTC0OiyaNOZ9vdmgezxeWNAZXtwyZgRKXz5XJr+z8f3qbVbQy9Rum1+4QE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3641d28a-f756-4b79-def9-08d615103725
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 22:21:10.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2247
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66153
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


> The problem is that the "only CPU0 will use reboot_code_buffer" part
isn't true because CPU0 might not be the one that writes to it.

[Dengcheng]: I didn't say CPU0 is always the one running machine_kexec().
Actually, in my testing, I intentionally did something like:

taskset -c 3 echo c > /proc/sysrq-trigger

And for "either halted or powered down", do you have any idea/plan for
Octeon, Loognson and bmips?


Thanks,

Dengcheng


From: Paul Burton
Sent: Friday, September 7, 2018 2:42 PM
To: Dengcheng Zhu
Cc: Paul Burton; ralf@linux-mips.org; linux-mips@linux-mips.org; rachel.mozes@intel.com
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
  

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
    
From pburton@wavecomp.com Sat Sep  8 01:12:37 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2018 01:12:43 +0200 (CEST)
Received: from mail-by2nam05on0718.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::718]:6445
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994663AbeIGXMhoRaf9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Sep 2018 01:12:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6TFXe7QB5xWbTn3QyaLYFooZxOGSPku7nnweuowODY=;
 b=YyTTZyZ1UiH1WoxJo6orsvGXD1p1m3pPtJCHFkCIeyVAZxxeSQvXatUZnp38QU4V9sHYL2jgu2DE6QFJlaLquRr4d02wurjVamDfCrcfXP54zhYsGpk+4PTB3rb5nnbcRtP95DYYGOjC4jp+sBJVavzDx/GsFeG9vzXIBqa8lHQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4940.namprd08.prod.outlook.com (2603:10b6:5:4b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Fri, 7 Sep 2018 23:11:56 +0000
Date:   Fri, 7 Sep 2018 16:11:54 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     Paul Burton <pburton@wavecomp.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "rachel.mozes@intel.com" <rachel.mozes@intel.com>
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Message-ID: <20180907231154.hnnhi2kns77hdnr2@pburton-laptop>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
 <20180905225455.luh32536uei5je6m@pburton-laptop>
 <5B917DD5.6020009@wavecomp.com>
 <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
 <5B91A8D1.4060206@wavecomp.com>
 <20180906232122.wp72jwfnsbb2ps7b@pburton-laptop>
 <CO2PR0801MB21512A2FA3A3A718725DC035A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
 <20180907214232.du2fh422uwzhdusm@pburton-laptop>
 <CO2PR0801MB2151111E37EDDB45D93F0F64A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR0801MB2151111E37EDDB45D93F0F64A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To DM6PR08MB4940.namprd08.prod.outlook.com
 (2603:10b6:5:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dec7c0c-21da-418b-3f4c-08d615174e94
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4940;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;3:nGqBDRfqr+lUWfFGqTWPFI4QJuiHoEzXbYsfAKC3vulaQpEgHRRcEhYKW9P9p5dDOEPBz0fzhDqIrAliCD/ywV8WY8P7wztIKff8KmL6RDkgJB/ZCmXEye4XQ2Z5UBvTskp2LYvQx25Ck3bdV2sSohfe5CE85UPxZ2LYSnTr9ey6Kr4DmBblB/6SyWI9ynGnZ2xe66dzuAm9wDG9+YwQhmk9E3vbkPLRGmqnawJVnnCiAYgkBNQ7zrcvZ5MyR2lL;25:Lu1KIHbbPU0j5mBJUiNxD3bo3xzZ6VJI9MX9QZqNRWQB4Omi4VLLNqLquSJtUGfSI8tpLcFfowvMYMnWk/pr+fQhCfItmREHpsT9F9UCeTmUql09vQ2Na9TRdvTAOd49zOandiifXB3iDTKMvKLGzHT0/ldqEW7cZychIO2BNHCXtXyw9VXDp69GZZkOctR4JD5NnxovSDKqYi1C+554rYTWULWcviimYKTiXoNqwmG6yAT13gSCx7xq2kwiI2YVSmF/6r9E2a72D6oYxUyKzG83/ctbEEy3IAZLkh3ksLo2cjIzA2Sq8pSlONNlVYcoBSPQ84yyqeiIb9CpikClTw==;31:fqCc49N6dNaGYShN+WZNxlqAJj6/1XsJJy6+M0+kvJkLsoSKEs+qldLqJax/bgyJN77iLf3mbuuZ3N52KSHPna0HjrRRtWLmyLbClCrwmyad61lpCDPg6aaokY9khreHRBojg0xXTw4T636J3OyJzrGDDiPG2AEPaIzC8Ieb8DpGrcbeC/qjk8WeFV978Kz8ThFhkJbBpgAlZP46Ov6+4a33og7/sxY/+j5vrXaWW14=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4940:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;20:Y/ownOQxx4M0IFGye/vI7Hc7xxdTVzrzb1fII8JakQJ+FaF7IaxuA2NRCKOYAesIZAA93yndZ4MQY+pljJiMz+28Dmsvlregmr6ViW3a+3TFCu+AfXS3mnHfxai8dl3LzQnLgGhoYZ5fkXJOHYFGkZTetoQX8Ti/tMH3J3Fi1L016AcMB7ZNnNaTK4ppEYOQbVKBszVqTDV5XxqnqEYB8RdBg4qJ4b3hERjZPJDLbNfHRI4/REc6MReiyR6f027v;4:4BVGr4wnz5a6bqLbvwEwyCVZGemUAE6D8jpUbsxw/Nm36xZAmzYDrjqjCcYLFf8QehdF4m0p9xCmPEFjz5tbMUV95Urc/UA7B/V0yV2I9CrOCcb/sQOo78AiXSZugdhhCsmfCBR1ph6yMY4+MxhtbHNu7DVRXoeYPfRS7vy44rxoaL/aD/ShrVNz1EbkSZqpIujIdR1OhG+ST/c5EQbu0pTRoKcPnm29WDw11PiO0prqAvfuEf6AQ4jcTgMwAAUo/TgWDfoh6n4CnDRN4Lg8C4SMThlkTro6EXJ8MAHNwg7JXU6cGJDRc+wdMAmCi23a
X-Microsoft-Antispam-PRVS: <DM6PR08MB49401ACF4BDBE61B4267DF6CC1000@DM6PR08MB4940.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699050);SRVR:DM6PR08MB4940;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4940;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(396003)(376002)(366004)(346002)(39840400004)(199004)(189003)(76506005)(476003)(106356001)(105586002)(11346002)(33716001)(446003)(956004)(5660300001)(26005)(33896004)(16526019)(386003)(486006)(44832011)(76176011)(478600001)(14444005)(3846002)(1076002)(6116002)(966005)(50466002)(47776003)(42882007)(6246003)(93886005)(9686003)(229853002)(8936002)(7736002)(4326008)(54906003)(305945005)(6862004)(68736007)(53936002)(2906002)(316002)(97736004)(6496006)(81156014)(16586007)(66066001)(8676002)(6306002)(52116002)(25786009)(23726003)(6486002)(58126008)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4940;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4940;23:ecAUOOsDOfG9DOLs7BMz022V/aNs7uL5L+n+0K8Gp?=
 =?us-ascii?Q?Xt/SPqJHvcx+PjaZxpPbdKYz1EwJpDcI9s4zEjrdFLy6yenYPqML49W6LFMx?=
 =?us-ascii?Q?Ug6+pQ0G5lPvVNLLlT57O9gKpyTZIbfg4Zy7x9HOCXHgRwsWGXfP2Ql2tKae?=
 =?us-ascii?Q?+CZS/hTUXXz+mUODDWEjDuN33R1nIcy1jtUTY3V4KV2ivrmhE4lHqEyPcIlo?=
 =?us-ascii?Q?Gs1GWM74SkN1jdKbZijGDRtpwtRzmP5LPv0gijZdAuI7twzjUS3b8YQWscWg?=
 =?us-ascii?Q?7mVciLnAwAdv8QvXUvTW3z+tikL56nYK9KNYfuVNLtKfJngMTKVmODFltFQc?=
 =?us-ascii?Q?zC7nwRCk0zF58OWI7V2JQEEQGZL76YtfiZG9bMGJDOlBUk+C93RGWaF6DeW/?=
 =?us-ascii?Q?f66d7ZijoWArp90zv7bEF6Stw9mGR/JCKHsRyfEAQo76oJ6/s7GsRnTdMuOs?=
 =?us-ascii?Q?ozRBSI9yfKggnibCYMYAGVeMO42mdXLRMZs5rgpkjAw1clmLa+hdFrjn44Ti?=
 =?us-ascii?Q?ndoHvdSVtThWbP7plM03akF5kXcSnflEaEnQx7dx3QuvTC3XiWm9J8aA/lNT?=
 =?us-ascii?Q?o+3ArQJ+SloGoFubvlarKVVDBYDPc/Csj/sD7zP6HRV+sgm0sgpBxjubUpfp?=
 =?us-ascii?Q?TSFCgvUiVZX2CC8/d8uE3QbHv3zUaod6zk/xvotX7et/WOYbH1EvJcljkxqL?=
 =?us-ascii?Q?wCpez+2QdNw4xYb3nGpCwQhexcFhcqJVCHAUGBbh9/y+cOuak5nEmsnfYBEh?=
 =?us-ascii?Q?OaYFFS0DqFAn4z2zHzcZN8JLndIZEZ6WVFgnAsm7DbCTaCzB+D2jdwLiZRIi?=
 =?us-ascii?Q?OKZP+796ULwvVcDqozgeHmfCYL/2Xh0XAcap6L2PRngmap2vd498Z5yQMuto?=
 =?us-ascii?Q?VcwWlLiqbadDT8lUadPYnFYY7XXQcBtG99YuX8EUIMz3fxqZslm8O14AJ3uQ?=
 =?us-ascii?Q?2RfBWGLiJjpQtvq1Vm+jW/mqvcIBlHUxc+R1skrPncJevFOUYTltP4nSiGMQ?=
 =?us-ascii?Q?4PcLZk9sCfa6GHxaAszLhYFuDOHzltxyqyEs0qTXk6I2S70h+jtH0SUYcgH5?=
 =?us-ascii?Q?LMNfWKLBROw/d72YZNxiaecCNJsbzkQUOVzS0/bdKTkVtYJRDqxDYEfMnvQ2?=
 =?us-ascii?Q?mKlNhOsuFjam3BZ89f+1yNhRsdqrM1K4aT+D+mgHEG6otlUVfzuCAALgkfdK?=
 =?us-ascii?Q?RbD6qOHisTFcdKsyoGPyOjxvYmd6tSXWwn3mp4yyfGbDp9BteR9xYqAE6Q3a?=
 =?us-ascii?Q?CQJeNezLGXl8m+tCKP35ZybdpmdFfoxsVf8Id4U05bS3JIq2Va+jqAo6jsNf?=
 =?us-ascii?Q?cWpxYfg2LVfzlOCmct0+/sv0/NJKUou/H7RM/TUXk2Bp2NN8hLxwNLosEL6I?=
 =?us-ascii?Q?Ck91g=3D=3D?=
X-Microsoft-Antispam-Message-Info: zuVj3KfFLn5y2754iJKB85zgikNpbXcrbPBj12l13pTFRw1qfrwwgEbqVP1qXMDoGeFLKvg/u32EjoiWbJR0nGo28a2mPcfY/gtC+C3OaBp6GM5T/xWaLHwIERBoPQhJXv5dZmW0szHmvrtGUbPuNdEqcTFJuXb4PA+gxOldBQALpJ8+oZ7PS29+017Hrtm8N47MpiMPxfKz00jVmeQQrEY/NPbJ6ufSa2nozKGWDrb15AmppXc0lwoRE8q7nMIG+E6o4e6WYnAtur8/1otB0lmxYBfCTDEcuJhekuGpz93QW/L810ZFN08Ai/M0XNiFkDyaxJAvFXsLKYeF+M9YAZykIUAKtggBlxBsDHferpY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;6:51T67EKHqwEkBB4CkmwaoJKWlZVOgW3to/QzH26BWVDz+bzNAK+ZoU7B/lVa7AIDYgNtR6WMmVTpQoaPP0reRVhBrI2+2rAz+sPaans/VyxwqtKoroqrYhuxkQ0/kXwOCdxyo+PrFSis/Ldei8+eFKpij0/a5ugXRoPUnAlzjSHsTcG23hvjNpUY3C24GJqKY2b9oi8qCHCEs0AabLBvg+GRGZMBthgGP2MUBnyYJWgLqu7qfOrSqxX897ZaEbP7BHb31cFStFjB+K9gC23fBe+Veq7oAOWujC9ev5IOto2TtAZeCZDw61g9grl5HCTYx5WIO/fgenk49ZPZjkj9Kpuiwl+hzCxQzM/WAzJt8VAaNb6fuQse1uINBo7gF7wz49NWHRk1NxH7f6T232GXxUXZ6FLnBqSy3PwOHP3zg+lrwHmuoJSNR0TC4LN9J3kMGNhm/+DBo4Jx5EOailkTHA==;5:Wli04Zphm9rm7LFcG35vTU2Ny+Pe7jvOtaDPt5+is02HCobdnsmzXksItIKaln0tkWIo/RJNejjaaL0JxS2Xg6/B0P6VDTd9EbOFq7i9D8/ZEZWfyHFwm7ijchGZzJN/vPYzgg/6qDSf0P7H3JZCOE2O36FDLuM2zRX2yBSSMdY=;7:r1auQhJ/s0MYuWQlbDhEK8IYu96nqMjBFZQ8tP0kt52klKdn4KrFHfc6lBHUisozXVV38/lcZnYfewXX1zerMYCrtS6IF6Sb1ZRjSSj27kNAytlClAEfkCOWUEWM59utd8nZi3RE/Tu24q+gom73otaaLPM+MTdEugGnCYe4T1dWtq7IyG67eekz+8sg6ovcdTHlE8GSb9Csbz9M9Ii6IZ2FipAO6DUGTm7+zadhv1LKhdphzmGxOtQ+ZeVYuCUb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 23:11:56.5102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dec7c0c-21da-418b-3f4c-08d615174e94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4940
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66154
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
Content-Length: 1837
Lines: 44

On Fri, Sep 07, 2018 at 03:21:10PM -0700, Dengcheng Zhu wrote:
> Hi Paul,
> 
> 
> > The problem is that the "only CPU0 will use reboot_code_buffer" part
> isn't true because CPU0 might not be the one that writes to it.
> 
> [Dengcheng]: I didn't say CPU0 is always the one running machine_kexec().
> Actually, in my testing, I intentionally did something like:
> 
> taskset -c 3 echo c > /proc/sysrq-trigger

Well, if CPU 0 isn't running machine_kexec() then some other CPU is
doing the write to reboot_code_buffer and therefore CPU 0 isn't the only
one accessing/using it.

As I walked through in an earlier email, the safe way for this to happen
is for the machine_kexec() CPU to write back its dcache as far as needed
for a remote CPU's icache to observe the stores. Having CPU 0 be the
only one to do any cache maintenance will not achieve that.

As I mentioned before, if you're testing on I6x00 then you probably got
away with it because the icache fills from the dcache. You'd probably
also get away with having CPU 0 be the only one to do cache maintenance
since the CM globalizes hit cache ops. But not all MIPS CPUs would be so
lucky.

> And for "either halted or powered down", do you have any idea/plan for
> Octeon, Loognson and bmips?

Well like I said before if we add a callback to struct plat_smp_ops to
stop other CPUs, at least in the crash case, then we can check that &
refuse to kexec() on systems that haven't implemented it.

Octeon right now has kexec, so any changes like this should bring Octeon
along for the ride by implementing the new callback there. Loongson has
a patch pending [1] so that should probably be taken into account too.
bmips would just be left alone, and wouldn't support kexec until someone
implements the new callback.

[1] https://patchwork.linux-mips.org/patch/20432/

Thanks,
    Paul
