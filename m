Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 02:09:22 +0200 (CEST)
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:21152
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994243AbeGYAJSObtVJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 02:09:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ2fHx0GX95tTm1ZqyVdvULD2Ie+qmoCxGPevPsxAwU=;
 b=oe8hWBJ1DiAAGfv5pC1EEH0gDrUAMehWSsa4n9a18i/iNKnXFcbyXUwxub9lOg+sI3vv9UTqtXeMW4mlKlnL8Lq34aPuCOWFGbQ82+xXCQKIYGLVoFeAysPAYu2tKIrpc63huUF0HArRHxbR1EPb0UjdgT3AAfP63W5oLV55A/0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4943.namprd08.prod.outlook.com (2603:10b6:805:69::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 25 Jul 2018 00:09:08 +0000
Date:   Tue, 24 Jul 2018 17:09:04 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fixes for 4.18-rc7
Message-ID: <20180725000904.o63pxdkhxxbt5o22@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xifqwmxgkbdfue53"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR12CA0062.namprd12.prod.outlook.com
 (2603:10b6:300:103::24) To SN6PR08MB4943.namprd08.prod.outlook.com
 (2603:10b6:805:69::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eee1304-3e07-4f6e-563c-08d5f1c2d759
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;3:Zn393lTTN0pjQ7+L+dMO8wbgYo+Mq/fkviA99BHs9yMmaZ4boXXYPNrnezcAiBTKR07CXS8RzBC+CLI+xmJSaEw/sCbC8kOtEAp8To1J6bbrfmWl7smHiWNmRViBLWlT28LfVkum6RCc0bkQMotOBogRhA3ptEW/g8eausht8f5CELQJkd70NTfm1zQDEivlUzMaJTQlbZJfiJ681bUSK+A436ycjOUYjJf+FN3s9sm0wLcmAsZLqpBqdmrPBvtS;25:15vUDtfqkQPYoxt6xRYeF4UzDfHZ39UR6EOYaN9I7Vc/wdG0i53K/9AfOhPiEcE93UwTh2CA55iPbEC4cj1gBAg2j+3xvSom9UtdtqCbElI+XQ25QRDbPTsubnAR09S3+cge8fSmfSIHc+aMr6V4kYDa2WrRvw//Isst15FZaBZvnOk3ogT6YrPQXlvHhomLbSscmdBJt62T3c8UwI6Q1m8YJhSbBO2SPd+/guE5oxDFSechYc7P5PP/b+x6+as9Gx9RJYpyMZwkMFcucJZOso3CFRxrq5cPXY6RIrZ16kP6qScC3bjfxYyMVapcxAWX2O0jxPDOS8mgtrD6hnNVQA==;31:gHgDrIs3N/qVPi33lCRSwoMjXmCN2brSdX3qDUUJBnvgUyLKfAwbKSUiOK29dQvaWYxwjIGqz/hcHKa//VW0twAbowh7jv5bhiI7KXjrDXcabeBatjt3JSlNhvHePnLNop65sVx1toenFbdIYFLmkTkUzzj8+PauN7T8Mf6twSqRPPYjAJhaj6j0N5+BuxbjCOIWnvttuzMos2gOXOoZPqAk14Su8tIRrFk8JnB/bjg=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4943:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;20:XIlDHfVjPimk7woygd+ROOiZjHNNv9okL0GVszrfE+ylHKJAny6GHu1ym26RRZ9nMLYeLREKyD7dVt5QU39NKum31xtBctHBMCTE708SA9dpOT0xXvnxw1Gp8/SuqGDtrq6azOtSoWrhRyt8G4G1nVMrrYQx9jVqb/jmxIBqP1ZupsLOBCmhwki2S8knl5PK1B/hgMwMw2zsUGfWhkGw+JNSntg76cAzaZc+J0FeNItNxE7v9u4fwbE68uByQP2n;4:vu+Qjf3+Ob9DoI4+m3UuEzqIWJDI94iKsVMSbvvpmjbm5fQFY48BmQWQj4Pb3d9mK5lBNXZX7NGccX/0poWFubpW2QIgfBB98vTv3+1bSnnPpb+H/4LlakHskWSX4S50zMKaLSbCmk1fB43POhbp+tvDHUJV5UvUjPyBHERuH7QLoeHLjOYJJcbVCGbUFdj1mUbyVTd3fN4SwbAgN/3PegCeezG/vspPj961PDVV2DJlwvwT7YzHMmLyxnxkWsInNAr8O7MJpOFO6l7OQDUMHTu0Z5WfvYGKEiVg8aiwew051Q3SppHRHiYGmAPrlstnyswRXXGySuzolvqPGDu1nRHWBZyWCVIeinhzsEbD3oY=
X-Microsoft-Antispam-PRVS: <SN6PR08MB4943B666483DCE46DFDA692FC1540@SN6PR08MB4943.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4943;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39840400004)(346002)(366004)(376002)(136003)(199004)(189003)(106356001)(25786009)(84326002)(4326008)(76506005)(97736004)(16586007)(58126008)(21480400003)(5660300001)(53936002)(8676002)(6496006)(105586002)(9686003)(8936002)(44144004)(54906003)(81166006)(44832011)(81156014)(476003)(68736007)(33896004)(486006)(305945005)(66066001)(7736002)(6486002)(2906002)(316002)(3846002)(16526019)(6116002)(186003)(478600001)(956004)(33716001)(6916009)(42882007)(52116002)(386003)(6666003)(26005)(1076002)(63394003)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4943;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4943;23:HY/e36xL6aejyFhwxBo26lBD5v2v68KKqrVLYVelW?=
 =?us-ascii?Q?AMnW0jrbJk2mYLsWJFqr2hsk/op1uNXqc0kSHth+lBBgQA7p1ZBPXbqn/jU+?=
 =?us-ascii?Q?MJWjAmhcXbMztG4xX8Lt4Rvxu06y1H95kjeXqN+iGt99m9+NqsbmIXU1+JlP?=
 =?us-ascii?Q?PjfLnsuRmeEL7fEJ5Htc7mA7LHzfb8F7WDUNZMCq1icNH9ip+HCd7EkQDLte?=
 =?us-ascii?Q?saqDTGNardCoTLI4UBwp+cl9j2c0zva52BJMbNZtT7l0n8jHoOyd3vSINzlP?=
 =?us-ascii?Q?fuDNuMk63PBMuz7hZE43b1UaUzqdyFPx6I50wMcigbFTadFYIyecG2OHuuTk?=
 =?us-ascii?Q?faAGHLOaICKdgORPu/Q3ESniIR+GK84CE0r6FbGXHWkdPcJ1u0PkOp7lFo9Z?=
 =?us-ascii?Q?o4x8TvRv2Pp09mCxg7hhSmgafXk35vKbEqoX61XZ7BmuW6YthtfpMcIN6WdU?=
 =?us-ascii?Q?NvKNdpCQYMnWXXDGnm62zQJYttzF8w07NFYlS0ODKjr3KYmxDhuBI0ilx+Rp?=
 =?us-ascii?Q?AYHt9/5/COhwOHNSF1Os1kRAr1BwRPpKM8fjulJ3JVqnDjdv8eBgODA534T1?=
 =?us-ascii?Q?3ififqPqkDHX4zi9JUisjYGUqu1VDp0IWP4S/o4079wJ7Sf+/2bE0B/OGmLx?=
 =?us-ascii?Q?d67j97S2bszFIdut5dE6N+AFjuQVVP/fSVqXcCn487Akwc+VznOUENY3yGct?=
 =?us-ascii?Q?892lvT/pjXngeFtwCpYbZKY7yGEd1yBYUabMJd8299J49dZmIAGy9RglWrFC?=
 =?us-ascii?Q?aJ6QPapppBnQAsMMAKR3vCtPxvehGGrxPw+fimzSNma2Ix6LNL1wk1l+qOLV?=
 =?us-ascii?Q?mctTZ+AfD41hCKs7WCpdy6N9ebTGBhbTxmepZcF9od9+v24bXET0Xnr0OTdU?=
 =?us-ascii?Q?u26NUzleZZduoYOyKmIUY9b/fRN/kwSFhWwNM+Z15rGmPrvtrwVdxWcmpS9V?=
 =?us-ascii?Q?jJQ31TXe4gtwSNCEvQ3UWRv2Dhy4cBLX8epUPZUV+5R+qW97qGUrhcbILlua?=
 =?us-ascii?Q?Z2AF1kbTIREQypC1A7aC74nr3DpBwLJ7KopYZ4BEANUaveijRVLIv2Ycpwp7?=
 =?us-ascii?Q?ow+NZB7XETT4MVuDaiHjdx4xAz1xzAVjGPZTg/UqlMc5SrQu0WNye/67xtO0?=
 =?us-ascii?Q?lcjFLkB+R3MvWB+hj2gBbhcwpqSAv17QTc4W/2k/Wz7PrRSlKJLTPsbLlX5D?=
 =?us-ascii?Q?/Q+ixV42QRct62xRVlw0z46sxrVQwxhmr+78QwKz5gFhQFQAOIWAmhZs4n/3?=
 =?us-ascii?Q?y4QK8lRZbQctLcGMBSsDl10cjqNjNxmGMqidKca?=
X-Microsoft-Antispam-Message-Info: chzwTWmpQuZmJ7Xwmw7CI5PM0eNWc3YI33VCBieTf7JfPZ8Cd2hHrBnkNGhaSstiB+QcMLXojOZHxapbOI2iXwdd4bJNwuNpIcOESsgwxtetjMYIDfkw/62X5p1F2YF/DdBxx0j0x8rk1q32V9yVt+m6ilJsujzzgICWSsDc4/A9ylrgrSum0e2jBsu6U6HkwJrRLNeiZDbuVlmMKazXfHqzGgWs4/kn3257FGrJTeqsxtXkrN2UXkJMfKk0+szi1Ult1/3WvheSi5wwp3Zb1K84vktz2778UhPO4lvtwFgdrdEy4ZVqnMhsZcH84T3ZmRQ4GMA/A9yYB3vd9Exy/cT1lDAoPDHFaOWd9/VdksI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;6:9lnl+BpO/6e7iJA+udhqSxDpfN3TTHfqoNRb5F2IoefNyw1sNnLnvp/9QjXFfjZkJLX77ti4+JO/eTtjSxpiZn0fxZytIrhRDPsmp0CLPyoBAFAqmoz73gUBeGOjyrPvkR6Wjk4XiHC7bFKIy51JuvITWnNrTVoHImO5mWQyplu0u+K8guthawqmfZ/R/ir8KuXaYK+a+QRHzkfD5/pxA1Qstyr6mBwuki1osCDN59hm5TRwKz04hesO1KAyFDm3rCJ+AzBtUbqT3SsMOLETQCebIFQPUik/xuYEOvnI9gIUfnFboN7TjBuRb1wV2x5ewM0amWSlx+wBFVnmy/yvWjfLIDJC5OqHYPqmd2VQE/QPgG27epVoQQMd2KhKgQMsjO8zuq3+JFFEv9Gy/bA3n1JlfHgntMrPLbTfgWa1Mo2jtGiBdcKayQ9Ecp9CfvN7qshPn4JffthHGyqxSwhOBQ==;5:ARxNKf6DwOiDm3aK4mhpWPzTM6XQf4kQs3F9Mbc1r33m/fJVNBU0buBmU+y6A2rJg/aTf1PKYsKiREaeRThlJnCl/EFb3cb9qdKNgWEXgRjJfv3c/Pk0XNfuiJasitpl4Dz9Rp0fFkqrj4L7nNGoqWzRhsG6dYi3Wm5lHwGywhI=;7:CGiR5DQTRmxwx2nGFTOuiklsc3xohDSRAgok+9veI6mhEXBY3t9Bec5j+HcZ0D2mNDTwD4qPGYs5IjU6K8szPJWZrukKdlh+YoqqIH3gmH+DLldaUwGooJkSH4ch2T+SCotFJmzujsnP5BJWL1TA6bxzNVpNSKhPz5dT0sh6oOy0yrRbn8c9++SgGlmuk2mEIYJJCxQtjEhVrYf4vMjOf1qyh3TszErsvLnyXS6URbryrKYdxolQOuJQvhMYqWIs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 00:09:08.0107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eee1304-3e07-4f6e-563c-08d5f1c2d759
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4943
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65124
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


--xifqwmxgkbdfue53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are a couple more one-line MIPS fixes for 4.18 - please pull.

Thanks,
    Paul

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.18_4

for you to fetch changes up to bc88ad2efd11f29e00a4fd60fcd1887abfe76833:

  MIPS: ath79: fix register address in ath79_ddr_wb_flush() (2018-07-20 10:17:04 -0700)

----------------------------------------------------------------
A couple more MIPS fixes for 4.18:

  - Fix an off-by-one in reporting PCI resource sizes to userland which
    regressed in v3.12.

  - Fix writes to DDR controller registers used to flush write buffers,
    which regressed with some refactoring in v4.2.

----------------------------------------------------------------
Felix Fietkau (1):
      MIPS: ath79: fix register address in ath79_ddr_wb_flush()

Paul Burton (1):
      MIPS: Fix off-by-one in pci_resource_to_user()

 arch/mips/ath79/common.c | 2 +-
 arch/mips/pci/pci.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--xifqwmxgkbdfue53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW1e/nQAKCRA+p5+stXUA
3TyZAP9n/LVvB9/ddCeSHHgAJm+CHfOfiXzYr57Ef+e3DeNKUgEAn7qACzKJugLo
8pZr7JA0ju7Q2/IZcRpfeFiXC+nNRAg=
=myVE
-----END PGP SIGNATURE-----

--xifqwmxgkbdfue53--
