Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jul 2018 21:23:43 +0200 (CEST)
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:19762
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993008AbeG1TXjpRSa- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jul 2018 21:23:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V+CFjtD6Gb2UnK22cB6RTZh5XhlC10kQl2q2Hfe5N0=;
 b=VZuR2u6pPsOtYYC71kxKuYZJQ/02+LNyW1FIpQn9AD9Uj1y+Nku+BwWIgJKOed1SeIOwJWuW/ltgHV4ZjIFnLTzwqj7vwRPFChiuRglNbj07p3VHXwMnCHKsBmXjwvRxiUNuQ5G8NMF2EolIppqz+Pcq9oIPp33yJYDFScSqDX8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (96.64.207.177) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Sat, 28 Jul 2018 19:23:29 +0000
Date:   Sat, 28 Jul 2018 12:23:23 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: [GIT PULL] Another MIPS fix for 4.18
Message-ID: <20180728192321.oyo53exlvm2j4zkj@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p7fhczricb5qch7a"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Originating-IP: [96.64.207.177]
X-ClientProxiedBy: MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e28c3db-3089-4ae5-d526-08d5f4bf996f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:TGN/uZrywCxtPb1pBXvgV6HnTKYq0oTXdXvqjknKDiPRWr8rPICoNAxrHeeDw+8jU5RpaTA7g29YJtw48ItBu+MpPoS6+vj/n1WzbJeosoIyxwkb0cZRH0uTtTy0RQEIXt8ezslYKsM1E+zF6b1aue3UmFv3MoP8MB5PqMhQLwAVe5UJtamOw11amWrL90TQSBDbV4x2hMq7FlA82RTtb/mUcpzQdUO6sAmsh17q98x9X+FMvDPurg1qL72DNDe0;25:Xan/9Isve5IX5hwaAMF/GiovvJziFs7S0905WXGL/lXuNxBPL/IndmCUkfceLmutTktGsrnrrsvYP8aFWoj62xKC2cZIf9dKjk3iX9HebC43cHZ47ZXbDTQXpYRD1CJ/RQyYllyLaLbQ+NqdIyycqpAc1S66XIf2t+f3uYaMp1ywi4Eee6jirE2ElajUyeJZJoMlaAnTX6v6D/8RMoTfKc86ECqQ1+EJX6D3ugSwqLcKh4c8qJ+n8S4WUModsvqUfyIDc5btb3UvetKSTeBKxwmxSYrKgeMUpMSV54lUnfaD6C3rJSKYBH8oli7SBMn1VeLK5/uzA1hxiHSU50ZH1w==;31:3LBBPru/FXM1ChNeB8ILf8I0qhnOh7m3R9ur8rBgYXU2+aHjjx5oTr4QQmbCU6+b2gsGiaagdOrdd30SbNLZ74JX7eoKoeRS69qav+Q5Qla1zsTOGJ1h2URk2aeAlD7q/aySC6KN/vl8ex6FIXcCwTuRmOSAT2U+dO7iqC9yq0gSI7xaryfZmurl0qoBjVMz33NOFMd4grPROoMeh2DS2t1tMYeZbp7t2x4L8luNy5M=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:0RvQ9Yky6P1FOe5TXJ1Gfr5LAQ6V76Ybpf0dLmy1saNi6TcLfgckVRNJM4vfg7gNs9TWRTFWT7TChpE0XiYkcTzAV0hJulbVvsu1eHhjZ6cK+Zb1HB1+T75sT7FrZZ3ACuXgKEj7NQ7fStnZgf7+o0AyrbGEVyyBRSUm+xpWm/uOvmHJ5OyXQma2PJUZU7wv00ft5Rd3o3kgUKgbTwI2Dpd/vj8CFP5kOryWhWEMcoYWx46NgkOBPGceBhqPWGts;4:aTT3oveB7i5vM8ZM0LnJBRxHXkV2IY4R6k67l1ws1+kxzEO4gdhWDKEaD76wfJ2aN7rB0F2Aglktna/AJ+hkTGTX9dMnVHLi4GycthKRdT12UOOr/vA5Mth4kk9TgCkAtnaK1hJ46AZix1Ut9T12NxrrGzLI9VxQb5MbYS7RkvwlkI6IH4cWkUpcjG8SOxXvwAYF/qchK6eqxGtwEqRB0to2pwi8AaiFVPlp34dHZN02p4MTOep2aWd7k8giHopuhjEjtCesZhejEHi98HMG12kG2pnTHly9Vx8+8SviV11F8u6Ka1rqd6DbC0Kf6qEc
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929738AEBDD59D3A4FB914EC1290@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(396003)(136003)(376002)(39840400004)(346002)(189003)(199004)(305945005)(6916009)(8936002)(53936002)(186003)(6486002)(16526019)(478600001)(2906002)(9686003)(81166006)(4326008)(25786009)(33896004)(8676002)(81156014)(26005)(386003)(5660300001)(42882007)(7736002)(6666003)(21480400003)(97736004)(6116002)(3846002)(106356001)(44832011)(105586002)(76506005)(1076002)(66066001)(486006)(956004)(84326002)(316002)(58126008)(16586007)(54906003)(476003)(33716001)(6496006)(52116002)(33964004)(68736007)(44144004)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:3IQXGEnF3uOzIYcYrAmP0mGb79laYwET/w7mHPeYs?=
 =?us-ascii?Q?vgLySWceMbkF6y/U5OoYuw+g77fCzERYKxL3uVcaBrEYpbZm/EvmB7jj7Hwo?=
 =?us-ascii?Q?zOH4vx0+aX+nUdjyuuEESNJzq4pU6yAXoXOG0gcywhFV2u1LFdR346prnjVq?=
 =?us-ascii?Q?VoBDC+uzpPFTgrP0ms6tYP1rW260HYqZ8bzRbcqIQx+LrLWFj3WaKhG6A4AA?=
 =?us-ascii?Q?WGT2w3B2g0MiH1Z06IlMxbusxuqWlK9HmcJXKYEghOmUroDU1rrmFoQdcjKl?=
 =?us-ascii?Q?j+qD6N25bPDg3TfI5FPC+5GXSRNggOtxmxPz9mfdU1WwS3xxNir5hrduo2yU?=
 =?us-ascii?Q?qlmsPOClYcaKqgWXcLiToatVGyYmIiLEA9ZDU6j9pjLt5sMSqgpuL/26bCTu?=
 =?us-ascii?Q?pa8g4HRg7CzBsdDVWXNgyLjdrxP45M5/OjGQAd8NYFLoAxIYWuTsXUXT0gKV?=
 =?us-ascii?Q?CLgeegcwrewas8Dzrkzt/JuzldQlwM2iRVqcD1VwCVkL+HWrZeUixxqipwBX?=
 =?us-ascii?Q?L5mJ+1If15KR9n6DpBC1756YiSVyAUUT4BsWoXa/EIH3RQcIfHxq7/OefP8O?=
 =?us-ascii?Q?zwxoOe/bu6I73u4sHaR18NkzzV35/ZyOKKZdCiV6wd1pTbQeqb7kJVeU+gHM?=
 =?us-ascii?Q?e4Efndlt+ToBTZaXYXT3iu+CbTlo7WIjGkrttnsHIofFgUvQZkGOMkQG9QPz?=
 =?us-ascii?Q?t7vT4LN/ueZeR/fKWOjWYErk2N0g3sAfMX7OQtncyb4WlPKZoDvfnN3XFXEk?=
 =?us-ascii?Q?jgCBczEVkNAlaAULYqBocVglSe0Eqn/32jiq/K/3dj0jCdxoekI8SQkpNu2/?=
 =?us-ascii?Q?VVzxnj/CIb2oPqCqtAjXIhOfsM76PvvMtL2Zbp4Wnoi7bBaf3P4I1LpUII05?=
 =?us-ascii?Q?Aa2dcg3f3ydIrjEpK6LLvP7BjTxJl5D/NMIfF6D5lsenVNeMSu3mAKWQAu9h?=
 =?us-ascii?Q?9ZZXdpshv1qef+923P2j8jRTVDY/gNtrwcxlr/QqacnzWVIpJmxZlRRqfQNz?=
 =?us-ascii?Q?Tp/CIgF8kGUlu+PUr/jcE727dckN76mdRaXYV2+SK94rv9zfoG+NQmi6Ob53?=
 =?us-ascii?Q?xagGtFPSYG4T/XonYNFnD8EetKplsMNcSvmzNlrZVp+BTrpKYiSHQMmNIy0t?=
 =?us-ascii?Q?KMGiE0AwLbLck1y7y/V9oxNnQXDRJHJYO0WQJwatTgINUG3l188dBJUue6EM?=
 =?us-ascii?Q?uJe+WDMhUQTVoUZOBxttjrP+nbzYhN1VOJxHH/pJIdCW/1kw2TyihMdswnSR?=
 =?us-ascii?Q?YNbU77Gq5yDr1IeLv3Kit/O6XyJZP7aTuU/rYgz?=
