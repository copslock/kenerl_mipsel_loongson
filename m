Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 22:40:39 +0200 (CEST)
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:16310
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993885AbeDMUkcBLJH3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Apr 2018 22:40:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C++7tqAdVtyJINW//SxBCAk31wneyUh6Z+vNaChztwQ=;
 b=EGK3gi6pEym8QA9ARfoI0RHdm8NvgrQ9mCMtdljI4tJeCihdxFcswt3TjOt7u8ehJXKFSMZOsZ3ZFjmQ4IBYiPl5Cbc233nt1QS0QQ4c7WqAMMoByvBiTdmwTHyqOjbbA2INL4SjaAJIe7XtY9KuCXkXcE9+aGBF9hVqHZrI6Sg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3612.namprd07.prod.outlook.com (2603:10b6:4:68::34) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.653.12; Fri, 13
 Apr 2018 20:40:16 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH 0/4] Formatting cleanups post-CPU hotplug and PCIe
Date:   Fri, 13 Apr 2018 15:20:16 -0500
Message-Id: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To DM5PR07MB3612.namprd07.prod.outlook.com
 (2603:10b6:4:68::34)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3612;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;3:x2c+zRa4xWinKa0b5dmDGh2jAMm0LHfC/yBYLFjcgNm/+Twh9wzC98ebImpgxNunV2HEsrIZetzF+PsbMNv7G99OMmUM92mEpITW4K0YSUJDiseSsLCUZxjaobMd9HKjVxztau+S3KWhq3iwzP+/ODci/E7a1aWUSEn89BM0Qzhmn4yd6vWG9Ip8rOy+5HIpOVbDwK5XOwTrZoCfM0NkPxbCw/W1aJrEDAuvebvohWAVUHQhTzH0vn6ynawy2s54;25:NbO6DUSO+bQUeW1nBxN4MQ/rQBo3wFnrDFdmDuj/IoVgkR/2yHfOmAN77LtHbuO0NJVRfc/9UF+aL4g107XS6PErSpJwIH3TfDCumadXPVhl1OWmoyDItAnSN9ue2Sh1dwRDyAGS23SxWB1e/NlpBGWr/lY5KHzsTTahB4mF0GGijs5RP/rkfz8633Wdsppf6a9g+gcWNcQjcMU2+m+l5Fwa0WqMSg1M8RSfn6d72ufwqiE5ibCbwgViIyV2Yld562WWhrxdWQsdVM3130vyBBm85bI8FKLWaQ3vFIcitNJej4D597Xdy32l2PQyAGYv9Pku0PmQmeJJgBkgzSq8hQ==;31:ooNLpnxXu7sAQfXi7u6S7JBvEO4UeUsrn0igyXPV/gX6qms6xtJ5n07PWDapaPLTMSOOSkSEoc+FKzn/RwdgCjG0qkHlOylHUky97Vkf8dCldw6AaqeMLb+JkWDEjDrPrZmN/rWUiU5vo/THRLdU/YXlPw5I9Dj7AyBTYfpgZLlJZ5Oj7vALuB59PKfmSxUG3n/CEaWCRnmYmL8CinfKRvbldKGR+LB9cWWIf7KqGXM=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3612:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;20:20tdg21DwlmgvDao7e3GyGQcSn6WEvzDGKeNyqBUZPtRtN1+rjnNBHv0UuuUSLmTYvIndZw8dqq4GQ4Om2rZbR7JzUz1RTNHFvP1XnliUNGTH9ZRoVP1DxbFHtqs+W5KxJhQAtb+/cH15A3GzwqH0+HIGaB529QEnBh09xjIDVlgQNDPZgAXRmahZg5soPKH1wYbVu2B184/V/Mzy+G/ZhqwNQQMZJZxJ0XzJuyvhUrP5YMn42ooCDqrb/6K4Nmrekl/zFZT4tMhmr6xvpncgt/X6kq622blbA3R0VB4Z3LV8IaKYverFYrQaM5ba4HCDxgtj/exDusm7UmDo64HZpZREX8z68zqXJ0GrwqLCUJsuixqysYGShyYRI7ZY6ZNkeEpqzC5nPiangQFbE8DPLKtGPGeuICuaUrbohRq2OcjWqjE4ixk9JGyOXwulBu0cZftr/NDRN/Zu97yltm8oxncvsC4vA2XuWPIpmEdQoDxFY4mRjT8STVW35H3cY55;4:h7NSyRnA0wKPxPqXGQX4xmH2ou37CGBf3AXJozqby6lREliuV5wfaiINBWmQH5sRZ0zozEitZaQWfk8lIjDPrsW2wyq1xmfunCD+dSdxfEXvT3CZbvLBgih8OPgaCjHwQsTL/KR6EMy3RW6M8ZWU533GYqTRCfyDntKxwR0S30Vr2EO5lfLCdL2FOfx0fvGb9J5GUsiJAgoo6Hvg7hRtPBIM/VUUZm8TIfeS/a6ATC/9dkYQ47jdfXlcmrmQe5u7W9+DksgxOpGv2a5z60uc+g==
