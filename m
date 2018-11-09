Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 19:51:05 +0100 (CET)
Received: from mail-eopbgr820105.outbound.protection.outlook.com ([40.107.82.105]:43212
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992289AbeKISvBt9O1W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2018 19:51:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orloLLzakIqVaOg6EyuIacKHgl1nGgdkEca2fI2CSgM=;
 b=BdWVwdmeHMuSZmDqIJzmcrZq4IQu83dDmFO4CQiOkwcTB07huXpsXY5km9HV3Wo0AMNUmae+ki5XPx0nEZnnUBP7LcFsBHreNHoWlfmp20nGaPGRui8/nY0WawyiF6UI2PjkokLjY+XVJFj1gbN2hQFA6v/HTZyXYLa++zmw4jc=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1253.namprd22.prod.outlook.com (10.171.216.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Fri, 9 Nov 2018 18:50:56 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 18:50:56 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [GIT PULL] MIPS fixes for v4.20-rc2
Thread-Topic: [GIT PULL] MIPS fixes for v4.20-rc2
Thread-Index: AQHUeF0lzsjGqcI/jkmahkpPrQm9fg==
Date:   Fri, 9 Nov 2018 18:50:55 +0000
Message-ID: <20181109185053.p4hy6whjtdj3gq4o@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0036.namprd21.prod.outlook.com
 (2603:10b6:300:129::22) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1253;6:zN16eMR6bXj8SrpKFBuoECYQknwSzuJH3da7iDu/vk+3CkzpE933hhXPl6Hqquc6ADI9RSOYGIvLqw+tb9XSwBK/7tuW1kCR6kl+RqSzBOlIDsEmtZmMzZ0GC4KLP6Pon+GbplNwm7bsorDocnzkyUnhj6lo6Hd6edGsdl501wXmLaI4W2tH8YoGND0C4qYLd7HixAs0Ao3BfbJ2pAx5TpeDcvoKd6hJp8p/QsW8nojFNkrB1IBedd72VaYHT3eAtGFbhLIgf9m0UA6Y9ots/+D/cNS722YAKQF63EuOGOiyEw8W+NVmwJ2wTYecS2BtSbggmj0kvxHt6thClr8YYBXMpRq5zHZGsK90n7Pv88r1fxyslS8wMiyDCAzHG7f9DjLVwInfMOgzJe6eAuzSQE1UJrhcS4fQEeHNHkmMqIJt5W0gi60alev2wJMZhTcXSK6nP/PpozP+aF1sxd6IGA==;5:nITvie5pSrXa/nYjJiuRwmg68r13Lo8daID6vGA5noRwS/hfGduxmEk8/kRr8A5JG53lIzRVbLpDSQCFZ1neOis9yImzKq2IEfupF+2HF+TKcqgvgFZqeJvqH5kMBsNTz6MZ5E0zTHfYI/zGuqyM8KAtzNItK8EKpsVZkX3SlJs=;7:OXCOeE+kRZl4Q3VMCo5TAAReCVWzlH/MtwCqlewCAp4qBScjJ6IlnjuoyNfNqd7f6lv5DVLdyhe6nupkec9n/n5/1Ess8zCKBS782Wd/xRugYa7jX7KRvJmROVISJC8ULaQ5euzxUvdw5sBR14Z5Pg==
x-ms-office365-filtering-correlation-id: 8eb657f7-d2c4-4562-1d78-08d6467447b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CY4PR2201MB1253;
x-ms-traffictypediagnostic: CY4PR2201MB1253:
x-microsoft-antispam-prvs: <CY4PR2201MB1253E34E30EBFF14066FB7B1C1C60@CY4PR2201MB1253.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231382)(944501410)(4983020)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1253;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1253;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(39840400004)(366004)(136003)(346002)(189003)(199004)(186003)(26005)(5660300001)(7736002)(316002)(33716001)(305945005)(97736004)(14444005)(256004)(2900100001)(8676002)(6916009)(53936002)(8936002)(106356001)(42882007)(14454004)(2906002)(54906003)(66066001)(58126008)(25786009)(508600001)(81156014)(81166006)(4326008)(1076002)(105586002)(68736007)(44832011)(476003)(33896004)(71200400001)(6116002)(386003)(71190400001)(3846002)(102836004)(6506007)(99286004)(6486002)(486006)(6512007)(52116002)(99936001)(9686003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1253;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: E2pvSvrVtsoIsABKyq/HIjNbnt/GKDWD4ZthmjTnnm1t7oABgjCFxdWCitx/6XFJZ1svvKZ2iSov6hEdirGX6BCFRVZFuFacS0lE6qA9iJfDJYQHPNr0IVIFzsm4ztih9Rt9rsDFIqLkGlF495+Mspzyjr4OvFsInIo0lUmItgTlKt/iEj2763cpa+96OdF3iXFH4RDfXYA28p75PSitCdowLQCdXeZd+1/VjKsOB27SODTVhqFb8PfWYROEWtN5qPdxTp2A+aOF9gzjntZ0GQDm5Hb6YoctFUh7iJSY0aBPOd4O+kCJSiDO/eGlYTc5KqhgUNm+yD512efIO8BiJlttCNRDBPmUlxVvAMnL4To=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zfn6zmwtblbqtwzp"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb657f7-d2c4-4562-1d78-08d6467447b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 18:50:56.0223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1253
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67193
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

--zfn6zmwtblbqtwzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are a couple of small MIPS fixes for 4.20 - please pull.

Thanks,
    Paul

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.20_2

for you to fetch changes up to d01501f85249848a2497968d46dd46d5c6fe32e6:

  MIPS: Fix `dma_alloc_coherent' returning a non-coherent allocation (2018-11-05 10:08:13 -0800)

----------------------------------------------------------------
A couple of small MIPS fixes for 4.20:

 - Extend an array to avoid overruns on some Octeon hardware, fixing a
   bug introduced in 4.3.

 - Fix a coherent DMA regression for systems without cache-coherent DMA
   introduced in the 4.20 merge window.

----------------------------------------------------------------
Aaro Koskinen (1):
      MIPS: OCTEON: fix out of bounds array access on CN68XX

Maciej W. Rozycki (1):
      MIPS: Fix `dma_alloc_coherent' returning a non-coherent allocation

 arch/mips/cavium-octeon/executive/cvmx-helper.c | 2 +-
 arch/mips/mm/dma-noncoherent.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--zfn6zmwtblbqtwzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW+XXDQAKCRA+p5+stXUA
3cq/AP0RqiNtiFNNVJiwJBsPIO6/lOex1CJnZcPBOgKwBT8QowD7Brcq2aoBWLDZ
EfINB9G29zVOuxP4EbuAlTa9PTm1mAE=
=tFvh
-----END PGP SIGNATURE-----

--zfn6zmwtblbqtwzp--
