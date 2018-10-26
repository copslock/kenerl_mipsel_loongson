Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2018 20:45:45 +0200 (CEST)
Received: from mail-eopbgr700119.outbound.protection.outlook.com ([40.107.70.119]:33770
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993041AbeJZSpklKu1c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2018 20:45:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pLWNEzv72N0D0xeUF2TOmVlAV7UlAJZ3tvpfocCtao=;
 b=FXxKnj1aCUCUsUU189inh/iRt4c34dxttO7DTEH11XJnil99KuHqx6xxb/HhNFtq0sW57gng3CIEJk93MS02EhrO0Ey8tO9jPiJNoT1rk3BH2HXj2EfbNpL/j12L5w7ZXgq/8h7cxQq/DE+4XKedPiw8m8Gc4xM6VjXl6VLMLyc=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1486.namprd22.prod.outlook.com (10.174.170.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 18:45:29 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 18:45:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: [GIT PULL] MIPS fixes for 4.20
Thread-Topic: [GIT PULL] MIPS fixes for 4.20
Thread-Index: AQHUbVwQCSHdpIzj9U2dIYU9+LmtvQ==
Date:   Fri, 26 Oct 2018 18:45:29 +0000
Message-ID: <20181026184527.2awmb6p2xm2uh3mj@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:300:95::22) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1486;6:55mGC96oZGf6pCuWQDWbe+skHlase+BV/Abh/Iw7GfMuHOH5D7HFXw9kONaxl6Inq9q5oo/vW4ra98GAh5uUV/B29D6aPQatpQblVjLs8hlgHSZ4tC06dGQfblOrSKPX+ym/wQOMRlBfuL7ZdimY0ajsep4M7yxoLMoa+gA8JOFXiV2P/A/RzMM2QQDexFtTKPIFjDnu+DRuo1t70Rn5kEoYtj1Ru0r4yYji64T5k7jb1kl1kmaqoM3cNWRQ6srJjugb0utUpOKXtiMnRZiKXNYhpN+m51NWdcbnS4RddrPetI8yPR7BuWdB+8dnGqnBImVesu6Jo8RhB3DuQZMWsHCamIo6B75pB3YL33Q2+brEFWp1aU93qb6PKEm/TKcJw0olci5zFmvhISeKKDKip8Go0h1Z+imSURr8HV5ntBXAaURpIOVvuQtO+1H8BK8RJLdr0LdshzC5TqN98ZTbyg==;5:bzF96sMgbKQwHZIKhe0gVvSdL/2nyfjEnkGDIqBfy7OfcIazFfLQwl7pgD9Z+E7mw2TkjHL5NgRnBbp8hmQLtl9tZ6U3JzHT7XdL2XPwXxpQFRJnjkvRNW8Q9uEqqZN4u3arIoQdI9b3D/rf5Pryirm4CIIBAvKLGKEjijzpYxo=;7:+8vaQlTHr7tF9e1g7+RPsoIBSkde9Qe3vN1gRmlNe3Gt0Vwuf5yiUc5wFeJPsNMsUYN5VcjbFqYc+6EhY3PLfCnLgzaSuFyff9X05erdEUmnpYB+DaOtN9x0bChM1hJ0VxwuJYHudJs/qDwgUEk0JWxeOalfxZ/4ZFLtLYggjI/DHhnr9TYaKHNKe0LzT1JaM+XJ6+9C021JQbYm45WbvL9D2sclcjFL4vhXXrvzNCb39S60J70jmjeM0vHzKVHH
x-ms-office365-filtering-correlation-id: 0809b697-631f-496a-4cb2-08d63b73332c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1486;
x-ms-traffictypediagnostic: MWHPR2201MB1486:
x-microsoft-antispam-prvs: <MWHPR2201MB1486958AB01C602C71DB0ECDC1F00@MWHPR2201MB1486.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1486;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1486;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(346002)(39840400004)(396003)(136003)(376002)(189003)(199004)(4001150100001)(14444005)(5250100002)(7736002)(316002)(6916009)(8936002)(5660300001)(54906003)(256004)(8676002)(81156014)(66066001)(58126008)(186003)(105586002)(71190400001)(486006)(476003)(71200400001)(81166006)(106356001)(305945005)(386003)(6436002)(42882007)(44832011)(52116002)(2900100001)(14454004)(102836004)(6506007)(26005)(508600001)(1076002)(6486002)(33716001)(99286004)(68736007)(33896004)(9686003)(6512007)(25786009)(4326008)(3846002)(6116002)(575784001)(97736004)(2906002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1486;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fcqusvDb8k6KhtI6xUWhx+yMlEE0XUKBsvPmhriVqTlsdMPsAT12Mr4dS9JPnMz8GAbJCODo23s13qmsM30tKj8L0tw0IpIkMYOx6D8655gl4RB5fuhWtpvm4IORhs8qBiHELncvrb5lt0tw5allZ7Wux4liYfmKw0vhDri4DqBDFwS6RclgLvFccJh7PVQNedT8wcSz6uiZUszNqsHKntkI5XHAeVm0shCu6ywX+DlhZZwvmpfjCzeGs0aeAsBNVD09mrMP5NCZ+IKD7tAHkaLOtYzMgVHKZPs01S3V4YEOfzUMkehCAEk+qcjZJF0GDNEm80HDOSHvqUYg9C7NkH8FWrrBNWYZVEgsK37QAqc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FB8FE7A3FE3174D8190B91D61300A0F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0809b697-631f-496a-4cb2-08d63b73332c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 18:45:29.3189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1486
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66957
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

Hi Linus,

Please find below a couple of patches which in a perfect world I'd have
submitted a week ago for 4.19.

I've sent this separately from the main MIPS pull request rather than
rebasing or merging the mips-fixes & mips-next branches, but if you have
a different preference I'll be happy to do it differently in future.

Thanks,
    Paul

The following changes since commit 148b9aba99e0bbadf361747d21456e1589015f74:

  MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup' regression (2018-10-05 09:41:39 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.20_1

for you to fetch changes up to c61c7def1fa0a722610d89790e0255b74f3c07dd:

  MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for 64bit (2018-10-16 09:47:18 -0700)

----------------------------------------------------------------
A couple of MIPS fixes that should have ideally made it for v4.19, but
hey-ho here they are now:

  - A fix for potential poor stack placement introduced in v4.19-rc8.

  - A fix for a warning introduced in use of TURBOchannel devices by DMA
    changes in v4.16.

----------------------------------------------------------------
Huacai Chen (1):
      MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for 64bit

Maciej W. Rozycki (1):
      TC: Set DMA masks for devices

 arch/mips/include/asm/processor.h | 2 +-
 drivers/tc/tc.c                   | 8 +++++++-
 include/linux/tc.h                | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)
