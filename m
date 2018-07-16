Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 17:28:02 +0200 (CEST)
Received: from mail-eopbgr730103.outbound.protection.outlook.com ([40.107.73.103]:46529
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991947AbeGPP1ypwimv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jul 2018 17:27:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXqVkXciawv2S+ssy0yFSXOHuaOjwAtNz6oODWNQ45k=;
 b=kR4KUUR0T/YZIhcoOFNHgALoXo0FRnChaDnuV3J2MIn3g8RPXj/zriEqPc9Kl5xBlWhOy7balpPGXqzJlzxPG9/O5bGsDLo6lCBrC1fMDx5Dma6WqBDX9ed8IE3K83q33VKCStySyPIKDi7uFQsvyyOrL7Law5ty5BI8Mi9IN9k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost.localdomain (2601:647:4100:4687:84d1:277a:c6e5:ae34)
 by SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Mon, 16 Jul
 2018 15:27:43 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads
Date:   Mon, 16 Jul 2018 08:26:36 -0700
Message-Id: <20180716152636.23891-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
X-ClientProxiedBy: BN6PR2001CA0035.namprd20.prod.outlook.com
 (2603:10b6:405:16::21) To SN6PR08MB4941.namprd08.prod.outlook.com
 (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc1b9334-7152-436a-bf48-08d5eb30ad7f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:19N4O6JILLV/unGOiFfQuoZkWAMOcG5bkkcXOiinpcJVS8wgNFNLBFre8QPRUbGH8MTJr1jpC7KZ9QJl2x2qh6z5hCMv5cxmTLBYP6v0vHBfEq9Devi3C7OwV/+7dzQNcM5j+etCJgSqWEaAupTCU+b3lKrShYzBuVrEZLsA4tuhcxCmy7/EXTyjwbj1PXehTKrVmjqrietdtDD9mkG7KkwEqwvTHwduHtnAJuYdQ9nkf6JVA23i9Wywxi4Gm4Wb;25:H4JwDyCHBwUoibKkp8JX13OWz5ZPF97wuc0EF453IZlZZgI4t2xu81XSgYbHTowQw6aIv8r7BXmFg5fLfR+FeSHD2ekYfX1r0zDQgWOrVzX+/fy/RoaKr2Mt/tmRXHckPL1bUazKne51mZM+BJMCWoVRrcmpBH8vRMGEVzbunkjcAGpwGOzvhSkVfLe9Rkz/m+Pm4/2EgVLvXGogMfuIcKtE8ANu6is/65wp0zyp0x5jXyAw54QJcaGMoceEGwAt/inhGmWKEbt7F6YIqmVqvqvG7MPodw0EabLYEGWUqqZxgKU+8QqXLxEqTqmx1IeECEIzipyVJ2XIZJsRHYGGfA==;31:P/7yFPswZ572uYyY6WJIewwUD6tO1M4CDO69KenUMNxddiZGDIWiZk80bLeWwe30+SEcgkoL9pN8wZ49EeHjtX9PQ+XyLTdXe+UsBG5lggY6KCA1mhBaYZ9++s8FZAwn5b8vUbODfwyNquUukeYCixtpsDbWBFyK3T2y5erGZi2fkxCte4YZOBd30usHgNKtfsEzwjHsmGvzVQXSAgYH/+iMyKiqpDNrfvQvvlRW3yk=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:O44LvNoCUsTsq6yFQCcbHPqUFUoLb3vgaPUhiCf6ZcMrDFJq+/y5RD8O1U+vqyYTA2S4RfR2cPeyaX0YVw7q4629jr4U4fq+9Hep08A4QyFdZdDmi5tR5+iPYVz6rTxH3s68PmHAksgwukWnA5RvjSCgFsOVLjTDhbrILXj8N4U05/SowT2GQSOfS7ameKZVlG7I4opcEAM5VHK4/6YSt9duUgsnH3asf3tcxGSZILZjy+hssiB4vnsLv7j2bJaG;4:nLLE1uXyk/N843Ukj/UTEVS5faGYNR/+AOXQswJUQhedry0k4dd/zpNAnMnJAumWQTqPorl87KFME1O9ryvqVx+1By2LYZbKIusD0a96nfme6wuFBeS6VBEil4ZC083Jc8XoT6AmohfD/zx9kpLNVzMZowtM+jlF73Nzcm3mLpM01g0hJbVWd+Y6xTlBV9MUbWKW5kXYMCVaV3+VEwQcGRVAYWS/b3z8LhdMyxA04fVgWn5tX7W+Kqd80IHsH+axTdRSu2Zv0W9erYPjVCg4Sg==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4941FD2EFE8C36E8640B18EBC15D0@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(346002)(376002)(39840400004)(366004)(396003)(189003)(199004)(50466002)(97736004)(2906002)(4326008)(25786009)(6666003)(14444005)(16586007)(68736007)(2361001)(47776003)(46003)(476003)(2616005)(486006)(6116002)(42882007)(48376002)(54906003)(44832011)(1076002)(6916009)(1857600001)(105586002)(8676002)(52116002)(6486002)(50226002)(6506007)(7736002)(52396003)(386003)(316002)(6512007)(186003)(478600001)(16526019)(81156014)(81166006)(51416003)(2351001)(36756003)(305945005)(5660300001)(106356001)(53936002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:yramSqjKu6OWv7QsBHi/OADf3ClR9a+BeHRExA1x6?=
 =?us-ascii?Q?Xru9h5DG4lX2xe2RMqxbytaUbo8WkdO6cZ+di6vZwbHElDMSq31SKwLn+kis?=
 =?us-ascii?Q?pA1o3XGdxpjDXl/1DfYiUGFms4bY/RHoz3qKviL4SoJAQ7gcV7AQOYWpWd/V?=
 =?us-ascii?Q?Tbg2NeDtGFnvqKySY8MXBFTmofSaGMgy3VadASZ/HZQpVzDDeSW10EWIke8b?=
 =?us-ascii?Q?97PhYP5Z+1W9fJhWIDo27st/1kQPo9ieWVp47GTJ5kG8E9gcr0XS1/d/UUrJ?=
 =?us-ascii?Q?2OPUjd+TwnjlyBndsvaggz+C4qbhVFf5DdFQQNcu5C0rl3VQlvwppX4L3m4z?=
 =?us-ascii?Q?KF+v25QMn2t7GbmKxuoh1ZZxz4GJpPxI/7JwA1gBotLLlvjZ1GOkUUCXghnC?=
 =?us-ascii?Q?QH3o9bcIsRI6sxnl3VH/Pj0qYoCezZFeM76y9VRo5zCat6slR3MMSzvcQFbV?=
 =?us-ascii?Q?J98OYg2aAvhlRHNI4CQRjHJYqdT59UAtxKMBr83skdQRrKZphYTYWjhWaOuY?=
 =?us-ascii?Q?usgNv4bIQuclHy8Nm+2DQ2HKcrsqIYMmhjkYVOIvKrjhyrNkIE5TZC6KBVEs?=
 =?us-ascii?Q?mn/WShBT3layMDIZboA2KkZ+v78UvcMMysav7BE+J+z267wt7s3J4SdmLCp3?=
 =?us-ascii?Q?lNO+x4jmAL/I0463dRgCXw5cPT2uBkbzv42kM+2cbpavorWyVNdEKbUs6aaG?=
 =?us-ascii?Q?H3elmmqZH/rB8Mf6N+9dzOWi3lh5vJNkw/2H9NkgyFi7UzZXqc9kNf1tVegC?=
 =?us-ascii?Q?YSeW6vV9u/HJ+MZWcxti9RRLn/3U3Z5efo4//TD8dTsXuPVSICSbD+r9cdfP?=
 =?us-ascii?Q?y7+GyEndnslO+UzDG0VP5XHWrJXx8cXYVjr0tAs35HRGY5hjE5mdPuv308Ce?=
 =?us-ascii?Q?Q2rkE5aSfFWLF90zEuRRLwRx0czyotGMAES+f9lE+XfQHbiCcsSVbVCGD4pd?=
 =?us-ascii?Q?R1snvB0qgR91qhUTXMYQROBd88yEKHN9wmOdKNkGRzv/PXnBZpvwJZpcMbj1?=
 =?us-ascii?Q?OFKFC3MCAVw6KLvMytuksjwq173ycQFUHxnCnYr5aDeUeAd/CzKuyGAkJCJ3?=
 =?us-ascii?Q?d8f6KJKLCnoF86nT9s7Lhk46+LB5iDLsc6dh1CQ0LqN1cBHraW8Z6GHnm8te?=
 =?us-ascii?Q?DYW3VzkGD1mVlULnZ/9p3Vf6s1VZo56ouGFgObZdscEKTYfUqbGY/HkPe1pf?=
 =?us-ascii?Q?qfpnfCj0DIyf+RaEe5SioJTtBc2GSj1xmmVLrd8dMVJN/6rQWuFg2ItVQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: PuZD6HNdhi8RoB9SjwF1iSLYiKOu3+Cf4Witn6PnidkyF8jJoQR2HZJ2LOBe9sFJIslaqbjZayThE8vo4VVnZDQLwt1cgQ5YJB7KlPm3Jxesay52bU8e0pT6074z3muU+KlY9/H/hl1ki/cKbAj6pNyIPXMdARX09Lz51ueGDy/7setBwu3Atqfzq7LC9wTRmHAxOUE/s1sb/+XVxGIJPfpTsSKm0+Uj3micwe5NTyIh7PNH0R87Yu0WuG0gLQx0OHFN4n1Yi0alpMtONkYgoVc2+vzKJhZCbSzlnQXLCIw/yZPuPuNulWz7/7swj/eepqU9iW+jIwG3d7O0QMugsATkbgBaieVpCK17xMG+Qe0=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:I1W3hjrSAchgeHaiqs1WwW/woPkIQdn4XD6WwX4Cy3T81hnPUtGjseS3AXO2+1jxVs0e4CdjIPbk0Prc+4qovMNgS402FzxUd6+on8tHXLpDQ632XYlkbj89xeyR0pQAE8PLldR2hLmgKbnuMH0v32MvZZy/aSTlw+KNdzeBtzd+FIBoQAvxnKxqfC/kLkJu8OOLR7ArjsNMSula4IritGooUvCj8HuEcTYIBFSEXHfjpS12zhMZriQXl9SuRW0J6IXR9CZyCkFK91AVsnHED6sg2+mB1hnUGHWbS8mt69Hf8JwqVXwZCQ7SiRocN4A5MdGK13sydhIxHFUeiWeEVioiSqHuo7jjlQHqVfRFfY+RHEEhORN4nga9nDvAX9DbP1KuauteGk+opllJEvUc0Sb1jCyndYLqxP5heg87y8KOGCP4vyHKxU4XaKoySY8G45VmkufKCZHasP04LDPFFg==;5:9zA9cMCrJC63DHI9AUebgkDTihlaPIO1KxrQx5SCateq7fGHBVVQFgCQoXg2JyPkrh2snr+3+KhWa32QeYCY7Joieg6uq3rtm6wRDE2MEbhRt2oN8K1fN/H/1ztJw7TrVj88S35PliuR0/BjT3Pmlf5s5KiUZEyM+5lKu9xNrIg=;24:wS2jVyDz+1ImqIqw93g9swDDKb1vsN8ZneM6q0k0d0Pr3ykKtZSAEnpKx5kfQjF/2qcl1BXKmVlNIOuJh+BW/RAOPXKtcW1dA79Q+dKxsQY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;7:6MHJTdPzbiL2Eh8T3JeFX+h9rLTqpy8AJOV55kvQekqYJxo2ZiIupH2rT9NzErvA58qfV0mRw0CHgysm+9NQPHFm8HxROTagsqCfpNfaUHScwJm1aH9Qvl40YpdnY+2uuM8kS5idphwa5QhtdesaWJUOd5M4r+BZMWe8HG/tILvVngd+6vb2pGui98/LZ8QSwmzZ8WUlSzXrBrfoSFDOSmC3JboKRSr9Tm+89vlsm8GN4EaoBYiEPVO7v3EWtud4
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 15:27:43.1321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1b9334-7152-436a-bf48-08d5eb30ad7f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64861
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

The PCI_OHCI_INT_REG case in pci_ohci_read_reg() contains the following
if statement:

  if ((lo & 0x00000f00) == CS5536_USB_INTR)

CS5536_USB_INTR expands to the constant 11, which gives us the following
condition which can never evaluate true:

  if ((lo & 0xf00) == 11)

At least when using GCC 8.1.0 this falls foul of the tautoligcal-compare
warning, and since the code is built with the -Werror flag the build
fails.

Fix this by shifting lo right by 8 bits in order to match the
corresponding PCI_OHCI_INT_REG case in pci_ohci_write_reg().

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
index f7c905e50dc4..92dc6bafc127 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
@@ -138,7 +138,7 @@ u32 pci_ohci_read_reg(int reg)
 		break;
 	case PCI_OHCI_INT_REG:
 		_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
-		if ((lo & 0x00000f00) == CS5536_USB_INTR)
+		if (((lo >> PIC_YSEL_LOW_USB_SHIFT) & 0xf) == CS5536_USB_INTR)
 			conf_data = 1;
 		break;
 	default:
-- 
2.18.0
