Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:43:57 +0200 (CEST)
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:51904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995039AbdH2PnDg-uk1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tlK9DFDp8G+4Qr4j0H/uIWH9dtAtkXlfxvts5rQ3/+4=;
 b=JCiebDX6k9pEEskVJBi6WFaDk+1LOBKX3rxEljL6aDkOtLYB3qF3KYx0LMZEmB25HNIhIy2wb0SCwCENiuIAP5afzdxENzqOs9tWcifHsK/lOLE1F1r3GQjKmS/YrBrjoBn5U7X7g8+Al7GfQ+pcPoN/gUBjG9DDXUfZQ8BU6SA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:42:53 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 0/8] Update Octeon watchdog driver.
Date:   Tue, 29 Aug 2017 10:40:30 -0500
Message-Id: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2924188-035a-4843-7a1e-08d4eef49d35
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:4LQn0fEywKxUnMyIZWyAt2z9evowyEdc7DCYtO/yg0rdprLuVjk4fxmFI1UgVeO+PBJxNjbFLI9u+jCHJF53m5crswM00IsuOh5SEt7Y1M4PZHiJfC3VphNtuo9M1fUjyBkMz3vPyFM0jtXbteS/OjKwQGhhXruXiOTGHC/2Ai5HJA5CXyBo81N2ArP0aOyOUmWpyt3kV5JgZn19BK070zIdLOYFx5bZNWZ0iMNcM2e7TU/e+YdnDnQCWLI4AV3r;25:t7QlcaFaNcYM6Uy/p9jlNbXy0AGc5w6RSQSpqF+nss6rBFYRF14VhNoIcxt2jPO7uFBxApZalIhAOACYacfChGsAaQfdES4dy5o3wLiEioHSuGa5fQLD8IhSra+P16npBrltiCg+YA+cbVav2InsdVREECOtirGPzaNBgEmr1tgmhw0frWkHKzclfDbqY1iiH1Xsl2ZOD6t8DQYfDPr3C1q4O1SpQiDaB4L5RbtkfReY5/Ln+sib4k6IIgIQGFog0SQwFSLgtc7R8wkWkao6K8i6ZCtoWoyIKuwJtysGUMCMLK+SfA5QXqFG3U5Wf7vZCj0f+lY+1qJ3xJdzMDMM7w==;31:fYzUvgRzyrSXtD++fX055GjNCEBFxjZXtxQtvCH0NbVM6xuEMImnBf7EVAeYVHPtcW6/ciwGDOLPdS4SadrSxswZWB79U7xhP1KiOeOD/fB1qaRLLOD5+VyfxNvhOgRdbCmQqHhBBwz2+04ybo1FjoJtuq4iP2QaJXHWo+gBZUT0P8wr3HbaPQa2iQUlzfxtXcPKlGUHR1LJWuCzeo0UGyQfV427t8053LLewilVSQo=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:gzakgLCguP9HJa5Iab5+AYN1Tv4KvZet5MalB2hHCFaBDRA/8yElJDEsi+KRovGx8zfZvb0CUzOtYkhs87oTpVy2KP+nrTDxIZmGeJhJAPpHwYf3aZHFOa3X1xSPbFAn2MA1Dx4JrH2RkJIvmtvFX+4TyoyUTqV8uMm+uwq3CDOH1nytTGmeaPkOyddUbTzHy7IRAQvsD+PTcJLF9qmpk4DYlipv013AzGjWodrLsDmiN7ICM5wXLX15+gmyJZTzzkcEPwztCuPoVisLoEtgtVHVNixi3Ci8i5CI5zgcZHX5Gh92cYaBUDw9JOgT3+cOe8FrQWdYqsvz4LNReC1+YGED1BOThZmsGUVD8EpCbkCW0mw4sNbCGm23eCHIlnX5CXwakJuBge9q3JOVXvqwXG5Pl7m9UwXZhiI2u+ReaCM7x+Xp51ValQXPoB1W0SP0NkT7r/jAPKu39xi/LsqCijyZG/00a0Q6GIJotFuR/PUJNnrP6xW++OICrv3BHDgp;4:tJRABjjqKTWBXyTfCuPMeyt5sMZhtd0XpDmAAgaSpkcf8me9hqIcufT6h9ZiwMPRPrvCQx99pGizDtGGllJ8ruvwxm2GkpUAaKfwTWHh18jH0ZrofcEt5pvhhOovESKsHUyUzsvO0b+CtsGoLWaM1uKU97ZtOm79WqHiQdrV8hqVpHT+0nwW5+mbMMKOIojrdV8xkhSTuIa3vLOiCTP0chvuKrnEZ/qYs1qg3Houu70bNWQukDdTerbQ9G8P6mDQ
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB380394330A8ED6E451679ABD809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(15650500001)(48376002)(6506006)(66066001)(86362001)(47776003)(53936002)(110136004)(50986999)(5660300001)(6666003)(6486002)(2906002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:7QO6r01LW3iKI2cCuRfbhfYQcdO5tiGE5AumXsP?=
 =?us-ascii?Q?mZXn3/MGySye80s6jXbyE7m7k2BUO12zWJwgVX2n3NVPVy5Ki1LuUBW7DN3k?=
 =?us-ascii?Q?dOFcbKaTyx6iZ53pJ+CCQDZD/wZU/3KFrhbooUSG/m7IbyUOl9/drz0lDuSh?=
 =?us-ascii?Q?HtaruI55ZWA2njSxeRPwBzSB4s4BK3k4jpSPXqtiBtUGw7rziZ/aNfAn4xmH?=
 =?us-ascii?Q?Oaoj00/EaVZyDtBNBnO7j93F5gI5EVX4od6btcZfOGSFT0sBDTn4Twk487gj?=
 =?us-ascii?Q?Dl/XIwzuWeh0CZm/txXKMzcCpayIG08Fr0In23GGy+i9t82O0S7go2GnTcRs?=
 =?us-ascii?Q?tr5oI8FWBq6QPKNstALbqXfph/x2pM19mkZv4y3KfoXn/Xshd2JsHKyv2FGu?=
 =?us-ascii?Q?mHw+1gfpRSBfdHqg8IZhdtyDqhrJa5kk2Lj938TIaA97TEx9cOg9Rl4wlunt?=
 =?us-ascii?Q?MrJvKIVoPrf6+Uq1vnEDAbzcKAMv7TeHqPPdWu6+E4qRCsqNs0jNSK90AGCK?=
 =?us-ascii?Q?7R1eskrNpaRa+s8Qegu33BODMuWQlgzHrgpV8f/Dy7hECBBbPGIUZv8YIwl0?=
 =?us-ascii?Q?YbpZpjCa0hz/gHGcxa99sywM7S+nfqFtPZE/CuCpGUdWZE8QmwRTSHv6BVdN?=
 =?us-ascii?Q?fpPGIHXO41t/vFFYqXbUA1GUOi1mHsPxUu2T0cNiuKHfAmB7GvbCyGlcqePs?=
 =?us-ascii?Q?vf4p1Yc20xb7KL2hx3VoQ65JZSHMj6D7HFkMyGszxbaR63/NNaqLf9cYaM5H?=
 =?us-ascii?Q?QO0TbfZnbDiFNCP9pcCFbr53cG1x2q7dRfFA7+bq+sjgEIH3B1vsHdjRdscx?=
 =?us-ascii?Q?HaAsUqoHImxxU2kFIN2CJdMgU0Ru4LS9GZGa8TMDTfJ1TukuBOrcN0eSnQaj?=
 =?us-ascii?Q?jIq5y+z5aUegMuL5Kdt8wo72C+nIo/ax9pbARXBuD+Nh9ikc4W1KlaDCx5Jb?=
 =?us-ascii?Q?WumZO0IBmRYKuzqtycYtekucmp095P6gxTk5/2sn7jpPakvpB9krTNKXF/4m?=
 =?us-ascii?Q?qV3O5sIKzd8+8aUkAB8QAajur0kfXPSOwQdJaE9y2JxRKK9lVr2dui3pGJJ0?=
 =?us-ascii?Q?GHl7LYEjWmLsgN0Sk504MUh3sEtD5iM0l/z/FezNwzn0Lu5QmtQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:cEZN7nz0aoqGAz8ASEvq0oUAihTuwebPa4K06kDF+FARgkzf390LqkbWUpRtz2lBKDuOvOryl9Xo1myBCA4tH59qw+nGV+iNpOtnCH3qoWpPyZ15x/hfTHL0YuBiw9vlBBesaSfsvt4S48x8jrJrkL/TuFG9pYWIw87PeX0b/+E6e6oWVN1UCKDeLY2bSfsCKrYu7YoU5AiUFVOyRqSBbjsDiz3K/UqMuUJ+v4mFxF61LZWyHSO/gW4uI7VhyxGhYoWoG0ji6e0bpQjcIZ1P1IOYO3+d5RVpR6WiMUsVRcNnTPX4Hz36/op+bbgO3wRNOgpx8SA4VpyfTIG3lUGPgQ==;5:jGdeKblOVz938FeM1ikj6wNaWdPdhrOYRhN8QP97lElCnj7FYWgRxb9z72TEN+i1cC8mg1+JFUZSrEHZCapceeZCti/1uLXhmWI0XepiVa0jrvcnnSLg5vs/YRNH6v7asqnFrg/F2acAMuT8qMRZpQ==;24:4kSYDEINnakGO4bmpA/+/urKA5g5vF2mVTCgKxZSavuS5sXOdroQx58fBjPoqOfpXAIZH09CAgN0QsT+mbFta6N9QGLYwZ3wviOsc/cch2A=;7:qcbtiyHhiKXg1JMnb5dhIX30wwZopvaIrs7K4D7legKOd2T0cWuW0JPHxpUschglGV4MGGgKezegYiGaFkXVP4cIxKwiE8ezXqMGigN7uPDQBdbOo+uTBtEsNoQN49G91KoH6ksFBAsXzw1o18cgTLpm9bImHluaVr36NS/BSbx6lTMB6Qwd8yXMHbsTCeP3/3GP/TiM73vFM4mBxATFHq3MwPm7OJmeVCDJ3Dtpjt8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:42:53.8197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

This patchset updates the Octeon watchdog with bug fixes and new
platforms. This code has been tested on our 70xx and 78xx development
boards as well as an EdgeRouter PRO.

* The time it takes for the watchdog to trigger is now 1 second
  for all tested platforms. The various cores have different
  divisor values. Some of these were just plain wrong. Example:
  On our 78xx platform, it took 1m20s for the watchdog to trigger
  and reset the board.
* Support has been added for newer 7xxx SOCs.
* The boot vector code has been simplified and updated.

These watchdog driver changes are dependant on MIPS architecture
code changes. Would the watchdog driver maintainers be willing to
allow Ralf to include the driver code along with the next MIPS
architecture update? Thanks for considering. -Steve


Carlos Munoz (1):
  watchdog: octeon-wdt: Add support for 78XX SOCs.

David Daney (1):
  watchdog: octeon-wdt: Add support for cn68XX SOCs.

Steven J. Hill (6):
  MIPS: Octeon: Add support for accessing the boot vector.
  watchdog: octeon-wdt: Remove old boot vector code.
  MIPS: Octeon: Watchdog registers for 70xx, 73xx, 78xx, F75xx.
  MIPS: Octeon: Make CSR functions node aware.
  MIPS: Octeon: Allow access to CIU3 IRQ domains.
  watchdog: octeon-wdt: File cleaning.

 arch/mips/cavium-octeon/executive/Makefile         |   2 +-
 .../cavium-octeon/executive/cvmx-boot-vector.c     | 167 ++++++++++
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  85 +++++
 arch/mips/cavium-octeon/octeon-irq.c               |   9 +
 arch/mips/include/asm/octeon/cvmx-boot-vector.h    |  53 +++
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |  28 ++
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       |  10 +
 arch/mips/include/asm/octeon/cvmx.h                |  28 ++
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 drivers/watchdog/octeon-wdt-main.c                 | 354 ++++++++++-----------
 drivers/watchdog/octeon-wdt-nmi.S                  |  42 ++-
 11 files changed, 592 insertions(+), 188 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
 create mode 100644 arch/mips/include/asm/octeon/cvmx-boot-vector.h

-- 
2.1.4
