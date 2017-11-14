Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:39:09 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991869AbdKNEjBtJOc3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=f0cifDkcd6CIP/YIvFk8e4/DrUS7NmA8btE1AKkZEcs=;
 b=DCNgv41GYNxNXftrliuxV7g/LVLGNTrpAxaUCgDgM+OqAniKr7owNatknY3X5gurW+RUTkIjq3ZidECwPJlMdBknckshnYrKgU2Z7nLY1lYPmmtBEO9J9FgJQ2N+I8B7AJea53CunPYOEMLFWbosNwdBbySnvq3imJzvIERbSD4=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:51 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v3 00/11] Add Octeon Hotplug CPU Support.
Date:   Mon, 13 Nov 2017 22:30:16 -0600
Message-Id: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::14) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fff01b2c-364b-46fc-08d6-08d52b199b25
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:Pa6wRdtPy/Zj8uBmb01Xpxwq6HSsi9VC+69rOMyQHT70kJxOo/QjyxroncwU0giNlWO8t1qp4Cp9rD/g7tYF4J79bN7OEaSGCPwKPhOTE/NKkblvXinqzJajHBJFl3acGOUKMrGfWTzG/WakAXDdnWaunvkVabfSyCz0J7NCsxD/3VEQXRLRZZPLdRpdGormM5yGIMNPuimy6ha/Bdb488+TiSr05hfb21pm8qp7c58cZXC1o5f+IiLGUIO8vN1K;25:lHVcrsajBKSaI7xHOTsQ0UnJ4L8LAT5uKXwNO3a5j+Swe3dQEwhcWSVhor8nz6CiTn62JLKdS+1mypQHrBsK4F/nN2hts7ccS5EzOHswYtO9V0vb+niwMQRVI0JW/uWbkLRNyD3kfKYANWk9DtakcK+U+atk9bgQUlnF6ahwhM1gmJj7ax/kbCzgthUBQa46IDbx/dvaP//iseBMmvy3HVEZ3PdgFA1w7R1h6lcbmzzhND4rH/VcDz8XArZWBENdKYVJgRqH/h/BUjgNloG72gk4XIgCpJlQkCAmOiP0Gy2xbr5PFWIhRU2FyY1SQ6VVRO3Wp8+YmJm5XXC8IKnL8Q==;31:7AKGksE+ORPsh8k2Assj5hDz6vkEiFbegMiKSK6igJnTsGIJd174UWGTcEaEhx47G1vbhsTAe9ZHX9gt5X5c3m5R8W+vJ0vLZR1Q/DHzR/q5jLuu88yHx9FLSEQiHtB7HqGOi5HFhGBr25KMYRf8sZsi6jorzFfnWC2YUMazXGPidbgNastQwVtZ3QqR4GsfS7WR70BLOwCwpgBByntR0gjagBgtqDRPFx+XBwkaEU4=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:kfHRhn82Qp6giWHmA9BVNDtyeh3cZqN5CNFCRWxRVnV6+Mk7Fx1TGFMA/jFeU7tGGcHMorTj398bTDrIFVot68gK4T0XKsbkeuPqCgZ5Yf5Vg23aEmQSVgY13FAOfm9UEdP9BKw4S5T5AbO6L6ibU27EK7mxqt/S1vRME+YiCm8T3lE3+dqlVP73bUjsHywXHgiZInALjQFb7v0PsfumwpMEdzB3uxtroUDd+5NAAsFId+GdRl1q3v+lLKDZYkk6ilt3At1mb8dp1KXHnArP02zOzFJcRANuQ9yI79zo0GYtjq6iTY1mkf2ox5waNsab5ZuBaT3ZlB2JkW1UXSRdnRC0l9vUCD5zdPM9CQBGIPo/PfNPGnXXqfIzuinU2cacYiY3AoGF/kmWct88R/jDDaOqrort793vK6nxbPWoGlabwJVkOtfeVfHp+k1JWMaaboETzluiAD3bmrDIGW301V+1z5MyO1ygInPFU82OA2scgtG5L4B6pFRCT1+Hh+MM;4:XljTPp8OSd5Fjra0woUzR3U6FcePB1lySd9t1sCaHVSsgHcXYBnndHXWDy9F7stZJzog5W2KexskRIFBWIY6gX+Pa4fjMrX/P94mgl3UGmGrHXQ1y9vZAqMA9UwFQOF6jj3SVoPcLM5EmlP2grG6QySQvVebC/JzSAhAwN06B0MgnrA98A91TztWXltKqJq/KeSm9jq+pAZaCJ835pPas499+xDDrzSA/0hV6L1WSWniVmj5XLYJRWGchz2EtvsAWirWHFqW9HPaH6Lyc+17zg==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB38066DBB724157985C79D00E80280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:M3j7nAZDjrWhLiSKgQ6IWWYnPPc9zdK0aeQRYaz?=
 =?us-ascii?Q?dXE8mKWXtPntQ6AnhMLNZ1Qz6ULCDbw2Msqfnx0O+g4nwEQyDxs+7lwD08m0?=
 =?us-ascii?Q?75iiWHX5A2L34WqxFIWbNKe2jlO7wjIdje7B9nDwzCYFy/4WwLUde3hQ8Yl1?=
 =?us-ascii?Q?A0I+01n9WOtgDVImgizurq0WdLE/kGFECpq3CEP5PWZy8io4sak0vAEuy3Bh?=
 =?us-ascii?Q?+vLVdh7VMmK4fXbx/DEkNoLSjxxlFotGRgTMS+8DfsS/UYU5+h1jYVFaNr26?=
 =?us-ascii?Q?TZnUeeT9pQgVey24uF/SAaDDa0725ZxmAAihuy96TRMYZg8vGGdnv89ylyAh?=
 =?us-ascii?Q?Guc0O/Jsx4ab12Ku5gJUNLYzY8pP9s9UWXT+0V59azXWLfE7VKh9gUXMQqlR?=
 =?us-ascii?Q?BfuQnJ1IuOGwytci9G5aOOEI1GnZHn7L7dNOHsytV15G2OPHIC2oIXyAppZa?=
 =?us-ascii?Q?Ou1WWyjz0Ue9bnFGcGBPyX5CiLNPaQqYl922Q7CVpnFms1WT5Mkhb5V4AD3Y?=
 =?us-ascii?Q?+uRZUhMduFpECu28XJvXGH9iGRzpeGLL52Guhe39kta+hv1KNRiQYa+1OhPz?=
 =?us-ascii?Q?Pojea41hVGup/4GpMNpTP7NdHwfcky5iEP73UUPWBq01SZ/xlUjSP4uCUyuM?=
 =?us-ascii?Q?YzGCk6GK57xMwRXxc1Y1vo2Hw65+FvNLDkmdNC+ze+cRTt9AW7si7dJQa6FV?=
 =?us-ascii?Q?qwUd7Akr0U2RyN0mOJhMQzUfEcnRNhOyMJijQ3lTTAFc/EZpg8YtC7ZzLG/+?=
 =?us-ascii?Q?iFNeRF7ztbTN+3FIuzvMxGW0fGDNwiRz+d8Gpqy/oJgPpjFf/eKT/ykFlGTn?=
 =?us-ascii?Q?tnDbBJGSVHGsUyr2YDbmf96yoEDX6Z2wUH2RELEL4dOii82dMdHTHG8zGwYd?=
 =?us-ascii?Q?MrWbWAgHZNgEPytnBu1fCyG6GtH7eLRYd6h23Fy6ujws8YzqtO8SRY1hdNdo?=
 =?us-ascii?Q?JkVglrS15ZtxL9I6AcpT8Yj9516OOR2tqg5zE4r/4ZruzOB2l/rsuuk0sdXe?=
 =?us-ascii?Q?ge4ZiyIqcaeYwBU31cNck/flmu9JtDkt/bS11uFhe4OF0YEDpLHr01P+4c9a?=
 =?us-ascii?Q?QOxJk3/6tp5yUQtEcPRiLw/Lddd+U1wzQkMC5gjhOaYnlDiYm4vUDtbNt7G3?=
 =?us-ascii?Q?f2nBYInXOMcUdZ/9c5zTRx0502MlI0No5?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:wcHogirxzCdc0/w7uH1ufbqW2h0QKBeQBV+fluh+NzmeA78UB9yPd/X8xnG2Aq0lGWFKf9nJv3UIQSoe0Cc8uk9Esj55CPTP2gbhrnsOfTNLjmIFSdAA0ebfSY+J+3JinfDElQzv3JB6tjw83YKR5IXJG2v3tfD9woArvvxYLDbncKl9bETKJgxCIj7fg4/ZunUrVhgzZZ3YgHfrel7HmGtHGTgZ+9/5ZumiEGeGnJF0Kpkrh8uksPyqH/NXCUMg7eNWuG6SN75pxKBS8CsHWk64DaOUy4964kCzklrio/TKyfL0UIRYiShDt6733DLgxOnidTNw7lI4+IIaq6wfs4+bzv8sz11iXzb/TH7NGbU=;5:9/SllecMElLGRnFMJTPkwSiigKCBep8sDN6mQ29A8Qe1Et0wuBaF/Hgi1kl/2HeYXk0/utmUL74zfoE/xC63rcKVBDClgt8cPg2pgTlqBV40Ps0lq94b8upxfeyqBTp1OgLRnhPezw9SeafK/6QC3FGMY9JkNf287QTsvuYUyaY=;24:YQ4t/UhhiWiHGh4+TQq+uDCC+weZI48QX97Vm+IVvq4rw7y/mr2gL9uEXlXWik1P9rGXwHJBSqbeuUTCmu3CE7NUsGO0zQD6OdLznHUzlmA=;7:bse5X8j5sa53V7kokOmVfDNn6Tb7Wziw8gC5X0U+kc4pElfxZZH6FaihMLXWEXd+I43SXEonNe61EaowxGxB1dkSZmXdK3a9HyOL64kBsN/su7saJuBi5vW+D40tQfSNN2V+fe3vCq0/94yuh6r5zqxY74pdgICg71eyi6WUyir1+YgrzRaBgg2zLA8UNGfv1008HDOyDPIVmQf/IBP9LOmZG27fo5VIEZo2ec/6YS+GeHxARcoJs5Vak+K0vPFS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:51.5021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff01b2c-364b-46fc-08d6-08d52b199b25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60892
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