X-Microsoft-Antispam-PRVS: <DM5PR07MB36125453DFE5D86E12CFF3CB80B30@DM5PR07MB3612.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3612;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3612;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(189003)(199004)(6486002)(486006)(69596002)(47776003)(16586007)(105586002)(25786009)(6916009)(66066001)(956004)(68736007)(2616005)(478600001)(6506007)(59450400001)(48376002)(2906002)(476003)(86362001)(51416003)(2351001)(53416004)(2361001)(5660300001)(81156014)(386003)(305945005)(6512007)(36756003)(52116002)(8936002)(50226002)(26005)(6116002)(8676002)(72206003)(81166006)(3846002)(186003)(316002)(97736004)(7736002)(50466002)(53936002)(106356001)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3612;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3612;23:T0whofntwq5Kn8d5Ri+TX6/t4/9IJ/NjJZKaj4SUE?=
 =?us-ascii?Q?RRQ7nbUTaX62Zuk8pVK3dzsaxEVPwUNXxTC+obW5oInK3e3vDBet6Si73dWp?=
 =?us-ascii?Q?OamG95yTMmhLAOXUbMy2GVXuMETuuXYWejaLi/eKHDclCG2M+6dLomMR5aB6?=
 =?us-ascii?Q?xC9pL1mUl0J9vTQTdeiOOCYatmbtumPaJfyh+D6Tqt3XHg9hnK7vRO817e6n?=
 =?us-ascii?Q?vANsteaOZQC0FF206FS+M6xS50NgKo5R6HzqvH2pBMWpbzKUP7JiAmRaVPux?=
 =?us-ascii?Q?ZBO7GTJhxrYXMJ1GkbJoWdvrbcb9JrLQ5yJ8A0BLAGp4rBgCt684nUTypzqO?=
 =?us-ascii?Q?Bt8IHfR46GTcg/pkJS7skyvAwIUGX+pYR1bp6j53S1oKT343T4YCGpZn7Z3h?=
 =?us-ascii?Q?KmXUzZJb+0qiIGhcpr0f7eVIzfWYH7D10+ARnccGSd3AbdPARlpTYx4mT19x?=
 =?us-ascii?Q?NPzd1A28coQ0hl0u1O03tETgaaoi3Au4sVI3IrgBl3nbBlzbnL5iuTmU3uyv?=
 =?us-ascii?Q?Yh9s5xElrmUvW8y3ykufuN/tJUVO0voSwfhbyg6zWfcJNfU75NQBrBo86Q0B?=
 =?us-ascii?Q?U5wphqp0bAX6niki3QOa1UPCoDUF4o5GZeLEDrQDlNSXofaKK53P8VhavMRK?=
 =?us-ascii?Q?mTwFyycjVoQZkRnJs9D1oG0i8kQSpmZKd4jXco+pdRMuofOwd1M+3NHzG9gs?=
 =?us-ascii?Q?mROEQForB6R448Oo3kUrnCLbqYej1qJ9izW/gdUvGq0s3LC+afEgfPZSuHIw?=
 =?us-ascii?Q?Bzsmm1Qo47PDRwIxA5xKZeATSgo8SMV8LU3lC/w76PmNVI/xUME/wfy+lKRn?=
 =?us-ascii?Q?2ztpDrJzqiAxIpP5bK33WvPAWOk3rvy4wDtBJi49ZJy8O3BJ/ETfnWDvEDRJ?=
 =?us-ascii?Q?3sQjTbVn4XWEtu522vU/lEpXW0GBklR9bDweMloy+FY+nrfh8CnDkVFdOZwn?=
 =?us-ascii?Q?Ciacws4I5eUIxDIS2kpM5nBDffnpB/yzjxZ6RvVvQjHi+FNlECZLB3NVojMR?=
 =?us-ascii?Q?utcuimtJ2e9XCAS/WXjhJiHAa9JNJNC2sGme5q93E6WXjYKHpumeeLMhwq6N?=
 =?us-ascii?Q?ryzz6LUWuxBkLzjeXKlckogu5aMpUSuct29zizkDcxPaAqJXO+NtgZ4JTU2D?=
 =?us-ascii?Q?if0aF6kIjNiCvPzSJSEvbP4pUpPFxMrhH3cjbXu60at+KPMi6hJbi3K+j/xA?=
 =?us-ascii?Q?E8NpkwLnV+qoUuBFac8ZKc4Iw7ZVCUPJ5+v?=
