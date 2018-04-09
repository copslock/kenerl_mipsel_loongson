Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:18:07 +0200 (CEST)
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:58093
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990520AbeDIAR7b0ECG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:17:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nldlfgQZSUy8/kXhF8R3udGjBiufIjwtdBn3lLE915A=;
 b=SnYoRcPTXWemyRpjKiWD2kLNgnqmsun1bJs6dZFCSDziQLe5hp3Q22nDZLG80TckszfgxBoY8jCIjJc381t7USnzYzxWXWhV24lsNnhqF38cM2mo8D6XvHa4uamt6q36yE2TH34A+pEbFa6OMgYDyfl+u96nHDG/8AuLwS+2G4w=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1048.namprd21.prod.outlook.com (52.132.128.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:17:49 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:17:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 047/189] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Thread-Topic: [PATCH AUTOSEL for 4.15 047/189] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Thread-Index: AQHTz5ghmWD5LLxnXUW9mrZF19L7xA==
Date:   Mon, 9 Apr 2018 00:17:23 +0000
Message-ID: <20180409001637.162453-47-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:TV+dsXOWkCPoFRbjsVvWvpFEKUXGiDWS2DRkCVo5R7/ckK5WFHvYqLzIITzwjOy81QyVkppCN/74hPPah7dK8ja4KQmkyLMwgDsncYn9fDxqWcXAWSmIQaA1ILBF44bgqK+pf/W0gGNmsq8sD2mGsbQPVOiUk/hfcMCNMCuLdSmV5qi66XES4ly3OzG3mLhnqXJDjUSERCxRCksgxiaicCqQ6Pd9k/G88VrG3OvqH1+qrtq2PZ0UJdFM2uXChH2Y;20:GAaX3afhzobBzxDRJYbIsEzu605f+KTV+y6vFdEdo2cjHsXpeBw4P1kXbuuoG91djUCYBbPIR5gUmIgCJ1NsM8rKbh/HvHRJo4aR+xmoitW3V8Gt+p7/FuBaVl01jvQ7UPgp/RH6/xAoAIysqlWWt2Q4MpTuG/J5OgR2vNHlKeE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cb763f4-c919-4c1b-9e14-08d59daf5413
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB10480CA7D728CBDD6D7558DBFBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(6306002)(53936002)(107886003)(68736007)(102836004)(966005)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SMjez1tSB6hI9CZdGRl52/UWsZiRkgY92+JV41R3w2QkgI2Mu20juL1KlXSAMW25HQ5s5jwmb5GziY76Jdein9t50q0l/MPT87aiSaGbkEHG+gLK/WPqz/PTx2c6zufugUcAacqLP+XZIzqOuu4q9RnhiEZt2jbVBq0o7Lf/jdWte2/m2dMSMa6ZNtzkw53+JrqA/nXEuCQWocNH5N58MG1v4njK8oz4+5jk5FA3muqj976xZ/OOFGpZ2c7jfPwICiyG9+qng25FztFUomeNytOcZItHMevUBi235HwUA74/dTOj78R1Tqtvbt5zZOrHE6XQKEqX2DgHX49fTP0gFzSFlsddsTAqJoxTY2MF5+YtPcJZoUu7DnoUs/W84RjqcMkZjhpEVF/Bc8MYPAkwMJ0fFzMMVbpXdtOgEyl5MrE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb763f4-c919-4c1b-9e14-08d59daf5413
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:23.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63432
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

[ Upstream commit 5f2483eb2423152445b39f2db59d372f523e664e ]

Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
separate files, so none of these files get cleaned up by make clean.
List the files separately instead.

Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make clean"")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18491/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/boot/compressed/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index c675eece389a..adce180f3ee4 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -133,4 +133,8 @@ vmlinuz.srec: vmlinuz
 uzImage.bin: vmlinuz.bin FORCE
 	$(call if_changed,uimage,none)
 
-clean-files := $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
+clean-files += $(objtree)/vmlinuz
+clean-files += $(objtree)/vmlinuz.32
+clean-files += $(objtree)/vmlinuz.ecoff
+clean-files += $(objtree)/vmlinuz.bin
+clean-files += $(objtree)/vmlinuz.srec
-- 
2.15.1
