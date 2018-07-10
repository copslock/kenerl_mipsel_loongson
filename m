Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 23:55:03 +0200 (CEST)
Received: from mail-sn1nam02on0126.outbound.protection.outlook.com ([104.47.36.126]:48128
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994541AbeGJVyzk3w6N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Jul 2018 23:54:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnSzyma1Udv7zh2gCuIsXcac6x2u1ypXZAwdlaVhhG4=;
 b=pke4OgYV2U4X/4X55tFPw5xyKhZH5JdCO7NLCtRj+4lrxyBZ6JDiolkuU3k39794lEThEnmPbQzQ51/80wLRBx5xCea/EDU8fG7W/oQIifv6jpVS0KbxD1AGu7hoygi2zjX7S2lC7OKr6NqHiiKZ5upgaKIjlxAzmmCD8P5ON6U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 21:54:44 +0000
Date:   Tue, 10 Jul 2018 14:54:41 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [GIT PULL] MIPS fixes for 4.18-rc5
Message-ID: <20180710215441.tijegciiyvq7zpif@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tgzk2hyubhkhi3oh"
Content-Disposition: inline
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23f35308-4863-485a-1e07-08d5e6afbf46
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:OEgB5ukT56nZbn0FtGp8jD5sEhwScFVjoC5uiLzL5Qacak66Y+nHXgxdP6NOJx27JPsAV2n9/J8wwyxH+TdTF95dDe3ySzrukh9cflK+IvlW5yiIzaHjSCLQ6eBb0qg6htQ8J18pvherhdHz298VYjoCMc8/yrr9Ll+nmdSSTBf2vyGLloFSYTtidlZ7Ezo/fqfAHBVqU6G9pKXfRhuhaXVDSXj9D8BiKNTBLD8ne4JvDfx2Z3mNpZZ8mbHU9hZw;25:sf75ZKwr/aw7IF99avOFy6hnkjqArMrvdwDEBfPE8YQkm0IKe90iiWmarzSxQoYuN0ZgXm50KTdIjMKkcG8I9VP80VqpdO4NpiJBNWuT/Srb2w2DXUkQOi3qgZtZdNcNeD5VZgzDSAN+MjP8eSpSW4lH9f5RjBwwJCbxAgP4WX2B2KtGNXY6ab9yijALHPPdTVgpaVNr/EXopyk4GuLAe6xgFOiHPfn9T7hZGYAHPeArcvcuNDFTmdSVpyKtoVVqkJW8FaJntnkvS/CSANvUV88GOwEdr9nLWYnsChnitVMLNi+zN6EyHVMSoFrEWeORyIcG6u/Ni39jm2iPp7Rd8Q==;31:hgkp4/HTFzoWO16nYuGsUl3OPuvrARh25NsTh/zPeFC+tKc0msWCfpygVBLzJfo+3psRubzvjoVrSw9Ux9STarW1aLgwOWVUQy0Y8Lq4YTZJmSLz7vFXnPqzWR+1pJqAfK/z4LlHwqboRBzHnmIHgh5JVerzzCE1+w5rphNeRaQ+ghiUPQyzT5X8xEC9a0Tq0OTpMZHUYIblwlAvJJQG+QDcfg4xAgrhHNfYXpUhRNY=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:S/CZN58ydI6lxh5dPDIho+UiMIKUQRwo7ZGUNkAggODF1j366n1BzH4121Uyn//qePuo52rG04StzUhpDjByC18PufQ2w/zfQbBQ0kFonLUOqDU6UNy9A28ttpQznR48oR9VseUdG/X1p8zYUiChf8iVRG/eKJsQROH6/sDbNZwP3DQ87C3YvDB3/TVySMzB9IrRr0SvDcS/g7ObLVFAW2kxOGhie0/VFQR/SFvQGiogRRg4iGH8Bcz0ZW4kj11N;4:mG9OiD3kZvcD8qdctC9of+u46pODmlVLFK3MESWvOTBTyL5Qs4XFtVfB05Xs8oTTPFJLUop3oE+1vACAMYU+rki6/zcOUmzNfvezaZIGBZVldkOgyrZM2nlB9nYpzbIpARxFzTTaWoxzgvA8NFgjTHqnitT667h0vO8WnsYuVCxKv22p9O9FGXEPxN2F+fMKuKpzYmaQayYRzpw+NYmWdWBm8UgDngwS2VmKM7/VWEZF2zo9Ew0uaJF48zGAqiz5Cq+pYijF0CZ0gOEHAe8cQsq+Zn0Y+yn2NJlPaKchzM+55ItmWSIAMzw81Zh7MJLg
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934D4AEFD15EC9E1E662C97C15B0@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(366004)(376002)(346002)(39850400004)(396003)(199004)(189003)(33896004)(4326008)(25786009)(386003)(97736004)(52116002)(6666003)(44832011)(14444005)(6496006)(44144004)(9686003)(6916009)(478600001)(53936002)(6486002)(66066001)(575784001)(33716001)(21480400003)(58126008)(76506005)(316002)(7736002)(305945005)(8676002)(106356001)(81156014)(16586007)(81166006)(8936002)(68736007)(1076002)(105586002)(5660300001)(186003)(63394003)(84326002)(42882007)(956004)(476003)(486006)(16526019)(6116002)(54906003)(3846002)(2906002)(26005)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:EFosfaMBscKKS2Vmcc6yQTkvhKw0C9tt2wyLEZRTi?=
 =?us-ascii?Q?6Q3bbyXsoiDxlU3j30U9ti5kwOb0kNAdv7yl+q4Edpvz2RKsz/CaTXlD+QHD?=
 =?us-ascii?Q?GBXN8gMdlEvuQW3OJPa2acQwoMJlsR6D8WMed63PY/IKu50qfb2gMGc88kk+?=
 =?us-ascii?Q?vH+07PzafQO2rL0sz4tsupqLthNMfcohLpz64ia279NZJk1UqNawEZjR7woy?=
 =?us-ascii?Q?PNiYXiYLq2Z6GNzPkSdmc0LusCdEobth0IIAW0qt6IGs9suttlOxPLw34She?=
 =?us-ascii?Q?ebes7i5z4rwPDlm0xZiX15FQJtS5tjMkFOuSadd28FwyAXGXRY0r10UImyMi?=
 =?us-ascii?Q?oEMnvf9oTG5C5/d6lYhiq2lcOVRUkEMvQA1fCP92xRef7QXgUrsALE1cdzVe?=
 =?us-ascii?Q?OzuioRVhBzWxSZOBpOghIy4Y3Zm8nZEnQQMR+NOV0mdIzWE6KSr0CTzPcKVQ?=
 =?us-ascii?Q?nxiQOUog83t/YVDrydL09h0Bwk2Dr6ua5jg/33c82X/LiBrdsEly1Nn0/XPF?=
 =?us-ascii?Q?YRSXhgqVAV0T/ppPHRzM6Ct5c9h1I8FZn8qRu58ZSygHwqJyYKeyGNGxhCaa?=
 =?us-ascii?Q?8VHTE0My/a5ncLluJMwqiu1teubs3gUbPVgGn1iw2G+HiuBDMm8YaRLLlGAT?=
 =?us-ascii?Q?jlHElapvWAQgvlkt9Z6+Pnc2jcQ4Nn96YxUnhI6dykYdv9A7OJGIqNuU3xBz?=
 =?us-ascii?Q?dVKRx10Oxphj1qeD1Zd9JUSi37d9dgFOf1X9xtIJBfXFMZvnL6gsYT9I6dtS?=
 =?us-ascii?Q?z2kbBUc9hIaGQ8kmRNVSScbbUANYC6gBJffHvv4hftRMR7bKasXUNzzedayw?=
 =?us-ascii?Q?FlgS/AibkZe/e9LjMIeKp0h3YXLI4FT1unP8wl++wjkLj0J+lNsVelAaYe3c?=
 =?us-ascii?Q?9y/A24h/be5koODdXrMF5g9+Y/6dSwknTwrOkyMkNx5TyHseQbMKKr6v17Hp?=
 =?us-ascii?Q?quya6EFlyKJL7rbOAx+xh8drM1Q+nf4hZQzoCgvs9mTkOvjxkfsXJKi5U+JB?=
 =?us-ascii?Q?1fWVwCCpIZaF3I47u43SSY7lM7o0PCtJL5z4p6jlYWLdsbrxxrmr5rYq2DXj?=
 =?us-ascii?Q?04RC9LPHxD5cXFUbCN4yEReaZ96m1717iCvhrU1sKg2h1Hd0QTj5zvoEPemy?=
 =?us-ascii?Q?zW4c6dQPEEIUP+DbEJk3stB49TtzDB3iwlrCaRlQND+bxnTZO4V/8mVFZJfP?=
 =?us-ascii?Q?GHtOtNeIw20q0Lz9WeIqpYb3ZbpvS3GPRy1sf/iAlOKqhmslc8Lgd/yCvDm0?=
 =?us-ascii?Q?Yfi7UQrN4FDylUspCsnzjsFn/ntQiwKs5Zy9E6yZq/d1cZhbfo+lfvCm9wT/?=
 =?us-ascii?Q?2esaeCKvIpPCFIEvj2uLTY=3D?=
X-Microsoft-Antispam-Message-Info: 5EtKBz7RNc4GM71aui4/1++YICgK3BWneJpaWjSAvdWidOb9yynVyx8U98cYWBkhzxgxFg7yW/n1920hkq/vGhqYa+3fzKa0z6WR07TIGY8JYaEXz29f/TkHy2r/y11LKidEXGC6HU/xdvEfV3Ox0VI0s6GLUFT303kbkaFCTHOv49GfgfsjBXfxUQYw3leICUjBkPoyzw1Y4ndEHqPaFBjSf4UvbNS8b3wA0x3/AHKBg8w3EXniSW4n1U1dXqAICs4Krg8ksBNnaX0S+XPB0GAP2cylHyeh/Ca9GC4OV+214HFkiSX+4t9/yEqKBYcYhfmJD8XdAp9A9yc7KjCkZi3gjmd6BQKjiInlkHQB94k=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:bGohdr20/3qH6c/GJ3Eov7xBl2fq6+ulAX86Wnz5rAEa3un2C9/meHWzLrzXfpEwf6OR9PVJyT68azUpnwFN/yLC51/ZZpJzCrTuEqM8MehDUyb8m1psxgZFCBfzfmPDj+Wq1URO5Ioo4Aa3hjIOUNm6rzcdbhf+PoR8ThBRp4Au07tMGqgQ3m5xVEr0BuC7ZtdARuWe5VpZs74XAOs2QyuMGXkbHRF9dE3GFV8FpByJXRJGPg3mO+iHl8a/IiZxaYz+TodBM7YYivBdguAoMtWbXmwedH6g5s4YD48t0tM9J2srlfgU/jb3nUx2I8rQYN/1TfxdrlGl8Z/inftOY2qiI5trXC9b91QTDrlZ1lGscHG53JJ1Pn8xf9o5egkQ74eGq1ySaS3BTviKBhDQRX3Ow/PH/NrwlaDVgu3BGF+PA16wzyN0pbyyTQc36pA4IVraINdYzECvAlUFJNepMQ==;5:3nKXAWPfk76j/Nc+VbN69yO3QCbCKTHQfsDrTuVt0mojn38pE0FwaqPSmThRfOUTaGj1/7YHxZ0wTlvkq8R19/4d975rc0eZfJp0Mx2K9k2CmiK5CnkoeCvb0r0xXcG21xPX/spB4hLokjFShal/P2RFU1GyFoJQ9ZiQTLvZVe0=;24:STcHE7xNeYEVWMzNGZzAIZ6P06Uq463QKUK8MURTpcnQ4wf/9TjkbSw345/hnzUlv9A+VjXGdXEkCPmUEWeYc6heL7nAt0xwi53XlULnWeI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:hPiaLsyUkxX9LbioUQ0svRjCUtDN2viQmnzlnGrtoGbq0YoKFYMvHTlX+QDhvD0808UWIFHhgxKU/ftKzgKaPSGQZ9Tw/UVC7KUnO0r1aa7dcJ+LHE6IFY7XyLxcRFMMhy1IwXLIuWzDBk5rWLYz2Fnol4PUCsMUyLb8R30rnpjBETjZzLAkSAG+5VU+GKPpo5AKiYxQ6oQh5l9bfHETj3xTqsUp3TP36BO3l2mu0YINrHdmNEpcI4YuA8vZ3ZQG
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 21:54:44.5361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f35308-4863-485a-1e07-08d5e6afbf46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64769
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


--tgzk2hyubhkhi3oh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are a couple more MIPS fixes for 4.18; please pull.

Thanks,
    Paul

The following changes since commit 662d855c66c0a7400f9117b6ac02047942cd1d22:

  MIPS: Add ksig argument to rseq_{signal_deliver,handle_notify_resume} (2018-06-24 10:33:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.18_3

for you to fetch changes up to 523402fa9101090c91d2033b7ebdfdcf65880488:

  MIPS: Fix ioremap() RAM check (2018-07-05 14:43:21 -0700)

----------------------------------------------------------------
A couple more MIPS fixes for 4.18:

  - Use async IPIs for arch_trigger_cpumask_backtrace() in order to
    avoid warnings & deadlocks, fixing a problem introduced in v3.19
    with the fix trivial to backport as far as v4.9.

  - Fix ioremap()'s MMU/TLB backed path to avoid spuriously rejecting
    valid requests due to an incorrect belief that the memory region is
    backed by potentially-in-use RAM. This fixes a regression in v4.2.

----------------------------------------------------------------
Paul Burton (3):
      MIPS: Call dump_stack() from show_regs()
      MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()
      MIPS: Fix ioremap() RAM check

 arch/mips/kernel/process.c | 43 +++++++++++++++++++++++++++++--------------
 arch/mips/kernel/traps.c   |  1 +
 arch/mips/mm/ioremap.c     | 37 +++++++++++++++++++++++++------------
 3 files changed, 55 insertions(+), 26 deletions(-)

--tgzk2hyubhkhi3oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW0UrIQAKCRA+p5+stXUA
3ftMAP0auxTVWe3TvtGMFAK+9T9jb85aGWpGrVvHpdcEskQNJQEAjyhwP7G/518i
XFz7xijTFfNsmOkP0aAFKZYPa6gJwgI=
=j9mG
-----END PGP SIGNATURE-----

--tgzk2hyubhkhi3oh--
