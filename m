Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:34:09 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991438AbdIOReBPbMvM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vSWEfMXxJyR2TuDQaGebxN1Mb4pwBT0sePqxhRl04gU=;
 b=kfTaLAIdQ93vTo3o7Ywk39+mVxosnyRiKgVXy6L10Di+2rwXP9+EHCtuVK8eHVmjZFH6kM6/V4fXXbUX6wQbEktEEW05Pgu/aoI0js3ThI1EO+Zzte5Kef72kEodyozKJxzkCMz6m+IOtJvlJ/pGxme4Oena6TI8xK3saXrO0aY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:50 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 00/11] Add Octeon Hotplug CPU Support.
Date:   Fri, 15 Sep 2017 12:30:02 -0500
Message-Id: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:5173::41) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd394785-8b40-495b-36e2-08d4fc5fee15
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:nra7owXYtDGG1KRijQp6onx3TfKFFfoSVgXoccX5TpchqVavGpr1nLdTGClcIKMv99fKSsxon9RFCAamNUYh6mj3qAprmTqVd3IF/snkLWYXfUIDsPYXCNTlSytDOtEBK/4a3r4hioJcOCc3ipJ/h1PVF6a6galYhzLVHBS8PmLZNyxwkOy9VJS5Y3gi/cnf+/Vj6Vh1r3ucFsy6JCJscoyTQ8WqcJDtm80LpqQD64twq56PJtlyyERLaj084yFR;25:6H1hq/QZLQpgAh4LKUQkaiibqGXgbgjSojciyh9TEjYjHtmpuuYsE8khe3kJkLKrdD8dDASvZEOUDz6CDV2JVGqwhZAzRAEcu0GJGGy1kgB1AzinVwNg/1NWlL93tGgR8LuPS3dljl8rV3mkHrLlLSBVWz2R4GsQsHCdx89NWDp9fdR3/uNCwF2MlwobRuH47o1vVxVVFF5kOcjjy9LEW2tKx8bfM4h+xLPALtUDvgq5/3QmkhiXRKLHb5s+QSxN7PCs/l1TLy/Bh1b7GltY4nLlwOradczX3pqzCe49sPP+FfYJfxG4SpkGmd0i8T1xXIhLqos4y17ZsicnFZgsbA==;31:tG4GIxbaHvo44oiCLbxPYxIF3e0JVj0sfq7M6l652S+2hS9sJ5nc+JtY8ViyRGgdKPP/SobGo/r1F+SwloZcCgEp9iW5q7wl8qWy0e7Gm/ykdH7q14XBJ/uaREU38bmoY6pJGuTKO2T90/Ym3Wmy+9BBC2fic+wNfS1ewyiHbPxY9SsRGHyv7Z9m4Oz+727BfKThanqgvIuXQsBTc4FNsGzdDL6cNJ6nbT7jqJ4ero8=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:KoRQx9WZxCRvfejd+t2pWDEkiyO9OdJFMJ1+dkzS6KeG4+eVoeR6wxIRx6SOOaTcROixCk9AlS6+DkjmV4rgI1J80L1LwLUMfxRxi08YGnGHWLfJBZbAVtsDLWwHHquPYQY7q5R1CU2MNiQtSHCaPpE6gRR2wIEQC6YctpXy8sjV/FLKtB7P2QAsJPTRtfX4Bcu/fqh7sKYGz2X+ahwo6G2jGvWvTdGF7K9onhoRNPPeTi4pfZtJj7voFWDWr0XAFE2AzIMo8CXPy/lVRuopZfP08IabRt/7B1+IlZvrWcCAETNy8qJg5IQlxawM5Ls6IiW9zP/XfGSy++Da3qVelFTlFq3AK2ZKEzjeJdqn3tOlBjRKs2HBwwhccvKQA6bVj4KY2pLDq2WDo/8mbMUGlaGupFkvNFZFzeQrI7fhdri7IyOnGWrmRm9Eyb3O1hIYVuwiDFdX/t/uDWhAfExojB21xuSi5XU7IPaQCX5T7M4SD9iYuJ2q8LqurLbkGyBl;4:+29br44hAmx23FjMVCoNmcsySnp3B+SNrrQlZ6mFuRC2qr08Ql5ejhJG+s/QtrzBlZ63ZCYpfmaL5S+3t2htuWzdbphwn9DIgBPf3XUWjPVqD9OTtZfaDbDiRVUJsFTNYvxref2qNf4oHTb1iE6R2eGqyEbVqIFXHY67uMEnrGLR1o5/czi4aOXfBqaOlZA12p0WHmxo6L/dfw+TpwEVliWVn9RMXr6jJo7QjKm2qXerHHAbbyUz3xUtgSBNZUR7
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB38003C523BEDC6C5D10BDE23806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(33646002)(50986999)(68736007)(53416004)(47776003)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:6MotVeY+h7aeCOOHXiZfEBqy3TK7wcJuhCQggL5?=
 =?us-ascii?Q?em/81rfOjtc1GzlYbOM+r1mjC45j/PdVwJ6FRs7Mw+C3Tbbwp88qJYPhcU5U?=
 =?us-ascii?Q?5hkLsMZNC6J+o8zb9VYffNUGAgsamDkF3SvMU+RSvnPzFR5pARSP3YyRhZ68?=
 =?us-ascii?Q?j1wpGerrfCDpc130Xv9jjICvJj3R3qJDeH5ZnKtm0kEme5hIzJi9liy6HKdw?=
 =?us-ascii?Q?AwaSp31v3kbGHRa4if6L4qeYVTZEe8mBfS7YSR3OhgNRDZo7pGb46L88aA+R?=
 =?us-ascii?Q?B7vlg4CLrstGOFP1lkme1+B3YUwe1myVPYu2lmQeve91Ayr+iOBL/DVRdjYE?=
 =?us-ascii?Q?dH22tR7Yd75oAMPTSn1Jwo8ifA0kVvAHVU1RfNKGkxSbONEnpW2IL0/XwBAx?=
 =?us-ascii?Q?LxUhZqgu7uRx/BjVvg5VoqPapwABf/B8qFNeewQc2j97/cWEC/BzkOZK0oh1?=
 =?us-ascii?Q?x+LBE3EhT7DuaIYpsHJ2RsDg2mExHr2AuhLqARTLNTtzWUDyjkVjuSjQZSHZ?=
 =?us-ascii?Q?suOUJ9+gonV/x9C1z0J4950bYT3Z9vN2vvlQheZAS0JcIlowlAnfUtl4dZbI?=
 =?us-ascii?Q?xnFbAWW4vGjT5/JPNnDY8PGHEnVMLuP8hkBs918glGQ8ZNOUTynHquTOAVOn?=
 =?us-ascii?Q?oixLlpLHATv76joEhh0OVotqOerLl9AsVhEe3JzAKV17MqiajtFhEiHPl7gs?=
 =?us-ascii?Q?li24zYcPpLxdXoak0uno5I5Gvi2y9z+dRJzB97oS+hfQrixk9UD381QECVNY?=
 =?us-ascii?Q?mJL3Wh394FlNqimSKBFz2m6HWjnmKrsvRvtzfEY8HW8Da32EoMAvJtePBYV7?=
 =?us-ascii?Q?wv/moQWx2jk3iAr3DueiE41EZXkTh+fJA78Au7zRG2KplMIfy7W+5OjJnLzC?=
 =?us-ascii?Q?0nJ8NjrqYC5ArCG6XOMdiFponR73mOvw9IsAxIKdRT7gtdHusqUvjy+swOzn?=
 =?us-ascii?Q?tjIliBL8gowUAOTGIhgGf5adij7vShoEfsvnm7WTjwRWMPmxqSvJI9hZYdtM?=
 =?us-ascii?Q?nR2hgNb0kgggG2z7VDiPbaPpRoSuD26G3u/jFEmT4qbp387SMw0H/F4KTIeu?=
 =?us-ascii?Q?SLoxu/5ceef+dmZCVnI+bFDI51EImKtpsuPhbTocVhuEBthQyFySEMHhCwsc?=
 =?us-ascii?Q?PfiaATss14LwpT/gH0KPtAUED4oHOsxIgOqNEqrY4Hz5QcD/+pbgTMQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:imziXwdgGfP8Yry+D6YS+7kuqeeuvzUX8YZEEfHTKum4TTfn5U4S20A9Vxfq1lAdHpYQ2obMAidww6kbIFA4kfKJEaEi7cqMM8v/qS6HXemb/E9Ly/ly+2ZTphy30W+pkvzEuStN+iSN0U032Gn8Z9Q9OXWEh8X6Dt1VLVC5U9gSMlk7V40fLr8aiJ/Yml4+u1E7h2syRJStyuv7wY9xgASzkl8lgXqvaXiKq6ijyAz1p2UL7dxSr9MAGH+Kgx1jUmLEB9gDwCGPyTe+jyd0SzjE5sbo+iYzY9KoOifd179wanPYO5VcnQw2g9HM3mbzmA3xNMNnT4NJC0f1Pt/uiw==;5:ARa2F/ihKgyoQkVPeOm4iSFdYN83k9VQkrJ017xrbkSct/VLV/nifAhFB0as9L9/keqKtV3HZgkTfSA/6YoWfc90ZMV345lcnvSNDYQEHx9XTKKqxKjx1YobW75vluGiADGM1lZ5y86HyIe7yj5ghQ==;24:Ftm1lOaQugQe74LD6LLu+tvZzy3GKiJTBEtL2mXm5xkgTKdE9K0euo2/4E8jrIdvbTbvCOAsOeg4vNnrYpDaQdnrtj/lVZAYXXZd2zTYJ/c=;7:Xd/Ce6EAYK4HBpJtSehcXT4p0OnIK3U+0SkpnYOOBuLWqjWtjzR4BYZaJlXuP98nSmsDsgLatJzrifwY+SOnxpH8UT7ZCHG82qLT7meAeWR0fV4OKuXQmMI5L/feTiwkE3RLLiz68aZH9CjV5WdVB09M8FxkmpU3TWBOo0JUEiyCN+NA39x9gj4IGdcSWHgB2DdX15qqMMDrZgfpqBgAYwPs1d3IPTAc0wUruxpjz/o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:50.9261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60013
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

