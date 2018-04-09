Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:23:08 +0200 (CEST)
Received: from mail-bn3nam01on0099.outbound.protection.outlook.com ([104.47.33.99]:6400
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992273AbeDIAXBPs3uG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:23:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nldlfgQZSUy8/kXhF8R3udGjBiufIjwtdBn3lLE915A=;
 b=jxwTyESIPRfXlFXBt7zSbbnKLOvQ9tLarDFfzSVg//3k52cnB3BO8KJx2cZHDPBCAlI1j9HrR83iyMxQ+NxnrcntIrSdv659hTuI9QrZyAnYEC/X4wE3TNqSUf+/4/93yc7yR0ZlBhpUOqCu4mTj4c0RECN0G7iMrZN4IpLq4lk=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1014.namprd21.prod.outlook.com (52.132.133.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:22:51 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:22:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 041/161] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Thread-Topic: [PATCH AUTOSEL for 4.14 041/161] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Thread-Index: AQHTz5iJ9Y0sPrTSZkWFGdTRSijEWg==
Date:   Mon, 9 Apr 2018 00:20:18 +0000
Message-ID: <20180409001936.162706-41-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:YDJ58ZbH+HuOL5rUuWMFoLkTgMgmwcYjEDD9cvqnD4NoBkoUdkj1YCe+TYpQ1aPn64mqpyWJRJXnYbtdLl9macSyrNVpWRuErkkNV9Ti7tUUPDxJEb8MoWnDdVNUEY4bR6Io3c8uhpDlixJtvAfHV7h4r/QqNwAHPBNu9B8v9oyD0Of77gBlLqDaoO27xT74iE76eBs4EoonehMZ8q9Weu+SdonQwW/qwCDVX73fE7Y+0E1h4DnKHDNpYIbj5aZU;20:XDB1rFaTmfoTRkTZb+M7xV1rg+y2nl75zD4stImDt/mmUmiGEtdOHpLuXmN+mJigozAQazWG3D9XcP9lvPBGuDqNyCWH1wKwKX7SB9OcGDreHKpCpKsGA6KdMrMX7xHPogLTn0uWq01+26bjhhWqGm58tvDjLFe+rldtcnQ2WCU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 388ad588-72a3-4a8e-d2a6-08d59db007b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB10147C9F6E3C789901AFA398FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(6306002)(107886003)(66066001)(86612001)(966005)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QtIO/k2ikfxgzGUtw3pSDChzlyBP27J60j0EUqCHMprqnDMf+JZspHJD1NsLlh7HtAwf2zMK4SgJX88AVG8TRv9dPyAj9yUbOE98dTOf4t5QGh4C6t0q8Cm4dBmNAUNs1EnZyU7clpHp/ZYMsMc8AkGDj+HkBBrqCFUXLyLqUVo13QaLMXjcrJgY20Z6yUOMXB3zfwQpU510MSjrfreIKVnv9MFJ8K8mIrpwkBxAvFG1OZesTRa/eZzsUQnOD4HN7nb27FY0/Y/sATH7oFoj+QWD+uQbkQC6tx5eAquXg1W4QugVplnCjj+GXfgbcTc8qaMwBjmp+cHsuj8LzyY3v9pIL6h2jsyh2qC0e+1+qesdbSlVn9ngGyZrAQWlRkrcT8wFBtKT/hq3BOoiXZslM+SmiIJ3FeJN/de0vpKENc0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388ad588-72a3-4a8e-d2a6-08d59db007b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:18.1289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63438
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
