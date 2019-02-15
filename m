Return-Path: <SRS0=/Ny7=QW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F9C43381
	for <linux-mips@archiver.kernel.org>; Fri, 15 Feb 2019 22:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7813D2192C
	for <linux-mips@archiver.kernel.org>; Fri, 15 Feb 2019 22:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IsgOY2Yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbfBOWDS (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:03:18 -0500
Received: from mail-eopbgr730116.outbound.protection.outlook.com ([40.107.73.116]:10846
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728589AbfBOWDR (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 15 Feb 2019 17:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j57nb27h3MXJjEtEjh52GYMWXaxL3q8BwqW8Xz8yoBI=;
 b=IsgOY2YqLpXkjJT26fIUZ+rcbB2/HT3bbCuBotWUCAJ5nkgINDDwQWgxwV6hQGdKGoMpQPw4qFa9Lmc8Qm6pGCfcSnkTLV6FU432Rf+FUvZ7dcYvA9n8ua1wWfCSgYFXKFRjRui+XbhaoGBIBAuECkuslVLdpfdLIrCyltuVP50=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1534.namprd22.prod.outlook.com (10.174.170.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 22:03:04 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 22:03:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: dma-noncoherent: Remove bogus condition in
 dma_sync_phys()
Thread-Topic: [PATCH] MIPS: dma-noncoherent: Remove bogus condition in
 dma_sync_phys()
Thread-Index: AQHUxXo5rh7pYxECVUC/VRrgIWfN0Q==
Date:   Fri, 15 Feb 2019 22:03:04 +0000
Message-ID: <20190215220250.30883-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f6d6ce6-9e85-40e4-45a9-08d693915b92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1534;
x-ms-traffictypediagnostic: MWHPR2201MB1534:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1534;23:vGsguZI5Hh2aN1/mGKGacIn/GOQ7eHh+OA9Q4?=
 =?iso-8859-1?Q?zEc/bKuw4VvYWe3dBC/Sz9AsfbQktrZ0iAvWsXDpCWmVxVke/FGsE56D9O?=
 =?iso-8859-1?Q?xLZqqMQd+nYMmwWjCSXh58TTTYSYG9SlHpSi8Jhvzlh2oCQd3KDW0mbc5E?=
 =?iso-8859-1?Q?KVNcDH2atZyrTTBCMO8jwMqysEmPAtEQeHesfhxnJJMpwnG0qGWVcLYUoq?=
 =?iso-8859-1?Q?N/N1UL9QH5f4FVGLkM5SF+r5YhPFBH0YhcrMnVZMUea5vfYMP96fTJtDsn?=
 =?iso-8859-1?Q?5MOLyEVmGm/d58jX2/WzQh6oI+EwzTDmP1E/430kla6D3AGMP3Uy6JK1rI?=
 =?iso-8859-1?Q?qc0HEKh8b/AB8YkualmAozbLqZjMceumdqMRXjTCIEMkZOhnpEY/U6hY+c?=
 =?iso-8859-1?Q?8EPmqyBZNYKdU8LDvrVwWLkj7MLLNKlPL0b0ELJ12alS14Hu2Suhqts5xu?=
 =?iso-8859-1?Q?kHF4TiSQva78i88mjXTdk+PNgYj/EQ0+r7hIaeBUACItld48N6RFpcapOB?=
 =?iso-8859-1?Q?0fLp8CX9O2B84E5zuKxQtBGDW9E/S76E1J6Gp4ZOiAPx+nI/NqIPWSprsC?=
 =?iso-8859-1?Q?d4TiQHnWcwrNoSKe1oXPowwPNbAU4IfaVsfN8pY6+chFIJRi8zCzUlVyJx?=
 =?iso-8859-1?Q?vgnFp3mQjp4yEAE1g/XihhDkEH1wcDNRXi8gFNKg9X9+uekfphoBasx5+s?=
 =?iso-8859-1?Q?R/qdnuEQGmP65mXYI2Q0Y+ZykayqtInXUwZPF2p0M1enonKUVpM9wnDHi5?=
 =?iso-8859-1?Q?6CVpug1BJUGPhE/+a8LtucE6jJrr1DcVBXAUcO28a4ls+nW6nJYk9oisV/?=
 =?iso-8859-1?Q?/rHoePIA2KUqrtHJixXTTd2ZKy/IbwEilRa/V/1Y2FQT+hq4Q4JN+d9yah?=
 =?iso-8859-1?Q?gOHcZ9MzWjqUXZehGa8r+peONIBg4FL/4srmfVHu7yov8d/QnWeDbmlk7F?=
 =?iso-8859-1?Q?jR/n+M7Yud0ALzVeDxIHY6U0xSp6PDR/PEEqkat53oXo2qDamTPhXvmyuZ?=
 =?iso-8859-1?Q?JYAMqQfuUiHzVLnaYc1yBNtVOnQvP9ANtwYbWqNL2h0H+0N8XiQNOHgbgK?=
 =?iso-8859-1?Q?JVW7zCoyDbx3h8gr8qjK3bPwLmq7TI/IpZE/CzjXkEVjpt+vj5AOYNjQhK?=
 =?iso-8859-1?Q?dWYbDV/FqlEFgNq8FJGkteDAuDhDVFGHCSpME66VqxKyTJhh+Y07wO4Mmd?=
 =?iso-8859-1?Q?aF3pOfhUjBuzfBwZY3+23A+3N9aKguN9eG9pMDa4Jb0XyBERs0+2vQ2dZC?=
 =?iso-8859-1?Q?blBgD7OJ9o4wBH3vDtkayjJe+qEmfcuLUrRDA40mOTIGmnJ4lDNUECsgtq?=
 =?iso-8859-1?Q?4qr8FDfb+6d3onJU8dndugTQJ?=
x-microsoft-antispam-prvs: <MWHPR2201MB1534E1DDB9543B7AAB88E19FC1600@MWHPR2201MB1534.namprd22.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(376002)(346002)(189003)(199004)(68736007)(42882007)(2906002)(1076003)(99286004)(102836004)(186003)(478600001)(2501003)(54906003)(52116002)(486006)(50226002)(6506007)(6486002)(6116002)(3846002)(316002)(107886003)(26005)(53936002)(386003)(66066001)(5660300002)(5640700003)(6512007)(4326008)(8676002)(71200400001)(36756003)(8936002)(81156014)(2616005)(44832011)(476003)(71190400001)(6916009)(81166006)(6436002)(25786009)(14454004)(106356001)(97736004)(256004)(14444005)(105586002)(2351001)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1534;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rmnt+qyiXpw2dmh/mNKaTFNDcxAQJns4sXprVfGFdcdJmvZnavriidRwFexd+b9WGXTBLTjjcPeI2dXEF4RX7njpHbpvPi9JUhmIm5a3WzSy9+E+GdDcS2HgypQKZaJM0hYH1vAH9ij4oQJgYTCpEX4RdihIjFpSrNPO7A+oMqfQJK2hW5rBEh8G5H4V1L2bkvrNLC8JbToVdHnPXgPXfzlMOvg1UrMzUnjAZr/KTNyyz3Ke8YzLDcvo436dxz8pp20IqHrXUgn0/U+rHP3Zt0gPkYwsqRTu+8f+7r2AkSuhA1WtjOo4YmArvJW55MfENPFzLXplIpzopNf0RO5FjmNe3PAiSOaip/tF1oydbcDadYiCLNvj0fICgCwfcCUxvUJDaPPCLheyZHA97IxzSwwPKTGhUyrmz7HLX5dgiFw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6d6ce6-9e85-40e4-45a9-08d693915b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 22:03:03.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1534
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Commit e36863a550da ("MIPS: HIGHMEM DMA on noncoherent MIPS32
processors") introduced code which:

  1) Calculates an offset within a page, by ANDing an address
     with ~PAGE_MASK.

  2) Checks whether that offset is >=3D PAGE_SIZE.

This check can never evaluate true, making the code it guards
unreachable. smatch spots bogus arithmetic resulting from the
impossible condition, resulting in the following warning:

  arch/mips/mm/dma-noncoherent.c:125
    dma_sync_phys() warn: mask and shift to zero

Fix this by removing the impossible to satisfy condition & the
unreachable code it guards.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/mm/dma-noncoherent.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.=
c
index f7e0fd6b7619..b57465733e87 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -120,13 +120,8 @@ static inline void dma_sync_phys(phys_addr_t paddr, si=
ze_t size,
 		if (PageHighMem(page)) {
 			void *addr;
=20
-			if (offset + len > PAGE_SIZE) {
-				if (offset >=3D PAGE_SIZE) {
-					page +=3D offset >> PAGE_SHIFT;
-					offset &=3D ~PAGE_MASK;
-				}
+			if (offset + len > PAGE_SIZE)
 				len =3D PAGE_SIZE - offset;
-			}
=20
 			addr =3D kmap_atomic(page);
 			dma_sync_virt(addr + offset, len, dir);
--=20
2.20.1