This patchset adds working Octeon Hotplug CPU. It has been tested
on our 70xx and 78xx develpoment boards. The 70xx has 4 cores and
the 78xx has 48 cores. This was also tested on an EdgerouterPRO,
which has 2 cores.

Changes in v3:
- Reorganized patches to be bisectable.
- Added in suggested changes from v2 patchset.

Chad Reese (1):
  MIPS: Add nudges to writes for bit unlocks.

David Daney (4):
  MIPS: Allow __cpu_number_map to be larger than NR_CPUS
  MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
  MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
  MIPS: Octeon: Add working hotplug CPU support.

Steven J. Hill (6):
  MIPS: Remove unused variable 'lastpfn'
  MIPS: Octeon: Remove usage of cvmx_wait() everywhere.
  MIPS: Octeon: Header and file cleaning.
  MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
  MIPS: Octeon: Add Octeon III platforms for console output.
  MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.

 arch/mips/Kconfig                                  |  14 +-
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
 arch/mips/cavium-octeon/smp.c                      | 231 +++++++------------
 arch/mips/include/asm/bitops.h                     |   1 +
 arch/mips/include/asm/bootinfo.h                   |   1 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |   8 +
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  60 ++++-
 arch/mips/include/asm/mipsregs.h                   |   1 +
 arch/mips/include/asm/octeon/cvmx-asm.h            |   6 +-
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx-fpa.h            |   4 +-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |   4 +-
 arch/mips/include/asm/octeon/cvmx.h                |  40 ++--
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 arch/mips/include/asm/smp.h                        |   2 +-
 arch/mips/kernel/setup.c                           |  30 ++-
 arch/mips/kernel/smp.c                             |   2 +-
 arch/mips/mm/init.c                                |   4 -
 arch/mips/pci/pcie-octeon.c                        |  12 +-
 32 files changed, 410 insertions(+), 481 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

-- 
2.1.4
