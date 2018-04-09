Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:25:47 +0200 (CEST)
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:2944
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994660AbeDIAZjvhTGV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:25:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ig1KXT1k0uuXxwdKYrj/gtJ28He9/1KBdqQJPaOYAfc=;
 b=T9ip4x2nJZ07jBs1rf11xXsiAL/RlMK0o8RPZP7actnxORccJ5a6ik61sONZmTZPDjBK0fCXCRzWhx5aydHQOsXgZgFi8jHofVLiK9wDqoDRAZ3pRRQdRwwy9ftXKl/MXpbAt3/ZsvoEdc9Q0kpyogK8TJnor6jNOEWsLTregfA=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1013.namprd21.prod.outlook.com (52.132.133.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:25:29 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:25:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 123/161] MIPS: generic: Fix machine
 compatible matching
Thread-Topic: [PATCH AUTOSEL for 4.14 123/161] MIPS: generic: Fix machine
 compatible matching
Thread-Index: AQHTz5i3Baocnw5SIUidDZolW0ru1g==
Date:   Mon, 9 Apr 2018 00:21:33 +0000
Message-ID: <20180409001936.162706-123-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:VJV1rtuxqWLTmcmE8qTEXKh+XQTxVBNRe42cusE8g7IVPmb9H3qsucBRH3P0LubctaT2OhqJ6ZlJ0u1P/xDvl3QgUkCtXSPk7hNYU89YJUPMuBz+etYtqiZMaVHUsgZf+Q4BZRqKrIMyxpd+esfVxMin88Ie/v9lfXmPYnMyMpjVnRz/SKCz/kOLN8syf+ZUu17fDQdtetncUuQ6W3yGQ1jGQwxppi8RUPwelKCSnyzev2O4vLiDOjea64Yt1Q3K;20:F0hiub9I8VSTudwiQRg0KvPhxXjX0MfhabzAIhLO0wpTGIfXuu/qChN7hp31Vsel85FhYdyCZqX2BgJBCMc8dMFnZB8p1Z/XRBLlXbG9rqb5B02HGG0zJgc9cBGjpHbKi77KWnL4VmE4QOTkLBLTSWRMNdVD5NHeZKdKKDuuiLk=
X-MS-Office365-Filtering-Correlation-Id: 8d6d46ab-1daa-4bed-14c0-08d59db06614
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB10134D527D7823E80210BC97FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dYUc4D/MzORASVBtR6Kr9Jmbq9WKX0hL5ztprKkmFjtVbfPJTRUK8CGnL2R14Y2tFUDyriov/emOp4j6FW0Upufj5CjsZ00EgtdsMWHdNN0+Bjt2g+lBmEiYD3I7WQ5KlgIFzU2wwdAXTACMVuurHImN4bT1h/w1D9XsCV/sl5RCWrdBIprytWWX9BsHqHAIpiiO6RKRrzbDDEqtFpz0YO6haPyMQavbM7Lxfa2xfYUMedyYxyBgLNRyw08z30Tf+cstcJuChojKHTonL94Jb6ems/yFe6WuBFYDLsZY+8ybVPi6IcTObHfkM4selaYF8Yc0I8w6oDkamqOxGLpsiPxtIdUvUO42WlXRtThheJMEUZIzwKDKtQ5O7mWPGwN2SNMAAnam72/ZhB6dDTkelLgyndICM7ywgU/OUtAIB3c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6d46ab-1daa-4bed-14c0-08d59db06614
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:33.7686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexander.Levin@microsoft.com
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

[ Upstream commit 9a9ab3078e2744a1a55163cfaec73a5798aae33e ]

We now have a platform (Ranchu) in the "generic" platform which matches
based on the FDT compatible string using mips_machine_is_compatible(),
however that function doesn't stop at a blank struct
of_device_id::compatible as that is an array in the struct, not a
pointer to a string.

Fix the loop completion to check the first byte of the compatible array
rather than the address of the compatible array in the struct.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18580/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/machine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/machine.h b/arch/mips/include/asm/machine.h
index e0d9b373d415..f83879dadd1e 100644
--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -52,7 +52,7 @@ mips_machine_is_compatible(const struct mips_machine *mach, const void *fdt)
 	if (!mach->matches)
 		return NULL;
 
-	for (match = mach->matches; match->compatible; match++) {
+	for (match = mach->matches; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, 0, match->compatible) == 0)
 			return match;
 	}
-- 
2.15.1
