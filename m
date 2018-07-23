Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2018 16:48:46 +0200 (CEST)
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:55469
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993920AbeGWOsmGnWbn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jul 2018 16:48:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5YoKuEwGjhf8InLHeEy6UYPCzCYvdn3CLELr5i4a1w=;
 b=FmA4Emf70OKHn9AN7SPKjpKMyBDTUGkbId0DiaR6DK3Dlp5+i816qQySYoXo7BkVsVH5Yo/40IgyYqu80jerjFfJccLoRPpFMtEFGE1cBioJNcNyKQiM33WaFAvBki3Sn0qkry597+UzDQc+km47K+jMa7Xi4oP3Y2HRwYT1nLA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2155.namprd08.prod.outlook.com (2a01:111:e400:c611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 14:48:31 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v3 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
Date:   Mon, 23 Jul 2018 07:48:13 -0700
Message-Id: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To CY1PR0801MB2155.namprd08.prod.outlook.com
 (2a01:111:e400:c611::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0984409-e138-44b2-1589-08d5f0ab5c5b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2155;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;3:jnGq9i+80EqkOuriL8UTaxLI7jb9WdwAQJfWyjsPJ1C5NVFwNmYR9h32VXp+SoI2mqdhMXZsQASFjbt/j98qNrOPLuksid01KdhvrRhtSVz2LAx0s5Bb6gkl8yUsxE5kjQVvGo4uj8n1uujqwCzIHA1kzGhezTpBKphZuEPFJuy+Gk1V3SZESVDIMNzxz4xl5yIJryS1CB9y5fRW6e3y5FKTrBT7icFcC8Fanap3HYrV3Jrhy00+DHSmWuoxZTZZ;25:GDrMDOGAR7KP38FhJ9YRWriuXWBMflBhVLWtu1Bd37YNaSZ5AQgbzJFzIUY2yYzpxwm+BPbkMmnWeq5Zi7bAd8KZZWdZ4fDXtGzhwhbkShgtAMJnkxJSCT6UsT/c4cyHxt8R988z/YR2b6PvIJKw7xAT8Iw1dIgL94XP7GSG5BvA5dn3lk0zeVB969QLi57voVppmzfIi4lcdAAjBizu2OYjPJ+jYXr5/tXt9Z5X0PF22D0egkOfnHO8xB4zHoH6vk0kI+OqqJd9/y/sgiIBWnYFn3vyY7g/FY4uNgyMD+/uSp6GHU0StNZNv5WtRr1P1faWZw5Mm/7SkrDWQyIqfQ==;31:adca+qorbBp6ye0g/Bb966tx4RxaQEw6CoB7XLQbyzt1n8zlJPqxpTPK/wlShZ8HBJOUvzSmArpKl117ar1NISV0Nkz6xSt7QJteaFH1r/lc4m4Y6ht293QOW6LB9FzIG3fnwNGXoBE0P+jadRwk6PonTQIDlpD6cTY0Oj549WlHdMD903oz0latwkMG84EFCuU9+diIn22LSg4E15TfIdAv4cPZuhMHu0dV4LUUzQA=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2155:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;20:u0Na2MZ527n5SxR+DUbBzPi15ALDHBZRZj7HvgL+/FEEXsifQSsFjlY/zRGSeOH7Qw0Gqut3jy2LKquPjo7uQLttbLV9WtuAvERxM3va2QOqyFcIN+T+5hthkOf9c4m2SbTmVrTP7FZwSDK2SBeXf1wOHy64+Nxgrh+Fn1p4rnFRdl3RM1BubjnBMnzhEHjFZ3eg6v/TkLyOgT6WzFLvycvlKtDula28mqtlTCcAHGpryAULLrRrbmluGIolx1xY;4:7QxGoLd4nWoCzPNRVmYB0IK6mzHr3txWg1Ab61vY3NkX+Ej6NuZPkZCRIYK6wHklnfbc2tVBon9r4lkiib/FnMB9oEmPci3az4m2Qv2wTkkbDMjgAaRyfqhNhOrIS0Ym0cFOzDWViD6kdopsRwLRZOT2JdvOuVp+wjO2l88vrZRzUzkAvjCAS1IKgy/hX6kB7+qhvxQSO5uPm7z0HwoVQShtM6lNTOaFkpEXnjzwi5IRxwuyCrrnVGrZBUPzDYgF6afx3jWmJdoRcDhRy5FO0A==
X-Microsoft-Antispam-PRVS: <CY1PR0801MB21554F24BE9ED8CD6B6154CCA2560@CY1PR0801MB2155.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:CY1PR0801MB2155;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2155;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(66066001)(86362001)(97736004)(8676002)(105586002)(81156014)(8936002)(47776003)(3846002)(6116002)(316002)(16586007)(106356001)(81166006)(14444005)(478600001)(5660300001)(6512007)(36756003)(6666003)(51416003)(305945005)(37156001)(69596002)(48376002)(68736007)(52116002)(50466002)(7736002)(25786009)(107886003)(4326008)(386003)(53936002)(16526019)(53416004)(2906002)(476003)(2616005)(50226002)(956004)(6486002)(486006)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2155;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2155;23:KK1VuS98qehVA4H00Ai03FVzam5b/YzrIP1E1jy?=
 =?us-ascii?Q?kT61LluimgZIpJexYYSsQWci9TlteVC6agnHUdnOe4qXO6qGeeeR6H+MwHc7?=
 =?us-ascii?Q?vjjZXfEjjN87dZRMkxlgZVj1khwT6kZg5qhvMFzfD74XYpVjcGXZ4Ngda0Kd?=
 =?us-ascii?Q?e8jyFcBFvx3r9cYdrMHKnlaq9zLdiXL+353adqGYP5cNhmWYSBTNnnWQOBSY?=
 =?us-ascii?Q?XBapHqqOw/shjsOcwxCqpstOf4P87LSRDMa7bS4IJJ2BzPXLO4JInE+NuogI?=
 =?us-ascii?Q?XKF3fyuQGDlO/ZMaVIDTODRs6doVGfHBB4M6S01ce8MMCx4uavCWZoWfXSKk?=
 =?us-ascii?Q?RsQL2+563GwJplooHONO73pjPc1hK0ZDYydJt7AfPK+TO4Pg0mlAXUyucFj7?=
 =?us-ascii?Q?LIijkKOWi0tChF+pbQs+FzPuVtswwAZ+HH2atzcFbtwY1y0IltlwytuPhIwx?=
 =?us-ascii?Q?Gw2DASkoxoYRBGeBQwNr6pjWntfbqVIsS/X9Kckk5W8fuZvAIzRYE7dhznfd?=
 =?us-ascii?Q?+Cyh4mbpYyzRmnbhmVPsSW+YUBoaR7HJeu6aMs1Hwuf3SlVe6OpMCw0mOycV?=
 =?us-ascii?Q?bEEJa+Y3+Y3VDf8FXb4fNx+BOLZZKWRTf9/+lKM8JrUwmstS+gXgVurfNj5d?=
 =?us-ascii?Q?4K3zwldnjAfekFh5W5cI0kgx9LoYSzuovTqcnVW25khSy1sDPGeCd7xKJIbc?=
 =?us-ascii?Q?HZe/UpnsnNbb0o/vhXn3Brn2MR/BhnIuUvwzPQbSZLDY9sqe+S10U+6i/w1R?=
 =?us-ascii?Q?h8SbN/aFBaZxOMpL06JwbDzHpdYKEyNiFcMGWD37wQTjP48km+UuZCaac4ET?=
 =?us-ascii?Q?FFrbRKHl8Sj/wy9HoE41ll3ZeDoCFc5Hb3ycYuj5xTtA5fYPHhbWsG8btd5V?=
 =?us-ascii?Q?PrTCFa1dlVNpo+IRUWisiOUBc3a07kl3coNoFKIFoc/vKkjzBZdFXC66STFV?=
 =?us-ascii?Q?v0G2aWAHJ1AWWHvSMumA1ZLncKf4yEgjhNJrk0o7kbx+dydz/Wz5tHkJgvB+?=
 =?us-ascii?Q?iad337ABa6qtcG2yJ+HwhXuI82i9TPWlp0dHAzLpEXQmSGVKkyGB8TrcXCrX?=
 =?us-ascii?Q?UZdyTVR4p/Zc+01NgJz7DYWBHUtv/k7GqdKSrqFai80nglxJAt7f7GI4QILL?=
 =?us-ascii?Q?HoWG4iTC+9k5q9aASCgQG82iZjHk/hmSEs3h/WQGkgyzNGwepVqhBGp+bxXa?=
 =?us-ascii?Q?0TuRwUDjX6ci9LLA=3D?=
X-Microsoft-Antispam-Message-Info: JrZa5ZjZR4tz4e5oZ4k4WbEknHKwtJbH5NIAErrrYMi9WKGZzs5oH5jhCfcBi5joGBy44OqCSINQ43bIoluZjV4b64V8uDf4Ycp7khdM0QSOnY8fIQUob3kym2QANnAAOMq4TBIEbPgK3RhEDz4140TNkvMtbdJgGI4umozWlHsPAzwyLvK7s49h53JJDqjLHg8xemI4AbeQB3nzNqsDN/ukNOAbVfZygR2A9VVFX1dqNPN5RTI2mLKyCCSiRGxBweDV4wZVxJmtVzOl4DRGMeK5CTmS7UGQp5trmq5j8okoPQtntBSdoZIpYP7/cNL8g8MnRnLVFoUWWhtX5enLmnV+Utnyx2OtqXI/tz5AHpI=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;6:F9Fz6R7vLnzHH+nT+TvQ2EfDjiVd+80Lw1oUGjUF+dNFNUwLH/UK1RwRdW3zDzyUsEzNGJFcdpUjYqdW6ZzfB8+16VEnH8MzVv6q388hvuVxcNbgSbs+TVfAQ31OsEgegrQMHs0dHapP+4d0Kk5lRUwg9H6Ac37zP/abNE+hpvj/WdIS/UEZDjP6tAgjmFQ4kKqceR5nsJwZZvxQ26nhc825fvr1YIoeik0CveBEYKr4W19qefNLLnREeYT63LVFPxAE61H+ZBOmofzXOBlNm2dQEi5s8pquBRX42wRZ+jf8+jxHlgb6LgMG8AxadCSa9r7iTHvH/Jn07Y0HefTD08jMskvIEadLfFDd9DxI+yZBg4ZBdcFNpQankNvfbm96s8FXLtPL7OLE4aJH7tNZYKwSmz+g0V8xn3utXmR+Lz3zRWs0LRHMAvOB3nkoufXXNPee9d8ZdPzwMC1LRZAnbw==;5:zQYZVhMwnh5g9qJQB7zGwLG70gx5B6p4XwI/6RBvUougbzuEKqv3Q9YjJdU4kzQtYft5r23Arla500F9XucU0lCgmMEsrI9j842sBbuPBvpI11npyKKQYCKKCdcUjw/7WeFzYPm0nNwsUpU2Xie56erpXHtj+l5SYEKeAqz3Njs=;7:KNw4n+uSnMhTYBDWfC5scUoOWyNVs95tqK5dkd8gtcVZ1nNPUrsJGCYf8KHp+BteWsoCQMviM1V26WWWHHwkM33fySfjRanxr9HrorI1xjLrYtmgHE978Ht724zxXVT8gPc4cfiRcP1qfrdaNlw3mWs+pRe9EIuhj3tLRkRxr9LVBM4TQg7N2K2plutft2/7vLVaY+ebQMgTT8x0e9sxQxfYXaFuvoUqaoj0xSdG5bnDBmp3x6L0GHre61ZzROZS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 14:48:31.9840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0984409-e138-44b2-1589-08d5f0ab5c5b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2155
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65050
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

The issues are mentioned in patches 1/4/5/6. I will update kdump
documentation for MIPS if the series gets accepted. Testing has been done
on single core i6500/Boston with IOCU, dual core i6500 without IOCU, and
dual core interAptiv without IOCU.

Changes:

v3 - v2:
* Code style changes according to `scripts/checkpatch.pl --strict`.
  Patch #6, like before, still has a warning message reminding if
  MAINTAINERS needs updating. But it does NOT involve a maintainer change.
* Add LIBFDT to CPU_LOONGSON3 for default_machine_kexec_prepare().

v2 - v1:
* Tested on MIPS32R2 platform in addition to MIPS64R6.
* Added patches #5 and #6.
* In patch #2, removed the unnecessary inclusion of asm/mipsmtregs.h

Dengcheng Zhu (6):
  MIPS: Make play_dead() work for kexec
  MIPS: kexec: Let the new kernel handle all CPUs
  MIPS: kexec: Deprecate (relocated_)kexec_smp_wait
  MIPS: kexec: Do not flush system wide caches in machine_kexec()
  MIPS: kexec: Relax memory restriction
  MIPS: kexec: Use prepare method from generic platform as default
    option

 arch/mips/cavium-octeon/setup.c       |  2 +-
 arch/mips/cavium-octeon/smp.c         | 36 +++++++++------
 arch/mips/generic/Makefile            |  1 -
 arch/mips/generic/kexec.c             | 44 ------------------
 arch/mips/include/asm/kexec.h         | 11 ++---
 arch/mips/include/asm/smp.h           |  4 +-
 arch/mips/kernel/crash.c              |  4 +-
 arch/mips/kernel/machine_kexec.c      | 78 ++++++++++++++++++++++++++-----
 arch/mips/kernel/process.c            |  2 +-
 arch/mips/kernel/relocate_kernel.S    | 39 ----------------
 arch/mips/kernel/smp-bmips.c          | 11 +++--
 arch/mips/kernel/smp-cps.c            | 60 ++++++++++++++----------
 arch/mips/loongson64/loongson-3/smp.c | 86 +++++++++++++++++++----------------
 13 files changed, 191 insertions(+), 187 deletions(-)
 delete mode 100644 arch/mips/generic/kexec.c

-- 
2.7.4
