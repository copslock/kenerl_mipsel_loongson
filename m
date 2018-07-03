Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 23:45:23 +0200 (CEST)
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:55342
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994606AbeGCVotjuih9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 23:44:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEHSSOeQH972sF2e1a9ssXhNg4GpU+JFURDQnjq8q7A=;
 b=Zf43+4D4pyH2Uv4ebc4eumP4iYrVRoDDd8fqm8PyGkba2OuDuRjTnI4opKnPH2CfM4lNPPs1ok0EaCXkw5hbc+d242cGUOVKUKCs8OCJgooZbUT/z/jkeOBCnU9rY+Ngi8fY8Sq6nR9RDKKuuNYrNghpDpUZ5g+JvOonwdy12Lo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3960.namprd07.prod.outlook.com (2603:10b6:4:b2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 21:44:35 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: [PATCH v7 4/6] MIPS: Octeon: Remove all unused CIU macros.
Date:   Tue,  3 Jul 2018 16:44:23 -0500
Message-Id: <1530654265-26949-5-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
References: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) To DM5PR07MB3960.namprd07.prod.outlook.com
 (2603:10b6:4:b2::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da3e3c98-fad1-42ca-64f6-08d5e12e2b9c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3960;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;3:WNBDGZKJSRejMeOaHaaZkRXBlFPKgpWoxUneSSPxxWvNchxdTlAA53a4c2M5h6I5oCWjjBVXrgeLjOfBf8M/JUpC8vOFmHzUFvbnrCh4XT4zPIErD/b5QCxfigPz6jAxeMnnNLsIvMVWYyIEwXPjUMkX4WAQsb1VDjgDL8SG7SkEY+qTCfOHKi14mcbKJ0i3U5mWvyB0kF84ovdoSPfAPVRk+oOhRhU1ef9WmTqXTN+3FdvUv/htbduDfPr8PVu/;25:woWO4wDizMJKY01hq6mFwcv0PknrLrRiQx3Cr5rvP6hDSCuP9S0fDDQRQ1cB2yHlPg+g1oHd0CbjrjSf52oUY4+74Ccjgprxg0LhEQ0Z8RsqHxxBwj9PRdzikNvmK7N7lvPVFrfCDSHyOrHbimexL4J12C4OLtYDA8Nn/9eF9m+IA3R1asAIFIQ/3cCswgZzwGBNGzorI0ZNQ4EGjrdTV6IWoghpM7hUT6PA/a12cp9HHz6PkSv10l10DYtr4v7mq7kXRPxFCnzUIJD39Ze40txe0fxrGBcoF8Jx5yVbygeKpx5wCMs5ov0O6eUMgRXOCPgGbKDYo0CHMY3Q9OrI7g==;31:m8twnBwKJtAmxpQjPl9ZRkRClxf3YSfUvlAban+AJzPZOnD1ICJDYNFuFiVRJ+SpX2yOjQUM39nQwFLvvYfW2kriN/frucw5ULjsolz+7bMLRyhfnV4wSY4ugO1oTL/Yd29umf5FfL+bF9dhLacF0bDiS/lGwn4oPfyDE1HpBaWktU/Hslk8aLSsEsECJgO8Da/CFppnEV9DWccPTsSMEViLsyNhRO6MDKhZSf/DEdc=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3960:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;20:zaz9ovOwZy9LTdyhdbWCtsFHZgUJW+CMrnwPiegePwTePaNlewiTIaWTE471qiwAELxUfbLRT1RCafh7Q4NFGGguWw3hLD6OqlW9iGSEWBzr9I83KKhOhT9grG2wDlj0utEyfFEUqIfUWnGRLZlozZchJbIHD5iOoUkKIZexS8qU9hC/W462OwSjc9bJP15151F4Di84fVVxUZfEFEG6AlbtSR7A6iy5MS3cNolUC0W39xFnu0uJOqurGJC55Bac1mkqihe0D0OIGR0ez8CZZFx8xohzTDjAFuANzumDFKFGv2YoixqLXNc4bqBAR0orqjdOxwUDySLbPYdkud5fAZq5fUDunMcOwwKqpMWCDzVk+OFU5RcL5arJyNz8sO0KL3zgG6LIdI9kEyH9W5KJiIfPM021TqJqEb1M8AuuI+8ZvI1NsFtm8clRGlt2h4l6DRwSw5gF/cat3aW/4QmRhlAJuoLJUW0fIYqiR6Vklv1m7dfqjUKnSjYWewDgwj0o;4:c+65fltHOH0hqzi+R15ZbtcrLlec8dyP5EdONQPQ7mz6WgOjwJAzEUnGQU7FmFXLYP+dpJnLGXS2GWCsEjWT12hRGQ8zwYAzj2XfJQXqGCDEWm8jH50rEYV0QgrRKG9FiYFsANoRYJxTC8FDNTK1nD+EquZx2enQHpY3oJupmKpn3BYszbkArRf3+TE8/xgKgWxWnHteOVf5299kHNjrzDG4/G1jNnMGOPZHDqJmauicRWwoONVsLHx1zEm83X+h6bzWOEuB6tx7I/78wnhXRA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3960C145DA57B933A0472C2080420@DM5PR07MB3960.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3960;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3960;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(316002)(6116002)(5660300001)(3846002)(6916009)(72206003)(97736004)(6666003)(47776003)(66066001)(6486002)(53936002)(68736007)(16586007)(107886003)(386003)(36756003)(6506007)(50466002)(2906002)(48376002)(186003)(26005)(8676002)(53416004)(486006)(2351001)(76176011)(2361001)(105586002)(106356001)(476003)(446003)(69596002)(11346002)(25786009)(50226002)(575784001)(51416003)(52116002)(956004)(4326008)(2616005)(16526019)(86362001)(478600001)(6512007)(305945005)(81166006)(8936002)(81156014)(7736002)(358055004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3960;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3960;23:dA6mXPjiUTNgbugLfcnLU+e+5RgWMqr9THjpTBKmP?=
 =?us-ascii?Q?VnLWUWhx1mQLf+Z4lx0VwIEHxKbJUkDglmi/nVtBmcLy8geqvlj+J+inQJ6e?=
 =?us-ascii?Q?9gAbyYPDO3iJ0TJQs1DWMyK0lGprAxgGuXWzyho66UdZgBREtQYzMZ4CXFS9?=
 =?us-ascii?Q?k+5ZhLXYn0eDV3tIz4oaeDt3Jb/vCyCL4NHwETi6luXdS7DykmyPhltK29YO?=
 =?us-ascii?Q?ywNHkBxRpsS/+Klb+trPVBFKg3PS/xUqvnDJ08RE8GjLw/Wq1B75sbG0hFAt?=
 =?us-ascii?Q?6HG2sUaYxK2tYsXhIDpsVEI2cZmDa7rwnRr0SufYmeQ14bzYz0VxbIONo4UZ?=
 =?us-ascii?Q?INbIgloBu/QJqQik9P7C8eGgOpRj2c6P8MXzZW4XElH9Jx75OS4h6agloggr?=
 =?us-ascii?Q?WHRtnSoXdGffXcN9lTWljtpodlzu6Naxmj56pOiGZ2OONmt8PvGqA22kbi9D?=
 =?us-ascii?Q?8rcKI8NWR7fLRV+UcaVgfD2kmNJifwPD9y4jXXEvqsspwiElsDoVQ6N5L3la?=
 =?us-ascii?Q?dSdFdgKixzBNVN9Fd0zho2vqIIzriVtga9yCq3mp6EhL3t9mDqhw0pfx9L/c?=
 =?us-ascii?Q?WlhsVfEBa5sQjPT0My95KN8F8rum/dL1Ll3rUb2qsHsekZJvhXaaDniNfhNr?=
 =?us-ascii?Q?/LY3fx7oxuYRwC7WeOMjWEecNmgRwiTAs9Fwe4Q86hN1gm7vK+ao83v84dD4?=
 =?us-ascii?Q?06PVMUTfLCkGXUvck5BrsXOZZ4KfVDfb4TYLKazJxMwl1S84M/J71UcvQKes?=
 =?us-ascii?Q?W4Vnl2k+6L8dfpBqPV7mrhdjvTPLxtYE0J2RFz8gBGI/pW827qOlSHXbeRbN?=
 =?us-ascii?Q?P1UGd65eAVVfKC5ZTQzlCdph1jvr0+ZD75qUdb+NLIwl6Ne/C9025U+FjzVv?=
 =?us-ascii?Q?OeZggsFM5IfFsEQPtKSPYBJXhg40ou2cw8qFrDQ+zpSMQchSZSyHUu+Yzutk?=
 =?us-ascii?Q?44NYUy3b2nnVjopoBvgGvGGF1SWv1DH/VGieTSSI6fVqRFx21k4iNV/3d+wH?=
 =?us-ascii?Q?FUTyrf1RPiPm5khbAdJU3N3HxRYBZwIP7fzOg+WmK+4okaw/H01CrZ4z0Cvi?=
 =?us-ascii?Q?W7bHahW5oKT5Sk1s6vv4OHph+zeHMuK0snQQOkywJ3X9wJfGU/PbBEXU0+Kq?=
 =?us-ascii?Q?1dihsfgb/Qi1Sxe2BC1XEbQy2zl3c/p1zmzmXS9PfgmYmlkiKavED/kR1C31?=
 =?us-ascii?Q?7/jxJsBgI7iVe/Ev+PgiL/aTS7IQcccwgJXWrTDMRqSNCYV1FwxtvjSwamqe?=
 =?us-ascii?Q?2bH2PYfLxYQ7DWwi1oH8syl8jmcndCNGwlgvQExkSH/eO0TMUiZgNgp+FK8F?=
 =?us-ascii?Q?93gJ9KdzWEVD5IbdnGB2+P9vKyI27yOGGv1IzGbQYf+?=
X-Microsoft-Antispam-Message-Info: 4rfjkZNBe+kRXzAxW6oR+nXSCC2gxk8nwPZ1bA52R2jSs8F0owgmeDMfd6YrB5DkfnIpDk+dKkwfejG33CQdob4p0H4syaR0xd+yvVzv4HlkbOQ6n6X9oJWutpxVESu+DDBOHNX28M5MRclI5928H7oxYHpfSv6kalETd0FJMz13vSG3I4UT32U+wIr3mqsWeuGYl2h0zp0wy3Dj0/s+WLskhdgGks9nUCefjW2Xx8cgpAuo7kwIID0ZQvSuGsiZgQ57QzwGqB8Vulu7xr5BlaZbi4mQGQ81mYOaru82mxmHkTC8orhtCbEpvNHO8M0XF2FeCXlNkbu0saI0NLSxs/cPHKMAN9rKq6ohvsz3O6Y=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;6:bKfrRxWfsMt5AmW1ocQC9oFwI+0Wygzk7OSLZAfuwb+7xoiyTst5ckRDRN4D136X4wgRjP5IdIcz4MOgFhtmAQj4unFeYAwmuKnNxe1899lx7GSryjVoofomYJQlwzcCXfZVkQ/ooN9t0tuW9d0xC4uZP4STEDOG4AEO9CXOpTQn/WUtCROiUWiy8bxZnnhIhG1zn0HwC3XWYyOksZmSrruaEq7yj0reBcGzNdHdnHrXUuKJu648mB1UK3xq/rmuL9W7vq9YWSNnKO/d6Rgv3u8DfW8tueL/KslRYoHinR8O6Jx39ffIEbmrDxVjWw8r1qCFLeF2OdTfaSyMbg2NQH8BaOaRnHHU/22kR/zradAHOeC1bEzw/wRrclZB5SbSM8vmR33zuPU3LbnIAQa60Jok1RH4chexWkkjwHSLc/JhZo5MvVJg/jwU6x/gyumL3Y1vv2ydHqW4wMcvE1gedw==;5:GAY/z0gd9L9ZkdmyG1g1RMPmbCkJaoxtkBo00E5bQp3oAAFfn4TPrvygf3mWT9QtuAGyY6MUNzizomJzXGsv8UwazvOU2UIVEx0+lLaan4zZ7IoGf1p0Qp5FYCCMfjIJ8xprlTTvs89yX1g5Dv5oUEDQL/6twxE53weuV/nrbdA=;24:y5jt4mXqyM+3ZprrsaT7h4VQ7Snq6l0DCZNJM+nwLpP51gD4XCvvUfQaSDbdi/NYRVLDQ0SYsRhhFfGDNCq9hmrw+o+KyGG8/3wtz0aFsxg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;7:/XO14/EvQYfGL/tJCFAE8c1oj7a1sGXHtoh+KnpsroAdJj8we4uIDVunLTc1T7iCjfp2Zpg/x+WiauKq6hkiwgLelGHwL3I/zYYuXaNCB1kStEl4cokeyZyi4xYsSXSuw7uLsR1QGSaZbqIlljYW6xKqtq4sV9SGDJMfrN+C7ImHNjrG3xGFTjCXyYynwFazNbmivFolNb9ppjSdWFcJS7JK++G/hZ+USC60r5hJkDN6FeTwCzW8+roWGjACgv0o
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 21:44:35.5845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da3e3c98-fad1-42ca-64f6-08d5e12e2b9c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3960
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64593
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

Get rid of all unused CIU macros and sort them. Verified with
'make allyesconfig' build test.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 70 +++++++---------------------
 1 file changed, 18 insertions(+), 52 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 931e911..c9fa6b6 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -9,40 +9,35 @@
 
 #include <asm/bitfield.h>
 
-#define CVMX_CIU_BIST (CVMX_ADD_IO_SEG(0x0001070000000730ull))
-#define CVMX_CIU_BLOCK_INT (CVMX_ADD_IO_SEG(0x00010700000007C0ull))
-#define CVMX_CIU_DINT (CVMX_ADD_IO_SEG(0x0001070000000720ull))
-#define CVMX_CIU_EN2_IOX_INT(offset) (CVMX_ADD_IO_SEG(0x000107000000A600ull) + ((offset) & 1) * 8)
-#define CVMX_CIU_EN2_IOX_INT_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CE00ull) + ((offset) & 1) * 8)
-#define CVMX_CIU_EN2_IOX_INT_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AE00ull) + ((offset) & 1) * 8)
-#define CVMX_CIU_EN2_PPX_IP2(offset) (CVMX_ADD_IO_SEG(0x000107000000A000ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_EN2_PPX_IP2_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000C800ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_EN2_PPX_IP2_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000A800ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_EN2_PPX_IP3(offset) (CVMX_ADD_IO_SEG(0x000107000000A200ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_EN2_PPX_IP3_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CA00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_EN2_PPX_IP3_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AA00ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x000107000000A400ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CC00ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AC00ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_FUSE (CVMX_ADD_IO_SEG(0x0001070000000728ull))
-#define CVMX_CIU_GSTOP (CVMX_ADD_IO_SEG(0x0001070000000710ull))
-#define CVMX_CIU_INT33_SUM0 (CVMX_ADD_IO_SEG(0x0001070000000110ull))
+#define CVMX_CIU_INT_SUM1 (CVMX_ADD_IO_SEG(0x0001070000000108ull))
 #define CVMX_CIU_INTX_EN0(offset) (CVMX_ADD_IO_SEG(0x0001070000000200ull) + ((offset) & 63) * 16)
 #define CVMX_CIU_INTX_EN0_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002200ull) + ((offset) & 63) * 16)
 #define CVMX_CIU_INTX_EN0_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006200ull) + ((offset) & 63) * 16)
 #define CVMX_CIU_INTX_EN1(offset) (CVMX_ADD_IO_SEG(0x0001070000000208ull) + ((offset) & 63) * 16)
 #define CVMX_CIU_INTX_EN1_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002208ull) + ((offset) & 63) * 16)
 #define CVMX_CIU_INTX_EN1_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006208ull) + ((offset) & 63) * 16)
-#define CVMX_CIU_INTX_EN4_0(offset) (CVMX_ADD_IO_SEG(0x0001070000000C80ull) + ((offset) & 15) * 16)
-#define CVMX_CIU_INTX_EN4_0_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002C80ull) + ((offset) & 15) * 16)
-#define CVMX_CIU_INTX_EN4_0_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006C80ull) + ((offset) & 15) * 16)
-#define CVMX_CIU_INTX_EN4_1(offset) (CVMX_ADD_IO_SEG(0x0001070000000C88ull) + ((offset) & 15) * 16)
-#define CVMX_CIU_INTX_EN4_1_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002C88ull) + ((offset) & 15) * 16)
-#define CVMX_CIU_INTX_EN4_1_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006C88ull) + ((offset) & 15) * 16)
 #define CVMX_CIU_INTX_SUM0(offset) (CVMX_ADD_IO_SEG(0x0001070000000000ull) + ((offset) & 63) * 8)
-#define CVMX_CIU_INTX_SUM4(offset) (CVMX_ADD_IO_SEG(0x0001070000000C00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_INT_DBG_SEL (CVMX_ADD_IO_SEG(0x00010700000007D0ull))
-#define CVMX_CIU_INT_SUM1 (CVMX_ADD_IO_SEG(0x0001070000000108ull))
+#define CVMX_CIU_NMI (CVMX_ADD_IO_SEG(0x0001070000000718ull))
+#define CVMX_CIU_PCI_INTA (CVMX_ADD_IO_SEG(0x0001070000000750ull))
+#define CVMX_CIU_PP_BIST_STAT (CVMX_ADD_IO_SEG(0x00010700000007E0ull))
+#define CVMX_CIU_PP_DBG (CVMX_ADD_IO_SEG(0x0001070000000708ull))
+#define CVMX_CIU_PP_RST (CVMX_ADD_IO_SEG(0x0001070000000700ull))
+#define CVMX_CIU_QLM0 (CVMX_ADD_IO_SEG(0x0001070000000780ull))
+#define CVMX_CIU_QLM1 (CVMX_ADD_IO_SEG(0x0001070000000788ull))
+#define CVMX_CIU_QLM_JTGC (CVMX_ADD_IO_SEG(0x0001070000000768ull))
+#define CVMX_CIU_QLM_JTGD (CVMX_ADD_IO_SEG(0x0001070000000770ull))
+#define CVMX_CIU_SOFT_BIST (CVMX_ADD_IO_SEG(0x0001070000000738ull))
+#define CVMX_CIU_SOFT_PRST1 (CVMX_ADD_IO_SEG(0x0001070000000758ull))
+#define CVMX_CIU_SOFT_PRST (CVMX_ADD_IO_SEG(0x0001070000000748ull))
+#define CVMX_CIU_SOFT_RST (CVMX_ADD_IO_SEG(0x0001070000000740ull))
+#define CVMX_CIU_SUM2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x0001070000008C00ull) + ((offset) & 15) * 8)
+#define CVMX_CIU_TIM_MULTI_CAST (CVMX_ADD_IO_SEG(0x000107000000C200ull))
+#define CVMX_CIU_TIMX(offset) (CVMX_ADD_IO_SEG(0x0001070000000480ull) + ((offset) & 15) * 8)
+
 static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned long offset)
 {
 	switch (cvmx_get_octeon_family()) {
@@ -97,10 +92,6 @@ static inline uint64_t CVMX_CIU_MBOX_SETX(unsigned long offset)
 	return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
 }
 
-#define CVMX_CIU_NMI (CVMX_ADD_IO_SEG(0x0001070000000718ull))
-#define CVMX_CIU_PCI_INTA (CVMX_ADD_IO_SEG(0x0001070000000750ull))
-#define CVMX_CIU_PP_BIST_STAT (CVMX_ADD_IO_SEG(0x00010700000007E0ull))
-#define CVMX_CIU_PP_DBG (CVMX_ADD_IO_SEG(0x0001070000000708ull))
 static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 {
 	switch (cvmx_get_octeon_family()) {
@@ -133,31 +124,6 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 }
 
-#define CVMX_CIU_PP_RST (CVMX_ADD_IO_SEG(0x0001070000000700ull))
-#define CVMX_CIU_QLM0 (CVMX_ADD_IO_SEG(0x0001070000000780ull))
-#define CVMX_CIU_QLM1 (CVMX_ADD_IO_SEG(0x0001070000000788ull))
-#define CVMX_CIU_QLM2 (CVMX_ADD_IO_SEG(0x0001070000000790ull))
-#define CVMX_CIU_QLM3 (CVMX_ADD_IO_SEG(0x0001070000000798ull))
-#define CVMX_CIU_QLM4 (CVMX_ADD_IO_SEG(0x00010700000007A0ull))
-#define CVMX_CIU_QLM_DCOK (CVMX_ADD_IO_SEG(0x0001070000000760ull))
-#define CVMX_CIU_QLM_JTGC (CVMX_ADD_IO_SEG(0x0001070000000768ull))
-#define CVMX_CIU_QLM_JTGD (CVMX_ADD_IO_SEG(0x0001070000000770ull))
-#define CVMX_CIU_SOFT_BIST (CVMX_ADD_IO_SEG(0x0001070000000738ull))
-#define CVMX_CIU_SOFT_PRST (CVMX_ADD_IO_SEG(0x0001070000000748ull))
-#define CVMX_CIU_SOFT_PRST1 (CVMX_ADD_IO_SEG(0x0001070000000758ull))
-#define CVMX_CIU_SOFT_PRST2 (CVMX_ADD_IO_SEG(0x00010700000007D8ull))
-#define CVMX_CIU_SOFT_PRST3 (CVMX_ADD_IO_SEG(0x00010700000007E0ull))
-#define CVMX_CIU_SOFT_RST (CVMX_ADD_IO_SEG(0x0001070000000740ull))
-#define CVMX_CIU_SUM1_IOX_INT(offset) (CVMX_ADD_IO_SEG(0x0001070000008600ull) + ((offset) & 1) * 8)
-#define CVMX_CIU_SUM1_PPX_IP2(offset) (CVMX_ADD_IO_SEG(0x0001070000008000ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_SUM1_PPX_IP3(offset) (CVMX_ADD_IO_SEG(0x0001070000008200ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_SUM1_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x0001070000008400ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_SUM2_IOX_INT(offset) (CVMX_ADD_IO_SEG(0x0001070000008E00ull) + ((offset) & 1) * 8)
-#define CVMX_CIU_SUM2_PPX_IP2(offset) (CVMX_ADD_IO_SEG(0x0001070000008800ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_SUM2_PPX_IP3(offset) (CVMX_ADD_IO_SEG(0x0001070000008A00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_SUM2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x0001070000008C00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_TIMX(offset) (CVMX_ADD_IO_SEG(0x0001070000000480ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_TIM_MULTI_CAST (CVMX_ADD_IO_SEG(0x000107000000C200ull))
 static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 {
 	switch (cvmx_get_octeon_family()) {
-- 
2.1.4