X-Microsoft-Antispam-Message-Info: fY/zlr6f3+pynmWVNax2ihSNci80ZnScTNLf4Sn/IFSqjVBbse6RV1Vt4ZSF94LMl2ohoURLL958vM6TO6iQE+ns4dpk7pbeuNNXZvfONi3SBf+zWo7JiS8ugJicu74fnYXS+rarPRs7SpO6ef0yor9HISSe3JK5/GkZMd38MHmyhuoEGSG4mw67Z0Vn8oRYhyMN1Ojs6xwXZumTHP089FuJjyzDKWB5U90TdEn0Dly5LbiAZ/PKydCl7Me+bYZopK1Xuh59QkBnn33efHsmZA0+/tzUtiAcazJRFvSaDsSax4hOAs2B6g2xoiaZQaOuumn7gUS+BkvCWjG6UOq+kZXLvtYYXs+e59gH7NX54XY=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:eSFXZJA3R7m2j6ddBSW1PZAjWvHiRanWDdy8G68HKgkUqxzCpZ9Uedbddn3LBGA0OVgnOsXs29Rs02wsin9JciBwN0Yy/uareAbCdTj34xJn24ci/H1YR1Mfho2SQIkerNoyefuRjhGx0RrbLsGh0AOXTpqRCtJkwto+Ys6AVWXO5j35ohDPquFEG31vxjHRH8L7wfozmxcYE86MnHG91cVP7wIpCzmmszB/Z1u4UmlOvB8/H5U7oM2y0IBCtCtygsAO1Uk3Leov1dluHmF0LkxNwTvJGRe7S+cVbt/zeC6RgXP4txgOgtQH4fN5Zwlgd0ahfNmDySD4NwoQwOarURCCnsCieVJ4kOBjPYaYEFcDNYiHYFllNzJiHBIONeHnJVQjQAdXmkvVYjqGUgtmZWNI+vTfH1rBdQSn5d8nsuZ8YjQZu8WdrjS1n42obWP59p0FOJTU+yV5wlqkuSP7OA==;5:kuiP0leQ1CL4f3/kqXycpKSjTt7PPPeIAeBGQZouppQCLgMtqJBd/xxE7ujzQZBFzl5hJmMrz2I8yKMQ6xZq1qlU0q/F5VgoksFwOcF2VFJmXMR/jQzGSBQikEmmPhn/wO1qrlVCaxn3iXTdebxG8mNa6gXnPrjPTweZf9lPA8k=;7:32Umiq+q0FJKhnyA9T0KkeFeIoBT63cS4Ar5vT64JB2sJi4f2MSPn3w7fU2alRlEQTjZvCtygTpU6NOUN5G6z0eY7YJifDba4uSJE2X+gvGbalW5SHRcoOF6ia3QBXCpFFGFdv+vdchYY9R8dbAwZVaLMXOBnlTZklHmi/p5quQkuqM6LDIlNA6jIrobwWmZTLtgujqw6LRUzF5k3lg9NkD+lyTR34tBJHzxbiFQHCZfAOmAXEjVc0BtDJ+A3bia
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 19:23:29.0467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e28c3db-3089-4ae5-d526-08d5f4bf996f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65224
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