X-Microsoft-Antispam-Message-Info: wczvt+63x3PJbcFfpRVQl4eFZkZxPQvVZCRXh2yBk1JSQ/maDnZ/Q4JVuIpKFg1Vdmod/92o9n1kqfAmVnV89na3ADiQaLIAYN8E3f2Dhm0bouVRMldT8Hlt+SWSxlD0gIJsPtqg50E/VvVAL9O3oOy+SIDc5zPrMZz7NdzAwBLVoyG/J0Og9J9NQ0Kk8rfz
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;6:s1CQiTas9OIWWFK8HtCflgK5LQE1lupvKUcNDDICj4gdrsid1jCDk8T4opfCiBkBe3/1RXe6uKEGqF7nFKplvBF6SUqrPoJECD81fYlyuhh5TS2NKtNUc8y5E+waqx64lNuykI5Mzvrjb0pH5/CXbplnnDbxvpv3AoSRcXWq946KS5uDMpFYLb6ycwPwmuKfKL5CaZvIZ6B/t874r7p4VabZjEfyC54Fp0iO2zyv1n72eiht1BICJ/9BhAKhUdWtcRxcv+8eUFULYuE4Mine7eRFOD0DSCIO1jzhEvmVStRKQ7KaVooTg8Q1k2/8Ree3JY0Krne9jOI5K0DNXm1DdM2e6mqt4c7vng61/FaPt4DABXx6WE9W+tf4trZo1AE+mOqqEW2Dudku/QZCk+2wwhvf8rHwSsW0vmkI9EoeNVtLrb6F8TwjGRiAY5D+l+Krghhd/cWjhFl9/hWu6FcGZw==;5:bJ71ijbwQQ7D46yJML8hbKzi9WdIakxG0q/E65mKMyZcLnGzbnbKGC1qtkWINaq8SyDr79G2peu75AXaVB7ZF793Sfh+gD6DMavEySToKFQrS+k/8jPDhVYyDF1vGxtzyVlRMsNMM1XkOvTStlATpADcYlwMishaJHzqrtsUR6s=;24:7W1nhQWL7zJz4jou41WgK3U4wOKkmaJTg5OdcmNi1zWM4B2Ph6l3v+xWqgeDeFHWMwiH3Y4Dq87ukcIuvT8ywASAxgBtQOmdeRt3ovPZaXo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;7:Kfkz4YvTt99NGJJON8TGxm9xLPniU0ZDCHLWjuda3QSwHLxJjKqnlu8AtsERM1Vx4J/qgV2IcdnfxaDPXL4SPyFZEBA8SRvyzEq19KIHavoZvopR6nFtLGBzAC4oWCOB1/4DLy+HFs/VCQRb9QzSotdyg97fK7G6zN1cgRZHQ7lW71u0PEBg/8c5Wk86Y7DtRvEKzqwNUgzm0fRm2fkB4LcomR79odfKTB1b9UFJODESgyt9ep1lyxFV7UrxT0FY
X-MS-Office365-Filtering-Correlation-Id: 2abe02cf-0136-4b61-7ea1-08d5a17ec3b7
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 20:40:16.0733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abe02cf-0136-4b61-7ea1-08d5a17ec3b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3612
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63527
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

Ran the checkpatch script on the key files which will be modified for
future CPU hotplug and PCIe patchsets. Copyright dates were updated
and dead code removed. These can be applied in any order without any
breakage. Tested by doing 'make ARCH=MIPS allyesconfig' then a
'make ARCH=mips menuconfig' and selecting Cavium Octeon platforms.

Steven J. Hill (4):
  MIPS: Octeon: Remove unused CIU types and macros.
  MIPS: Octeon: Remove extern declarations.
  MIPS: Octeon: Properly use sysinfo header file.
  MIPS: Octeon: Whitespace and formatting clean-ups.

 .../cavium-octeon/executive/cvmx-helper-board.c    |    29 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |     6 +-
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |    65 +-
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |    25 +-
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |    32 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |    14 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |    54 +-
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |    62 +-
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |   102 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |    29 +-
 arch/mips/cavium-octeon/octeon-platform.c          |    70 +-
 arch/mips/cavium-octeon/octeon_boot.h              |    10 +-
 arch/mips/cavium-octeon/setup.c                    |   151 +-
 arch/mips/cavium-octeon/smp.c                      |    49 +-
 arch/mips/include/asm/bootinfo.h                   |     3 +-
 arch/mips/include/asm/octeon/cvmx-asm.h            |    93 +-
 arch/mips/include/asm/octeon/cvmx-asxx-defs.h      |     2 +
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 10045 +------------------
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h      |     2 +
 arch/mips/include/asm/octeon/cvmx-ipd.h            |     1 +
 arch/mips/include/asm/octeon/cvmx-pcsx-defs.h      |     2 +
 arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h     |     2 +
 arch/mips/include/asm/octeon/cvmx-spxx-defs.h      |     2 +
 arch/mips/include/asm/octeon/cvmx-stxx-defs.h      |     2 +
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |     4 +-
 arch/mips/include/asm/octeon/cvmx.h                |   117 +-
 arch/mips/include/asm/octeon/octeon.h              |   138 +-
 arch/mips/pci/pcie-octeon.c                        |     6 +-
 28 files changed, 735 insertions(+), 10382 deletions(-)

-- 
2.1.4