This patchset adds working Octeon Hotplug CPU. It has been tested
on our 70xx and 78xx develpoment boards. The 70xx has 4 cores and
the 78xx has 48 cores. This was also tested on an EdgerouterPRO,
which is 2 cores (whoohoo).

David Daney (4):
  MIPS: Allow __cpu_number_map to be larger than NR_CPUS
  MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
  MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
  MIPS: Octeon: Add working hotplug CPU support.

Steven J. Hill (7):
  MIPS: Octeon: Remove usage of cvmx_wait() everywhere.
  MIPS: Octeon: Header and file cleaning.
  MIPS: Octeon: Add support for accessing the boot vector.
  MIPS: Octeon: Update registers for new platforms.
  MIPS: Octeon: Add Octeon III platforms for console output.
  MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
  MIPS: Octeon: Make register functions node aware.

 arch/mips/Kconfig                                  |  13 +-
 arch/mips/cavium-octeon/executive/Makefile         |   2 +-
 .../cavium-octeon/executive/cvmx-boot-vector.c     | 167 ++++++++++++++
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  85 +++++++
 .../cavium-octeon/executive/cvmx-helper-board.c    |   2 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |   1 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   1 +
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 +
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |   1 +
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   3 +-
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |   1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |  11 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |  53 ++++-
 arch/mips/cavium-octeon/octeon-platform.c          |   1 +
 arch/mips/cavium-octeon/octeon_boot.h              |  95 --------
 arch/mips/cavium-octeon/setup.c                    | 246 +++++++--------------
 arch/mips/cavium-octeon/smp.c                      | 213 +++++++-----------
 arch/mips/include/asm/bootinfo.h                   |   1 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |   8 +
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 129 ++++++++++-
 arch/mips/include/asm/octeon/cvmx-asm.h            |   6 +-
 arch/mips/include/asm/octeon/cvmx-boot-vector.h    |  53 +++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |  28 +++
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 132 ++++++-----
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx-fpa.h            |   4 +-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |   4 +-
 arch/mips/include/asm/octeon/cvmx.h                |  71 +++---
 arch/mips/include/asm/smp.h                        |   2 +-
 arch/mips/kernel/setup.c                           |  18 +-
 arch/mips/kernel/smp.c                             |   4 +-
 arch/mips/pci/pcie-octeon.c                        |  12 +-
 drivers/watchdog/Kconfig                           |   1 +
 34 files changed, 860 insertions(+), 536 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-boot-vector.h

-- 
2.1.4