--p7fhczricb5qch7a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here's one more MIPS fix, reverting an errata workaround that was merged
for v4.18-rc2 but has since been found to cause system hangs on some
BCM4718A1-based systems by the OpenWRT project.

Please pull.

Thanks,
    Paul

The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fi=
xes_4.18_5

for you to fetch changes up to d5ea019f8a381f88545bb26993b62ec24a2796b7:

  Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum" (20=
18-07-27 10:07:32 -0700)

----------------------------------------------------------------
One more fix for 4.18:

  - Revert an errata workaround for the BCM5300X platform that was
    merged for v4.18-rc2 but has been found to cause hangs on at least
    systems using the BCM4718A1.

----------------------------------------------------------------
Rafa=C5=82 Mi=C5=82ecki (1):
      Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"

 arch/mips/bcm47xx/setup.c        | 6 ------
 arch/mips/include/asm/mipsregs.h | 3 ---
 2 files changed, 9 deletions(-)

--p7fhczricb5qch7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW1zCpwAKCRA+p5+stXUA
3bLvAQCYXJDMeYx2qQDHdzZyIC9DKdjuyVl6RPqPqq7TAhu+YgEAwxRShhrDgtab
Ou5IuhpxMqH/4KvRWO07OI/+cQWCFAg=
=Zsri
-----END PGP SIGNATURE-----

--p7fhczricb5qch7a--
