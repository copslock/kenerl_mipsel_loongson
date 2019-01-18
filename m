Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C26C07EBF
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 18:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6F20850
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 18:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="FZPUtIYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfARSjv (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:39:51 -0500
Received: from mail-eopbgr770115.outbound.protection.outlook.com ([40.107.77.115]:47456
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728644AbfARSjv (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 18 Jan 2019 13:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQvCzTl5GNPSbEvD1isunw0cE7YpSfKNRYa3z61jfDY=;
 b=FZPUtIYZZFpkYsAmq4kIXQRfVlD1n7hd4N+w6uS7Jv0pPQkt9lE5lqM0uYOFAQ1HZapzDOqC4hWylM6/Jkg4ztWkm2+rp6mzvrK/1HUQagGoYoHfITsAR3r8TAM+umceYX7PXtenD0zyjuGcMV1JKEDhyvnujsgAMAc/ufKiyUE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1183.namprd22.prod.outlook.com (10.174.169.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 18:39:41 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:39:41 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 07/17] fanotify: encode file identifier for
 FAN_REPORT_FID
Thread-Topic: [PATCH v5 07/17] fanotify: encode file identifier for
 FAN_REPORT_FID
Thread-Index: AQHUqYjygU/xMgxTL0q0Ep1acUEY66W1Z0SA
Date:   Fri, 18 Jan 2019 18:39:40 +0000
Message-ID: <20190118183939.tasdhobwtqxkjukm@pburton-laptop>
References: <20190110170444.30616-8-amir73il@gmail.com>
 <201901111612.XzUbwDyo%fengguang.wu@intel.com>
 <CAOQ4uxg+Zk74XqPMNmrEpR13Wr9r=8osOrHVAhH1De9UMFmRoQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+Zk74XqPMNmrEpR13Wr9r=8osOrHVAhH1De9UMFmRoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1183;6:tsHGsx4VtzxXSiTSKWHtjGX8lxmdwdKXaPEOtXNbJ8xFuYmxedg2CD4i26iYJLJVPBscrYgfw99P32fUUdLQN3Hyg8lgLxW1cCC3EJHzYhFxQbnsAVbYRsaarqWb9k6iGSAxHfEOeKdGeONFolcdFYaxvt+kyNREKiEoVNxJPhmc8diNoS4nJTyzm3DmWAavPsSWtSNjDqtFOxQetWoPb91M+v4VT5wKBAVszFEWy0Jor7xOPf81+yp7ixIGvV5Z7ATVd1ggPnmsKo3A3mG7HafkMWW8OSf6jQWC9vlOEMPMosyPJdpitw2ETNVl40uxEiAROikx9VBDyak4opYtdfcObemwFcgGASgI1dmzZpgaTwxLJ068ENR2t3KSxwElCVIKM+QkTT+vsYg8e47QHxSC5BA5TCD51p3i8Ai7D9ajZiXQ2kTyeJZ3phADFNmUeI4PqAaM+4OP4kzxWEQ2eQ==;5:SoephLMMnNUX9gHafkTS6zJbT25CqWYlVX3c7lw0NSKSVUoIAl17DQbu/IWwiZv+jMDkUB+4Ehawy7IqA685ipV7lulPHj4SX5fY9YYRy6B3HS+uZdsdWYy6qf9vG5Yk3Hfi7g9VrUt6rTNiEwAf33dhhdfZVWbUUjzUPAYYHb2ehtBsGAdlG1rSP/3y8pK/b8qUQEBk/cocpEAlbwwrpw==;7:gJEmVb3zPZ/DkPP/gmwF2fLuU15A+YOtXNGXkYZmkNmT5HJQQguLcfJB/khUy2fxX2qDf0tbfgfUf3DJg9vgiFxHRamOh7eUqrLSxAMrOVyEPrD7zYBhn+Oku48+1BiugpOvEX7HDsb8Gt4JN/GcOw==
x-ms-office365-filtering-correlation-id: ff82cf71-b8d0-4033-8ed8-08d67d744e6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1183;
x-ms-traffictypediagnostic: MWHPR2201MB1183:
x-microsoft-antispam-prvs: <MWHPR2201MB1183562DC3FD6D2E4509BF23C19C0@MWHPR2201MB1183.namprd22.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(39840400004)(396003)(376002)(346002)(199004)(189003)(6916009)(76176011)(7736002)(6436002)(102836004)(478600001)(99286004)(386003)(14454004)(106356001)(26005)(186003)(68736007)(6506007)(52116002)(6486002)(5660300001)(105586002)(3716004)(966005)(97736004)(305945005)(53546011)(33896004)(6116002)(3846002)(33716001)(1076003)(66066001)(4326008)(39060400002)(44832011)(486006)(229853002)(6306002)(5024004)(2906002)(14444005)(25786009)(8676002)(1411001)(81156014)(8936002)(71200400001)(316002)(42882007)(71190400001)(58126008)(256004)(81166006)(11346002)(53936002)(54906003)(476003)(9686003)(446003)(6246003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1183;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: At0eqeBz31/SqyrgT4uH4g/OFGb101QdsA/7b0OtYSFfz0RmO1HvXwBmEoExmHzNCAx55fJqDf1Q6FyNtHDVaIwG+pqeGreoHtVB88zBS/adH/lkukf5KSGHwVyyg7l7cQaexASC4arDSfRnrnNXW7VUXMlarr/MaY0/5yhUGNkgIn/fzr8VaqhYW9ZrVpH1JEGhrez7p5HsKOA6ROwULdYIvTE0vxadAArDdYHoF6pdN0tROzaUuJdkwYtBrzxsVdnFbHUoO4bm/8MWnh1eOpBZLjbUxZXaUmET7g9D6kOWd60G9LTzMS9HToFO1zLHaAvgHW7XTCHkjqzn0McsMH8j8wwTMt25K8tMLb5y1kPfJfx5+vnONLcjiqrWRwHPu780xS9zk6E1i3tCS8ZeslnL4GEV88k8uGTeEqYJYcg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35826B42C5E440459811D11F6AC6B7FC@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff82cf71-b8d0-4033-8ed8-08d67d744e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:39:40.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1183
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Amir,

On Fri, Jan 11, 2019 at 10:37:39AM +0200, Amir Goldstein wrote:
> On Fri, Jan 11, 2019 at 10:11 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Amir,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v5.0-rc1]
> > [if your patch is applied to the wrong git tree, please drop us a note =
to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Amir-Goldstein/fanotif=
y-add-support-for-more-event-types/20190111-090241
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=3D7.2.0 make.cross ARCH=3Dmips
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/kernel.h:14:0,
> >                     from include/linux/list.h:9,
> >                     from include/linux/preempt.h:11,
> >                     from include/linux/spinlock.h:51,
> >                     from include/linux/fdtable.h:11,
> >                     from fs/notify/fanotify/fanotify.c:3:
> >    fs/notify/fanotify/fanotify.c: In function 'fanotify_encode_fid':
> >    include/linux/kern_levels.h:5:18: warning: format '%x' expects argum=
ent of type 'unsigned int', but argument 2 has type 'long int' [-Wformat=3D=
]
>=20
> I'm confused.
> __kernel_fsid_t val member is long[] on mips arch and int[] on other arch=
s.
> Which format specifier am I supposed to use to print it?

That's a good question.

Here's another: why on Earth do we have this custom __kernel_fsid_t
definition for MIPS at all..?

We only provide the MIPS definition when _MIPS_SZLONG =3D=3D 32, ie. when
long is the same size as int & the generic definition of the struct
would have an identical memory layout anyway.

So I'm tempted to just delete this weird code - the only thing that
might break is if someone is doing something that really expects a long
& cares about getting an int of the same size. For example if anyone
prints the value with %lx or the like - essentially the opposite case to
yours.

I consider it pretty unlikely that anyone will be doing this in a
MIPS32-specific codepath such that they've been seeing the custom
__kernel_fsid_t up until now, but does anyone see a problem with this?

Thanks,
    Paul

---
diff --git a/arch/mips/include/uapi/asm/posix_types.h b/arch/mips/include/u=
api/asm/posix_types.h
index 6aa49c10f88f..f0ccb5b90ce9 100644
--- a/arch/mips/include/uapi/asm/posix_types.h
+++ b/arch/mips/include/uapi/asm/posix_types.h
@@ -21,13 +21,6 @@
 typedef long		__kernel_daddr_t;
 #define __kernel_daddr_t __kernel_daddr_t

-#if (_MIPS_SZLONG =3D=3D 32)
-typedef struct {
-	long	val[2];
-} __kernel_fsid_t;
-#define __kernel_fsid_t __kernel_fsid_t
-#endif
-
 #include <asm-generic/posix_types.h>

 #endif /* _ASM_POSIX_TYPES_H */
