Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 19:46:18 +0200 (CEST)
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:44640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994748AbeHIRptaIwGm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 19:45:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZvGZqVhafGThUeBzNSeyouglMHIAbzbWO3mjYsJFU0=;
 b=okzHI/yVlo3EUCeg/gfKnCo/4uX3oTYLcu+3HqAWX1MMzpyhFocJ7SQjQiue31ovxl6rAketGsTKsCZxyUslsKkAadZ8HgiyUfhlKDsOAsyj4fkJMZk5c3g+WmnSqVyBN6qACX2KloSanTBJnx6Kipx1E2Gx4FkWr4YdWLvT+sA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 9 Aug 2018 17:45:38 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v6 2/4] um: Add generated/ to MODE_INCLUDE
Date:   Thu,  9 Aug 2018 10:44:42 -0700
Message-Id: <20180809174444.31705-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809174444.31705-1-paul.burton@mips.com>
References: <20180809174444.31705-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0025.namprd20.prod.outlook.com
 (2603:10b6:405:16::11) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa78020e-67ea-4d77-f5cb-08d5fe1fec05
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:MrQd2QYDF/YvBdrffGksBKglh+mxoSza+BvWyWWeWj8ILKiiAuad+xqlkeTGh7sCVErpSoY8ffXYDMjTGmSwGhAEpxVJTjMYdun4M0VMm1C57hg9ybPOa8GV+BBg+foRgPkbVUIvglUhw/34hNURpLUh6affILsmq7gGLF1FH7kObmHW2DpCJXL1UmxTD5f0kD+SiP6wWKF7eeoPl9bb2Db5bhBbkT5DqmXYmL93/rvjDh4QPd4WWckcX41TSXIR;25:3S+NdZuD1YYQ0PLDhWckFc3Plp5KLPWP5QkKC22qq69lRLVJNi4if3QQNvax7tnI2DhrpjgZwLfMGNATP5tVVOey6IUrKunIttMhYAJ9C10lGr2nSG9EmeXOLIi0YrLOV1i+yEeiNQX/V/H7ZK4nqOQPXlv61o/9ayKrrz/7AFAgnkfGwQPyjCKIGKpIlFlAuU8/cWz3UUnpGQveZ2b3mb2CaQsw94JL7iBX/VG9TlJj0LXSw+wlVhBE9HW1lMSGQajoGRP8I55NY7AyfFCGJ7IPKJOjApEXdyaDxmWV28nu81dA9uNJYuiN0GGSUJ3ypO3RvKeuCg6Vd+0m+HhBgA==;31:a66AykhqISNuwvEg3Lm/YjeNcuVY9caj6RaUFrUZbiDePhASv+a5C4d01ScJu4NVgjUGIIZoFqFpWMr4Cbl1uKFH6tAkuK7UrFA4Y4COBYk3ohc9s8Zl+z9TBEoPJDzzTrlkM7hnYX3+TPlWUQyEGARkJKc8kh3l/u1ip3o/mbu44hAvfPnuqJLeGlypgc2HYitsn/fuNQKpxQCLy1l5u6eUXTZs6yL3n4WgveiP7Ng=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:laymgZ4potkLP3wfZIqgQTwd7mry/L8rb3SQOiyBRe2UVVvfG6OphJXou576ZG9a6Wj26+JBcAWWwm3YsJf0q7neM09br70n2v/7nOM/wHs4UNmeucAiXnTFvevUYXdvxhI9f3c8WFbCVbQK5C+f49H+Myd+FzJ76Ba7NBc+sC0zMxniOd2ychNTFCLzxLmtm+QSz87FObZfotOuu2W/+cvKeORZcxxuCV6xRPrEq+luLKTjpZ0Eq+Ilj5IppUZL;4:UN4iY3O6yjmwDD+HiW4+Oj2KR7WwkvSk1+Il+9oyHuQ1K+s8hMR4eU0PdMfk+VWtoRF3AFRgjhUOmU0ShYaPnF6MK+n+m1pbf52Q/+8sJbc2aUZdnDUUYC0m0Z9dQ7XKn7WAyeyRCs5FCmH7YZANN0o4sgxhuhztRlm56JIdRXIRmNEnwcPEqro7OhG5QyeuFYDh6z585PTdt22pHtBOD2Oml0vRK8my2ty33RnsIexYpToNrSWF73y4TgFgEPY0CNsN+GF1efAO+DlaL2Ig9eVyIknPAQO7pKP6Hq68iZ0q+f1JaJ34iGPnsbTxBj9dSh2Rt1LTTmczQInu7sYI1MLOSL2qBGRyfxe348sJFEBUd473pL7nV4xocH/O6q/8Uzq3dzxnvmbTcR+z5kg017Ys+Pbkfih2b4feq6ZlW9g=
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929F28A04D04075418D3995C1250@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(143289334528602)(258649278758335)(42262312472803)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39850400004)(396003)(366004)(199004)(189003)(47776003)(2351001)(7736002)(81166006)(81156014)(6116002)(3846002)(186003)(16526019)(6506007)(386003)(107886003)(5660300001)(39060400002)(25786009)(1076002)(26005)(8676002)(6666003)(53936002)(478600001)(6512007)(105586002)(106356001)(2361001)(66066001)(53416004)(6486002)(305945005)(6916009)(4326008)(11346002)(50226002)(8936002)(69596002)(476003)(486006)(97736004)(316002)(68736007)(51416003)(52116002)(44832011)(76176011)(16586007)(42882007)(54906003)(50466002)(446003)(2906002)(7416002)(48376002)(956004)(2616005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:4Q08ESR9dh04r4i8pgUp/m0fLShM2wpZ3qWI3Dile?=
 =?us-ascii?Q?+ghgv85bhnuRZ7cdEjnouU47Muut/TXbMdfY/HJxgBagiknfs4Bw58JoxNXp?=
 =?us-ascii?Q?K68dQLziW1S0/ZQS9LeMr4rAHGWWh1g/MEj6IHe6srfdSD2p+F4JGpxq4P2M?=
 =?us-ascii?Q?hh0Ddrj9X8rjCPmTYoIIBsrSnvg3sgSBV6vNVZKRyGKtwTVGBGqOmGt4ExZ9?=
 =?us-ascii?Q?2uG4c188ndeypfv2Y/ts6SycvsEtpk/UkDQSygVtdf1pUpIIIi9RPoxMQXs/?=
 =?us-ascii?Q?0Y42f8JIZGGEoRTdC+uq0wERBS9vEE6aiWMzaY1UkZvEA1aiQqIhJRgHl5BP?=
 =?us-ascii?Q?rK4wqxbJ4+/khVv2kptF/pc2lmA12ybYhKhVwaup9e2h/cdkTg2E/xEIZkAN?=
 =?us-ascii?Q?OxhwqqDNrTc3bHrhSQyzmPIbHBPzx9rxUhTyazxvwEYuNG4AU/ntKpMWIBJX?=
 =?us-ascii?Q?BdRP2+imhRlIsAhghKmjxgud/5T1DMTBv8Ve9y5VbgAkvWjYRbiYhOMcX+jy?=
 =?us-ascii?Q?jYDdluMP8JHy4HDeaiFRtDbWMlb2w3hfhdxfsDCGWNWjEJHc7LP7XTqv7fRK?=
 =?us-ascii?Q?zoypRfO7JUJA4vVkF6ViFSFapOazN+iJmXeyFgbeKfAlXiAQoaqjgTA+uXQ3?=
 =?us-ascii?Q?tqPNJbGpbPn+8zNhFDRK+ujRR3FOj7b/3hfG+gsVk9v/BjC2hEIERg5TV3wn?=
 =?us-ascii?Q?399UNZIgQy6EeXAx7QjOph6H8ZgG9BGXg2rPb5cgHLabKQCoWKuJLs/8G+vp?=
 =?us-ascii?Q?U5SL80qLucpue0TzdPa8VN1L26iZ0ZaUj5rRXUfuFDXXwEZrgeGbQmkCdn/1?=
 =?us-ascii?Q?uHK56rMr/q9XuZbU57LoPiN5wBDvnlpmwRcArOmhLljVpmRf5v6Cuc/4KohA?=
 =?us-ascii?Q?Zk0b4zbi9trN7EYSkKz5MJWBMjzHlVx1Dqa1o5bX+Ht96zSGVGsb8DkxLNUx?=
 =?us-ascii?Q?hK/51BfCb193FVb4CCm1tdvdq4eCDbizw2kZe2oAkvSwdqcym6huRL5WlQtM?=
 =?us-ascii?Q?xmhoQm23p9mmlJyQgbL+2nRTPcH6S97QHOjNrXOcwauNFhpN1ez3tfqPYGFm?=
 =?us-ascii?Q?KZxnSPW4+n98CzDd12f8pWl8rmw6vvHMixbox+JsY0S7H63ntsLYncJhE5eR?=
 =?us-ascii?Q?b3p5V07WKHbretE1Bt+tsDYglKKC5rLW7WqIHIT7fGZtC8DgZ+62adNfQAJ6?=
 =?us-ascii?Q?bO7GIUjdknTOWvElGuzJ1CvP82/boycN6AMdjAkmGYiK6oMLi0R5stnJNNYX?=
 =?us-ascii?Q?wjEvK42dwHWlMIFxJRxvkte8u+fji9YiMaYD9ft6SGI3QU+ymAYEMpLVHafI?=
 =?us-ascii?Q?AozlvVZ2stHLCUvzZgbbxZxUX0ZTgpsSHEg8VdTGfGSZvj5dRf8kDq+DCn87?=
 =?us-ascii?Q?Dhgb3sxFqrKNjxxrfUlizJvGkk=3D?=
X-Microsoft-Antispam-Message-Info: TF62tCXhToeiCBPygPRfPlFF9EhDMoQVNHvT+zccI6FMlTATKnlGRtw1jJxaFkZNr36gm43bJ97RwE7rnY2TgWAxeYjrso8xK4v/9BcAOJYM7XqLHUZMB88VqS6D7g1h1qhhbRP2mphVgvsRpSnxksuzWl09ZV3+5xMBVISKeYDs8GkC3raN94/P8j0I1QFx2LbZrDbPe4qKnegB1fKVGxEvnfX4OFZqJ5ERer4/pi9qhGt1VswNyzvM0JrS4ZCo1Zx5xt1hs2mgQHwj5tNA9HzHiA3mvpRQaJiHW6HyrIIbLnBBoEZ1zIPSXeLT9Kg6lylY1UlBcuDgWojSTv/aE5COr/d2IUhG8UaP1vmvBs4=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:CNMjmvwh8NQrA1+oGMsKRaILNR7poVyoSjxtNMMFFIb28gQCg4P+zUdMG5b77q0j46C2/lHDnE0t2lqN8eh8BySbfXplP4eTlMqYvHTtKgf/WNeESGqe1A87fS3T0/QjtfnE4YCNa6tALPITlI7DoKmByfCXa5vyZVFqjyCXkjacwAPC24OFzJkxCezXDyib21f2O1LOzHQTUhWu2nXnxSDMqY4DUd07sXjG0GDpxHWh3HUaZsixKHLV67FdJJkGPdOh33TagHFryosDozfte/o0fDbYVHQrUgfFbDartPGiShN4w7eEZGaJ++5VyKz6rZhDzMVNY1TXMI5g6kQavHbjoQo01dmec16OS0GTbwYVzRGOBXtS1XUVDa97BpNoebsZvJujnoqIotwh/WcwuiUdX/sDy8X9P81Xcq+gYl5sUdTGWh1azNghosW5+ZBvPVG3M+gF2g0qFV/iTvnfmg==;5:rbDqjDDHDpkLWkMJU0gw2nP3WFHamClA9dsUu9bIk89/ORcGbh2UxAoSuznGIwhJFzYFf0kkN/ArcBDlC39vIGQYzWFKKlLcCLa7LANljI/XCPKZIPGlD4+tx02XUM2FQgwCs4DBiEjoidUK5VCAc6PF3VW22myEZ/HN82wsIJk=;7:XGt0k05qdal+oQJKmG3rIxhOFjuiNVynLUiICBmEH+mWiA/AVxc6od9Ov8qJjgRa4QZkoDhJ6VRXB5tm6zZtohRK+kubSWj5h/ucMKku25pmhGltOr/UiOUbXo/kDLCJnyCNDz1URI4wTdESzfn7uIyjuXtaazTS+WSshxxHVXAMoOqXkkLkbBOEAu0BfoFbYQMlbIb/ylMMcqMcMpdE6spTX5zfwf0ZemFUOOlMdXYB0H7ELu2r/zJX0KUWNq8+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 17:45:38.8840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa78020e-67ea-4d77-f5cb-08d5fe1fec05
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65500
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

From: James Hogan <jhogan@kernel.org>

Add the um specific generated includes directory to MODE_INCLUDE so that
asm/compiler.h can be used for overriding linux/compiler*.h which is
included automatically, with um using a generated asm-generic wrapper at
arch/um/include/generated/asm/compiler.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-um@lists.infradead.org

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

Changes in v6:
- s/srctree/objtree/ to fix build issues when building out of tree.

Changes in v5: None
Changes in v4:
- New patch in v4.

 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8a0363..fec1252160db 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -30,6 +30,7 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/os-$(OS)/
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
+MODE_INCLUDE	+= -I$(objtree)/$(ARCH_DIR)/include/generated
 
 HEADER_ARCH 	:= $(SUBARCH)
 
-- 
2.18.0
