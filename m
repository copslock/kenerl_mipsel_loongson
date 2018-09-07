Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2018 01:31:19 +0200 (CEST)
Received: from mail-eopbgr700099.outbound.protection.outlook.com ([40.107.70.99]:26160
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990411AbeIGXbQKQT26 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Sep 2018 01:31:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Lde2ZpDmCl5hrPfWRl84gBrxp6On6dKWTRgnvAheLI=;
 b=c4EJppa5koh/lW8wEtPUDJDJrSdAD2TBwCOaw7KpmnnFxOAQUkEz5WU9VomMVX9Crz15Xwa7kb2pRabWvzuqH5jXs5lT3xSTSOHJFa16LScSU7uMsugSsFU5etFgAaBBiCgzunkRnVE9f7N6LfzXXBebeKvgnhFVzFR+gEBpj5g=
Received: from CO2PR0801MB2151.namprd08.prod.outlook.com (10.166.215.6) by
 CO2PR0801MB2344.namprd08.prod.outlook.com (10.174.192.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 23:31:03 +0000
Received: from CO2PR0801MB2151.namprd08.prod.outlook.com
 ([fe80::c4c7:4eeb:5aa4:a77e]) by CO2PR0801MB2151.namprd08.prod.outlook.com
 ([fe80::c4c7:4eeb:5aa4:a77e%6]) with mapi id 15.20.1101.016; Fri, 7 Sep 2018
 23:31:03 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "rachel.mozes@intel.com" <rachel.mozes@intel.com>
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Thread-Topic: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other
 issues
Thread-Index: AQHURTGC8dvwr/NLxkqUoeL58OaY6KTiTImAgADg44CAAIpUgP//qOqAgACFmACAATIi2oAARJYAgAAH95WAABEBAIAABCKP
Date:   Fri, 7 Sep 2018 23:31:03 +0000
Message-ID: <CO2PR0801MB21518DC2B1D4993DFCCF21E6A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
 <20180905225455.luh32536uei5je6m@pburton-laptop>
 <5B917DD5.6020009@wavecomp.com>
 <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
 <5B91A8D1.4060206@wavecomp.com>
 <20180906232122.wp72jwfnsbb2ps7b@pburton-laptop>
 <CO2PR0801MB21512A2FA3A3A718725DC035A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>
 <20180907214232.du2fh422uwzhdusm@pburton-laptop>
 <CO2PR0801MB2151111E37EDDB45D93F0F64A2000@CO2PR0801MB2151.namprd08.prod.outlook.com>,<20180907231154.hnnhi2kns77hdnr2@pburton-laptop>
In-Reply-To: <20180907231154.hnnhi2kns77hdnr2@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
x-originating-ip: [73.162.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR0801MB2344;6:awS5HQRFtO+T85tVj1LJNgPEewGJVXu6mFdpBMl0q9YSbXS1W9/fHDIzUfVco9xFIkOGNeXYpR5/zQm4+Gr1vD4ubMikkPjusLSvxO6yy5eFI/lx1V/ngaQNP4dTzMGnMymWvO1IU1yBfODHptAfiQncKI+3WQRpzk8c5zYnsfFbtrydd7NsKNI8Zz0sF6Zw/4emkw5xcNv+YX+UzX3ptT4ACLsiNBRFscBUexyFbyIred4pJGxUqk2zrXATEjzt4KpY2oi4lRGeMiBU0NBM4xHD/cEXmPJ/swAbZI2RsWKUvtSmC5yHgqrYm0snE9QHoCDyyMV+OvKK/yVUNzztjlV+ko0/6pEc75OJcRz/ktHdoc8B80M4GnWXyGiJ5r9dUXd5lDLgmil3r2xBUFBWAFokwME6npWC4aY+IxySmRxBR8wTxkxhEIymo3Fo6G1+ELVUYEg6KvhIaT0zdi7HYA==;5:Lf6grY01fonJEFTwGRGlUn5yzUXYYaN1N9Ya27aZUR/8qlRkyyP63SPHS0jSue5OUSl5w/qGIf/SNrDZIMybqU7d8pMTczGG23DdsKBJXs95j2zZI/Je33kjgX5HtwkPjZQjjdLdLwELXwbFeV4ckVrKbTVelz7c3i1BT7PSwWw=;7:kxr0PuWUlkgXPyRiKuLxwwFbbmb+MJPDzsC5blQ6mb9q0knJUyp+0OavWzaW80/5aP0upM0xvBEGpx6j9sGLFrb+I52+eGJh+Ew8D1czhXw8elH1kAQmzHllYmlNmVKLWj64ScPR0X7lSdyMISYFWUoYQetmmGTZRyJ5Fx0rirY5N5SzzZNq3WrC2oJsSPFS1aXBadL/bvi0rQtbytQ4Hf6XTrC9eTbDR6hyv59bUCMMNtHcTMICcBPiO4uo+J08
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(39840400004)(136003)(189003)(199004)(966005)(5250100002)(3846002)(6116002)(93886005)(6862004)(97736004)(6246003)(14454004)(478600001)(6506007)(186003)(26005)(102836004)(53546011)(68736007)(6636002)(99286004)(8676002)(5660300001)(7696005)(76176011)(54906003)(316002)(74316002)(86362001)(106356001)(33656002)(105586002)(8936002)(66066001)(25786009)(81156014)(305945005)(81166006)(229853002)(2906002)(53936002)(6306002)(4326008)(7736002)(9686003)(55016002)(2900100001)(11346002)(476003)(446003)(6436002)(486006)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2344;H:CO2PR0801MB2151.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 3b3d353e-cce5-413c-d2b9-08d61519fa09
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2344;
x-ms-traffictypediagnostic: CO2PR0801MB2344:
x-microsoft-antispam-prvs: <CO2PR0801MB23446DBA1D5C427F423F0A1FA2000@CO2PR0801MB2344.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050);SRVR:CO2PR0801MB2344;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2344;
x-forefront-prvs: 07880C4932
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v2dC2R8OZml1BWmuWm5ZcKIfSou7hexH5LDxwBNJlwnOIZhDOdwQmLTSlKF0VeSqL2CV9n7bbOiVib2V6i5xfvuTg0Cb0KzmDiBvjtKs7Wky6/zctPdpUzaUqdlKo5VH1woKP+BOomGICGJYtuHCHk//rsm6qjOpJ6ELb6F2PYFuo1gPPeFoAhsULauNPDVd6ajbq2gm4wZOh5OeyTzShWpRihmwe2z9p1hFTsEYG/o2nRB50IXGJrCPEAV3WI/fXQQ73ouBxmsz4r+wW3lw6dZRM2UCCQ5U25LUldS5JrXDg0bS+SN/T3rGC/la7v4axEd5SpHhKg4BU6ZSbtb90BuN4ono1QUBrJ0tYphRKa8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3d353e-cce5-413c-d2b9-08d61519fa09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 23:31:03.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2344
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66155
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

> Well, if CPU 0 isn't running machine_kexec() then some other CPU is
doing the write to reboot_code_buffer and therefore CPU 0 isn't the only
one accessing/using it.

[Dengcheng]: I meant only CPU0 will jump to reboot_code_buffer. This buffer is
surely possibly written by another CPU. Any issue with the machine_kexec() CPU
flush "local" dache, and CPU0 invalidate "local" icache and scahe before jumping?


Thanks,

Dengcheng


From: Paul Burton
Sent: Friday, September 7, 2018 4:11 PM
To: Dengcheng Zhu
Cc: Paul Burton; ralf@linux-mips.org; linux-mips@linux-mips.org; rachel.mozes@intel.com
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
  

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
    
From alexandre.belloni@bootlin.com Sat Sep  8 10:17:39 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2018 10:17:42 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:48469 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994059AbeIHIRjBHzYG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Sep 2018 10:17:39 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EBADC207B0; Sat,  8 Sep 2018 10:17:33 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id BF3B6203DC;
        Sat,  8 Sep 2018 10:17:23 +0200 (CEST)
Date:   Sat, 8 Sep 2018 10:17:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        keguang.zhang@gmail.com, y2038@lists.linaro.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rtc: mips: default to rtc-cmos on mips
Message-ID: <20180908081723.GB2598@piout.net>
References: <20180828142724.4067857-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828142724.4067857-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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
Content-Length: 587
Lines: 18

On 28/08/2018 16:26:30+0200, Arnd Bergmann wrote:
> The old rtc driver is getting in the way of some compat_ioctl
> simplification. Looking up the loongson64 git history, it seems
> that everyone uses the more modern but compatible RTC_CMOS driver
> anyway, so let's remove the special case for loongson64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/Kconfig    | 2 +-
>  drivers/char/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
