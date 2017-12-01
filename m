Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:21:33 +0100 (CET)
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:52096
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbdLAXTBJBezs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Dec 2017 00:19:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WIB3YCU0n/OyC5FLE13oAbLkXHJ+IIZw/rc5+J9SsRY=;
 b=GpEaVND/5XHGg4o5KST47h1a2d4gzoWo9QPgML6C3IfZL2sG+h6p/rOCnEYGCRDTIzpXvSTt1jfs1twdlNuOYkiN8Nq2UTg5JgqXAb6c30hBxEYOw3vEa0r0tWj00yLkoQCYOfFNcATWfNV9u5MPR+6mH45u+1bzj/J62vP25oI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Fri, 1 Dec 2017 23:18:58 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v5 net-next,mips 7/7] MAINTAINERS: Add entry for drivers/net/ethernet/cavium/octeon/octeon3-*
Date:   Fri,  1 Dec 2017 15:18:07 -0800
Message-Id: <20171201231807.25266-8-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171201231807.25266-1-david.daney@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (10.174.192.32) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c146aa8-0e81-4918-b18a-08d53911e6fd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:YFlaRlAY9FrD+r++Cv8607mk/cfR9dzepybADrXfClz+P3+Lbbeu6xTJ+yjc5+aC8yXfMWGqbeST0pqQFEWVqx/rQiQys+JpehN7aHQTZDWV9e6MPoSx3vjB8CXjASEww71oxaPGUvVel8KtojC/AShncw91mTrlA9fm6d0/EarLcDZl++U0XpG9Zqr7l1giJ9/Czoq1D4oRPyR7XZ1+1fZW2pPa5pZFB07+bXh1gvhZskwqCCNSzF8BUgPR/yiB;25:/q2jWchjbdb5WpQXC2QfPGhM3jO/r5xn6f87hqzCqZ6I+uedXnNycP8A4aZZydhsYnKzZb6rmZbJ7kYjn8/q0IqNJNrQ2gX86SOR0dDcurUnHZtgKz+rhyol+rpz/MRkbSw9WulVXBvFIEPynEpQwEE5jYezcmZEemXdiZ5n0pd+pZkwuO4lNaOTvNhNa60Taf3K5xafWJx+cuKi1DlTCfP1GbpidrdfiwAr69O4QLC5kVxViDxRxXaBRPAdr6l/IimpORFeEhnuCtdKDvcg/NIR6oKJY9GpwQr/fxgKWpmqZUuahRciDfwlSSuQ/ZopSJTKJlCqjTCVPlMP3DSGBg==;31:QjAku+CZXgW6kKG9+DfoVCapxZgTSQQmmC8tyq/3IgBxR9HUN/12smrC3zDF4F0vStqLkmUKA3EVGBwapG2HnO9pKWyk5njgJ7pCzRRQ8L7r4qYQLZGY03+mPiAxsdxPiVF4JnSmb0PEXRYoHIQJhS7qbiAGiDP7MV1TwJlYovYbhx4+odE8fAhVaBEkMYCQ1sjxytyT9CpV1mHVeqvCbTrvIU0WA5Qy82Iq/J+t4+I=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:ZfE5o06ZkUybuVscwmcldAnT/OpSTJEmlgVrU50wcuMkCk7WzcFRAxrnKkRGLUX7RmfFnuHx1MG6pvE0PgvoZPYSfGrS+QdfCD2/6rj6rWlg9kZKwvYfkrBC/wAYuLNE/l/BbHLe1r5jTFl5r49j699Gpmi71LDabVyVZb9hhPvLgCqFr6Cal0zmelgzRhmsUjXhi0KQW4p7WAbxH+FCdFUA8udz8i3Xh8id97D0DZ/Cdy2Rh7WJBvLobghAHpntQRtwHiI/IuyR4Q6p47obRkU75OjZ9IoXYNCZdF3VAYO1Pkx9QmcD8VTv4sGgjiRlf+tVHqUjO9kzEsdsDo4PhFf+1220QXfkYod9zjG+vUhHdE8iHPYL3bEnDbpsUK/mQ/iSFvM5dggDDNpNG1qP6SaYev6LUGibgKHnIC66fRsjkZWnQBip0GGaI1AObET5b97mD2tM4rwpf9YsekyqD14yBG5tDUyKDNN7435MoEBngS7wVEjsmLte7RhQKy3n;4:3Pl3DJdYko+YwyfIdYlIhL52BP9/q3ELgZ8F/6AxYLD6o57fiNP24s4nBSMsKi49xeU32hfc92ZShuxb+/LE5Yyqr4VSaNpQNTwD2TtM4re0VipJd/MtVuPMCRS7uPd6tUrGz8aZFSqj7qCGxDZhag1W15WVTUG5/oF+da34neglwz+4430u1laxniWZrjUjN+VXDL+98zubMOccM0xJMHd8otk3KWrSRylePHJUzD+GKYVgbC0Du9ocJJfmB7YKBMU/fuWizONjmC2o2aMVH/VmLs+TAbRCx0qntzpD0ohwMBcWafhMGYD4YTdbXzO0
X-Microsoft-Antispam-PRVS: <DM5PR07MB34993ADD8D2D29758C506E1A97390@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(199003)(966005)(47776003)(72206003)(1076002)(7416002)(50466002)(4326008)(66066001)(16526018)(48376002)(33646002)(6666003)(76176011)(97736004)(86362001)(68736007)(25786009)(39060400002)(2950100002)(101416001)(478600001)(53416004)(6506006)(106356001)(5660300001)(3846002)(105586002)(36756003)(69596002)(8676002)(6512007)(2906002)(6306002)(51416003)(53936002)(81156014)(110136005)(6116002)(81166006)(8936002)(7736002)(52116002)(16586007)(316002)(107886003)(189998001)(6486002)(305945005)(53386004)(50226002)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3499;23:qSU2eQLpi7HDqrR8rxuCVoWFHQpd8lt8MoE2iG0Fy?=
 =?us-ascii?Q?6gsBM3TMhuhS6gmJAtrPojsZQft/i2Bx9yHlSF37Lw0dHPUQ0A4svR2/iKHY?=
 =?us-ascii?Q?FXCYkEx42mBGbIzp2JJdqjI2oiPDqWm2dx/2Gg3TIGGW5Xk/Btw7hDnQWEFX?=
 =?us-ascii?Q?w+MsWN0Rq5wrv5UQ62VS9XDiMQTEJ5oJCMX4Vr6s3dsNdIBOmluQ6dXOx5nf?=
 =?us-ascii?Q?enbTq4rmN6iq5to4Yfk5eseIexeGjkStyRmRrtNS75GsHljibB9VVPR3GExX?=
 =?us-ascii?Q?/77Vddp2Yd4YIJgmwgUwnxQzjupOUTSTc6/BGjOb5+z4l6OV2TUk5vLNWRpq?=
 =?us-ascii?Q?2+orJ8tgUqyyJ5eRnYhhDd5Z6Htqs/qx2kQYOsCJ6PoPGc6yFzgnJsyZX3Iy?=
 =?us-ascii?Q?mRlnnQ73ocTllrYYmXDazZR2m6k2cSGNgEexSCLVVei/N2s+BNTZgTYn7aCl?=
 =?us-ascii?Q?urEjW3eHl3g2GnK+cF9/U7Vo55byvdBv5efhOkBL5NV2Xz7egUtoTzVGozXZ?=
 =?us-ascii?Q?FIJaWFb5X9/YH9/vI6iHmxRu/2WJAiQv2rIdQy00PrMlRgfbtlTAKtlzfNdy?=
 =?us-ascii?Q?TwxbYPiwgtVmiPBdU9KPyoG450O5jja3CChBhu1zh6grnJET41OnwZKfMG9O?=
 =?us-ascii?Q?MlESmZ4w7aEDLP/jNpjK3cJE6zMSyG9CHvdNUE3VHQ6e5nFolKH2R8CyU7YX?=
 =?us-ascii?Q?oLzrj/hTR8WJgNMm5zrmpnm88KlV91FMYNUGZXOgdtgzjZI7GkcTWnUjXOjd?=
 =?us-ascii?Q?Agf2mZclS+NEp9P5nAuiK7eXqp/BC/xzaxNPNhBGo5HDuwY7f8DPS0ntIAGZ?=
 =?us-ascii?Q?kQfI1Pk/CrCs69RVTq5wQKGkYg0+rmmwfqzy+8y6LDxLeZ7EupQha8IUpJ4l?=
 =?us-ascii?Q?4YEpcJjCvtQdzldtFNXL37AqQdKTYU75Kyv5cmtAHmjwZrvrfyBM4OAXfgG7?=
 =?us-ascii?Q?w7h/khD6osI51K++Xf76Mxj3MsdlYituUWtJ1mu1gdBNWFKuCGEaa73wdhDe?=
 =?us-ascii?Q?wj3ruv+PNq/1L+5jAJdQnqWVkSA0zcKU1U4vsVkl3etuoEgZK8Nl4geLl9ds?=
 =?us-ascii?Q?ey7ADc5Vqn1T+QYMznzJi9RyFKPCv+nlKWde/3L8dIM1CMj5199nW77Q42rj?=
 =?us-ascii?Q?W1IiwTlbRKsVKxUCTAWQqpyZxHOR28lEzW6FqYiQ6drti3YUUaudk5qTH/iL?=
 =?us-ascii?Q?YRZxCGlZhjhpIxilTnYBdGjg4sRcvjUrKv8arGtH7TuIAExtwFuIh+V8nOZB?=
 =?us-ascii?Q?MMsTEO/xRNN1V3eK2pKWfFJCkUanON2rDr556yzX5xiKw1UM3A3YBMPtyZ30?=
 =?us-ascii?Q?sdqRx8VkGtbViXulcrVYCs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:jgSV3yA9zZsi3PODz2n+zVyxAItQIkaV218NjBCxBdXG278ZDRp66zG3JIVUwNim/P+aayP0V7CxptundjV+xaTIfXln3bbLJ6d+bva1pv/9ctqlk5iVHyD78rNuWAVI0aQqGBiyDm01qvIz5WwDcYogNWGsYueHqjM9FviUla91Xg6Cml2LeOYEZNAD8AoRoJZAaIOs5uDz+e+Y8PlDsJHp20EmSKSn7vGUYCEvJfM/hcSe65O9tYe4zkICh6I11OjEBQsEFMUZ8h53pi09jG+HZ9kY9IdLrkw7TiqnzY0RcmbgACkHzFjFhV03XAsdbrb2KG+N3jPkwhI8dr8pJr9DfeHGqxvImErGD1I0JSM=;5:6qeHlurwPIebFcZEmekp8HRX/v9A+WgwAHJUjBUDSbArVwf/KVvN3OGCei1y7w183clD/t/4ArwES9eeN9td4+VrxpOKs7OugtRVw/2ajmOtx2rdu1IY0CMBJqMlDvMeqZFFwBwY5EoQauFOo/QdZ/An1Cz8txtEklLg+eLedaA=;24:bU21kWHMKzN1LWaaOonrkQ5LNVsSGuPzoSULzXZ6ZeSDrz9Pj5fVK8Ru2OPFTkJ9mK38nX1h2/GCBNuI5lhkBQEB75/V31haA7AGEFE1q7Y=;7:HAIB1hcr9TpbhTI+Karbf4SiqVuk/Ly6bswWXy64phgURwA2Z0g0vpTtfl2w12nxWop37FfomfmhxamhnXm4YZajE5zqsCeQHURkgBIueDV/xEoPrfs+IHgD9BhtndCR9aT54LAK8caPXGbq8d43nZ2P03H/CKpacPs6sEjdb/IATMrvj4rZU20821gUocvRcC4gO4gn9dE7cz5riSQ4GO9jMSD+B9q5tbCYS3q20en4hMTCEFRkcB1eX3kdvGID
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 23:18:58.5406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c146aa8-0e81-4918-b18a-08d53911e6fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77d819b458a9..5aff6fb41b21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3249,6 +3249,12 @@ W:	http://www.cavium.com
 S:	Supported
 F:	drivers/mmc/host/cavium*
 
+CAVIUM OCTEON-III NETWORK DRIVER
+M:	David Daney <david.daney@cavium.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/cavium/octeon/octeon3-*
+
 CAVIUM OCTEON-TX CRYPTO DRIVER
 M:	George Cherian <george.cherian@cavium.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.14.3
