Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 18:33:59 +0200 (CEST)
Received: from mail-eopbgr730124.outbound.protection.outlook.com ([40.107.73.124]:52163
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993891AbeGLQdwnQWDy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 18:33:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9xNT5aYvBDpVtLDWmDBZxhNEIMBnUEAqd+tn03cI2g=;
 b=ib12aqh3vPSxepfz0hAtx2WJesVttrGpY/p/3VHXZYrFov/7p57D0QdX6PRat7mxXiFPuqnle1hSRswe6p7wM/6TW1Z+E0c0WiniZJRNGvD2tcvbC0uHjwgkk8Tat1vG38OJgPHgNgvEXFUxymX18xnIAXAeHRIDS/QBhM+BOk8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 12 Jul 2018 16:33:42 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org, Rui Wang <rui.wang@windriver.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wolfgang Grandegger <wg@grandegger.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix off-by-one in pci_resource_to_user()
Date:   Thu, 12 Jul 2018 09:33:04 -0700
Message-Id: <20180712163304.10553-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <4bcefc31-a62e-17ba-eb10-a3cd4e8bd06c@windriver.com>
References: <4bcefc31-a62e-17ba-eb10-a3cd4e8bd06c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: SN6PR0102CA0010.prod.exchangelabs.com (2603:10b6:805:1::23)
 To BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97bfb6f9-27e5-4ba0-b98e-08d5e8153b69
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:hm/8Vl3YTg/Izz/jzfFIi9XMW97dXDX255JBMed007Yeajl0PMfgwTs7gXJOWZfqfox39x8My7k6gog5RjQvDQ0EW5AG3sLHPQ2tCEibyhP9trSb5xynfQJakJ/9rGbuCzAhDvOwOGLfcBkud3WwXL3qS8Eo7K8vmzzI3+mtiDwQdU0+lExWH154lN7V3VnKAwQRWkYOg0hibnPoZGAIjANdBcKXIMieqYN1yDFh9IiGGH/lKRjvv1qsoa9bjlRC;25:OOXu5fo+QQ4KPXioWXlFrThSvjEFIaWIv/v45Td6j40C2kGMT3IJX9e+820UlSd2SNDOavSIA25galLk2MzZOmvIhF4GhPtUkkFjpR2YPM6TPSu40Bfzvxoxa1eh8eCmZErjIm0WI7yFcawLVMNFLwTJKWmaD+63Qh4T/R5tR4LJfapjKW9q8HJuD6OsLYMRMRN8w3vnzd+YtzFBMv8TmnJ3OYOFn1aPDlvDn+O28Kf0SwsDSs9ry9EqphNZn8iflicnTNkUFobPghQv3XgiwizR82JKn9nRLvzQIMMpaGqJkz+AQB2X4St/qVzxj8qWivCOoHDcxhjvTNJbrjud4A==;31:dcCfUTQF1iNL3AZvB/08NfMnLCueO177JGJIXyUMhekfbyKEYpeAtzx0JGuhqfvSb1ZSnSL6vfhSrmzGDvzmIx3jc32Aoq52eeoBHcbpfFYAeJtFQwWy25/394SwUZ1XW2LZBdJ2lwzbZpU/Df2CgL7qRcCLCajKCvyMriEw+IxEvncI3Qg2CmbxyXySCQcXkWGkC/mwZO78losfrSKmcVXm2hBOSEGzN/ywl50qH4E=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:4vwO/HhhzhxBEtgi2jVVZVC3CI06XrQrBeJac1r/4IIrdLGui8O0/IAsx010kDqDlYQERDdr8boYweIo74LVWlpJF9gH3QENx4gz0Ws23tUj5C5q1XCcGkDGsk9vqeLv2YhvAzpy/X+dVpxHzXonjTyNvOnBIGimH1wJNSFxk2lpJ/1HiTphdgCyO37W8A0ysUtXtapai/7AhX/Bhso6cAvur3mai7D1k0mQVZEFKKt3zMkgaVbt8BUmPmtbvMTi;4:96N4wF6+KyjuQwah6M+X1qUyMgqNXknpvwAHcmWpWSgrHUQzVspISrqaBOzvWOu5Ew6Q/pSAf8IVcK7xdC0r9dMSQ0mn9t8reOD6YzJJgC3azci4WWyt1PDZ2ee2mCbnmlituLLVDgtAE/KdsjXKO5s39CZgpQWxp9pBAbN7HtAx5xdzoLKpKVvttPDxOaqrpUspq8hL+jrqOmmM9kJrHiFLxU3B4XXkMcyfaGY8NozIdFjiu5C+k3DsEsvQ2ItWXO5kJR7S+rcYZHUbLmStaanGfPYYo/zsjcQqrn0xC99J0w95DFRh7cOrKVJWhM3V9KvJaCSIbovyhOa5TEqLRQ==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932A5DAA062F596784A55E0C1590@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(366004)(136003)(376002)(346002)(189003)(199004)(6486002)(305945005)(478600001)(7736002)(68736007)(2906002)(956004)(42882007)(48376002)(446003)(11346002)(14444005)(2616005)(44832011)(486006)(476003)(5660300001)(53936002)(4326008)(50466002)(25786009)(47776003)(386003)(6506007)(51416003)(52116002)(76176011)(16586007)(316002)(53416004)(106356001)(54906003)(50226002)(186003)(1857600001)(16526019)(66066001)(6512007)(26005)(69596002)(6916009)(6666003)(97736004)(36756003)(81156014)(105586002)(8676002)(3846002)(1076002)(6116002)(81166006)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:rV2wTEvGv7apDq1KKeBkEdZFd2cOPLE1uK9gpvT9Q?=
 =?us-ascii?Q?CyzzhFzBS6bUfbnosW+IBbHjx/chl8W4CHCW9ZKpg5qMvQrO2EdQkrNYdBMr?=
 =?us-ascii?Q?trl4+UIHxmDilugi2Pd7c5kKFec3LSHpfYPmDSEUn4Qw41Z7sjknvmH3SdzS?=
 =?us-ascii?Q?0J+u/N/23AllmjLjSY62TYlrTVrMcnNoLzeRLZ0HpaI6QHFkY7nFfeMSuKPM?=
 =?us-ascii?Q?LC4CRSAKeLxI3W0sRpslDfFHDzZsrKdTWxmIbJ+tkhycpiOECuo5at2cZPog?=
 =?us-ascii?Q?2fkuunupOda8w23aPnjGb9sy0HUdA81xrLE+h3B5C9dKaAbCnI1VW+LpGXC1?=
 =?us-ascii?Q?MLd3IcVNxRlIVixvKM+pnD9iCOn3x146bjtTyUtEc+In+Z54hjQ+acb0HGPO?=
 =?us-ascii?Q?ho3B2PwEbUhsI2FrrrdbFHTNDzp8K+MVUoBcaW9/waQ8Fj8sRhVNIgl5cd3F?=
 =?us-ascii?Q?C6rTCh99kSFAPn0yEDK3ucgOuZ2zUK6vyM4XPdS8IZ9364gIS7YqKjXtJ2+K?=
 =?us-ascii?Q?Djkg2JjW1AdQOYhz0bfWw7Ol8fmZnyxrdOFGTH1YtwLXEoYcuYNEDmMAf5NG?=
 =?us-ascii?Q?fHLForu9Af6+q/PnBwDNHnZczKRlM+yVpIN0MdldZ5t57vn+Sk52wVgZQy/y?=
 =?us-ascii?Q?FPufo/FLrodmZNp+9LvzOjKJuEJYhy/B2VJ6128iG/Rubt/w/RHkkgQ43lWI?=
 =?us-ascii?Q?bD+oZ1GLX0pKXE5whDHcHv8FE1GQlIXWNaePSqumkrfGhhUlnja0jhEvw6gZ?=
 =?us-ascii?Q?on8PTMwuVfoWUrDcXqPKGcw1aSuMTTq5fGsj8Pf7mJrX7fhAs3+eKHQ1SiVN?=
 =?us-ascii?Q?1x9vh5j8A/vU+1k3AG3/PTDAHwxvh3rASbS2vqj1/nmZDzH4pscziyFuTlf4?=
 =?us-ascii?Q?b+Qe2qa3rxfZoZzdI5/QyAglnkPK+klzkVTiEGCkLRgLfwLlYDbm26JEqIN6?=
 =?us-ascii?Q?ZlILbzNK6vHMz42YAPDsr5lplUaGWfanMidR2g1s/Mt1I66lmEbXSNTYYFrE?=
 =?us-ascii?Q?xdlUK0qtOcBgpKNdAqj138P9Ms34yAypincKmIqitqiVpWrlCBEECw97lhb3?=
 =?us-ascii?Q?sMS9RZd07YnVAhu/OC7UbLZ/nWBMDQrvQWSmzXfE4Svf9n5WE3nrQAOVEcrW?=
 =?us-ascii?Q?D1V/oqVSPSq4vzhq9VT58sC2Q5Ni1xSUa3wtIac6XaqE2r/nMmnQs2TunhJ7?=
 =?us-ascii?Q?kjlvylqErvVYocEVNpShHkySzu3BccasH8GZNv1S0RDJk63UhR0KCt2H0KJy?=
 =?us-ascii?Q?KVeGIkeXxQJNZwqkv3GLZYVG9qu2vAUBiPMXT8wMFVTaIh7wEbHYLd7M62fP?=
 =?us-ascii?Q?RUikobdSozGrbXesQS07iw=3D?=
X-Microsoft-Antispam-Message-Info: 5SPs+EPm9MsejjrqVi3mrpgBNde4RsLbxtO8nhbWVuj+srv0y9wJ3+GlOAjJZfpFRt9bPTEmqdFxv1X3iQVlRs4wEYcbbyKwKD1APzwZe4VDoCWb2L4jjFwksmT3DzAG01jQZ6FztrSvL4qXPtzVFKS5qH8Z3dr+81wzHhrCx/AjxrKRG0VYkXJSvAtW22W2k//AWY1xpraxJjsJJm3cTFAiL4e7YA7qBKRqpThY55bV26Dj14tnrl9M51imDlCZ94kmhK1kc0Gdv4aMCIid7nozRR26pSvbZtaIcdbhkt8ygb1xXIKTfeJfJlBjyX9ZiP48yUr5i3t5iyiJHGFzEViaiAPqxSsXzPR07UymdCc=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:p4Z6Vpkoh6rzrXIhHLUee2aDI8qB7F+3QuX8IaBSYlGViP8hD0y+GCO77t6PFOs9z+pqiMyUKX2NcuucFBnhvL/jOyBtYCbSJV4k3GkUh0QV5CdW/sbbgcGPQvShfYdwrxSUp4b4tdTpE8JNvNIZdj0sWSEHhO+HmR6eBCrOmcIFC+e2Pb74ow2oVeomf4vp1H/Kek3CsONmkzUePMH6der8cnGG5QrqgoGfapRGRrJS+e3Wje8/4XBZmeGMD0GuN4yvOQbW4Brevqbkej9CFPtKfzeedHsn+lfY7buGl+67R8OFOHtGBb+nSaP7XHHMgWVMaY8XIr9Hh9FeKUUZEOqj764O63Sgn2b294/4p3oAv3iP4T6Ge6uuJmDJlx0ZDwAGKPubLLP55O6Y80ahNOxOOMyH2ZkZQrbXwgtCRChM2xb+EGDxCv/M3PDFaiUc07Lw4Di74M4jXibb5VbUsQ==;5:iXKtAwSr1XDAXv4ggv58hI+PyhcD0lvmmBXLyBgYWzxj/ntIRkDE85hYV16cKIXyGP6LrO7MbCqE6wm1Js2eukklb4oLdInwncR4XI3f7p+w/DLNKRWIq0NpS99tWlnmPuW0QZbNeikCFMuESTbVFCmYpfH78lwXdoRDZ3b0rwM=;24:EYaH3pNMVFypu9M361nvs+39DDXF7f7g8jblyp03YVjlZB+Zmm4LrssuUebeW2gQhnNmNqlIoIg73NC0u/eF3Pvt1tuh19JcjjnT96dR480=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;7:5CREk3sFUoo27XqHcFN9SspNB2nAGftizUQWTnmYShOkoglZ3dt93RpRjJmfX3QA0AXLWvSZwjUjVHdTI67YE4DgVhTrRMEIxaacOHvUZVO56lI8T1piQp7Ktay5Hw8ngZpXjgLZy2lgRAGkxM8qPRvjWToYJ1i3A0E/hUpaBLcQN8KvodtkMMZ5nPxzN6lD4YL2a0PWnxj+/VUsh/GEeGSUIZ6ppFRnEhkuIcXSjI2rpdBMpI4qdsViabtxCgE4
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 16:33:42.5340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bfb6f9-27e5-4ba0-b98e-08d5e8153b69
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64819
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

The MIPS implementation of pci_resource_to_user() introduced in v3.12 by
commit 4c2924b725fb ("MIPS: PCI: Use pci_resource_to_user to map pci
memory space properly") incorrectly sets *end to the address of the
byte after the resource, rather than the last byte of the resource.

This results in userland seeing resources as a byte larger than they
actually are, for example a 32 byte BAR will be reported by a tool such
as lspci as being 33 bytes in size:

    Region 2: I/O ports at 1000 [disabled] [size=33]

Correct this by subtracting one from the calculated end address,
reporting the correct address to userland.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Rui Wang <rui.wang@windriver.com>
Fixes: 4c2924b725fb ("MIPS: PCI: Use pci_resource_to_user to map pci memory space properly")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v3.12+
---

 arch/mips/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 9632436d74d7..c2e94cf5ecda 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -54,5 +54,5 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 	phys_addr_t size = resource_size(rsrc);
 
 	*start = fixup_bigphys_addr(rsrc->start, size);
-	*end = rsrc->start + size;
+	*end = rsrc->start + size - 1;
 }
-- 
2.18.0
